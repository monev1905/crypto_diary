import 'package:flutter/material.dart';
import 'package:crypto_diary/pages/deposit_page.dart';
import 'package:crypto_diary/pages/withdraw_page.dart';
import 'package:crypto_diary/pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple[400],
          secondary: Colors.deepPurple[700],
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Crypto Diary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  //var activeWidgetPage = const DepositPage();
  var activeWidgetPage = const WithdrawPage();

  List<BottomNavigationBarItem> bottomToolbarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      label: 'Deposit',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.money_off),
      label: 'Withdraw',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.grid_on),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  getActiveWidgetPage(selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const DepositPage();
      case 1:
        return const WithdrawPage();
      case 2:
        return const Text('History');
      case 3:
        return const SettingsPage();
      default:
        return const DepositPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Container(
            child: getActiveWidgetPage(selectedIndex),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: bottomToolbarItems.map((item) {
          int index = bottomToolbarItems.indexOf(item);
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Keep the background transparent
                border: Border.all(
                  color: selectedIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(
                    8.0), // Same border radius for rounded corners
              ),
              child: item.icon,
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}
