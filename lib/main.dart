import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/keyboard/KeyWidget.dart';
import 'package:virtual_keyboard/keyboard/Keyboard.dart';
import 'package:virtual_keyboard/keyboard/KeyboardWidget.dart';
import 'package:virtual_keyboard/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:camera_android/camera_android.dart' if (dart.library.html) 'package:camera_web/camera_web.dart' if (dart.library.io) 'package:camera/camera.dart';
import 'package:virtual_keyboard/utils/appState.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final cameras = await availableCameras();
    print("Cameras found: ${cameras.length}");

    if (cameras.isNotEmpty) {
      print("Using camera: ${cameras.first.name}");
      runApp(MyApp(camera: cameras.first));
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

  MyApp({Key? key, required this.camera}) : super(key: key) {
    print("MyApp initialized with camera: ${camera.name}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebSocket Camera Stream',
      home: CameraScreen(camera: camera),
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: const Locale('en'),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late WebSocketChannel _channel;
  bool _isStreaming = false;
  String serverMessage = "Waiting for server response...";
  bool state = true;
  Keyboard keyboard_object = Keyboard(15, 5);
  String current_message = "";
  late App app;

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

    _channel.stream.listen((message){
      setState((){
        serverMessage = message;
      });
    },
    onError: (error){
      print("WebSocket error: $error");
    },
    onDone: (){
      print("WebSocket connection closed");
    });

    app = App(current_message);
  }

  @override
  void dispose() {
    _controller.dispose();
    _channel.sink.close();
    super.dispose();
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
    return Scaffold(
        body: Column(
         children: [
           Expanded(
             flex: 1,
             child: Container(
               color: Colors.red,
               child: Center(
                 child: Text(current_message),
               ),
             )
           ),
           Expanded(
             flex: 2,
             child: KeyboardWidget(state: state, keyboard: keyboard_object),
           )
         ],
        ),
      );
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