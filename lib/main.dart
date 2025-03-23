import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';
import 'package:virtual_keyboard/keyboard/KeyboardWidget.dart';
import 'package:virtual_keyboard/keyboard/models/KeyObject.dart';
import 'package:virtual_keyboard/keyboard/providers/input_text_provider.dart';
import 'package:virtual_keyboard/keyboard/services/KeyBuffer.dart';
import 'package:virtual_keyboard/keyboard/services/keyboardManager.dart';
import 'package:virtual_keyboard/keyboard/strategies/french_string_buffer_strategy.dart';
import 'package:virtual_keyboard/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:camera_android/camera_android.dart'
    if (dart.library.html) 'package:camera_web/camera_web.dart'
    if (dart.library.io) 'package:camera/camera.dart';
import 'package:virtual_keyboard/parameters/ParameterPage.dart';
import 'package:virtual_keyboard/parameters/models/OptionTextSize.dart';
import 'package:virtual_keyboard/parameters/parameterWidget.dart';
import 'package:virtual_keyboard/parameters/providers/parameter_provider.dart';
import 'package:virtual_keyboard/parameters/services/ConfigFileManager.dart';
import 'package:virtual_keyboard/parameters/services/ParameterManager.dart';
import 'package:virtual_keyboard/predictor/PredictorWidget.dart';
import 'package:virtual_keyboard/predictor/models/Prediction.dart';
import 'package:virtual_keyboard/theme/CustomTheme.dart';
import 'package:virtual_keyboard/theme/models/Themes.dart';
import 'package:virtual_keyboard/theme/styles/ThemeCustomText.dart';
import 'package:virtual_keyboard/utils/appState.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'keyboard/providers/keyboard_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigFileManager.createConfigFileIfNotExists();
  try {
    final cameras = await availableCameras();
    final parameters = Parameter.fromJson(await ConfigFileManager.loadConfig());
    print("Cameras found: ${cameras.length}");

    if (cameras.isNotEmpty) {
      print("Using camera: ${cameras.first.name}");
      runApp(ProviderScope(child: MyApp(camera: cameras.first, parameter: parameters,)));
    } else {
      print("No cameras available!");
      runApp(ErrorApp(message: "No cameras available!"));
    }
  } catch (e, stackTrace) {
    print("Error initializing cameras: $e\n$stackTrace");
    runApp(ErrorApp(message: "Failed to initialize cameras: $e"));
  }
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  final Parameter parameter;

  MyApp({Key? key, required this.camera, required this.parameter}) : super(key: key) {
    print("MyApp initialized with camera: ${camera.name}");
    print("MyApp initialized with parameters : ${parameter}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter WebSocket Camera Stream',
      home: CameraScreen(camera: camera, parameter: parameter,),
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
    );
  }
}

