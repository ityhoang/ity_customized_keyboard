part of '../ity_customized_keyboard.dart';

class CustomKeyboardManager {
  factory CustomKeyboardManager() => _instance;

  CustomKeyboardManager._internal();

  static final CustomKeyboardManager _instance =
      CustomKeyboardManager._internal();
  bool _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;

  void openKeyboard() {
    if (!_isKeyboardOpen) {
      _isKeyboardOpen = true;
    }
  }

  void closeKeyboard() {
    if (_isKeyboardOpen) {
      _isKeyboardOpen = false;
    }
  }
}
