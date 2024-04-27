import 'package:sqflite/sqflite.dart';
import 'package:student_database/Db/model.dart';

late Database db;

Future<void> dataBase() async {
  db = await openDatabase(
    "studentDb",
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,mobile TEXT,email TEXT,image TEXT)");
    },
  );
}

Future<List<StudentModel>> getStudents() async {
  final values = await db.rawQuery('SELECT * FROM student');
  final List<StudentModel> studentList =[];

  for (var map in values) {
    final student = StudentModel.fromMap(map);
    studentList.add(student);
  }
  return studentList;
}

void addStudent(StudentModel val) async {
  await db.rawInsert(
      'INSERT INTO student (name,mobile,email,image) VALUES (?,?,?,?)',
      [val.name, val.mobile, val.email, val.image]);
}

 deleteStudent(StudentModel id) {
  db.rawDelete("DELETE FROM student WHERE id =?", [id.id]);
}

 update(StudentModel val) async {
  await db.rawUpdate(
      'UPDATE student SET name = ? ,mobile = ? ,email = ?,image =? WHERE id = ?',
      [val.name, val.mobile, val.email, val.image, val.id]);
}
