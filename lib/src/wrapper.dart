part of '../ity_customized_keyboard.dart';

class KeyboardWrapper extends StatefulWidget {
  const KeyboardWrapper({
    required this.child,
    super.key,
    this.heightBottomNavigationBar = 0,
    this.isBottomSheetOrDialog = false,
    this.hasPaddingKeyboard = true,
    this.removePaddingSafe = false,
    this.removeViewInsetsBottom = false,
    this.width,
    this.keyboards = const [],
    this.shouldShow,
  });

  final Widget child;
  final double heightBottomNavigationBar;
  final bool isBottomSheetOrDialog;
  final bool hasPaddingKeyboard;
  final bool removePaddingSafe;
  final bool removeViewInsetsBottom;
  final double? width;
  final List<CustomKeyboard> keyboards;

  /// Will be called before showing any keyboard.
  ///
  /// If it returns true, the requested keyboard is shown, otherwise the keyboard
  /// request is ignored.
  ///
  /// Use this to prevent keyboards showing on desktop devices for example.
  final bool Function(CustomKeyboard)? shouldShow;

  static KeyboardWrapperState? of(BuildContext context) {
    return context.findAncestorStateOfType<KeyboardWrapperState>();
  }

  @override
  State<KeyboardWrapper> createState() => KeyboardWrapperState();
}

