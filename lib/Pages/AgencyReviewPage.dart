import 'package:flutter/material.dart';

class AgencyReviewPage extends StatefulWidget {
  const AgencyReviewPage({super.key});

  @override
  State<AgencyReviewPage> createState() => _AgencyReviewPageState();
}

class _AgencyReviewPageState extends State<AgencyReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/NoComments.png",
              height: 200,
            ),
            Text(
              "No reviews",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
