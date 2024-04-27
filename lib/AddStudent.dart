// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/controller/add_student_controller.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  AddStudentController addController = Get.put(AddStudentController());

  late XFile file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Details"),
      ),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formkey,
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo_camera),
                                    title: const Text("Camera"),
                                    onTap: () {
                                      ontap(context, ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text("Gallery"),
                                    onTap: () {
                                      ontap(context, ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Obx(
                      () => addController.selectedImageFile.value == ""
                          ? CircleAvatar(
                              radius: 100,
                              child: Lottie.asset(
                                  "assets/animations/Animation - 1713885222787.json"),
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: FileImage(
                                File(addController.selectedImageFile.value),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Name";
                      }
                      return null;
                    },
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.account_circle,
                      ),
                      label: const Text("Name"),
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      } else if (value.length != 10) {
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    },
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      label: const Text("Mobile"),
                      hintText: "Mobile",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email Address";
                      } else if (!value.contains("@gmail.com")) {
                        return "Enter Valid Email Address ";
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      label: const Text("Email"),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    onPressed: () {
                      addbutton(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  addbutton(context) async {
    final student = StudentModel(
      id: DateTime.now().microsecondsSinceEpoch,
      name: name.text,
      email: email.text,
      mobile: mobile.text,
      image: addController.selectedImageFile.value,
    );

    if (formkey.currentState!.validate()) {
      if (addController.selectedImageFile.value == "") {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text("Add photo"),
        //   backgroundColor: Colors.red,
        Get.snackbar(
          "Add Photo",
          "Ready to add a photo? Let's do it! 📸",
          backgroundColor: Colors.red.shade200,
          duration: const Duration(
            seconds: 1,
          ),
        );
      } else {
        addStudent(student);
        // await getStudents();
        addController.selectedImageFile.value = "";
        // Navigator.pushNamedAndRemoveUntil(
        //     context, "HomePage", (route) => false);
        Get.back();
      }
    }
  }

  ontap(ctx, ImageSource cam) async {
    file = (await ImagePicker().pickImage(source: cam))!;

    addController.addImage(file.path);
  }
}
