part of "../customized_keyboard.dart";

class CustomKeyboardManager {
  static final CustomKeyboardManager _instance = CustomKeyboardManager._internal();
  bool _isKeyboardOpen = false;

  CustomKeyboardManager._internal();

  factory CustomKeyboardManager() {
    return _instance;
  }

  void openCustomKeyboard() => _isKeyboardOpen = true;

  void closeCustomKeyboard() => _isKeyboardOpen = false;

  bool get isKeyboardOpen => _isKeyboardOpen;
}
