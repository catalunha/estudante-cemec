import 'package:async_redux/async_redux.dart';
import 'package:estudante/app_state.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/home/home_page.dart';
import 'package:estudante/login/login_action.dart';
import 'package:estudante/student/controller/student_action.dart';

import 'package:flutter/material.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      onInit: (store) async {
        await store.dispatch(GetStudentDocsStudentAction());
      },
      builder: (context, vm) => HomePage(
        signOut: vm.signOut,
        userPhotoUrl: vm.userPhotoUrl,
        // userPhoneNumber: vm.userPhoneNumber,
        userDisplayName: vm.userDisplayName,
        // userEmail: vm.userEmail,
        // userUid: vm.userUid,
        courseList: vm.courseList,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        signOut: () => dispatch(SignOutLoginAction()),
        userPhotoUrl: state.loginState.userFirebaseAuth?.photoURL ?? '',
        userPhoneNumber: state.loginState.userFirebaseAuth?.phoneNumber ?? '',
        userDisplayName: state.loginState.userFirebaseAuth?.displayName ?? '',
        userEmail: state.loginState.userFirebaseAuth?.email ?? '',
        userUid: state.loginState.userFirebaseAuth?.uid ?? '',
        courseList: state.courseState.courseList!,
      );
}

class HomeViewModel extends Vm {
  final VoidCallback signOut;

  final String userPhotoUrl;
  final String userPhoneNumber;
  final String userDisplayName;
  final String userEmail;
  final String userUid;
  final List<CourseModel> courseList;

  HomeViewModel({
    required this.signOut,
    required this.userPhotoUrl,
    required this.userPhoneNumber,
    required this.userDisplayName,
    required this.userEmail,
    required this.userUid,
    required this.courseList,
  }) : super(equals: [
          userPhotoUrl,
          userPhoneNumber,
          userDisplayName,
          userEmail,
          userUid,
          courseList,
        ]);
}
