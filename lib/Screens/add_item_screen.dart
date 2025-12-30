import 'package:campus_claim/services/cloudinary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:campus_claim/models/lost_item_model.dart';
import 'package:campus_claim/services/item_service.dart';
import 'package:campus_claim/services/storage_service.dart';

import 'package:campus_claim/Screens/Updating_item_screen.dart';
import 'package:campus_claim/Screens/item_list_screen.dart';

class AddItemsList extends StatefulWidget {
  const AddItemsList({super.key});

  @override
  State<AddItemsList> createState() => _AddItemsListState();
}

class _AddItemsListState extends State<AddItemsList> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final locationController = TextEditingController();
  final ItemService itemService = ItemService();
  final StorageService storageService = StorageService();
  bool name = false;
  bool number = false;
  bool loc = false;
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool Check_condition() {
    name = nameController.text.trim().isNotEmpty;
    number = contactController.text.length == 10;
    loc = locationController.text.trim().isNotEmpty;

    if (name == false && number == false && loc == false) {
      showMessage("Please Enter the Above Details");
      return false;
    }

    if (name == true && number == false && loc == false) {
      showMessage("Please Enter Contact Details and location");
      return false;
    }

    if (name == false && number == true && loc == false) {
      showMessage("Please Enter Item Name and location");
      return false;
    }

    if (name == false && number == false && loc == true) {
      showMessage("Please Enter Item Name and Contact Details");
      return false;
    }

    if (name == false) {
      showMessage("Please Enter Item Name");
      return false;
    }

    if (number == false) {
      showMessage("Please Enter Correct Contact Details");
      return false;
    }

    if (loc == false) {
      showMessage("Please Enter Location");
      return false;
    }

    return true;
  }

  Future pickFromGallery() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  Future pickFromCamera() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  void showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.black),
                title: Text(
                  'Click Picture',
                  style: TextStyle(fontFamily: 'Manrope'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.black),
                title: Text(
                  'Open Gallery',
                  style: TextStyle(fontFamily: 'Manrope'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFA855F7),
        automaticallyImplyLeading: false,
        title: Text(
          'CampusClaim',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            letterSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(57, 107, 40, 0),
                  width: 306,
                  height: 334,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDECEC),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text('Item Name'),
                      SizedBox(height: 29),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 234,
                          height: 30,
                          child: TextField(
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical(y: 1),
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Item Name",
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color(0xFF0EA5E9),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 21),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 234,
                          height: 30,
                          child: TextField(
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical(y: 1),
                            controller: locationController,
                            decoration: InputDecoration(
                              hintText: "Last Location",
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color(0xFF0EA5E9),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 21),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 234,
                          height: 30,
                          child: TextField(
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical(y: 1),
                            controller: contactController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: "Contact Number",
                              hintStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color(0xFF0EA5E9),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 36),
                      Container(
                        height: 110,
                        width: 229,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                          image: imageFile != null
                              ? DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageFile == null
                            ? Column(
                                children: [
                                  SizedBox(height: 23),
                                  Center(
                                    child: Text(
                                      'Upload Picture',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 20,
                                        color: Color(0xFF4F46E5),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showImageSourceDialog();
                                    },
                                    icon: Icon(
                                      Icons.upload,
                                      size: 27,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  height: 46,
                  width: 146,
                  decoration: BoxDecoration(
                    color: Color(0xFFF59E0b),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ElevatedButton(
                    onPressed: () async {
                      if (Check_condition()) {
                        try {
                          showMessage("Uploading...");

                          String? imageUrl;

                          if (imageFile != null) {
                            imageUrl = await CloudinaryService.uploadImage(
                              imageFile!,
                            );
                          }

                          if (imageUrl != null) {
                            showMessage("Image Upload Succesfully");
                          } else {
                            imageUrl = null;
                          }

                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            showMessage("Auth Error. Please restart the app");
                            return;
                          }

                          //final uid = FirebaseAuth.instance.currentUser?.uid ?? "unknown";
                          final item = Item(
                            itemName: nameController.text.trim(),
                            contactDetails: contactController.text.trim(),
                            location: locationController.text.trim(),
                            //createdAt: FieldValue.serverTimestamp(),
                            imageUrl: imageUrl,
                            isFound: false,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          );
                          await itemService.uploadItem(item);

                          showMessage("Item uploaded Successfully!");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => ItemListScroll()),
                          );
                        } catch (e) {
                          showMessage("Error Uploading: $e");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF59E0B),
                      //foregroundColor: Color(0xFFF59E0B),
                    ),
                    child: Center(
                      child: Text(
                        'Upload Item',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        height: 80,
        width: 393,
        decoration: BoxDecoration(
          color: Color(0xFFA855F7),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => AddItemsList()),
                // );
              },
              icon: Icon(Icons.upload, size: 36, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ItemListScroll()),
                );
              },
              icon: Icon(Icons.list, size: 36, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => updating_Item_Screen()),
                );
              },
              icon: Icon(Icons.update, size: 32, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
