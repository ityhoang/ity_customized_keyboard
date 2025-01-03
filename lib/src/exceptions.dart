part of '../ity_customized_keyboard.dart';

class KeyboardNotRegisteredError implements Exception {
  final String message =
      '[KeyboardWrapper] has not been registered. Please ensure that the keyboard is correctly initialized.';
}

class KeyboardWrapperNotFound implements Exception {
  final String message =
      '[CustomTextFormField] and [CustomTextField] need to be wrapped in a [KeyboardWrapper].';
}

class KeyboardErrorFocusNext implements Exception {
  KeyboardErrorFocusNext(this.originalException);

  final Object originalException;
  final String message =
      'Failed to change focus to next element using focusNode.nextFocus(). See member [originalException] of this exception instance for details.';
}

class KeyboardErrorFocusPrev implements Exception {
  KeyboardErrorFocusPrev(this.originalException);

  final Object originalException;
  final String message =
      'Failed to change focus to next element using focusNode.previousFocus(). See member [originalException] of this exception instance for details.';
}
