import 'package:another_flushbar/flushbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../providers/auth_provider.dart';
import '../Homepage.dart';

class AgencyRegistration extends StatefulWidget {
  const AgencyRegistration({super.key});

  @override
  State<AgencyRegistration> createState() => _AgencyRegistrationState();
}

class _AgencyRegistrationState extends State<AgencyRegistration> {
  final formKey = GlobalKey<FormState>();

  late String _userName, _description, _dateOfJoining;
  bool isLoading = false;
  final DateRangePickerController _controller = DateRangePickerController();
  String _date = DateFormat('dd MM yyyy').format(DateTime.now()).toString();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {
        _date = DateFormat('dd/MM/yyyy').format(args.value).toString();
        print("Date $_date");
      });
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // The file was picked successfully.
      // You can access it using:
      // result.files.single.path
    } else {
      // The user canceled the file picking.
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    dynamic registerAgency() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> respose;
        respose = auth.registerAgency(_userName, _description);
        respose.then((response) {
          if (response['status']) {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              title: "Registered Successful",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ).show(context);
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Homepage())));
          } else {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              title: "Failed Registeration",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ).show(context);
          }
        });
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_back),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Register Agency",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.025,
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
                        controller: nameController,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Name" : null,
                        onSaved: (value) => _userName = value!,
                        decoration: const InputDecoration(
                            hintText: "Agency Name",
                            hintStyle: TextStyle(color: Color(0xFF667085)),
                            prefixIcon: Icon(Icons.person_outline,
                                color: Color(0xFF667085))),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
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
                        controller: emailController,
                        onSaved: (value) => _userName = value!,
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value!)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "abc@gmail.com",
                            hintStyle: TextStyle(color: Color(0xFF667085)),
                            prefixIcon: Icon(Icons.email_outlined,
                                color: Color(0xFF667085))),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                height: 350,
                                width: 350,
                                child: SfDateRangePicker(
                                  view: DateRangePickerView.month,
                                  initialSelectedDate: DateTime.now(),
                                  controller: _controller,
                                  onSelectionChanged: selectionChanged,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1.2, color: Color(0xFFE0E2E7)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Color(0xFF667085)),
                              SizedBox(width: 15),
                              Text(
                                "Date of Creation",
                                style: TextStyle(
                                    color: Color(0xFF667085),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await pickFile();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1.2, color: Color(0xFFE0E2E7)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Row(
                            children: [
                              Icon(Icons.post_add_outlined,
                                  color: Color(0xFF667085)),
                              SizedBox(width: 15),
                              Text(
                                "Upload Documents",
                                style: TextStyle(
                                    color: Color(0xFF667085),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
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
                        controller: descriptionController,
                        maxLines: 10,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Description" : null,
                        onSaved: (value) => _description = value!,
                        decoration: const InputDecoration(
                          hintText: "Agency Description",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10),
                          hintStyle: TextStyle(color: Color(0xFF667085)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            registerAgency();
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
                              SizedBox(
                                width: width * 0.27,
                              ),
                              const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFF3D55F0),
                                  shape: OvalBorder(),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
