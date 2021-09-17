import 'package:estudante/app_state.dart';
import 'package:estudante/student/controller/student_model.dart';
import 'package:flutter/foundation.dart';

class StudentState {
  final StudentModel? studentCurrent;
  final List<StudentModel>? studentList;
  static StudentModel? selectStudentOfList(AppState state, String userId) =>
      state.studentState.studentList!
          .firstWhere((element) => element.userId == userId);
  StudentState({
    this.studentCurrent,
    this.studentList,
  });
  factory StudentState.initialState() => StudentState(
        studentCurrent: null,
        studentList: [],
      );

  StudentState copyWith({
    StudentModel? studentCurrent,
    List<StudentModel>? studentList,
  }) {
    return StudentState(
      studentCurrent: studentCurrent ?? this.studentCurrent,
      studentList: studentList ?? this.studentList,
    );
  }

  @override
  String toString() => 'StudentState(...)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentState &&
        other.studentCurrent == studentCurrent &&
        listEquals(other.studentList, studentList);
  }

  @override
  int get hashCode => studentCurrent.hashCode ^ studentList.hashCode;
}
