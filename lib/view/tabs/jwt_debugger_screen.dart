import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:devtools/view/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class JWTDebuggerScreen extends StatefulWidget {
  const JWTDebuggerScreen({Key? key}) : super(key: key);

  @override
  _JWTDebuggerScreenState createState() => _JWTDebuggerScreenState();
}

class _JWTDebuggerScreenState extends State<JWTDebuggerScreen> {
  TextEditingController _inputTextController = TextEditingController();
  TextEditingController _outputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        centerTitle: true,
        title: Text(
          "JWT Debugger",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        decoration: BoxDecoration(
          border: null,
        ),
      ),
      children: [
        ContentArea(builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //!Input Section
                //! Header Top Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Input:',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PushButton(
                          buttonSize: ButtonSize.small,
                          child: const Text('Clipboard'),
                          onPressed: () {
                            FlutterClipboard.paste().then((value) {
                              _inputTextController.text = value;
                              String encoded =
                                  base64.encode(utf8.encode(value));
                              _outputTextController.text = encoded;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PushButton(
                          buttonSize: ButtonSize.small,
                          child: const Text('Clear'),
                          onPressed: () {
                            _inputTextController.text = "";
                            _outputTextController.text = "";
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MacosTextField(
                  controller: _inputTextController,
                  onChanged: (value) {
                    String encoded = base64.encode(utf8.encode(value));
                    _outputTextController.text = encoded;
                  },
                  maxLines: null,
                  minLines: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Output Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Output:',
                      style: TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: [
                        PushButton(
                          buttonSize: ButtonSize.small,
                          child: const Text('Copy'),
                          onPressed: () {
                            FlutterClipboard.copy(_outputTextController.text);
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PushButton(
                          buttonSize: ButtonSize.small,
                          child: const Text('Use as input'),
                          onPressed: () {
                            String value = _outputTextController.text;
                            _inputTextController.text =
                                _outputTextController.text;
                            String encoded = base64.encode(utf8.encode(value));
                            _outputTextController.text = encoded;
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MacosTextField(
                  controller: _outputTextController,
                  maxLines: null,
                  minLines: 15,
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}
