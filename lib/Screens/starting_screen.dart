import 'package:campus_claim/Screens/item_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Starting extends StatefulWidget {
  const Starting({super.key});

  @override
  State<Starting> createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  bool cameraAllowed = false;
  bool galleryAllowed = false;

  Future<void> requestCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      setState(() {
        cameraAllowed = true;
      });
    } else {
      setState(() {
        cameraAllowed = false;
      });
    }
  }

  Future<void> requestGallery() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      setState(() {
        galleryAllowed = true;
      });
    } else {
      setState(() {
        galleryAllowed = false;
      });
    }
  }

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
                decoration: BoxDecoration(
                  color: Color(0xFFF43F5E),
                  borderRadius: BorderRadius.circular(20),
                ),
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
                  Checkbox(
                    value: cameraAllowed,
                    onChanged: (_) => requestCamera(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFFF43F5E),
                    ),
                    child: const Text(
                      "Camera Access",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: galleryAllowed,
                    onChanged: (_) => requestGallery(),
                  ),
                  //SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    //color: Colors.pinkAccent,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Color(0xFFF43F5E),
                    ),
                    child: Text(
                      'Gallery Access',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () async {
                  if (!cameraAllowed || !galleryAllowed) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Permissions Required'),
                        content: Text(
                          'Please Allow all permissions to continue',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF0ea5e9),
                            ),
                            child: Center(
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                    // if (!cameraAllowed) await requestCamera();
                    // if (!galleryAllowed) await requestGallery();
                    return;
                  }

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("onboarding_completed", true);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ItemListScroll()),
                  );
                },
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
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
