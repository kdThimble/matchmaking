import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'LoginScreen.dart';
import 'TransitionPage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formKey = GlobalKey<FormState>();

  late String _userName, _fullname;
  String _password = "";
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    AuthProvider auth = Provider.of<AuthProvider>(context);

    dynamic signUp() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        print(_password);
        final Future<Map<String, dynamic>> respose;
        respose = auth.signUp(_fullname, _userName, passwordController.text);
        respose.then((response) {
          if (response['status']) {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              title: "Registered Successful",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TransitionPage())));
          } else {
            setState(() {
              isLoading = false;
            });
            Flushbar(
              title: "Registration Failed ",
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        primary: true,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Row(
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  side: const BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextFormField(
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? "Please enter Name" : null,
                onSaved: (value) => _fullname = value!,
                decoration: const InputDecoration(
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Color(0xFF667085)),
                    prefixIcon:
                        Icon(Icons.person_outline, color: Color(0xFF667085))),
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
                  side: const BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
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
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Color(0xFF667085))),
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
                  side: const BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextFormField(
                controller: passwordController,
                autofocus: false,
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Please enter password" : null,
                onSaved: (value) {
                  setState(() {
                    _password = value!;
                  });
                },
                decoration: const InputDecoration(
                    hintText: "Your Password",
                    hintStyle: TextStyle(color: Color(0xFF667085)),
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xFF667085))),
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
                  side: const BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: TextFormField(
                controller: conformPasswordController,
                obscureText: true,
                onSaved: (value) => _password = value!,
                //
                decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Color(0xFF667085)),
                    prefixIcon:
                        Icon(Icons.lock_outline, color: Color(0xFF667085))),
              ),
            ),
            SizedBox(
              height: height * 0.01,
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
                  });
                  signUp();
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
                        'Sign up',
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
              height: height * 0.025,
            ),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFE0E2E7)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        Image.asset("assets/super_g.png"),
                        const SizedBox(width: 40),
                        const Text(
                          'Login with Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Already have an account?  ',
                    style: TextStyle(
                      color: Color(0xFF110C26),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginScreen())));
                      },
                    text: 'Sign in',
                    style: const TextStyle(
                      color: Color(0xFF5668FF),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ),
    );
  }
}
