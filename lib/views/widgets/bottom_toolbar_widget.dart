import 'package:crypto_diary/data/notifiers.dart';
import 'package:flutter/material.dart';

class BottomToolbarWidget extends StatefulWidget {
  const BottomToolbarWidget({super.key});

  @override
  State<BottomToolbarWidget> createState() => _BottomToolbarWidgetState();
}

class _BottomToolbarWidgetState extends State<BottomToolbarWidget> {
  final List<BottomNavigationBarItem> bottomToolbarItems = const [
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (newIndex) {
            selectedPageNotifier.value = newIndex;
          },
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                    color: selectedPage == index
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
        );
      },
    );
  }
}
