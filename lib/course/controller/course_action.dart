import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
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
