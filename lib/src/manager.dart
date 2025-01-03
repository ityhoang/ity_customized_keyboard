part of '../ity_customized_keyboard.dart';

class CustomKeyboardManager {
  factory CustomKeyboardManager() => _instance;

  CustomKeyboardManager._internal();

  static final CustomKeyboardManager _instance =
      CustomKeyboardManager._internal();
  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;
}
