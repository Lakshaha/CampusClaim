import 'package:flutter/material.dart';

class Starting extends StatelessWidget {
  const Starting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CampusClaim',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 114,
                width: 217,
                decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                child: Center(
                  child: Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Manrope',
                      color: Color(0xFF000000),
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 80),

              Container(
                height: 30,
                width: 217,
                decoration: BoxDecoration(color: Color(0xFFF43F5E)),
                child: Center(
                  child: Text(
                    'Permission Required',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Checkbox(
                  //   value: cameraAccess,
                  //   onChanged: (value) {
                  //     setState(() => cameraAccess = value!);
                  //   },
                  // ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    color: Colors.pinkAccent,
                    child: const Text(
                      "Camera Access",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(backgroundColor: Color(0xFFD9D9D9)),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
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
