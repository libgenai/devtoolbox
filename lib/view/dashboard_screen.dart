import 'package:devtools/view/tabs/base64_encoding_decoding_screen.dart';
import 'package:devtools/view/tabs/json_format_validate_screen.dart';
import 'package:devtools/view/tabs/json_to_yaml_screen.dart';
import 'package:devtools/view/tabs/jwt_debugger_screen.dart';
import 'package:devtools/view/tabs/url_encoding_decoding_screen.dart';
import 'package:devtools/view/tabs/word_count.dart';
import 'package:devtools/view/tabs/yaml_to_json_screen.dart';
import 'package:devtools/view/tabs/qr_code_to_text_screen.dart';
import 'package:devtools/view/tabs/text_to_qr_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int pageIndex = 0;

  final List<Widget> pages = [
    const Base64EncodingDecodingScreen(),
    const JsonFormatValidateScreen(),
    const JsonToYamlScreen(),
    const YamlToJsonScreen(),
    const QrCodeToTextScreen(),
    const TextToQrCodeScreen(),
    const JWTDebuggerScreen(),
    const WordCountScreen(),
    const UrlEncodingDecodingScreen(),
  ];

  Color textLuminance(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  _launchURL() async {
    const url = 'https://github.com/nileshtrivedi/devtoolbox/discussions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      child: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      sidebar: Sidebar(
        minWidth: 240,
        bottom: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MacosListTile(
            title: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 12),
              ),
              onPressed: _launchURL,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.mail,
                    size: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Feedback for v1.0.0'),
                ],
              ),
            ),
          ),
        ),
        builder: (context, controller) {
          return SidebarItems(
            currentIndex: pageIndex,
            onChanged: (i) => setState(() => pageIndex = i),
            scrollController: controller,
            items: const [
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'Base64 Encoding/Decoding',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'JSON Format/Validate',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'JSON to YAML',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'YAML to JSON',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'QR Image to Text (WIP)',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'Text to QR Image (WIP)',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'JWT Debugger',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'Word Count',
                  style: TextStyle(fontSize: 13),
                ),
              ),

              SidebarItem(
                leading: MacosIcon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                label: Text(
                  'URL Encoding / Decoding',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
