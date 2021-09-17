import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/controller/course_state.dart';
import 'package:estudante/module/controller/module_action.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/resource/controller/resource_action.dart';
import 'package:estudante/resource/controller/resource_model.dart';
import 'package:estudante/resource/resource_page.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class ResourceConnector extends StatelessWidget {
  final String moduleId;
  const ResourceConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ResourceViewModel>(
      onInit: (store) async {
        store.dispatch(SetModuleModuleAction(moduleId: moduleId));
        store.dispatch(StreamResourceDocsResourceAction());
      },
      vm: () => ResourceFactory(this),
      builder: (context, vm) => ResourcePage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        teacher: vm.teacher,
        moduleModel: vm.moduleModel,
        resourceList: vm.resourceList,
        studentResourceList: vm.studentResourceList,
      ),
    );
  }
}

class ResourceFactory extends VmFactory<AppState, ResourceConnector> {
  ResourceFactory(widget) : super(widget);
  ResourceViewModel fromStore() => ResourceViewModel(
        courseModel: state.courseState.course!,
        coordinator: CourseState.selectCoordinator(
            state, state.courseState.course!.coordinatorUserId)!,
        teacher: selectTeacher(),
        moduleModel: state.moduleState.module!,
        resourceList: state.resourceState.resourceList!,
        studentResourceList: studentResourceList(),
      );
  selectTeacher() {
    if (state.moduleState.module!.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, state.moduleState.module!.teacherUserId!);
      return temp;
    }
    return null;
  }

  studentResourceList() {
    List<String>? studentResourceList = [];
    if (state.studentState.student!.resourceMap.containsKey(widget!.moduleId)) {
      studentResourceList =
          state.studentState.student!.resourceMap[widget!.moduleId];
    }
    print(studentResourceList);
    return studentResourceList;
  }
}

class ResourceViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel coordinator;
  final UserModel teacher;
  final ModuleModel moduleModel;
  final List<ResourceModel> resourceList;
  final List<String> studentResourceList;

  ResourceViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.teacher,
    required this.moduleModel,
    required this.resourceList,
    required this.studentResourceList,
  }) : super(equals: [
          courseModel,
          coordinator,
          teacher,
          moduleModel,
          resourceList,
          studentResourceList,
        ]);
}
