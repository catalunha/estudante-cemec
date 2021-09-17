import 'package:estudante/app_state.dart';
import 'package:estudante/student/controller/student_model.dart';
import 'package:flutter/foundation.dart';

class StudentState {
  final StudentModel? student;
  final List<StudentModel>? studentList;
  static StudentModel? selectStudentOfList(AppState state, String userId) =>
      state.studentState.studentList!
          .firstWhere((element) => element.userId == userId);
  static StudentModel? selectStudentByCourseId(
          AppState state, String courseId) =>
      state.studentState.studentList!
          .firstWhere((element) => element.courseId == courseId);
  StudentState({
    this.student,
    this.studentList,
  });
  factory StudentState.initialState() => StudentState(
        student: null,
        studentList: [],
      );

  StudentState copyWith({
    StudentModel? student,
    List<StudentModel>? studentList,
  }) {
    return StudentState(
      student: student ?? this.student,
      studentList: studentList ?? this.studentList,
    );
  }

  @override
  String toString() => 'StudentState(...)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentState &&
        other.student == student &&
        listEquals(other.studentList, studentList);
  }

  @override
  int get hashCode => student.hashCode ^ studentList.hashCode;
}
