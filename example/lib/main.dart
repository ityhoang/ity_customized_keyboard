import 'package:flutter/material.dart';
import 'package:ity_customized_keyboard/ity_customized_keyboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final keyboardMomo = KeyBoardMomo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: KeyboardWrapper(
        context: context,
        keyboards: [keyboardMomo],
        child: Scaffold(
          appBar: AppBar(title: const Text('ity_customized_keyboard')),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('Button'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return KeyboardWrapper(
                                context: context,
                                keyboards: [keyboardMomo],
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextField(
                                      autofocus: true,
                                      keyboardType: keyboardMomo.inputType,
                                      onSubmitted: (value) =>
                                          FocusScope.of(context).unfocus(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('BottomSheet'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return KeyboardWrapper(
                                context: context,
                                keyboards: [keyboardMomo],
                                child: Dialog(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const TextField(),
                                        CustomTextField(
                                          autofocus: true,
                                          keyboardType: keyboardMomo.inputType,
                                          onSubmitted: (value) =>
                                              FocusScope.of(context).unfocus(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('Dialog'),
                      ),
                    ),
                  ],
                ),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(),
                const TextField(keyboardType: TextInputType.datetime),
                CustomTextField(
                  keyboardType: keyboardMomo.inputType,
                  onSubmitted: (value) => FocusScope.of(context).unfocus(),
                ),
                CustomTextFormField(keyboardType: keyboardMomo.inputType),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
