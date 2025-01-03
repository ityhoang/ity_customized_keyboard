part of '../ity_customized_keyboard.dart';

abstract class CustomKeyboard {
  abstract final double height;
  abstract final String name;
  abstract final Color backgroundColor;

  Widget build(BuildContext context);

  Widget _activeBuild(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          color: Colors.transparent,
          height: height,
          child: build(context),
        ),
      );

  CustomTextInputType get inputType => CustomTextInputType(name: name);
}
