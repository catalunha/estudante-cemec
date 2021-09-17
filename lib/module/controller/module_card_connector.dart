import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/module/module_card.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class ModuleCardConnector extends StatelessWidget {
  final ModuleModel moduleModel;

  const ModuleCardConnector({Key? key, required this.moduleModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleCardViewModel>(
      vm: () => ModuleCardFactory(this),
      builder: (context, vm) => ModuleCard(
        moduleModel: moduleModel,
        teacher: vm.teacher,
        countResourcesOfStudent: vm.countResourcesOfStudent,
        countSituationOfStudent: vm.countSituationOfStudent,
      ),
    );
  }
}

class ModuleCardFactory extends VmFactory<AppState, ModuleCardConnector> {
  ModuleCardFactory(widget) : super(widget);
  @override
  ModuleCardViewModel fromStore() => ModuleCardViewModel(
        teacher: selectTeacher(),
        countResourcesOfStudent: countResourcesOfStudent(),
        countSituationOfStudent: countSituationOfStudent(),
      );

  selectTeacher() {
    if (widget!.moduleModel.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, widget!.moduleModel.teacherUserId!);
      // print(temp!.displayName);
      return temp;
    }
    return null;
  }

  countResourcesOfStudent() {
    int qde = 0;
    List<String>? resourceIdList =
        state.studentState.student!.resourceMap[widget!.moduleModel.id];
    if (resourceIdList != null) {
      qde = resourceIdList.length;
    }
    return qde;
  }

  countSituationOfStudent() {
    int qde = 0;
    List<String>? situationList =
        state.studentState.student!.situationMap[widget!.moduleModel.id];
    if (situationList != null) {
      qde = situationList.length;
    }
    return qde;
  }
}

class ModuleCardViewModel extends Vm {
  final UserModel? teacher;
  final int countResourcesOfStudent;
  final int countSituationOfStudent;
  ModuleCardViewModel({
    required this.teacher,
    required this.countResourcesOfStudent,
    required this.countSituationOfStudent,
  }) : super(equals: [
          teacher,
          countResourcesOfStudent,
          countSituationOfStudent,
        ]);
}
