import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/Session.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? _selectedLanguageIndex;
  final List<String> _languages = ['English', 'Arabic'];
  final List<String> _languageCodes = ['en', 'ne'];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() async {
    Locale currentLocale = await getLocale(); // Retrieve saved locale
    setState(() {
      _selectedLanguageIndex = _languageCodes.indexOf(currentLocale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'choose_lang') ?? 'Choose Language'),
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          return RadioListTile(
            title: Text(_languages[index]),
            value: index,
            groupValue: _selectedLanguageIndex,
            onChanged: (value) {
              setState(() {
                _selectedLanguageIndex = value as int;
                _changeLanguage(_languageCodes[_selectedLanguageIndex!]);
              });
            },
          );
        },
      ),
    );
  }

  void _changeLanguage(String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocale(context, _locale); // Ensure this method is defined in your MyApp class
  }
}
