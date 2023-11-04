import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  SfRangeValues _values = const SfRangeValues(50000.0, 80000.0);
  TextEditingController descriptionController = TextEditingController();
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
                                  print("button tapped");
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
                    padding: EdgeInsets.symmetric(vertical: 10.0),
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
                        Text(
                          'Need Man power',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                  SizedBox(
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
