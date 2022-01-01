import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:devtools/view/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class Base64EncodingDecodingScreen extends StatefulWidget {
  const Base64EncodingDecodingScreen({Key? key}) : super(key: key);

  @override
  _Base64EncodingDecodingScreenState createState() =>
      _Base64EncodingDecodingScreenState();
}

class _Base64EncodingDecodingScreenState
    extends State<Base64EncodingDecodingScreen> {
  int _groupValue = 0;
  TextEditingController _inputTextController = TextEditingController();
  TextEditingController _outputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        centerTitle: true,
        title: Text(
          "Base64 Encoding/Decoding",
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
                              if (_groupValue == 0) {
                                String encoded =
                                    base64.encode(utf8.encode(value));
                                _outputTextController.text = encoded;
                              } else if (_groupValue == 1) {
                                String decoded =
                                    utf8.decode(base64.decode(value));
                                _outputTextController.text = decoded;
                              }
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
                    Row(
                      children: [
                        CustomRadioListTile<int>(
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value!;
                            });
                            String encoded = base64
                                .encode(utf8.encode(_inputTextController.text));
                            _outputTextController.text = encoded;
                          },
                          title: 'Encode',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomRadioListTile<int>(
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value!;
                            });
                            String decoded = utf8.decode(
                                base64.decode(_inputTextController.text));
                            _outputTextController.text = decoded;
                          },
                          title: 'Decode',
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MacosTextField(
                  controller: _inputTextController,
                  onChanged: (value) {
                    if (_groupValue == 0) {
                      String encoded = base64.encode(utf8.encode(value));
                      _outputTextController.text = encoded;
                    } else if (_groupValue == 1) {
                      String decoded = utf8.decode(base64.decode(value));
                      _outputTextController.text = decoded;
                    }
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
                            if (_groupValue == 0) {
                              String encoded =
                                  base64.encode(utf8.encode(value));
                              _outputTextController.text = encoded;
                            } else if (_groupValue == 1) {
                              String decoded =
                                  utf8.decode(base64.decode(value));
                              _outputTextController.text = decoded;
                            }
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
