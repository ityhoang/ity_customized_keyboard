part of '../ity_customized_keyboard.dart';

class CustomKeyboardConnection {
  CustomKeyboardConnection({
    required this.name,
    required this.controller,
    required this.focusNode,
    required this.triggerOnChanged,
    required this.inputFormatters,
    this.onSubmit,
    this.isActive = false,
    this.onNext,
    this.onPrev,
  }) : id = Ulid().toUuid();
  final String id;
  final String name;
  final void Function(String)? onSubmit;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;
  TextEditingController controller;
  final FocusNode focusNode;
  bool isActive;
  VoidCallback triggerOnChanged;
  final List<TextInputFormatter>? inputFormatters;
}