class CameraScreen extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final Parameter parameter;

  const CameraScreen({Key? key, required this.camera, required this.parameter}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late WebSocketChannel _channel;
  late WebSocketChannel _text_channel;
  late KeyboardManager keyboardManager;
  late KeyBuffer keyBuffer;
  bool _isStreaming = false;
  bool _isTextStreaming = false;
  String serverMessage = "Waiting for server response...";
  String textServerMessage = "Waiting for text server response...";
  Map<String, dynamic>? serverData;
  Prediction prediction = Prediction();
  bool state = true;
  bool isLoading = true;
  String current_message = "";
  late App app;
  CustomTheme customTheme = CustomTheme();

  @override
  void initState() {
    super.initState();

    print("Initializing CameraScreen with camera: ${widget.camera.name}");
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();

    _channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/ws'),
    );

    _text_channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/text'),
    );

    _channel.stream.listen((message) {
      setState(() {
        serverMessage = message;
      });
    }, onError: (error) {
      print("WebSocket error: $error");
    }, onDone: () {
      print("WebSocket connection closed");
    });

    _text_channel.stream.listen((message){
      setState(() {
        try{
          serverData = json.decode(message);
          prediction = Prediction.fromJson(serverData!);
          serverMessage = serverData?["status"] == 'valid' ? "Predictions received" : "No predictions";
        }catch(e){
          serverMessage = "Error decoding Json";
        }
      });
    }, onError: (error){
      print("WebSocket error: $error");
    }, onDone: (){
      print("WebSocket connection closed");
    });

    keyBuffer = KeyBuffer(ref, FrenchStringBufferStrategy());
    keyboardManager = KeyboardManager();
    fetchKeyboardData();

    app = App(current_message);
  }

  Future<void> fetchKeyboardData() async{
    await keyboardManager.populate(ref);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _channel.sink.close();
    _text_channel.sink.close();
    super.dispose();
  }

  void _start_text_streaming() async{
    if(_isTextStreaming) return;

    setState(() {
      _isTextStreaming = true;
    });

    while (_isTextStreaming) {
      try {
        String word = ref.watch(inputTextProvider).toString();
        _text_channel.sink.add(word);
      } catch (e) {
        print('Error while streaming: $e');
        setState(() {
          _isTextStreaming = false;
        });
        break;
      }

      // Add a small delay to limit the frame rate
      await Future.delayed(const Duration(milliseconds: 100)); // Approx 10 FPS
    }
  }

  void _stopTextStreaming() {
    setState(() {
      _isTextStreaming = false;
    });
  }

  void _startStreaming() async {
    if (_isStreaming) return;

    setState(() {
      _isStreaming = true;
    });

    while (_isStreaming) {
      try {
        // Capture the frame as bytes
        final image = await _controller.takePicture();
        final bytes = await image.readAsBytes();

        // Send the frame to the WebSocket server
        _channel.sink.add(bytes);
      } catch (e) {
        print('Error while streaming: $e');
        setState(() {
          _isStreaming = false;
        });
        break;
      }

      // Add a small delay to limit the frame rate
      await Future.delayed(const Duration(milliseconds: 10)); // Approx 100 FPS
    }
  }

  void _stopStreaming() {
    setState(() {
      _isStreaming = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      String textOutput = ref.watch(inputTextProvider);
      final param_provider = ref.watch(parameter_provider);
      print(textServerMessage);
      print(prediction.status);
      print(prediction.predictions);
      return param_provider.when(
        error: (error, stack) => Text("Error: $error"),
        loading: (){
          return CircularProgressIndicator();
        },
        data: (parameter){
          OptionTextSize optionTextSize = OptionTextSize.fromString(parameter.getParameter("policeSize").value);
          Themes currentTheme = Themes.fromString(parameter.getParameter("theme").value);
          return Container(
            color: currentTheme.backgroundColor,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        /*
                    Expanded(
                      flex:1,
                      child: FutureBuilder<void>(
                          future: _initializeControllerFuture,
                          builder: (context, snapshot){
                            if(snapshot.connectionState == ConnectionState.done){
                              return CameraPreview(_controller);
                            }else{
                              return const Center(child: CircularProgressIndicator(),);
                            }
                          }),
                    ),*/
                        Expanded(
                            flex:1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex:1,
                                    child: ClipRect(
                                      child: Wrap(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.settings, size: ThemeCustomText.getBasicTextSize(context, optionTextSize)),
                                            onPressed: () {
                                              //showSettingsMenu(context,widget.parameter); // Open settings menu
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) {
                                                    return ParameterPage();
                                                  }));
                                            },
                                          ),
                                          ElevatedButton(
                                            onPressed: _isStreaming ? null : _startStreaming,
                                            child: const Text('Start Streaming'),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: _isStreaming ? _stopStreaming : null,
                                            child: const Text('Stop Streaming'),
                                          ),
                                          ElevatedButton(
                                            onPressed: _isTextStreaming ? null : _start_text_streaming,
                                            child: const Text('Start Text Streaming'),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton(
                                            onPressed: _isTextStreaming ? _stopTextStreaming : null,
                                            child: const Text('Stop Text Streaming'),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                Expanded(child: Text(
                                  textOutput,
                                  style: TextStyle(
                                    fontSize: ThemeCustomText.getBasicTextSize(context, optionTextSize),
                                    color: Colors.black,
                                  ),
                                ))
                              ],
                            )
                        )
                      ],
                    )
                ),
                Expanded(
                  flex:1,
                  child: PredictorWidget(ref,prediction),
                ),
                Expanded(
                  flex: 5,
                  child: isLoading ?
                  Center(child: CircularProgressIndicator())
                      : KeyboardWidget(ref,keyboardManager: keyboardManager, buffer: keyBuffer,),
                )
              ],
            ),
          );
        }
      );
    }));
  }
}

class ErrorApp extends StatelessWidget {
  final String message;

  ErrorApp({required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
