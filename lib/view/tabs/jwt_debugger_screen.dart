import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:devtools/view/widgets/custom_radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JWTDebuggerScreen extends StatefulWidget {
  const JWTDebuggerScreen({Key? key}) : super(key: key);

  @override
  _JWTDebuggerScreenState createState() => _JWTDebuggerScreenState();
}

class _JWTDebuggerScreenState extends State<JWTDebuggerScreen> {
  final TextEditingController _inputTextController = TextEditingController();
  final TextEditingController _headerTextController = TextEditingController();
  final TextEditingController _payloadTextController = TextEditingController();
  final TextEditingController _signatureTextController =
      TextEditingController();

  String sigstatustext = '';

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += "==";
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64 string.');
    }

    return utf8.decode(base64Url.decode(output));
  }

  void parseJWT(token) {
    var parts = token.split(".");
    _headerTextController.text =
        prettyJson(jsonDecode(utf8.decode(base64.decode(parts[0]))), indent: 2);
    _payloadTextController.text =
        prettyJson(jsonDecode(_decodeBase64(parts[1])), indent: 2);

    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey(_signatureTextController.text));
      sigstatustext = 'Signature verified';
    } on FormatException catch (ex) {
      sigstatustext = ex.message;
    } on JWTExpiredError {
      sigstatustext = 'Signature expired';
    } on JWTError catch (ex) {
      sigstatustext = ex.message;
    }
    setState(() {});
  }

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
                              parseJWT(value);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PushButton(
                          buttonSize: ButtonSize.small,
                          child: const Text('Example'),
                          onPressed: () {
                            _inputTextController.text =
                                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
                            parseJWT(_inputTextController.text);
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
                            _headerTextController.text = "";
                            _payloadTextController.text = "";
                            _signatureTextController.text = "";
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
                    parseJWT(value);
                  },
                  maxLines: null,
                  minLines: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Header:'),
                        MacosTextField(
                          controller: _headerTextController,
                          maxLines: null,
                          minLines: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Payload:'),
                        MacosTextField(
                          controller: _payloadTextController,
                          maxLines: null,
                          minLines: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Signature Secret:'),
                        MacosTextField(
                          controller: _signatureTextController,
                          onChanged: (value) {
                            parseJWT(_inputTextController.text);
                          },
                          maxLines: 1,
                          minLines: 1,
                        ),
                        Text(sigstatustext),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          );
        }),
      ],
    );
  }
}
