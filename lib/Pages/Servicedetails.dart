import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaking/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ServiceDetails extends StatefulWidget {
  final String requestId;

  const ServiceDetails({required this.requestId});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  ServiceRequestDetails? agency;
  bool isBidsEmpty = true;
  bool isLoading = false;
  // Assuming the initial state is empty
  final TextEditingController priceController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchAndSaveData();
  }

  Future showMyBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1.2, color: Color(0xFFE0E2E7)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        decoration: const InputDecoration(
                            hintText: 'Price',
                            contentPadding: EdgeInsets.all(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1.2, color: Color(0xFFE0E2E7)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: TextFormField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                            hintText: 'Message',
                            contentPadding: EdgeInsets.all(8)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5669FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'BID',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
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
          ),
        );
      },
    );
  }

  Future<void> fetchAndSaveData() async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final authToken = userProvider.token;

    var headers = {
      'Authorization': 'Bearer $authToken',
    };

    var request = http.Request(
      'GET',
      Uri.parse(
          'https://eventmanagementproject.onrender.com/api/v1/serviceRequest/${widget.requestId}'),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print("in success code");
      var data = json.decode(response.body)['serviceRequest'];
      var startDate = DateTime.parse(data['startDate']);
      var endDate = DateTime.parse(data['endDate']);
      // Instantiate the ServiceRequestDetails object
      var newAgency = ServiceRequestDetails(
        title: data['title'],
        brief: data['brief'],
        address: data['address'],
        lowestBudget: data['lowestBudget'].toString(),
        highestBudget: data['highestBudget'].toString(),
        bids: List<Map<String, dynamic>>.from(data['bids']),
        Startdate: startDate,
        Enddate: endDate,
      );

      // Use setState to update the UI with the new agency
      setState(() {
        agency = newAgency;
        isBidsEmpty = false; // Set loading to false when data is available
      });

      // Now you can use agency in your application
      print("Title: ${agency?.title}");
      print("Brief: ${agency?.brief}");
      print("Address: ${agency?.address}");
      print("Lowest Budget: ${agency?.lowestBudget}");
      print("Highest Budget: ${agency?.highestBudget}");
      print("Bids: ${agency?.bids}");
      var formattedStartDate =
          DateFormat.yMMMMd().format(agency?.Startdate as DateTime);
      var formattedEndDate =
          DateFormat.yMMMMd().format(agency?.Enddate as DateTime);

      print("Formatted Start Date: $formattedStartDate");
      print("Formatted End Date: $formattedEndDate");
    } else {
      print("in unsuccessful code");
    }
  }

  @override
  Widget build(BuildContext context) {
    var formattedStartDate = DateFormat.yMMMMd().format(agency!.Startdate);
    var formattedEndDate = DateFormat.yMMMMd().format(agency!.Enddate);
    return isBidsEmpty
        ? const Center(
            child: CircularProgressIndicator(), // Show circular indicator
          )
        : MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                toolbarHeight: 90,
                title: const Center(child: Text('Service Detail')),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                backgroundColor: const Color(0xFF5D56F3),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    // Add your slider icon on pressed logic here
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Add your notification icon on pressed logic here
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              agency!.title ?? "No Title", // Display the title
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              agency!.address["city"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xFF667085),
                        ), // Divider after the first column
                        const SizedBox(height: 10),
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 150, // Set the desired minimum height
                          ),
                          child: Text(
                            agency!.brief ?? "No Title",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const Divider(
                          color: Color(0xFF667085),
                        ), // Divider after the Lorem Ipsum text
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  agency?.lowestBudget as String,
                                  style: const TextStyle(
                                      color: Color(0xFF667085), fontSize: 18),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '-',
                                  style: TextStyle(color: Color(0xFF667085)),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  agency?.highestBudget as String,
                                  style: const TextStyle(
                                      color: Color(0xFF667085), fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.data_exploration_rounded,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formattedStartDate,
                                  style: const TextStyle(
                                      color: Color(0xFF667085), fontSize: 16),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'to',
                                  style: TextStyle(
                                      color: Color(0xFF667085), fontSize: 16),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formattedEndDate,
                                  style: const TextStyle(
                                      color: Color(0xFF667085), fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xFF667085),
                        ), // Divider after the second row
                        const SizedBox(height: 10),
                        const Text(
                          'Top Biddings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Live Proposals',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF667085),
                                ),
                              ),
                              Text(
                                'Bid',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF667085),
                                ),
                              ),
                              Text(
                                'Time',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF667085),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Color(0xFF667085),
                        ), // Divider after the column headers
                        const SizedBox(height: 10),
                        // Sample Bidding Data
                        BiddingRow(agency!.bids),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 50,
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showMyBottomSheet(context);
                      },
                      child: Container(
                        height: 70,
                        width: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5668FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              '₹ Bid',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0.05,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 70,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF5668FF),
                          ),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 4),
                              Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color(0xFF5668FF),
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    height: 0.05,
                                  ),
                                ),
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

class BiddingRow extends StatelessWidget {
  final List<Map<String, dynamic>> bids;

  BiddingRow(this.bids);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bids.map((bid) {
        // print(bid['agency']['name']);
        // print(bid['agency']['name']);
        // print(bid['agency']['name']);
        String formatDateTime(String dateTimeString) {
          DateTime dateTime = DateTime.parse(dateTimeString);
          return DateFormat.jm()
              .format(dateTime); // "jm" format gives 12-hour time with AM/PM
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  // Assuming 'name' is the field you want to display for the bid
                  Text(
                    bid['agency']['name'] ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.25,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  // Assuming 'price' is the field you want to display for the bid
                  Text(
                    '${bid['price']}' ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.25,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  // Assuming 'createdAt' is the field you want to display for the bid time
                  Text(
                    formatDateTime(bid['agency']['createdAt'] ?? ''),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.25,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const Divider(
                color: Color(0xFF667085),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF5668FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '₹ Bid',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.05,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF5668FF),
                ),
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Color(0xFF5668FF),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF5668FF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceRequestDetails {
  final String title;
  final String brief;
  final DateTime Startdate;
  final DateTime Enddate;
  final Map<String, dynamic> address;
  final String lowestBudget;
  final String highestBudget;
  final List<Map<String, dynamic>> bids;

  ServiceRequestDetails({
    required this.title,
    required this.brief,
    required this.address,
    required this.lowestBudget,
    required this.highestBudget,
    required this.Startdate,
    required this.Enddate,
    required this.bids,
  });

// Additional constructors, methods, or properties can be added if needed
}
