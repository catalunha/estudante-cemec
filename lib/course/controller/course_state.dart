import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class CourseState {
  final List<CourseModel>? courseList;
  final List<UserModel>? coordinatorList;
  final CourseModel? course;
  final UserModel? coordinator;
  final List<UserModel>? collegiate;

  static List<CourseModel> selectCourseNotArchived(AppState state) =>
      state.courseState.courseList!
          .where((element) => element.isArchivedByAdm == false)
          .toList();
  static List<CourseModel> selectCourseArchived(AppState state) =>
      state.courseState.courseList!
          .where((element) => element.isArchivedByAdm == true)
          .toList();
  static CourseModel? selectCourse(AppState state, String courseId) =>
      state.courseState.courseList!
          .firstWhereOrNull((element) => element.id == courseId);
  static UserModel? selectTeacherInCollegiate(
          AppState state, String teacherId) =>
      state.courseState.collegiate!
          .firstWhereOrNull((element) => element.id == teacherId);
  static UserModel? selectCoordinator(AppState state, String userId) =>
      state.courseState.coordinatorList!
          .firstWhereOrNull((element) => element.id == userId);
  CourseState({
    this.courseList,
    this.course,
    this.coordinator,
    this.coordinatorList,
    this.collegiate,
  });
  factory CourseState.initialState() => CourseState(
        courseList: [],
        course: null,
        coordinator: null,
        coordinatorList: [],
        collegiate: [],
      );
  CourseState copyWith({
    List<CourseModel>? courseList,
    List<UserModel>? coordinatorList,
    CourseModel? course,
    bool courseSetNull = false,
    UserModel? coordinator,
    bool coordinatorSetNull = false,
    List<UserModel>? collegiate,
  }) {
    return CourseState(
      courseList: courseList ?? this.courseList,
      coordinatorList: coordinatorList ?? this.coordinatorList,
      course: courseSetNull ? null : course ?? this.course,
      coordinator: coordinatorSetNull ? null : coordinator ?? this.coordinator,
      collegiate: collegiate ?? this.collegiate,
    );
  }

  @override
  String toString() =>
      'CourseState(courseModelCurrent: $course, courseModelList: $courseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseState &&
        other.course == course &&
        other.coordinator == coordinator &&
        listEquals(other.coordinatorList, coordinatorList) &&
        listEquals(other.collegiate, collegiate) &&
        listEquals(other.courseList, courseList);
  }

  @override
  int get hashCode =>
      coordinatorList.hashCode ^
      collegiate.hashCode ^
      coordinator.hashCode ^
      course.hashCode ^
      courseList.hashCode;
}
