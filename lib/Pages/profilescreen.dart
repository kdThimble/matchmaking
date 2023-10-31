import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Myprofile extends StatefulWidget {
  @override
  _MyprofileState createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call the function to fetch the user profile details
    fetchUserProfileDetails();
  }

  Future<void> fetchUserProfileDetails() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
    var headers = {
      'Authorization': 'Bearer $authToken',
    };
    print("ssjj");
    print(authToken);

    var request = http.Request(
        'GET', Uri.parse('https://eventmanagementproject.onrender.com/api/v1/users/profile'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
     print("response aaya lch");
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      Map<String, dynamic> profileData = json.decode(jsonResponse);

      setState(() {
        fullNameController.text = profileData['fullName'];
        emailController.text = profileData['email'];
        cityController.text = profileData['address']['city'];
        stateController.text = profileData['address']['state'];
        countryController.text = profileData['address']['country'];
        zipCodeController.text = profileData['address']['zipCode'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }


  Future<void> updateProfile() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    };
    print("ssjj");
    print(authToken);

    var request = http.Request(
        'PUT', Uri.parse('https://eventmanagementproject.onrender.com/api/v1/users/profile/update'));
    request.headers.addAll(headers);

    var profileData = {
      "fullName": fullNameController.text,
      "address": {
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "zipCode": zipCodeController.text,
        "lat": "",
        "lng": ""
      }
    };

    request.body = json.encode(profileData);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      // Show a green flush bar for success
      Flushbar(
        message: 'Profile updated successfully',
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      )..show(context);
    } else {
      print(response.reasonPhrase);
      // Show a red flush bar for error
      Flushbar(
        message: 'Profile update failed',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        primary: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when arrow_back is pressed
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Circular Image with Edit Button
              Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 64.0,
                      backgroundImage: AssetImage('assets/Rectangle 4.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 48.0, // Adjust size as needed
                        height: 48.0, // Adjust size as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Implement your image editing logic here
                          },
                          icon: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Full Name Text Field with Border and Background Color
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200], // Off-white background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: InputBorder.none, // Remove default underline
                        contentPadding:  EdgeInsets.all(8.0),
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
              ),

              // Email Text Field with Border and Background Color
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200], // Off-white background color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                        contentPadding:  EdgeInsets.all(8.0),
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
              ),

              // Address Fields (City, State, Country, ZipCode) with Border and Background Color
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200], // Off-white background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            labelText: 'City',
                            border: InputBorder.none,
                            contentPadding:  EdgeInsets.all(8.0),
                            icon: Icon(Icons.location_city),
                          ),
                        ),
                      ),
                    ),
                    // Repeat the same structure for State, Country, and ZipCode
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200], // Off-white background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: stateController,
                          decoration: InputDecoration(
                            labelText: 'State',
                            border: InputBorder.none,
                            contentPadding:  EdgeInsets.all(8.0),
                            icon: Icon(Icons.location_city),
                          ),
                        ),
                      ),
                    ),
                    // Repeat the same structure for State, Country, and ZipCode
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200], // Off-white background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: countryController,
                          decoration: InputDecoration(
                            labelText: 'Country',
                            border: InputBorder.none,
                            contentPadding:  EdgeInsets.all(8.0),
                            icon: Icon(Icons.location_city),
                          ),
                        ),
                      ),
                    ),
                    // Repeat the same structure for State, Country, and ZipCode
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200], // Off-white background color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: zipCodeController,
                          decoration: InputDecoration(
                            labelText: 'Zipcode',
                            border: InputBorder.none,
                            contentPadding:  EdgeInsets.all(8.0),
                            icon: Icon(Icons.location_city),
                          ),
                        ),
                      ),
                    ),
                    // Repeat the same structure for State, Country, and ZipCode
                  ],
                ),
              ),
              // Update Profile Button
              GestureDetector(
                onTap: updateProfile,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
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
                        Text(
                          'Update Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4,),
                        Image.asset(
                          'assets/Shape.png', // Replace with your image asset
                          width: 24.0, // Adjust the image width
                          height: 24.0, // Adjust the image height
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

