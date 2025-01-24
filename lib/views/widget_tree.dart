import 'package:crypto_diary/data/constants.dart';
import 'package:crypto_diary/data/notifiers.dart';
import 'package:flutter/material.dart';

import 'package:crypto_diary/views/widgets/bottom_toolbar_widget.dart';
import 'package:crypto_diary/views/pages/deposit_page.dart';
import 'package:crypto_diary/views/pages/withdraw_page.dart';
import 'package:crypto_diary/views/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatefulWidget {
  final String title;

  const WidgetTree({
    super.key,
    required this.title,
  });

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  var selectedIndex = 0;
  var activeWidgetPage = const WithdrawPage();

  List<Widget> pages = [
    const DepositPage(),
    const WithdrawPage(),
    const Text('History'),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          ValueListenableBuilder(
            valueListenable: isDarkModeNotifier,
            builder: (context, isDarkMode, child) {
              return IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () async {
                  isDarkModeNotifier.value = !isDarkModeNotifier.value;

                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setBool(
                      Constants.themeModeKey, isDarkModeNotifier.value);
                },
              );
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectePage, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: pages.elementAt(selectePage),
          );
        },
      ),
      bottomNavigationBar: const BottomToolbarWidget(),
    );
  }
}
