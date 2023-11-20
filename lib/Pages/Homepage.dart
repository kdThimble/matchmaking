import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:matchmaking/Pages/Profilepage.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:matchmaking/Pages/Servicedetails.dart';

import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../Models/ServiceRequestModel.dart';
import 'AgencyReviewPage.dart';
import 'LoginScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Index of the selected tab
  List<ServiceRequest> serviceRequests = [];
  final List<Color> colorList = [
    Color(0xFFF0635A),
    Color(0xFFF59762),
    Color(0xFF29D697),
    Color(0xFF46CDFB),
    const Color.fromARGB(255, 209, 68, 234),
    // Add more colors as needed
  ];

  final List<Widget> _tabs = [
    Image.asset('assets/home-2.png'),
    Image.asset('assets/frame.png'),
  ];

  // Define the images for your active tabs
  final List<Widget> _activeTabs = [
    Image.asset('assets/home-2b.png'),
    Image.asset('assets/profile1.png'),
  ];
  List<Category> categoryList = [];
  Category extraCategory = Category(id: "", name: "All", description: "");
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCategory();
  }

  Future<void> fetchData() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
    var headers = {
      'Authorization': 'Bearer $authToken',
    };
    print("ssjj");
    print(authToken);
    var request = http.Request(
      'GET',
      Uri.parse(
        'https://eventmanagementproject.onrender.com/api/v1/serviceRequest/all',
      ),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("response ${response.body}");

    if (response.statusCode == 200) {
      print("in success code");
      setState(() {
        var data = json.decode(response.body)['serviceRequests'];
        for (Map i in data) {
          serviceRequests.add(ServiceRequest.fromJson(i));
        }
      });
    } else {
      print("in unsuccessful code");
    }
  }

  Future<void> fetchCategory() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
    List<Category> apicategoryList = [];
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    print(authToken);
    var request = http.Request(
      'GET',
      Uri.parse(
        'https://eventmanagementproject.onrender.com/api/v1/category/all',
      ),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("response ${response.body}");

    if (response.statusCode == 200) {
      print("in success code");
      setState(() {
        var data = json.decode(response.body)['categories'];
        for (Map i in data) {
          apicategoryList.add(Category.fromJson(i));
        }
        categoryList = [extraCategory, ...apicategoryList];
        isLoading = false;
      });
    } else {
      print("in unsuccessful code");
    }
  }

  String selectedCategory = "";

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF5D56F3),
              ),
              child: Center(
                  child: Text(
                'Side Menu',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              )),
            ),
            ListTile(
              leading: const Icon(
                Icons.reviews,
                color: Color(0xFF5669FF),
              ),
              title: const Text('Reviews',
                  style: TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              textColor: const Color(0xFF5669FF),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AgencyReviewPage())));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.add_business,
                color: Color(0xFF5669FF),
              ),
              title: const Text('Log Out',
                  style: TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              textColor: const Color(0xFF5669FF),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const LoginScreen())));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Blue rounded container
          Container(
            height: height * 0.33,
            decoration: const BoxDecoration(
              color: Color(0xFF5D56F3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
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
                    GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: const SizedBox(
                          height: 62,
                          child: Center(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        )),
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
                              const Opacity(
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
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
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
                    Container(
                      // Adjust the size as needed
                      height: 62,
                      width: 45, // Adjust the size as needed
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF7974E7),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications, // Use the notification icon
                          color:
                              Colors.white, // Change the icon color as needed
                          size: 30.0, // Adjust the icon size as needed
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 335,
                      height: 39.30,
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/search.png', // Replace with your search image asset
                                width: 30.0,
                                height: 30.0,
                                fit: BoxFit.fill,
                              ),
                              const VerticalDivider(
                                color:
                                    Color(0xFF7974E7), // Vertical divider color
                                thickness:
                                    1.0, // Adjust the thickness as needed
                              ),
                              SizedBox(
                                width: 160, // Adjust the width as needed
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search...', // Hint text
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                          .withOpacity(0.30), // Hint text color
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
                          Container(
                            width: 80,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(
                                  0xFF7974E7), // Filter button color
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
                                Row(
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
                                    const SizedBox(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
                // SizedBox(height: 18.0),
              ],
            ),
          ),
          Positioned(
            top: height * 0.3, // Adjust the top position to control the overlay
            left: 0,
            right: 0,
            // bottom: 0, // Allow the scroll view to expand to the bottom
            child: Container(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  var category = categoryList[index];
                  var isSelected = selectedCategory == category.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category.id ?? "";
                        isSelected = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 40.0,
                        constraints: BoxConstraints(
                          minWidth: 140, // Set the minimum width here
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: colorList[5 % (index + 1)],
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 1.5)
                              : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              category.name ?? "Category",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: height *
                0.34, // Adjust the top position to start below the top section
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (BuildContext context, int index) {
                  var agency = serviceRequests[index];
                  if (selectedCategory == "" ||
                      agency.categoryId == selectedCategory) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ServiceDetails(
                                          requestId: serviceRequests[index].id!,
                                        ))));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0), // Blue border
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/Rectangle 4.png',
                                        width: width * 0.1,
                                      ), // Replace with your image asset
                                      const SizedBox(
                                          width:
                                              16.0), // Adjust the spacing between image and text
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  agency.title ?? "No title",
                                                  style: const TextStyle(
                                                    color: Color(0xFF252627),
                                                    fontSize: 17,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0.07,
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    icon: Icon(
                                                      Icons.arrow_forward,
                                                      color: Color(0xFF667085),
                                                    ))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              agency.brief ?? "No Description",
                                              style: const TextStyle(
                                                color: Color(0xFF667085),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                height: 0.13,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    'assets/map-pin.png'),
                                                SizedBox(
                                                    width:
                                                        4), // Replace with your image asset
                                                Text(agency.address!.city!),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Add space between each container
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    );
                  }
                  return SizedBox();
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
          if (_selectedIndex == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ProfileScreen())));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () {
          // Add your action when the button is pressed.
        },
        child: Stack(
          children: [
            Container(
              width: 60.0, // Adjust the size as needed
              height: 60.0, // Adjust the size as needed
              decoration: const BoxDecoration(
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
