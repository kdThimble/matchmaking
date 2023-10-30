import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/LoginScreen.dart';
import 'package:matchmaking/Pages/RegistrationScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matchmaking/Pages/profilepage.dart';
import 'package:http/http.dart' as http;


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Index of the selected tab
  List<dynamic> agencies = [];

  final List<Widget> _tabs = [
    Image.asset('assets/home-2.png'),
    Image.asset('assets/frame.png'),
  ];

  // Define the images for your active tabs
  final List<Widget> _activeTabs = [
    Image.asset('assets/home-2b.png'),
    Image.asset('assets/profile1.png'),
  ];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var headers = {
      'User-Agent': 'insomnia/8.3.0',
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1M2ZmOTcxMzQ2MTdlMGUyNjAxY2ZmZCIsImlhdCI6MTY5ODY5Mjc3NywiZXhwIjoxNjk4Nzc5MTc3fQ.UoWazTQBPSCZWRB03n9W92Giz_XoNxHixcIJVYbjd4o',
    };
    var request = http.Request('GET', Uri.parse('https://eventmanagementproject.onrender.com/api/v1/agency/all'));
    request.headers.addAll(headers);

    final response = await http.get(
      Uri.parse('https://eventmanagementproject.onrender.com/api/v1/agency/all'),
    );

    if (response.statusCode == 200) {
      setState(() {
        agencies = json.decode(response.body)['agencies'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //   backgroundColor:Color(0xFF4a44c2),
      //   automaticallyImplyLeading: false, // Hide the back arrow
      // ),
      body: Stack(
        children: [
          // Blue rounded container
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xFF5D56F3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
          ),
          // Your top section
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/Combined Shape.png',
                      height: 62,
                     width: 30,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(width: 12),
                              Opacity(
                                opacity: 0.70,
                                child: Text(
                                  'Current Location',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.57,
                                child: Image.asset(
                                  'assets/loc.png', // Replace with your image asset
                                  // fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6,),
                        Text(
                          'New Delhi, India',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF4F4FE),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Container(// Adjust the size as needed
                      height: 62,
                      width: 45,// Adjust the size as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF7974E7),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications, // Use the notification icon
                          color: Colors.white, // Change the icon color as needed
                          size: 30.0, // Adjust the icon size as needed
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 335,
                      height: 39.30,
                      padding: const EdgeInsets.all(4),
                      // decoration: BoxDecoration(
                      //   color: Colors.white, // White background color
                      //   borderRadius: BorderRadius.circular(50.0),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/search.png', // Replace with your search image asset
                                  width: 30.0,
                                  height: 30.0,
                                  fit: BoxFit.fill,
                                ),
                                VerticalDivider(
                                  color: Color(0xFF7974E7), // Vertical divider color
                                  thickness: 1.0, // Adjust the thickness as needed
                                ),
                                SizedBox(
                                  width: 160, // Adjust the width as needed
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search...', // Hint text
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.30), // Hint text color
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFF7974E7), // Filter button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(width: 12),
                                      Image.asset(
                                        'assets/Vector.png', // Replace with your search image asset
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 35.90,
                                        height: 16.57,
                                        child: Text(
                                          'Filters',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
                // SizedBox(height: 18.0),
              ],
            ),
          ),
          Positioned(
            top: -140.0, // Adjust the top position to control the overlay
            left: 0,
            right: 0,
            bottom: 0, // Allow the scroll view to expand to the bottom
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color(0xFFF0635A),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Container(
                          width: 17.73,
                          height: 17.73,
                          child: Stack(children: [
                            Image.asset(
                              'assets/Group.png',
                              width: 30.0,
                              fit: BoxFit.fill,
                            ),
                            ]
                          )
                          ),
                            SizedBox(width: 8.0),
                            Text(
                              'Sports',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Add your other containers here
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color(0xFFF59762),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 17.73,
                                height: 17.73,
                                child: Stack(children: [
                                  Image.asset(
                                    'assets/Vector (1).png',
                                    width: 30.0,
                                    fit: BoxFit.fill,
                                  ),
                                ]
                                )
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Music',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: Color(0xFF29D697),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 17.73,
                                height: 17.73,
                                child: Stack(children: [
                                  FaIcon(
                                    FontAwesomeIcons.utensils, // Use the utensil icon
                                    color: Colors.white, // Change the icon color as needed
                                    size: 20.0, // Adjust the icon size as needed
                                  ),
                                ]
                                )
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Food',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                          color: Color(0xFF46CDFB),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 17.73,
                                height: 17.73,
                                child: Stack(children: [
                                  Image.asset(
                                    'assets/Group.png',
                                    width: 30.0,
                                    fit: BoxFit.fill,
                                  ),
                                ]
                                )
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Arts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

    Positioned(
      top: 250, // Adjust the top position to start below the top section
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView.builder(
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
                  border: Border.all(color: Colors.grey, width: 1.0), // Blue border
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset('assets/Rectangle 4.png'), // Replace with your image asset
                        SizedBox(width: 16.0), // Adjust the spacing between image and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                agency['description'],
                              style: TextStyle(
                              color: Color(0xFF667085),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.13,
                              ),
                              ),
                              SizedBox(height: 18,),
                              Text(
                                agency['name'],
                                style: TextStyle(
                                  color: Color(0xFF252627),
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0.07,
                                ),
                              ),
                              SizedBox(height: 22,),
                              Row(
                                children: [
                                  Image.asset('assets/map-pin.png'), // Replace with your image asset
                                  Text('New Delhi'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0), // Border radius of 10
                            border: Border.all(color: Color(0xFF5668FF), width: 2.0), // Blue border
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Handle the "See More" button tap
                            },
                            child: Text(
                              'See More',
                              style: TextStyle(
                                color: Color(0xFF5668FF), // Text color for the "See More" button
                              ),
                            ),
                          ),
                        ),
                        // Add space between each container
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        );
      }),
    ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? _activeTabs[0] : _tabs[0],
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? _activeTabs[1] : _tabs[1],
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if(_selectedIndex == 1){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        Profilepage())));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.black ,
        shape: CircleBorder(),
        onPressed: () {
          // Add your action when the button is pressed.
        },
        child: Stack(
          children: [
            Container(
              width: 60.0, // Adjust the size as needed
              height: 60.0, // Adjust the size as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/search-normal.png', // Replace with your image asset
                width: 30.0, // Adjust the size as needed
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}