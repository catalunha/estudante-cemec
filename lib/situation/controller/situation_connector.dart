import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/module/controller/module_action.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/situation/controller/situation_action.dart';
import 'package:estudante/situation/controller/situation_model.dart';
import 'package:estudante/situation/situation_page.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class SituationConnector extends StatelessWidget {
  final String moduleId;
  const SituationConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SituationViewModel>(
      onInit: (store) async {
        store.dispatch(SetModuleModuleAction(moduleId: moduleId));
        store.dispatch(StreamSituationDocsSituationAction());
      },
      vm: () => SituationFactory(this),
      builder: (context, vm) => SituationPage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        teacher: vm.teacher,
        moduleModel: vm.moduleModel,
        situationList: vm.situationList,
        studentSituationList: vm.studentSituationList,
        updateStudentSituationMap: vm.updateStudentSituationMap,
      ),
    );
  }
}

class SituationFactory extends VmFactory<AppState, SituationConnector> {
  SituationFactory(widget) : super(widget);
  SituationViewModel fromStore() => SituationViewModel(
      courseModel: state.courseState.course!,
      coordinator: CourseState.selectCoordinator(
          state, state.courseState.course!.coordinatorUserId)!,
      teacher: selectTeacher(),
      moduleModel: state.moduleState.module!,
      situationList: state.situationState.situationList!,
      studentSituationList: studentSituationList(),
      updateStudentSituationMap: (String situationId) {
        dispatch(UpdateStudentSituationMapSituationAction(
            situationId: situationId, isUnionOrRemove: true));
      });
  selectTeacher() {
    if (state.moduleState.module!.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, state.moduleState.module!.teacherUserId!);
      return temp;
    }
    return null;
  }

  studentSituationList() {
    List<String>? studentSituationList = [];
    if (state.studentState.student!.situationMap
        .containsKey(widget!.moduleId)) {
      studentSituationList =
          state.studentState.student!.situationMap[widget!.moduleId];
    }
    print(studentSituationList);
    return studentSituationList;
  }
}

class SituationViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel coordinator;
  final UserModel teacher;
  final ModuleModel moduleModel;
  final List<SituationModel> situationList;
  final List<String> studentSituationList;
  final Function(String) updateStudentSituationMap;
  SituationViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.teacher,
    required this.moduleModel,
    required this.situationList,
    required this.studentSituationList,
    required this.updateStudentSituationMap,
  }) : super(equals: [
          courseModel,
          coordinator,
          teacher,
          moduleModel,
          situationList,
          studentSituationList
        ]);
}
