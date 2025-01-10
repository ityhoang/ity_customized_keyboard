part of '../ity_customized_keyboard.dart';

enum CustomKeyType {
  character,
  submit,
  next,
  deleteOne,
  clear,
  previous,
  hideKeyboard,
  calculate,
  operator,
}

class CustomKeyboardEvent {
  const CustomKeyboardEvent.character(this.value)
      : type = CustomKeyType.character;

  const CustomKeyboardEvent.submit()
      : type = CustomKeyType.submit,
        value = null;

  const CustomKeyboardEvent.next()
      : type = CustomKeyType.next,
        value = null;

  const CustomKeyboardEvent.previous()
      : type = CustomKeyType.previous,
        value = null;

  const CustomKeyboardEvent.deleteOne()
      : type = CustomKeyType.deleteOne,
        value = null;

  const CustomKeyboardEvent.clear()
      : type = CustomKeyType.clear,
        value = null;

  const CustomKeyboardEvent.hideKeyboard()
      : type = CustomKeyType.hideKeyboard,
        value = null;

  const CustomKeyboardEvent.calculate()
      : type = CustomKeyType.calculate,
        value = null;

  const CustomKeyboardEvent.operator(this.value)
      : type = CustomKeyType.operator;
  final CustomKeyType type;
  final String? value;
}
