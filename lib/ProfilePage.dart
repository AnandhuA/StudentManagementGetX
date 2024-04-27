// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';
import 'package:student_database/HomePage.dart';
import 'package:student_database/UpdateStudent.dart';
import 'package:student_database/controller/home_page_controller.dart';
import 'package:student_database/image_view.dart';

class Profile extends StatelessWidget {
  final StudentModel student;
  Profile({super.key, required this.student});
  final HomePageController homeController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () => Get.to(UpdateStudent(student: student))
                ?.then((value) => homeController.refershList()),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Delete ${student.name}"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await deleteStudent(student);
                          // await getStudents();
                          Get.snackbar(
                            "${student.name} ",
                            "🗑️ Deletion Successful! ",
                            backgroundColor: Colors.red.shade200,
                            duration: const Duration(
                              seconds: 2,
                            ),
                          );
                          Get.offAll(() => HomePage());
                          Get.find<HomePageController>().refershList();
                        },
                        child: const Text("Yes"),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(ImageViewWidget(
                    imagePath: student.image,
                    name: student.name,
                  ));
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(
                    File(student.image),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                student.name,
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  color: const Color.fromARGB(248, 240, 232, 236),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Text(
                          "Contact",
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(student.mobile),
                        ),
                        ListTile(
                          leading: const Icon(Icons.mail),
                          title: Text(student.email),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
