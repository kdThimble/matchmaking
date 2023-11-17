import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchmaking/Pages/user/Profile3.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/form_provider.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  SfRangeValues _values = const SfRangeValues(50000.0, 80000.0);
  TextEditingController descriptionController = TextEditingController();
  late String _description;
  bool _isChecked = false;
  DateTimeRange? _selectedDateRange;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime1;
  TimeOfDay? _selectedTimeEnd;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime firstDay = DateTime.now().toLocal();
  DateTime focusedDay = DateTime.now().toLocal();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime? _selectedStart;
  DateTime? _selectedEnd;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    var width = MediaQuery.of(context).size.width;
    final startDate1 = _selectedDateRange?.start.toString();
    final endDate1 = _selectedDateRange?.end.toString();
    final startTime1 = _selectedTime;
    final endTime1 = _selectedTimeEnd;
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
                                  "Event Date",
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
                    height: height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TableCalendar(
                        calendarFormat: _calendarFormat,
                        focusedDay: _focusedDay,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2050),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          leftChevronIcon: Icon(Icons.chevron_left,
                              color: Color(0xFF3C4FDF)),
                          rightChevronIcon: Icon(Icons.chevron_right,
                              color: Color(0xFF3C4FDF)),
                          titleTextStyle: TextStyle(
                            color: Color(0xFF3C4FDF), // Month name color
                            fontWeight: FontWeight.bold, // Month name bold
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return _selectedDay != null &&
                              isSameDay(_selectedDay!, day);
                        },
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            if (_rangeStart == null || _rangeEnd != null) {
                              _rangeStart = selectedDay;
                              _rangeEnd = null;
                            } else {
                              if (_rangeStart!.isBefore(selectedDay)) {
                                _rangeEnd = selectedDay;
                              } else {
                                _rangeEnd = _rangeStart;
                                _rangeStart = selectedDay;
                              }
                            }
                            _selectedDay = selectedDay;
                            _selectedStart = _rangeStart;
                            _selectedEnd = _rangeEnd;
                            print("startDate $_selectedStart");
                            formProvider.startDate = _selectedStart ?? DateTime.now();
                            formProvider.endDate = _selectedEnd ?? DateTime.now();
                          });
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: const CalendarStyle(
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey, // Color for today
                          ),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Color(0xFF3C4FDF), // Color for selected dates
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          defaultTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          outsideTextStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: height * 0.1,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'From',
                              style: TextStyle(
                                color: Color(0xFF667085),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            if (_selectedStart != null)
                              Text(
                                DateFormat('dd MMM').format(_selectedStart!),
                                style: const TextStyle(
                                  color: Color(0xFF667085),
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Till',
                              style: TextStyle(
                                color: Color(0xFF667085),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            if (_selectedEnd != null)
                              Text(
                                DateFormat('dd MMM').format(_selectedEnd!),
                                style: const TextStyle(
                                  color: Color(0xFF667085),
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: height * 0.1,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Start Time',
                              style: TextStyle(
                                color: Color(0xFF667085),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime ?? TimeOfDay.now(),
                                ).then((pickedTime) {
                                  if (pickedTime != null) {
                                    setState(() {
                                      _selectedTime = pickedTime;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                _selectedTime != null
                                    ? _selectedTime!.format(
                                        context) // Display the selected time
                                    : 'Start Time',
                                style: const TextStyle(
                                  color: Color(0xFF667085),
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'End Time',
                              style: TextStyle(
                                color: Color(0xFF667085),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime:
                                      _selectedTime1 ?? TimeOfDay.now(),
                                ).then((pickedTime) {
                                  if (pickedTime != null) {
                                    setState(() {
                                      _selectedTime1 = pickedTime;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                _selectedTime1 != null
                                    ? _selectedTime1!.format(
                                        context) // Display the selected time
                                    : 'End Time',
                                style: const TextStyle(
                                  color: Color(0xFF667085),
                                  fontSize: 30,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Screen3())));
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
