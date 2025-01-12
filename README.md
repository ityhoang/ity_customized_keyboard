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
> [!NOTE]  
> To ensure the library functions at its best, we highly recommend using the provided **CustomTextField**, **CustomTextFormField**.
> This widget has been optimized for seamless integration with your customized keyboard, minimizing potential issues and ensuring high performance.

1. Add the package to your `pubspec.yaml`:

   ```yaml
   dependencies:
     ity_customized_keyboard: ^1.0.12
   ```
2. Craft Your Custom Keyboard

    ```dart
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';

    class YourCustomKeyboard extends CustomKeyboard {
   
      // Define the keyboard UI
      @override
      Widget build(BuildContext context){
        return Container(
          child: CustomKeyboardKey(
            keyEvent: const CustomKeyboardEvent.clear(),
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(2),
            color: Colors.red,
            child: Center(child: Text('AC')),
          ),
        );
      }
   
      // Set the keyboard height
      @override
      double get height => 230;
   
      // Provide a unique name for the keyboard
      @override
      String get name => 'YOUR_NAME_KEYBOARD';
      
      @override
      Color get backgroundColor => const Color(0xEAEFEFEF);
    }
   ```
3. Seamlessly Embed Your Custom Keyboard
    ```dart
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';
    // Initialize the custom keyboard
    final yourCustomKeyboard = YourCustomKeyboard();
   
    // Wrap your widget tree with KeyboardWrapper
    KeyboardWrapper(
      context: context,
      keyboards: [yourCustomKeyboard],
      child: //Your code here
    ),
   
    // Use the custom keyboard in a text field
    CustomTextField(
      keyboardType: yourCustomKeyboard.inputType,
    ),
   ```
## 🔧 Usage
**Dialog:**
```dart
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return KeyboardWrapper(
          context: context,
          keyboards: [keyboardMomo],
          child: Dialog(
            // Your code here
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
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return KeyboardWrapper(
          context: context,
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

**Show BottomNavigationBar:**
```dart
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';

    KeyboardWrapper(
      context: context,
      keyboards: [keyboardMomo],
      child: Scaffold(
        // Your code here
      ),
    )
```

<p align="center">
  <img src="https://raw.githubusercontent.com/ityhoang/ity_customized_keyboard/main/resources/customizedkeyboard.gif" width="150" />
</p>

**Hidden BottomNavigationBar:**
```dart
    import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';

    KeyboardWrapper(
      context: context,
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

## 🐞 Issues and feedback

We value your feedback! Share your thoughts or report bugs by filing [issues](https://github.com/ityhoang/ity_customized_keyboard/issues). Thank you for helping us improve!

## 📄 Source

This package is a clone of the [Customized Keyboard package](https://pub.dev/packages/customized_keyboard).

## 📜 License

[MIT](https://mit-license.org) License