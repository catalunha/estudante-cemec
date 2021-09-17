import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/situation/controller/situation_model.dart';
import 'package:estudante/student/controller/student_action.dart';
import 'package:estudante/student/controller/student_model.dart';

class StreamSituationDocsSituationAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsSituationAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(SituationModel.collection)
        .where('moduleId', isEqualTo: state.moduleState.module!.id);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<SituationModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                SituationModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<SituationModel> situationList) {
      dispatch(SetSituationListSituationAction(situationList: situationList));
    });
    return null;
  }
}

class SetSituationListSituationAction extends ReduxAction<AppState> {
  final List<SituationModel> situationList;

  SetSituationListSituationAction({required this.situationList});
  @override
  AppState reduce() {
    return state.copyWith(
      situationState: state.situationState.copyWith(
        situationList: situationList,
      ),
    );
  }
}

class UpdateStudentSituationMapSituationAction extends ReduxAction<AppState> {
  final String situationId;
  final bool isUnionOrRemove;
  UpdateStudentSituationMapSituationAction({
    required this.situationId,
    required this.isUnionOrRemove,
  });
  @override
  Future<AppState?> reduce() async {
    print(isUnionOrRemove);
    print(state.studentState.student!.id);
    print(state.moduleState.module!.id);
    print(situationId);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(StudentModel.collection)
        .doc(state.studentState.student!.id);
    bool temp = state
        .studentState.student!.situationMap[state.moduleState.module!.id]!
        .contains(situationId);
    if (!temp) {
      // if (isUnionOrRemove) {
      await docRef.update({
        'situationMap.${state.moduleState.module!.id}':
            FieldValue.arrayUnion([situationId])
      });
    } else {
      await docRef.update({
        'situationMap.${state.moduleState.module!.id}':
            FieldValue.arrayRemove([situationId])
      });
    }
    return null;
  }

  void after() {
    dispatch(GetStudentDocsStudentAction());
    dispatch(SetStudentStudentAction(
        courseId: state.studentState.student!.courseId));
  }
}
