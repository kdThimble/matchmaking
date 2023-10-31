import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';


class Agencydetails extends StatefulWidget {
  const Agencydetails({Key? key, required this.selectedIndex}) : super(key: key);
  final String selectedIndex;
  @override
  State<Agencydetails> createState() => _AgencydetailsState();
}

class _AgencydetailsState extends State<Agencydetails> {
  Agency ? agency;
  Future<void> fetchAgencyDetails() async {
    try {
      final userProvider = Provider.of<AuthProvider>(context, listen: false);
      final authToken = userProvider.token;
      var headers = {
        'Authorization': 'Bearer $authToken',
      };

      var request = http.Request(
        'GET',
        Uri.parse(
          'https://eventmanagementproject.onrender.com/api/v1/agency/${widget.selectedIndex}',
        ),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        setState(() {
          agency = Agency.fromJson(jsonResponse['agency']);
        });
      } else {
        print(response.reasonPhrase);
        throw Exception('Failed to load agency details');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  int _selectedTab = 0;


  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    print("ywss");
    print(widget.selectedIndex);
    super.initState();
   fetchAgencyDetails();
    print("ywss");
    // print(agency!.name);
  }

  @override
  Widget build(BuildContext context) {
    if (agency == null) {
      // Render a loading indicator or placeholder here while agency is being fetched.
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      );
    }
    else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50.0),
            Image.asset(
              'assets/Rectangle 4.png', // Replace with your image asset
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                agency!.name ?? 'loading..', // Check if agency is not null
                style: TextStyle(
                  color: Color(0xFF110C26),
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 154,
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5668FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Adjust the alignment as needed
                    children: [
                      Image.asset(
                        'assets/Vector5.png', // Replace with your image asset
                        width: 24.0, // Adjust the image width
                        height: 24.0, // Adjust the image height
                      ),
                      Text(
                        'Pricing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.0),
                Container(
                  width: 154,
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF5668FF)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Adjust the alignment as needed
                    children: [
                      Image.asset(
                        'assets/call.png', // Replace with your image asset
                        width: 24.0, // Adjust the image width
                        height: 24.0, // Adjust the image height
                      ),
                      Text(
                        'Contact',
                        style: TextStyle(
                          color: Color(0xFF5668FF),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TabItem(
                  text: 'About',
                  isSelected: _selectedTab == 0,
                  onTap: () => _onTabTapped(0),
                ),
                SizedBox(width: 70,),
                TabItem(
                  text: 'Event',
                  isSelected: _selectedTab == 1,
                  onTap: () => _onTabTapped(1),
                ),
                SizedBox(width: 70,),
                TabItem(
                  text: 'Reviews',
                  isSelected: _selectedTab == 2,
                  onTap: () => _onTabTapped(2),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  TabItem({required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: isSelected
              ? Border(
            bottom: BorderSide(
              color: Color(0xFF5668FF),
              width: 3.0,
            ),
          )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Color(0xFF5668FF) : Colors.black,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}

class Agency {
  final String id;
  final String name;
  final String description;
  final List<dynamic> documents;
  final String createdAt;
  final String updatedAt;
  final String userId;
  // final List<dynamic> event;
  final List<dynamic> services;

  Agency({
    required this.id,
    required this.name,
    required this.description,
    required this.documents,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    // required this.event,
    required this.services,
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      documents: json['documents'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
      // event: json['event'],
      services: json['services'],
    );
  }

// Add any other methods or properties you need for your app
}