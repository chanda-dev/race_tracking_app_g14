import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class ParticipantsBody extends StatelessWidget {
  const ParticipantsBody({super.key});

  final List<Map<String, dynamic>> participants = const [
    {'BIB': '001', 'NAME': 'Sok Chanda', 'AGE': 25},
    {'BIB': '002', 'NAME': 'Dara Sok', 'AGE': 30},
    {'BIB': '003', 'NAME': 'Sreyleak Kim', 'AGE': 56},
    {'BIB': '004', 'NAME': 'Vuthy Chan', 'AGE': 19},
    {'BIB': '005', 'NAME': 'Sophea Neang', 'AGE': 50},
    {'BIB': '006', 'NAME': 'Rithy Touch', 'AGE': 33},
    {'BIB': '007', 'NAME': 'Monika Chhun', 'AGE': 50},
    {'BIB': '008', 'NAME': 'Nita Ly', 'AGE': 25},
    {'BIB': '009', 'NAME': 'Bopha Em', 'AGE': 26},
    {'BIB': '010', 'NAME': 'Kimsan Oum', 'AGE': 35},
    {'BIB': '011', 'NAME': 'Dany Hor', 'AGE': 36},
    {'BIB': '012', 'NAME': 'Sokun Rath', 'AGE': 36},
    {'BIB': '013', 'NAME': 'Vannak Hem', 'AGE': 38},
    {'BIB': '014', 'NAME': 'Linda Sou', 'AGE': 25},
    {'BIB': '015', 'NAME': 'Makara Keo', 'AGE': 18},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Segments Cover Box
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Segments Cover',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ),
        ),

        // List of Participants Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Text(
                'List of Participants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 15, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${participants.length} P',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.person_add), onPressed: () {}),
            ],
          ),
        ),

        // Table of participants
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.red),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  columns: const [
                    DataColumn(label: Text('BIB')),
                    DataColumn(label: Text('NAME')),
                    DataColumn(label: Text('AGE')),
                  ],
                  rows:
                      participants
                          .map(
                            (participant) => DataRow(
                              cells: [
                                DataCell(Text(participant['BIB'])),
                                DataCell(Text(participant['NAME'])),
                                DataCell(Text(participant['AGE'].toString())),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
