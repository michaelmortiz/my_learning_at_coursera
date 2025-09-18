import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  String _storedValue = '';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body:
          SafeArea(
            child: Column(
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: 'Value to store')
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: _saveData,
                        child: Icon(Icons.save)
                    ),
                    Padding(padding: EdgeInsetsGeometry.all(10)),
                    ElevatedButton(
                        onPressed: _loadData,
                        child: Icon(Icons.autorenew_rounded)
                    ),
                    Padding(padding: EdgeInsetsGeometry.all(10)),
                    ElevatedButton(
                        onPressed: _launchUrl,
                        child: Icon(Icons.open_in_browser)
                    ),
                ]),
                const SizedBox(height: 16),
                Text(_storedValue)
              ])
        )
      )
    );
  }

  void _launchUrl() async {
    if (!await url_launcher.launchUrl(Uri.parse('https://flutter.dev'))) {
      throw 'Could not launch the url';
    }
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('custom_key', _controller.text);
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('custom_key') ?? 'No data';
    });
  }
}
