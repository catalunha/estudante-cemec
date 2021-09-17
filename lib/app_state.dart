import 'package:async_redux/async_redux.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/login/login_state.dart';
import 'package:estudante/module/controller/module_state.dart';
import 'package:estudante/resource/controller/resource_state.dart';
import 'package:estudante/situation/controller/situation_state.dart';
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
  final ModuleState moduleState;
  final ResourceState resourceState;
  final SituationState situationState;

  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.uploadState,
    required this.studentState,
    required this.courseState,
    required this.moduleState,
    required this.resourceState,
    required this.situationState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        uploadState: UploadState.initialState(),
        studentState: StudentState.initialState(),
        courseState: CourseState.initialState(),
        moduleState: ModuleState.initialState(),
        resourceState: ResourceState.initialState(),
        situationState: SituationState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    UploadState? uploadState,
    StudentState? studentState,
    CourseState? courseState,
    ModuleState? moduleState,
    ResourceState? resourceState,
    SituationState? situationState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      situationState: situationState ?? this.situationState,
      userState: userState ?? this.userState,
      uploadState: uploadState ?? this.uploadState,
      studentState: studentState ?? this.studentState,
      courseState: courseState ?? this.courseState,
      moduleState: moduleState ?? this.moduleState,
      resourceState: resourceState ?? this.resourceState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.situationState == situationState &&
        other.resourceState == resourceState &&
        other.moduleState == moduleState &&
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
        situationState.hashCode ^
        resourceState.hashCode ^
        moduleState.hashCode ^
        courseState.hashCode ^
        studentState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
