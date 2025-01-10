part of '../ity_customized_keyboard.dart';

class KeyBoardMomo extends CustomKeyboard {
  KeyBoardMomo({
    this.style,
    this.actionColor = Colors.white,
  });

  final TextStyle? style;
  final Color actionColor;

  @override
  double get height => 220;

  @override
  String get name => 'KeyBoardMomo';

  @override
  Color get backgroundColor => const Color(0xEAEFEFEF);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.clear(),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('AC', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('7'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('7', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('4'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('4', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('1'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('1', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('000'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('000', style: style)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.operator('/'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('/', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('8'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('8', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('5'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('5', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('2'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('2', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('0'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('0', style: style)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.operator('x'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('x', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('9'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('9', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('6'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('6', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.character('3'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('3', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.operator('.'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('.', style: style)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.deleteOne(),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('⌫', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.operator('-'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('-', style: style)),
                ),
              ),
              Expanded(
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.operator('+'),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('+', style: style)),
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomKeyboardKey(
                  keyEvent: const CustomKeyboardEvent.calculate(),
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(2),
                  color: actionColor,
                  child: Center(child: Text('=', style: style)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
