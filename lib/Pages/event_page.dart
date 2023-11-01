import 'package:flutter/material.dart';


class Eventpage extends StatelessWidget {
  final List<Map<String, String>> agencies = [
    {
      'name': 'Agency 1',
      'description': 'Description of Agency 1',
      'id': '1',
    },
    {
      'name': 'Agency 2',
      'description': 'Description of Agency 2',
      'id': '2',
    },
    // Add more agencies as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: agencies.length,
        itemBuilder: (BuildContext context, int index) {
          var agency = agencies[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.asset('assets/Frame 33553.png'),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '14 December, 2021',
                                  style: const TextStyle(
                                    color: Color(0xFF5668FF),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.13,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  'India vs Pakistan ',
                                  style: const TextStyle(
                                    color: Color(0xFF252627),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.07,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  '| T20 World Cup ',
                                  style: const TextStyle(
                                    color: Color(0xFF252627),
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.07,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: const Color(0xFF5668FF),
                                width: 2.0,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Navigate to the details page with agency data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AgencyDetailsPage(
                                      agencyData: agency,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'See More',
                                style: TextStyle(
                                  color: Color(0xFF5668FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }
}

class AgencyDetailsPage extends StatelessWidget {
  final Map<String, String> agencyData;

  AgencyDetailsPage({required this.agencyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sportd'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${agencyData['name']}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Description: ${agencyData['description']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'ID: ${agencyData['id']}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
