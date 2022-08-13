import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/shared_pref_reminder_helper.dart';

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
        body: ChangeNotifierProvider(
          create: (_) => SchedulingProvider(prefs: SharedPrefReminderHelper()),
          child: Consumer<SchedulingProvider>(
            builder: (context, provider, child) {
              log(provider.isScheduled.toString());
              _isReminder = provider.isScheduled;

              return Column(
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
                            provider.setReminderOption(value);
                          });
                        },
                      ),
                      title: const Text('Get restaurant reminders'),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
