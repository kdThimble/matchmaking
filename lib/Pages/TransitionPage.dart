// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matchmaking/Pages/user/NewHomepage.dart';
import 'package:matchmaking/utilities/appUrls.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'Homepage.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({super.key});

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  Future<http.Response> fetchData() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;
    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    var request = http.Request('GET', Uri.parse(AppUrls.getUser));
    request.headers.addAll(headers);

    final response = await http.get(
      Uri.parse(AppUrls.getUser),
    );
    print("response ${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<http.Response>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.body != null) {
              if (json.decode(snapshot.data!.body)['agencies'] != null) {
                print(json.decode(snapshot.data!.body)['agencies']);
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Homepage())));
                });
              } else {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Newhomepage())));
                });
              }
            }
            // API call succeeded, handle the response here
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // API call failed, handle the error here
            return Text('Error: ${snapshot.error}');
          } else {
            // API call is still in progress, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
