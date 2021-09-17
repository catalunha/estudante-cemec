import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/resource/controller/resource_model.dart';

class StreamResourceDocsResourceAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsResourceAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(ResourceModel.collection)
        .where('moduleId', isEqualTo: state.moduleState.module!.id);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<ResourceModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                ResourceModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<ResourceModel> resourceModelList) {
      dispatch(
          SetResourceListResourceAction(resourceModelList: resourceModelList));
    });
    return null;
  }
}

class SetResourceListResourceAction extends ReduxAction<AppState> {
  final List<ResourceModel> resourceModelList;

  SetResourceListResourceAction({required this.resourceModelList});
  @override
  AppState reduce() {
    return state.copyWith(
      resourceState: state.resourceState.copyWith(
        resourceList: resourceModelList,
      ),
    );
  }
}
