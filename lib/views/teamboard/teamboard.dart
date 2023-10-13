import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/teamboard_card.dart';

class Teamboard extends StatefulWidget {
  const Teamboard({super.key});

  @override
  State<Teamboard> createState() => _TeamboardState();
}

class _TeamboardState extends State<Teamboard> {
  List<String> list = <String>[
    'Team 1',
    'Team 2',
    'Team 3',
    'Team 4',
  ];

  String dropdownValue = 'Team 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Expanded(
                  child: TeamboardCard(
                    cardName: 'Total delayed Tasks',
                    number: 0,
                  ),
                ),
                const Expanded(
                  child: TeamboardCard(
                    cardName: 'Total in-progress Tasks',
                    number: 0,
                  ),
                ),
                const Expanded(
                  child: TeamboardCard(
                    cardName: 'Total success Tasks',
                    number: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              isExpanded: true,
              borderRadius: BorderRadius.circular(10),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_sharp),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.tealAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // add animation here...
          ],
        ),
      ),
    );
  }
}
