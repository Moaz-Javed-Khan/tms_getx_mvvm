import 'package:flutter/material.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  List<String> userNames = <String>[
    'User 1',
    'User 2',
    'User 3',
    'User 4',
  ];

  List<String> userIds = <String>[
    '1',
    '2',
    '3',
    '4',
  ];

  List<String> selectedUserIDs = [];

  // String dropdownValue = 'User 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(10),
            value: selectedUserIDs.isNotEmpty
                ? selectedUserIDs[0]
                : null, //dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.tealAccent,
            ),
            onChanged: (String? value) {
              setState(() {
                if (selectedUserIDs.contains(value)) {
                  // selectedUserIDs.remove(value);
                  print(selectedUserIDs);
                } else {
                  selectedUserIDs.add(value!);
                  print(selectedUserIDs);
                }
              });
            },
            // onChanged: (String? value) {
            //   setState(() {
            //     dropdownValue = value!;
            //   });
            // },
            items: userNames.asMap().entries.map<DropdownMenuItem<String>>(
              (entry) {
                int index = entry.key;
                String name = entry.value;
                String id = userIds[index];

                return DropdownMenuItem<String>(
                  value: id,
                  child: Text(name),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
