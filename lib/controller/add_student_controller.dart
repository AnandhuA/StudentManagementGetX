import 'package:get/state_manager.dart';
import 'package:student_database/Db/model.dart';

class AddStudentController extends GetxController {
  RxString selectedImageFile = "".obs;

  addImage(String path) {
    selectedImageFile.value = path;
  }
}

class UpdateStudentController extends GetxController {
  RxString selectedImageFile = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString mobile = "".obs;

  initialization({required StudentModel student}) {
    name.value = student.name;
    email.value = student.email;
    mobile.value = student.mobile;
    selectedImageFile.value = student.image;
  }

    updateImage(String path) {
    selectedImageFile.value = path;
  }
}
