import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/module/controller/module_state.dart';

class GetModuleDocsModuleAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetModuleDocsModuleAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final List<ModuleModel> moduleList = [];
    if (state.studentState.student!.resourceMap.isNotEmpty) {
      for (String moduleId in state.studentState.student!.resourceMap.keys) {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await firebaseFirestore
                .collection(ModuleModel.collection)
                .doc(moduleId)
                .get();
        ModuleModel moduleModel = ModuleModel.fromMap(
          docSnapshot.id,
          docSnapshot.data()!,
        );
        moduleList.add(moduleModel);
      }
    }
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleList: moduleList,
      ),
    );
  }
}

class SetModuleModuleAction extends ReduxAction<AppState> {
  final String moduleId;

  SetModuleModuleAction({required this.moduleId});
  @override
  AppState reduce() {
    ModuleModel? module = ModuleState.selectModule(state, moduleId);
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        module: module,
      ),
    );
  }
}
