import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/Profilepage.dart';
import 'package:matchmaking/Pages/user/Screen2.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../Agency/AgencyRegistration.dart';
import '../AgencyReviewPage.dart';

class Newhomepage extends StatefulWidget {
  const Newhomepage({super.key});

  @override
  State<Newhomepage> createState() => _NewhomepageState();
}

class _NewhomepageState extends State<Newhomepage> {
  SfRangeValues _values = const SfRangeValues(50000.0, 80000.0);
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
  TextEditingController descriptionController = TextEditingController();
  late String _description;
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              leading: Icon(
                Icons.reviews,
                color: Color(0xFF5669FF),
              ),
              title: Text('Reviews',
                  style: TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              textColor: Color(0xFF5669FF),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AgencyReviewPage())));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_business,
                color: Color(0xFF5669FF),
              ),
              title: Text('Become an Agency',
                  style: TextStyle(
                      color: Color(0xFF5669FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              textColor: Color(0xFF5669FF),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AgencyRegistration())));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
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
                                    Navigator.pop(context);
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
                                    size:
                                        30.0, // Adjust the icon size as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Screen2())));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img_2.png', // Replace with your image path
                                height: 150,
                                width: 150,
                              ),
                              const SizedBox(width: 40),
                              Image.asset(
                                'assets/img_8.png', // Replace with your image path
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Screen2())));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img_9.png', // Replace with your image path
                                height: 40,
                              ),
                              const SizedBox(width: 40),
                              Image.asset(
                                'assets/img_4.png', // Replace with your image path
                                width: 150,
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Screen2())));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img_3.png', // Replace with your image path
                                height: 150,
                                width: 150,
                              ),
                              const SizedBox(width: 40),
                              Image.asset(
                                'assets/img_11.png', // Replace with your image path
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Screen2())));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 20),
                              Image.asset(
                                'assets/img_10.png', // Replace with your image path
                                height: 30,
                              ),
                              const SizedBox(width: 70),
                              Image.asset(
                                'assets/img_5.png', // Replace with your image path
                                width: 150,
                                height: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Screen2())));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img_6.png', // Replace with your image path
                                height: 150,
                                width: 150,
                              ),
                              const SizedBox(width: 40),
                              Image.asset(
                                'assets/img_12.png', // Replace with your image path
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            )
          ],
        ),
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
