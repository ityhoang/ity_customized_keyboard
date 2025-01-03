part of '../ity_customized_keyboard.dart';

class CustomKeyboardKey extends StatelessWidget {
  const CustomKeyboardKey({
    required this.child,
    required this.keyEvent,
    this.padding = EdgeInsets.zero,
    this.enabled = true,
    this.borderRadius,
    this.color = Colors.transparent,
    super.key,
  });

  final Widget child;
  final bool enabled;
  final CustomKeyboardEvent? keyEvent;

  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        color: color,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: enabled ? () => onTap(context) : null,
          child: child,
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    // Send [character] to keyboard wrapper
    final keyboardWrapper = KeyboardWrapper.of(context);
    if (keyboardWrapper == null) throw KeyboardWrapperNotFound();
    if (keyEvent != null) keyboardWrapper.onKey(keyEvent!);
  }
}
