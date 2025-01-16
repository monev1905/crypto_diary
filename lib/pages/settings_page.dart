import 'package:flutter/material.dart';

import 'package:crypto_diary/pages/page_header.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<MultiSelectItem<String>> _items = [
    MultiSelectItem("Option 1", "Option 1"),
    MultiSelectItem("Option 2", "Option 2"),
    MultiSelectItem("Option 3", "Option 3"),
    MultiSelectItem("Option 4", "Option 4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: PageHeader(
            title: 'Settings',
            subtitle: '',
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Your Crypto Currencies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              MultiSelectDialogField(
                items: _items,
                title: const Text("Options"),
                listType: MultiSelectListType.LIST,
                searchable: true,
                selectedColor: Theme.of(context).colorScheme.primary,
                cancelText: const Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                confirmText: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                selectedItemsTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                itemsTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.settings,
                ),
                buttonText: const Text(
                  "Choose options",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (values) {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
