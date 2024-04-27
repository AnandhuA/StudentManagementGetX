// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_database/AddStudent.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/ProfilePage.dart';
import 'package:student_database/controller/home_page_controller.dart';
import 'package:student_database/image_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePageController homeController = Get.put(HomePageController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => homeController.search.value
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                  ),
                  onChanged: (value) {
                    homeController.searchFun(value);
                  },
                )
              : const Text("Student"),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                homeController.chageSearch();
                homeController.searchFun("");
              },
              icon: homeController.search.value
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, "AddStudent");
          Get.to(AddStudent())?.then((value) => homeController.refershList());
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () {
          return homeController.studentListObx.isEmpty
              ? const Center(
                  child: Text("NoData"),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListView.separated(
                    itemCount: homeController.studentListObx.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final student = homeController.studentListObx[index];
                      return ListTile(
                        leading: InkWell(
                          onTap: () {
                            Get.to(
                              ImageViewWidget(
                                imagePath: student.image,
                                name: student.name,
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: FileImage(
                              File(student.image),
                            ),
                          ),
                        ),
                        title: Text(student.name),
                        subtitle: Text(student.email),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Profile(student: student),
                          //     ));
                          Get.to(Profile(student: student));
                          //     ?.then((value) => homeController.refershList());
                        },
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
