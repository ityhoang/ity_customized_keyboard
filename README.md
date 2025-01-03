# ITY Customized Keyboard

[![Pub](https://img.shields.io/pub/v/ity_customized_keyboard.svg)](https://pub.dev/packages/ity_customized_keyboard)

Empowers you to design personalized keyboards tailored to your preferences and seamlessly integrate them with [TextField].

## ✨ Features

- Customized keyboards can be anything you imagine – they are essentially a widget crafted by you.
- The custom keyboard automatically appears and disappears based on whether the text field is
  focused or loses focus.
- The [onFieldSubmitted] functionality works seamlessly, and special buttons like backspace and next
  are included for smooth navigation.

## 🚀 Getting Started

1. Add the package to your `pubspec.yaml`:

   ```yaml
   dependencies:
     ity_customized_keyboard: ^1.0.2
   ```
2. Create CustomKeyboard

    ```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';

    class DemoCustomKeyboard extends CustomKeyboard {
      // Your code here
    }
   ```
3. Create a KeyboardWrapper in the widget tree
    ```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';
    final keyboardMomo = KeyBoardMomo();
    KeyboardWrapper(
      keyboards: [keyboardMomo],
      child: //Your code here
    ),
    CustomTextField(
      keyboardType: keyboardMomo.inputType,
    ),
   ```
## 🔧 Usage
**Dialog:**
```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return KeyboardWrapper(
          hasPaddingKeyboard: false,
          keyboards: [keyboardMomo],
          child: Stack(
            children: [
              Positioned.fill(
                child: Dialog(
                  // Your code here
                ),
              ),
            ],
          ),
        );
      },
    );
```
<p align="center">
   <img src="https://raw.githubusercontent.com/ityhoang/ity_customized_keyboard/main/resources/dialog.gif" width="150" />
</p>

**BottomSheet:**
```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return KeyboardWrapper(
          isBottomSheetOrDialog: true,
          keyboards: [keyboardMomo],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Your code here
            ],
          ),
        );
      },
    );
```

<p align="center">
  <img src="https://raw.githubusercontent.com/ityhoang/ity_customized_keyboard/main/resources/bottomsheet.gif" width="150" />
</p>

**Customized Keyboard:**
```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';

    KeyboardWrapper(
      removeViewInsetsBottom: true,
      keyboards: [keyboardMomo],
      child: Scaffold(
        // Your code here
      ),
    )
```

<p align="center">
  <img src="https://raw.githubusercontent.com/ityhoang/ity_customized_keyboard/main/resources/customizedkeyboard.gif" width="150" />
</p>

**BottomNavigationBar:**
```dart
    import 'package:ity_customized_keyboard/customized_keyboard.dart';

    KeyboardWrapper(
      removeViewInsetsBottom: true,
      //remove height bottomNavigationBar
      heightBottomNavigationBar: kBottomNavigationBarHeight - 10,
      keyboards: [keyboardMomo],
      child: Scaffold(
        // Your code here
      ),
    )
```
<p align="center">
  <img src="https://raw.githubusercontent.com/ityhoang/ity_customized_keyboard/main/resources/bottomnavigationbar.gif" width="150" />
</p>

## 📱 Example

To see `ity_customized_keyboard` in action, explore the full example project available in the [example](https://github.com/ityhoang/ity_customized_keyboard/blob/main/example/lib/main.dart).

## 🛠️ Contributions

We gladly accept contributions! If you have suggestions for new features, bug fixes, or improvements, don't hesitate to open an issue or submit a pull request. Your input is always welcome!

## 📄 Source

This package is a clone of the [Customized Keyboard package](https://pub.dev/packages/customized_keyboard).

## 📜 License

[MIT](https://mit-license.org) License