import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
        body: Consumer<SchedulingProvider>(
          builder: (context, provider, child) {
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
                          provider.scheduledRestaurant(value);
                          final isScheduled = provider.isScheduled;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(isScheduled
                                ? 'You have been turn on the reminder'
                                : 'You have been turn off the reminder'),
                          ));
                        });
                      },
                    ),
                    title: const Text('Get restaurant reminders'),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
