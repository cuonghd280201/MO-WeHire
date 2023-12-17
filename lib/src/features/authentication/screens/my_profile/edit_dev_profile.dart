// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:we_hire/src/constants/colors.dart';
import 'package:we_hire/src/features/authentication/controllers/developer_controller.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';
import 'package:we_hire/src/features/authentication/repository/request_repository.dart';
import 'package:we_hire/src/features/authentication/screens/my_profile/dev_profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? file;

  User? userProfile;
  final developerController = DeveloperController(RequestRepository());
  bool loading = false;
  File? _image;
  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');

  Future getImageProfile() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    genderController.text = genderOptions.isNotEmpty ? genderOptions[0] : '';

    developerController.fetchDeveloperById(context).then((user) {
      setState(() {
        userProfile = user;
        genderController.text = userProfile?.genderName ?? '';
        summaryController.text = userProfile?.summary ?? '';
        fisrtNameController.text = userProfile?.firstName ?? '';
        lastNameController.text = userProfile?.lastName ?? '';
        phoneNumberController.text = userProfile?.phoneNumber ?? '';
        birthdayController.text = userProfile?.dateOfBirth ?? '';
        _image = userProfile?.userImage != null
            ? File(userProfile!
                .userImage!) // Use the non-null assertion operator (!)
            : null;
      });
    });
  }

  List<String> genderOptions = ['Female', 'Male', 'Unknown'];
  String? selectedGender;

  TextEditingController fisrtNameController =
      TextEditingController(text: ''); // Initialize controllers
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController birthdayController = TextEditingController(text: '');
  TextEditingController genderController = TextEditingController();
  TextEditingController summaryController = TextEditingController(text: '');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Check for null
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        birthdayController.text = formattedDate;
      });
    }
  }

  @override
  void dispose() {
    birthdayController.dispose();
    super.dispose();
  }

  String mapGenderToId(String genderText) {
    switch (genderText.toLowerCase()) {
      case 'male':
        return '1';
      case 'female':
        return '2';
      case 'unknown':
        return '3';
      default:
        throw Exception('Invalid gender text: $genderText');
    }
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // You can add more validation for the phone number if needed
    return null;
  }

  String? validateSummary(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a summary';
    }
    return null;
  }

  bool validateFields() {
    if (fisrtNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        summaryController.text.isEmpty ||
        birthdayController.text.isEmpty) {
      // Show an error message or handle the case where fields are empty
      MotionToast.error(
        description: const Text("Please fill in all the fields"),
      ).show(context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: tHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, UserProfileScreen.routeName);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: _image != null
                              ? (_image!.path.startsWith('http') ||
                                      _image!.path.startsWith('https'))
                                  ? Image.network(_image!
                                      .path) // Firebase image, use Image.network
                                  : Image.file(
                                      _image!) // Local cache image, use Image.file
                              : const Center(
                                  child: Icon(Icons.image),
                                )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            getImageProfile();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            child: Icon(
                              Icons.photo_camera,
                              color: tBottomNavigation.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Icon(
                            Icons.person_2_rounded,
                            color: tBottomNavigation,
                          ),
                        ),
                        controller: fisrtNameController,
                        validator: validateFirstName,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.only(top: 15),
                          prefixIcon: Icon(Icons.person_2_rounded,
                              color: tBottomNavigation),
                        ),
                        controller: lastNameController,
                        validator: validateLastName,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.phone, color: tBottomNavigation),
                  ),
                  controller: phoneNumberController,
                  validator: validatePhoneNumber,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Summary',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.summarize, color: tBottomNavigation),
                  ),
                  validator: validateSummary,
                  controller: summaryController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: genderController.text,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderController.text = newValue!;
                          });
                        },
                        items: genderOptions.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Birthday',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon:
                        Icon(Icons.cake_rounded, color: tBottomNavigation),
                  ),
                  controller: birthdayController,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: tBottomNavigation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        String filePath = _image != null
                            ? _image!.path
                            : userProfile?.userImage ?? '';
                        String fisrtName = fisrtNameController.text;
                        String lastName = lastNameController.text;
                        String phoneNumber = phoneNumberController.text;
                        String birthDay = birthdayController.text;
                        String genderId = mapGenderToId(genderController.text);
                        String summary = summaryController.text;
                        try {
                          final bool success =
                              await developerController.editDeveloper(
                            context,
                            genderId,
                            fisrtName,
                            lastName,
                            phoneNumber,
                            birthDay,
                            summary,
                            filePath,
                          );

                          if (success) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const UserProfileScreen(),
                              ),
                            );
                            MotionToast.success(
                              description:
                                  const Text("Edit profile successfully"),
                            ).show(context);
                          } else {
                            MotionToast.error(
                              description: const Text("Edit profile failed"),
                            ).show(context);
                          }
                        } catch (e) {
                          print("Error: $e");
                          MotionToast.error(
                            description: const Text("Edit profile failed"),
                          ).show(context);
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
