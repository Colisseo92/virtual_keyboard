import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeCheckboxSelectionProvider = StateProvider<int>((ref) => 2);

final themeWindowFirstBuildProvider = StateProvider<bool>((ref) => true);