import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_action.dart';
import 'package:estudante/module/controller/module_action.dart';
import 'package:estudante/student/controller/student_model.dart';
import 'package:estudante/student/controller/student_state.dart';

class GetStudentDocsStudentAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(StudentModel.collection)
        .where('userId', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchived', isEqualTo: false)
        .get();
    List<StudentModel> studentList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => StudentModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return state.copyWith(
      studentState: state.studentState.copyWith(
        studentList: studentList,
      ),
    );
  }

  void after() {
    dispatch(GetCourseDocsCourseAction());
  }
}

class SetStudentStudentAction extends ReduxAction<AppState> {
  final String courseId;
  SetStudentStudentAction({
    required this.courseId,
  });
  @override
  AppState reduce() {
    StudentModel? studentModel =
        StudentState.selectStudentByCourseId(state, courseId);

    return state.copyWith(
      studentState: state.studentState.copyWith(
        student: studentModel,
      ),
    );
  }

  void after() {
    dispatch(GetModuleDocsModuleAction());
  }
}
