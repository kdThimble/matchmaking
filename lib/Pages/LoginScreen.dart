import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matchmaking/Pages/RegistrationScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.025,
              ),
              Center(child: Image.asset("assets/birdLogo.png")),
              SizedBox(
                height: height * 0.07,
              ),
              const Row(
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextFormField(
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
                padding: EdgeInsets.symmetric(vertical: 3),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.2, color: Color(0xFFE0E2E7)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Your Password",
                      hintStyle: TextStyle(color: Color(0xFF667085)),
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Color(0xFF667085))),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xFF667085),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF5669FF),
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
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE0E2E7)),
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
                height: height * 0.01,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don’t have an account?  ',
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
                                  builder: ((context) =>
                                      RegistrationScreen())));
                        },
                      text: 'Sign up',
                      style: TextStyle(
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
    );
  }
}
