import 'package:flutter/material.dart';
import 'package:crypto_diary/pages/deposit_page.dart';
import 'package:crypto_diary/pages/withdraw_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.deepPurple[200],
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  ];

  getActiveWidgetPage(selectedIndex) {
    if (selectedIndex == 0) {
      return const DepositPage();
    } else if (selectedIndex == 1) {
      return const WithdrawPage();
    } else if (selectedIndex == 2) {
      return const Text('History');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: getActiveWidgetPage(selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        items: bottomToolbarItems,
      ),
    );
  }
}
