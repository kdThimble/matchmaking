// import 'dart:convert';
//
// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:matchmaking/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
//
// class Screen3 extends StatefulWidget {
//   @override
//   _Screen3State createState() => _Screen3State();
// }
//
// class _Screen3State extends State<Screen3> {
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController zipCodeController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Call the function to fetch the user profile details
//     fetchUserProfileDetails();
//   }
//
//   Future<void> fetchUserProfileDetails() async {
//     final userProvider = Provider.of<AuthProvider>(context, listen: false);
//     final authToken = userProvider.token;
//     var headers = {
//       'Authorization': 'Bearer $authToken',
//     };
//     print("ssjj");
//     print(authToken);
//
//     var request = http.Request(
//         'GET', Uri.parse('https://eventmanagementproject.onrender.com/api/v1/users/profile'));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     print("response aaya lch");
//     if (response.statusCode == 200) {
//       var jsonResponse = await response.stream.bytesToString();
//       Map<String, dynamic> profileData = json.decode(jsonResponse);
//
//       setState(() {
//         fullNameController.text = profileData['fullName'];
//         emailController.text = profileData['email'];
//         cityController.text = profileData['address']['city'];
//         stateController.text = profileData['address']['state'];
//         countryController.text = profileData['address']['country'];
//         zipCodeController.text = profileData['address']['zipCode'];
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   Future<void> updateProfile() async {
//     final userProvider = Provider.of<AuthProvider>(context, listen: false);
//     final authToken = userProvider.token;
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $authToken',
//     };
//     print("ssjj");
//     print(authToken);
//
//     var request = http.Request(
//         'PUT', Uri.parse('https://eventmanagementproject.onrender.com/api/v1/users/profile/update'));
//     request.headers.addAll(headers);
//
//     var profileData = {
//       "fullName": fullNameController.text,
//       "address": {
//         "city": cityController.text,
//         "state": stateController.text,
//         "country": countryController.text,
//         "zipCode": zipCodeController.text,
//         "lat": "",
//         "lng": ""
//       }
//     };
//
//     request.body = json.encode(profileData);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       // Show a green flush bar for success
//       Flushbar(
//         message: 'Profile updated successfully',
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       )..show(context);
//     } else {
//       print(response.reasonPhrase);
//       // Show a red flush bar for error
//       Flushbar(
//         message: 'Profile update failed',
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 2),
//       )..show(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//
//           children: [
//           Positioned(
//           right: 0,
//           top: 0,
//           left: 0,
//           child: Image.asset(
//             "assets/FormBG.png",
//             fit: BoxFit.fill,
//           ),
//         ),
//                SafeArea(
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     GestureDetector(
//                                         onTap: () {
//                                           print("button tapped");
//                                         },
//                                         child: const SizedBox(
//                                           height: 62,
//                                           child: Center(
//                                             child: Icon(
//                                               Icons.arrow_back,
//                                               color: Colors.white,
//                                               size: 32,
//                                             ),
//                                           ),
//                                         )),
//                                     const SizedBox(
//                                       height: 62,
//                                       child: Center(
//                                         child: Text(
//                                           "Address",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       // Adjust the size as needed
//                                       height: 62,
//                                       width: 45, // Adjust the size as needed
//                                       decoration: const BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Color(0xFF7974E7),
//                                       ),
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons
//                                               .notifications, // Use the notification icon
//                                           color: Colors
//                                               .white, // Change the icon color as needed
//                                           size: 30.0, // Adjust the icon size as needed
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color: Colors.grey[200], // Off-white background color
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                               controller: fullNameController,
//                               decoration: InputDecoration(
//                                 labelText: 'Your Name',
//                                 border: InputBorder.none, // Remove default underline
//                                 contentPadding:  EdgeInsets.all(8.0),
//                                 icon: Icon(Icons.person),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // Email Text Field with Border and Background Color
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color: Colors.grey[200], // Off-white background color
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 border: InputBorder.none,
//                                 contentPadding:  EdgeInsets.all(8.0),
//                                 icon: Icon(Icons.email),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.0),
//                             color: Colors.grey[200], // Off-white background color
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextFormField(
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 labelText: 'Phone Number',
//                                 border: InputBorder.none,
//                                 contentPadding:  EdgeInsets.all(8.0),
//                                 icon: Icon(Icons.call),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Address Fields (City, State, Country, ZipCode) with Border and Background Color
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: Colors.grey[200], // Off-white background color
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: cityController,
//                                   decoration: InputDecoration(
//                                     labelText: 'House no. / Event place',
//                                     border: InputBorder.none,
//                                     contentPadding:  EdgeInsets.all(8.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Repeat the same structure for State, Country, and ZipCode
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: Colors.grey[200], // Off-white background color
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: stateController,
//                                   decoration: InputDecoration(
//                                     labelText: 'Area/Street',
//                                     border: InputBorder.none,
//                                     contentPadding:  EdgeInsets.all(8.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Repeat the same structure for State, Country, and ZipCode
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: Colors.grey[200], // Off-white background color
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: countryController,
//                                   decoration: InputDecoration(
//                                     labelText: 'City',
//                                     border: InputBorder.none,
//                                     contentPadding:  EdgeInsets.all(8.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Repeat the same structure for State, Country, and ZipCode
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: Colors.grey[200], // Off-white background color
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: zipCodeController,
//                                   decoration: InputDecoration(
//                                     labelText: 'Pin no',
//                                     border: InputBorder.none,
//                                     contentPadding:  EdgeInsets.all(8.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Repeat the same structure for State, Country, and ZipCode
//                           ],
//                         ),
//                       ),
//                       // Update Profile Button
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 color: Colors.grey[200], // Off-white background color
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   controller: zipCodeController,
//                                   decoration: InputDecoration(
//                                     labelText: 'State',
//                                     border: InputBorder.none,
//                                     contentPadding:  EdgeInsets.all(8.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Repeat the same structure for State, Country, and ZipCode
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30,),
//                       Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 24, vertical: 16),
//                           clipBehavior: Clip.antiAlias,
//                           decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(47),
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Next',
//                               style: TextStyle(
//                                 color: Color(0xFF5668FF),
//                                 fontSize: 16,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0,
//                               ),
//                             ),
//                           )),
//                       SizedBox(
//                         height: 60,
//                       ),
//                     ],
//               ),
//                  ),
//                ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/user/Screen4.dart';
import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  SfRangeValues _values = const SfRangeValues(50000.0, 80000.0);
  TextEditingController descriptionController = TextEditingController();
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
  late String _description;
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                left: 0,
                bottom: 0,
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
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 62,
                                  child: Center(
                                    child: Text(
                                      "Address",
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
                      Column(children: [
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200], // Off-white background color
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  labelText: 'Your Name',
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


                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200], // Off-white background color
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: InputBorder.none,
                                  contentPadding:  EdgeInsets.all(8.0),
                                  icon: Icon(Icons.call),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200], // Off-white background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: cityController,
                                    decoration: InputDecoration(
                                      labelText: 'House no. / Event place',
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.all(8.0),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200], // Off-white background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: stateController,
                                    decoration: InputDecoration(
                                      labelText: 'Area/Street',
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.all(8.0),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200], // Off-white background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: countryController,
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.all(8.0),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200], // Off-white background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: zipCodeController,
                                    decoration: InputDecoration(
                                      labelText: 'Pin no',
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              // Repeat the same structure for State, Country, and ZipCode
                            ],
                          ),
                        ),
                        // Update Profile Button
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200], // Off-white background color
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: zipCodeController,
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              // Repeat the same structure for State, Country, and ZipCode
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap:  (){ Navigator.push(context,
                              MaterialPageRoute(builder: ((context) => Screen4())));},
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(47),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Color(0xFF5668FF),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                    ],
                  ),
              ]
    )))
            ],
          ),
        ));
  }
}
