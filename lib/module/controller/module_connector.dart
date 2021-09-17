import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_action.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/module/module_page.dart';
import 'package:estudante/student/controller/student_action.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class ModuleConnector extends StatelessWidget {
  final String courseId;
  const ModuleConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleViewModel>(
      onInit: (store) async {
        store.dispatch(SetCourseCourseAction(id: courseId));
        store.dispatch(SetStudentStudentAction(courseId: courseId));
      },
      vm: () => ModuleFactory(this),
      builder: (context, vm) => ModulePage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        moduleList: vm.moduleList,
      ),
    );
  }
}

class ModuleFactory extends VmFactory<AppState, ModuleConnector> {
  ModuleFactory(widget) : super(widget);
  ModuleViewModel fromStore() => ModuleViewModel(
        courseModel: state.courseState.course!,
        coordinator: CourseState.selectCoordinator(
            state, state.courseState.course!.coordinatorUserId)!,
        moduleList: state.moduleState.moduleList!,
      );
}

class ModuleViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel coordinator;
  final List<ModuleModel> moduleList;
  ModuleViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.moduleList,
  }) : super(equals: [
          courseModel,
          coordinator,
          moduleList,
        ]);
}
