import 'package:get/get.dart';
import 'package:student_database/Db/function.dart';
import 'package:student_database/Db/model.dart';

class HomePageController extends GetxController {
  RxList<StudentModel> studentListObx = <StudentModel>[].obs;
  RxBool search = false.obs;

  @override
  void onInit() {
    super.onInit();
    refershList();
  }

  chageSearch() {
    search.value = !search.value;
  }

  refershList() async {
    studentListObx.assignAll(await getStudents());
  }

  searchFun(String value) async {
    
    if (value.isEmpty) {
      studentListObx.assignAll(await getStudents());
    }else{
      final student = await getStudents();
      studentListObx.assignAll(student.where((student) =>
              student.name.trim().toLowerCase().contains(value.trim().toLowerCase()))
          .toList());
    }
  }
}
