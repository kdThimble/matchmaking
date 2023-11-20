import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:matchmaking/providers/form_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../providers/auth_provider.dart';
import '../TransitionPage.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  SfRangeValues _values = const SfRangeValues(50000.0, 80000.0);
  TextEditingController descriptionController = TextEditingController();
  Future<void> showErrorDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            // Container for the image
            child: Image.asset(
              'assets/img_13.png', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Error!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 86),
                    fontSize: 24,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Please Try again later',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'we are preparing for you...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Circular dotted animation (you can replace this with your own loading indicator)
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Okay',
                    style: TextStyle(
                      color: Color.fromARGB(255, 244, 52, 52),
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }

  Future<void> showSuccessDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            // Container for the image
            child: Image.asset(
              'assets/img_13.png', // Replace with your image URL
              fit: BoxFit.cover,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Successful!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5668FF),
                    fontSize: 24,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Please wait a moment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5668FF),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'we are preparing for you...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5668FF),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Circular dotted animation (you can replace this with your own loading indicator)
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 4),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5668FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(47),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Okay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('Close'),
          //   ),
          // ],
        );
      },
    );
  }

  late String _description;
  bool _isChecked = false;
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isLoading = true;
    var height = MediaQuery.of(context).size.height;
    FormProvider formProvider = Provider.of<FormProvider>(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);

    dynamic sendServiceRequest() {
      print("title: ${formProvider.title}");
      final Future<Map<String, dynamic>> respose;
      respose = auth.sendServiceRequest(
          formProvider.categoryId,
          formProvider.brief,
          titleController.text,
          formProvider.city,
          formProvider.state,
          formProvider.zipCode,
          formProvider.startDate,
          formProvider.endDate,
          _values.start,
          _values.end,
          _isChecked);
      respose.then((response) {
        if (response['status']) {
          setState(() {
            isLoading = false;
          });

          showSuccessDialog(context);
        } else {
          setState(() {
            isLoading = false;
          });
          Flushbar(
            title: "Registration Failed ",
            message: response['message'].toString(),
            duration: const Duration(seconds: 3),
          ).show(context);
          showErrorDialog(context);
        }
      });
    }

    return Scaffold(
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
                                  "Price & Details",
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
                  Container(
                    height: height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Price Range",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.085,
                      ),
                      Center(
                        child: SfRangeSliderTheme(
                          data: SfRangeSliderThemeData(
                            tooltipBackgroundColor: const Color(0xffA471F6),
                          ),
                          child: SfRangeSlider(
                            min: 30000,
                            max: 150000,
                            values: _values,
                            interval: 10000,
                            showLabels: false,
                            enableTooltip: true,
                            showDividers: true,
                            shouldAlwaysShowTooltip: true,
                            inactiveColor: Colors.grey,
                            activeColor: const Color(0xffA471F6),
                            onChanged: (SfRangeValues newValues) {
                              setState(() {
                                _values = newValues;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_values.start.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${_values.end.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white // Off-white background color
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: height * 0.35,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE0E2E7)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 10,
                      validator: (value) =>
                          value!.isEmpty ? "Please enter Description" : null,
                      onSaved: (value) => _description = value!,
                      decoration: const InputDecoration(
                        hintText: " Description",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        hintStyle: TextStyle(color: Color(0xFF667085)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          side: const BorderSide(color: Colors.white),
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        const Text(
                          'Need Man power',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("button tapped");
                      sendServiceRequest();
                    },
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
                        child: const Center(
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
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
