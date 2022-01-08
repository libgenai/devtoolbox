import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class WordCountScreen extends StatelessWidget {
  const WordCountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      titleBar: const TitleBar(
        centerTitle: true,
        title: Text(
          "Word Count",
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
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: WordCount(),
            ),
          );
        }),
      ],
    );
  }
}

class WordCount extends StatefulWidget {
  const WordCount({Key? key}) : super(key: key);

  @override
  _WordCountState createState() => _WordCountState();
}

class _WordCountState extends State<WordCount> {
  final _inputTextController = TextEditingController();
  String text = "";

  @override
  void initState() {
    super.initState();
    _inputTextController.addListener(() {
      setState(() {
        text = _inputTextController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
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
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              PushButton(
                buttonSize: ButtonSize.small,
                child: const Text('Clear'),
                onPressed: _inputTextController.clear,
              ),
            ],
          ),
        ),
        MacosTextField(
          controller: _inputTextController,
          minLines: 15,
          maxLines: null,
        ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: WordCountStats(text),
        ),
      ],
    );
  }
}

class WordCountStats extends StatelessWidget {
  final String text;

  const WordCountStats(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordCount = text
        .split(RegExp(r"\s+"))
        .where((element) => element.isNotEmpty)
        .length;

    final alphanumericRegex = RegExp(r'[A-Za-z0-9]+');
    final alphanumericCount = text.characters
        .where((char) => alphanumericRegex.hasMatch(char))
        .length;

    final whitespaceRegex = RegExp(r'\s+');
    final whitespaceCount =
        text.characters.where((char) => whitespaceRegex.hasMatch(char)).length;

    final specialCharacterRegex = RegExp(r'[^A-Za-z0-9\s]+');
    final specialCharacterCount = text.characters
        .where((char) => specialCharacterRegex.hasMatch(char))
        .length;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(200),
        children: [
          TableRow(
            children: [const Text("Word count:"), Text("$wordCount")],
          ),
          TableRow(
            children: [
              const Text("Alphanumerics:"),
              Text("$alphanumericCount")
            ],
          ),
          TableRow(
            children: [const Text("Whitespaces:"), Text("$whitespaceCount")],
          ),
          TableRow(
            children: [
              const Text("Punctutation / others:"),
              Text("$specialCharacterCount")
            ],
          ),
          TableRow(
            children: [
              const Text("Total characters:"),
              Text("${text.characters.length}")
            ],
          ),
        ],
      ),
    );
  }
}