class KeyboardWrapperState extends State<KeyboardWrapper>
    with SingleTickerProviderStateMixin {
  /// Holds the active connection to a [CustomTextField]
  CustomKeyboardConnection? _keyboardConnection;

  late final AnimationController _animationController;
  late Animation<Offset> _animationPosition;
  double _bottomInset = 0;
  Widget? _activeKeyboard;
  double _keyboardHeight = 0;
  final _resizeHeightKeyBoard = ValueNotifier<double>(0);
  var _backgroundKeyboard = Colors.transparent;
  CustomKeyboardManager get manager => CustomKeyboardManager();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _animationPosition = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.addListener(() {
      final keyboardPosition = _animationPosition.value.dy;
      _resizeHeightKeyBoard.value = (_keyboardHeight +
              (widget.removePaddingSafe
                  ? 0
                  : MediaQuery.of(context).padding.bottom)) *
          (1 - keyboardPosition);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _resizeHeightKeyBoard.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return RepaintBoundary(
      child: MediaQuery(
        data: _activeKeyboard != null
            ? data.copyWith(
                viewInsets: widget.removeViewInsetsBottom
                    ? null
                    : data.viewInsets.copyWith(
                        bottom: _bottomInset +
                            data.viewInsets.bottom +
                            data.padding.bottom),
              )
            : data,
        child: Stack(
          children: [
            if (widget.isBottomSheetOrDialog)
              _buildPaddingForDialogOrSheet()
            else
              _buildPositionedForNormal(),
            if (_activeKeyboard != null) _buildCustomKeyboard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingForDialogOrSheet() {
    return ValueListenableBuilder<double>(
      valueListenable: _resizeHeightKeyBoard,
      builder: (context, height, child) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: widget.hasPaddingKeyboard
                  ? (max(0, height - max(0, widget.heightBottomNavigationBar)))
                  : 0),
          child: widget.child,
        );
      },
    );
  }

  Widget _buildPositionedForNormal() {
    return Positioned.fill(
      child: ValueListenableBuilder<double>(
        valueListenable: _resizeHeightKeyBoard,
        builder: (context, height, child) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: widget.hasPaddingKeyboard
                    ? (max(
                        0, height - max(0, widget.heightBottomNavigationBar)))
                    : 0),
            child: widget.child,
          );
        },
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return Positioned(
      bottom: 0,
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: _keyboardHeight +
          (widget.removePaddingSafe
              ? 0
              : MediaQuery.of(context).padding.bottom),
      child: SlideTransition(
        position: _animationPosition,
        child: Material(
          color: _backgroundKeyboard,
          child: Container(
            color: _backgroundKeyboard,
            padding: EdgeInsets.only(
                bottom: (widget.removePaddingSafe
                    ? 0
                    : MediaQuery.of(context).padding.bottom)),
            child: _activeKeyboard,
          ),
        ),
      ),
    );
  }

  CustomKeyboard getKeyboardByName(String name) {
    try {
      final keyboard =
          widget.keyboards.firstWhere((keyboard) => keyboard.name == name);
      return keyboard;
    } on StateError {
      throw KeyboardNotRegisteredError();
    }
  }

  /// Connect with a custom keyboard
  void connect(CustomKeyboardConnection connection) {
    // Verify that the keyboard exists -> throws otherwise
    final keyboard = getKeyboardByName(connection.name);

    // Should we show this keyboard?
    if (widget.shouldShow?.call(keyboard) == false) return;

    manager._isKeyboardOpen = true;
    // Set as active
    connection.isActive = true;

    // Is a keyboard currently shown and is it the same as the requested one?
    if (_keyboardConnection?.name == connection.name) {
      // Only change the connection to send events to the new text field, discarding the
      // old one.
      _keyboardConnection = connection;
    }
    // Is another keyboard currently shown?
    else if (_keyboardConnection != null) {
      // Hide old keyboard in an animation
      // Then animate the new keyboard in
      _animateOut().then((_) {
        _keyboardConnection = connection;
        _animateIn(
            keyboard: keyboard, fieldContext: connection.focusNode.context);
      });
    }
    // No keyboard shown yet?
    else {
      // Animate new keyboard in and set connection
      _keyboardConnection = connection;
      _animateIn(
          keyboard: keyboard, fieldContext: connection.focusNode.context);
    }
  }

  /// Animate keyboard in
  Future<void> _animateIn(
      {required CustomKeyboard keyboard, required BuildContext? fieldContext}) {
    setState(() {
      _backgroundKeyboard = keyboard.backgroundColor;
      _activeKeyboard = keyboard._activeBuild(context);
      _keyboardHeight = keyboard.height;
      _bottomInset = _keyboardHeight;
    });
    return _animationController.forward().then((value) {
      // Ensure the currently active field is shown and not hidden by the keyboard
      // -- only if item is not visible anyways --
      if (fieldContext != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final visibilityState = isItemVisible(fieldContext);

          switch (visibilityState) {
            case VisibilityState.hiddenAbove:
              Scrollable.ensureVisible(fieldContext, alignment: 0.1);
              break;
            case VisibilityState.hiddenBelow:
              Scrollable.ensureVisible(fieldContext, alignment: 0.9);
              break;
            case VisibilityState.visible:
              break;
          }
        });
      }
    });
  }

  /// Animate keyboard out
  Future<void> _animateOut() {
    setState(() => _bottomInset = 0.0);
    return _animationController.reverse();
  }

  /// Disconnect the given connection id
  void disconnect({required String id}) {
    // Is the current connection id active?
    if (_keyboardConnection?.id == id) {
      manager._isKeyboardOpen = false;
      //remove code base
      // onKey(const CustomKeyboardEvent.calculate());
      // Set as inactive
      _keyboardConnection!.isActive = false;

      // Remove it and hide the keyboard
      _keyboardConnection = null;
      // Do this after a possible build is done to prevent an exception that would
      // occur if the widget is currently rebuilding. It might be that we lost focus
      // on the textfield due to a widget rebuild.
      _animateOut();
    }

    // Otherwise, do nothing.
  }

  /// Hides the keyboard if currently shown
  void hideKeyboard() {
    // Disconnect and hide if keyboard connection is still active
    if (_keyboardConnection != null) {
      return disconnect(id: _keyboardConnection!.id);
    } else {
      // Otherwise, just animate out
      _animateOut();
    }
  }

  /// Add character to text field
  void onKey(CustomKeyboardEvent key) {
    // Throw if keyboard connection not found
    // Ignore if hideKeyboard type because the field might have lost focus and disconnected
    // before this method is called. It won't hurt to call [hideKeyboard()] multiple times.
    if (_keyboardConnection == null && key.type != CustomKeyType.hideKeyboard) {
      return;
    }
    final keyboardConnection = _keyboardConnection!;

    String calculate(String text) {
      if (text.isEmpty) return '';
      var userInputFC = text.replaceAll(',', '');
      userInputFC = userInputFC.replaceAll('x', '*');
      userInputFC = userInputFC.replaceAll(':', '/');
      var last = userInputFC.substring(userInputFC.length - 1);
      while ('+-x:*/'.contains(last)) {
        userInputFC = userInputFC.substring(0, userInputFC.length - 1);
        last = userInputFC.substring(userInputFC.length - 1);
      }
      try {
        final p = Parser();
        final exp = p.parse(userInputFC);
        final ctx = ContextModel();
        final eval = exp.evaluate(EvaluationType.REAL, ctx);

        final userOutput =
            double.tryParse(eval.toString())?.numberFormat() ?? '';
        return userOutput;
      } catch (e) {
        return '';
      }
    }

    void replaceSelection({TextSelection? selection, String newText = ''}) {
      // Remove all selected text
      final originalValue = keyboardConnection.controller.value;

      // Use provided selection over actual selection
      final selectionToUse = selection ?? originalValue.selection;

      // Generate new text value
      final textBefore = selectionToUse.textBefore(originalValue.text);
      final textAfter = selectionToUse.textAfter(originalValue.text);
      final newValue = originalValue.copyWith(
        text: '$textBefore$newText$textAfter',
        selection: TextSelection.collapsed(
            offset: selectionToUse.start + newText.length),
      );

      // Apply input formatters
      // This is not done automatically by the field because we're effectively changing
      // the value programatically.
      var formattedValue = newValue;
      final formatters = keyboardConnection.inputFormatters;
      if (formatters != null && formatters.isNotEmpty) {
        for (final formatter in formatters) {
          formattedValue =
              formatter.formatEditUpdate(originalValue, formattedValue);
        }
      }

      // Set new value
      keyboardConnection.controller.value = formattedValue;
      // Trigger onChanged event on text field
      keyboardConnection.triggerOnChanged();
    }

    void replaceOperator({TextSelection? selection, String newText = ''}) {
      final originalValue = keyboardConnection.controller.value;
      final selectionToUse = selection ?? originalValue.selection;
      var textBefore = selectionToUse.textBefore(originalValue.text);
      final textAfter = selectionToUse.textAfter(originalValue.text);
      var count = newText.length;
      if (selectionToUse.start <= 0) {
        return;
      }
      if (textAfter.isNotEmpty &&
          '.+-x:/'.contains(textAfter.substring(0, 1))) {
        return;
      }
      if ('.+-x:/'.contains(textBefore.substring(
          selectionToUse.start - 1, selectionToUse.start))) {
        textBefore = textBefore.substring(0, textBefore.length - 1);
        count = 0;
      }

      // Generate new text value
      final newValue = originalValue.copyWith(
        text: '$textBefore$newText$textAfter',
        selection:
            TextSelection.collapsed(offset: selectionToUse.start + count),
      );

      // Apply input formatters
      // This is not done automatically by the field because we're effectively changing
      // the value programatically.
      var formattedValue = newValue;
      final formatters = keyboardConnection.inputFormatters;
      if (formatters != null && formatters.isNotEmpty) {
        for (final formatter in formatters) {
          formattedValue =
              formatter.formatEditUpdate(originalValue, formattedValue);
        }
      }

      // Set new value
      keyboardConnection.controller.value = formattedValue;

      // Trigger onChanged event on text field
      keyboardConnection.triggerOnChanged();
    }

    switch (key.type) {
      case CustomKeyType.character:
        replaceSelection(newText: key.value!);
        break;
      case CustomKeyType.operator:
        replaceOperator(newText: key.value!);
        break;
      case CustomKeyType.submit:
        keyboardConnection.onSubmit?.call(keyboardConnection.controller.text);
        break;
      case CustomKeyType.deleteOne:
        final orig = keyboardConnection.controller.value;
        if (orig.selection.start != -1) {
          // Text selected?
          if (orig.selection.start != orig.selection.end) {
            replaceSelection();
          } else if (orig.selection.start > 0) {
            // Remove last character
            replaceSelection(
              selection: TextSelection(
                  baseOffset: orig.selection.start - 1,
                  extentOffset: orig.selection.start),
            );
          }
        }
        break;
      case CustomKeyType.clear:
        final origText = keyboardConnection.controller.text;
        replaceSelection(
            selection:
                TextSelection(baseOffset: 0, extentOffset: origText.length));
        break;
      case CustomKeyType.next:
        if (keyboardConnection.onNext != null) {
          keyboardConnection.onNext?.call();
        } else {
          try {
            keyboardConnection.focusNode.nextFocus();
          } catch (e) {
            throw KeyboardErrorFocusNext(e);
          }
        }
        break;
      case CustomKeyType.previous:
        if (keyboardConnection.onPrev != null) {
          keyboardConnection.onPrev?.call();
        } else {
          try {
            keyboardConnection.focusNode.previousFocus();
          } catch (e) {
            throw KeyboardErrorFocusPrev(e);
          }
        }
        break;
      case CustomKeyType.hideKeyboard:
        hideKeyboard();
        break;

      case CustomKeyType.calculate:
        final t = calculate(keyboardConnection.controller.text);
        keyboardConnection.controller.text = t;
        keyboardConnection.onSubmit?.call(t);
        break;
    }
  }
}

extension DoubleExtensions on double {
  String numberFormat() {
    if (toString().endsWith('.0')) {
      return intl.NumberFormat('##0', 'en_US').format(this);
    } else {
      return intl.NumberFormat('##0.0#', 'en_US').format(this);
    }
  }
}
