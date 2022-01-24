import 'package:clipboard/clipboard.dart';
import 'package:devtools/view/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class UrlEncodingDecodingScreen extends StatefulWidget {
  const UrlEncodingDecodingScreen({Key? key}) : super(key: key);

  @override
  _UrlEncodingDecodingScreenState createState() =>
      _UrlEncodingDecodingScreenState();
}

class _UrlEncodingDecodingScreenState
    extends State<UrlEncodingDecodingScreen> {
  int _groupValue = 0;
  final TextEditingController _inputTextController = TextEditingController();
  final TextEditingController _outputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        centerTitle: true,
        title: Text(
          "Url Encoding/Decoding",
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
                                    Uri.encodeFull(value);
                                _outputTextController.text = encoded;
                              } else if (_groupValue == 1) {
                                String decoded =
                                    Uri.decodeFull(value);
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
                            String encoded = Uri
                                .encodeFull(_inputTextController.text);
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
                            String decoded = Uri.decodeFull(_inputTextController.text);
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
                      String encoded = Uri.encodeFull(value);
                      _outputTextController.text = encoded;
                    } else if (_groupValue == 1) {
                      String decoded = Uri.decodeFull(value);
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
                                  Uri.encodeFull(value);
                              _outputTextController.text = encoded;
                            } else if (_groupValue == 1) {
                              String decoded = Uri.decodeFull(value);
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
