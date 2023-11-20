import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/LoginScreen.dart';
import 'package:matchmaking/Pages/Profilepage.dart';
import 'package:matchmaking/Pages/user/Screen2.dart';
import 'package:http/http.dart' as http;
import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../Models/CategoryModel.dart';
import '../../providers/form_provider.dart';
import '../Agency/AgencyRegistration.dart';
import '../AgencyReviewPage.dart';

class Newhomepage extends StatefulWidget {
  const Newhomepage({super.key});

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage> {
  int _selectedIndex = 0; // Index of the selected tab
  List<dynamic> agencies = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
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
          categoryList.add(Category.fromJson(i));
        }
        isLoading = false;
      });
    } else {
      print("in unsuccessful code");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    final formProvider = Provider.of<FormProvider>(context);
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
              title: const Text('Become an Agency',
                  style: TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              textColor: const Color(0xFF5669FF),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const AgencyRegistration())));
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
          Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/FormBG.png",
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
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
                            const SizedBox(
                              height: 62,
                              child: Center(
                                child: Text(
                                  "Select Service",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
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
                                  Icons
                                      .notifications, // Use the notification icon
                                  color: Colors
                                      .white, // Change the icon color as needed
                                  size: 30.0, // Adjust the icon size as needed
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: categoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var category = categoryList[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          formProvider.categoryId =
                                              category.id!;
                                        });

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const Screen2())));
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(45)),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 30, sigmaY: 30),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minHeight: height *
                                                  0.2, // set minimum height here
                                            ),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(45)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Expanded(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      category.name ?? "Error",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 29,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      category.description ??
                                                          "Error",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white70,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                  ],
                                );
                              }),
                        )
                ],
              ),
            ),
          )
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
