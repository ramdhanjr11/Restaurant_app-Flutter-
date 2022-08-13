import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings Page'),
          centerTitle: true,
          backgroundColor: customGreyColor,
          elevation: 0,
        ),
        backgroundColor: customGreyColor,
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white54,
              ),
              child: ListTile(
                trailing: Switch(
                  activeColor: primaryColor,
                  value: _isReminder,
                  onChanged: (value) async {
                    setState(() {
                      _isReminder = !_isReminder;
                    });
                  },
                ),
                title: const Text('Get restaurant reminders'),
              ),
            ),
          ],
        ));
  }
}
