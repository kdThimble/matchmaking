import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _selectedTab = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Agency 1',
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFF5668FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust the alignment as needed
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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF5668FF)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust the alignment as needed
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