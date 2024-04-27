// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/HomePage.dart';
import 'package:student_database/controller/add_student_controller.dart';
import 'package:student_database/controller/home_page_controller.dart';

// ignore: must_be_immutable
class UpdateStudent extends StatelessWidget {
  final StudentModel student;
  UpdateStudent({super.key, required this.student});

  final formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  late XFile file;
  String selectfile = "";

  UpdateStudentController updateController = Get.put(UpdateStudentController());


  @override
  Widget build(BuildContext context) {
    updateController.initialization(student: student);
    name.text = updateController.name.value;
    email.text = updateController.email.value;
    mobile.text = updateController.mobile.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Details"),
      ),
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 30),
            child: Form(
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
                        () => CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(
                            File(updateController.selectedImageFile.value),
                          ),
                        ),
                      )),
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
                    maxLength: 10,
                    controller: mobile,
                    keyboardType: TextInputType.phone,
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
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (updateController.selectedImageFile.value == "") {
                          Get.snackbar(
                            "Add Photo",
                            "Ready to add a photo? Let's do it! 📸",
                            backgroundColor: Colors.red.shade200,
                            duration: const Duration(
                              seconds: 1,
                            ),
                          );
                        } else {
                          StudentModel studentModel = StudentModel(
                            id: student.id,
                            name: name.text,
                            email: email.text,
                            mobile: mobile.text,
                            image: updateController.selectedImageFile.value,
                          );
                          await update(studentModel);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Profile(
                          //         student: student,
                          //       ),
                          //     ));
                          Get.snackbar(
                            "${name.text} ",
                            "🎉 Update Successful!  🎉",
                            backgroundColor: Colors.green.shade200,
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                          Get.offAll(() => HomePage());
                          Get.find<HomePageController>().refershList();
                        }
                      }
                    },
                    child: const Text(
                      "Update",
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

  ontap(ctx, ImageSource cam) async {
    file = (await ImagePicker().pickImage(source: cam))!;
    updateController.updateImage(file.path);
  }
}
