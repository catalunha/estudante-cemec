import 'package:async_redux/async_redux.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/login/login_state.dart';
import 'package:estudante/student/controller/student_state.dart';
import 'package:estudante/upload/upload_state.dart';
import 'package:estudante/user/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final UploadState uploadState;
  final StudentState studentState;
  final CourseState courseState;

  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.uploadState,
    required this.studentState,
    required this.courseState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        uploadState: UploadState.initialState(),
        studentState: StudentState.initialState(),
        courseState: CourseState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    UploadState? uploadState,
    StudentState? studentState,
    CourseState? courseState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      uploadState: uploadState ?? this.uploadState,
      studentState: studentState ?? this.studentState,
      courseState: courseState ?? this.courseState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.courseState == courseState &&
        other.studentState == studentState &&
        other.uploadState == uploadState &&
        other.loginState == loginState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return uploadState.hashCode ^
        courseState.hashCode ^
        studentState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
