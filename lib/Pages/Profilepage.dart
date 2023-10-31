import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/profilescreen.dart';


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 64.0,
            backgroundImage: AssetImage('assets/Rectangle 4.png'),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            onTap:() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                       Myprofile())));
            },
              child: ProfileOption('Profile', Icons.person)),
          SizedBox(height: 20.0),
          ProfileOption('Notification', Icons.notifications),
          SizedBox(height: 20.0),
          ProfileOption('Settings', Icons.settings),
          SizedBox(height: 20.0),
          ProfileOption('Sign Out', Icons.exit_to_app),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String text;
  final IconData icon;

  ProfileOption(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
