import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/user/user_model.dart';

class GetCourseDocsCourseAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final List<CourseModel> courseList = [];
    final List<UserModel> coordinatorList = [];

    if (state.studentState.studentList != null &&
        state.studentState.studentList!.isNotEmpty) {
      for (var student in state.studentState.studentList!) {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await firebaseFirestore
                .collection(CourseModel.collection)
                .doc(student.courseId)
                .get();
        CourseModel courseModel = CourseModel.fromMap(
          docSnapshot.id,
          docSnapshot.data()!,
        );
        courseList.add(courseModel);

        DocumentSnapshot<Map<String, dynamic>> docSnapshotUser =
            await firebaseFirestore
                .collection(UserModel.collection)
                .doc(courseModel.coordinatorUserId)
                .get();
        UserModel userModel = UserModel.fromMap(
          docSnapshotUser.id,
          docSnapshotUser.data()!,
        );
        coordinatorList.add(userModel);
      }
    }
    return state.copyWith(
      courseState: state.courseState.copyWith(
        courseList: courseList,
        coordinatorList: coordinatorList,
      ),
    );
  }
}

// class SetCourseCourseAction extends ReduxAction<AppState> {
//   final String id;
//   SetCourseCourseAction({
//     required this.id,
//   });
//   @override
//   Future<AppState> reduce() async {
//     CourseModel? courseModel = CourseState.selectCourse(state, id);

//     UserModel? userModel =
//         CourseState.selectCoordinator(state, courseModel!.coordinatorUserId);
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     final List<UserModel> collegiate = [];

//     if (courseModel.collegiate!.isNotEmpty) {
//       for (var teacherId in courseModel.collegiate!) {
//         DocumentSnapshot<Map<String, dynamic>> docSnapshot =
//             await firebaseFirestore
//                 .collection(UserModel.collection)
//                 .doc(teacherId)
//                 .get();
//         UserModel userModel = UserModel.fromMap(
//           docSnapshot.id,
//           docSnapshot.data()!,
//         );
//         collegiate.add(userModel);
//       }
//     }

//     return state.copyWith(
//       courseState: state.courseState.copyWith(
//         course: courseModel,
//         coordinator: userModel,
//         collegiate: collegiate,
//       ),
//     );
//   }
// }

class SetCourseCourseAction extends ReduxAction<AppState> {
  final String id;
  SetCourseCourseAction({
    required this.id,
  });
  @override
  AppState reduce() {
    CourseModel? courseModel = CourseState.selectCourse(state, id);

    return state.copyWith(
      courseState: state.courseState.copyWith(
        course: courseModel,
      ),
    );
  }

  void after() {
    dispatch(SetCoordinatorCourseAction());
  }
}

class SetCoordinatorCourseAction extends ReduxAction<AppState> {
  SetCoordinatorCourseAction();
  @override
  AppState reduce() {
    UserModel? userModel = CourseState.selectCoordinator(
        state, state.courseState.course!.coordinatorUserId);
    return state.copyWith(
      courseState: state.courseState.copyWith(
        coordinator: userModel,
      ),
    );
  }

  void after() async {
    dispatch(SetColegiateCourseAction());
  }
}

class SetColegiateCourseAction extends ReduxAction<AppState> {
  SetColegiateCourseAction();
  @override
  Future<AppState> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final List<UserModel> collegiate = [];
    if (state.courseState.course!.collegiate!.isNotEmpty) {
      for (var teacherId in state.courseState.course!.collegiate!) {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await firebaseFirestore
                .collection(UserModel.collection)
                .doc(teacherId)
                .get();
        UserModel userModel = UserModel.fromMap(
          docSnapshot.id,
          docSnapshot.data()!,
        );
        collegiate.add(userModel);
      }
    }
    return state.copyWith(
      courseState: state.courseState.copyWith(
        collegiate: collegiate,
      ),
    );
  }
}
