import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/course_tile.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/situation/controller/situation_model.dart';
import 'package:estudante/situation/situation_card.dart';
import 'package:estudante/team/coordinator_tile.dart';
import 'package:estudante/team/teacher_tile.dart';
import 'package:estudante/theme/app_colors.dart';
import 'package:estudante/theme/app_text_styles.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class SituationPage extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel coordinator;
  final UserModel teacher;
  final ModuleModel moduleModel;
  final List<SituationModel> situationList;
  final List<String> studentSituationList;
  final Function(String) updateStudentSituationMap;

  const SituationPage({
    Key? key,
    required this.situationList,
    required this.courseModel,
    required this.moduleModel,
    required this.teacher,
    required this.coordinator,
    required this.studentSituationList,
    required this.updateStudentSituationMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situações deste curso e môdulo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, right: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // color: AppColors.secondary,
              elevation: 10,
              child: Column(
                children: [
                  CourseTile(
                    courseModel: courseModel,
                  ),
                  CoordinatorTile(
                    coordinator: coordinator,
                  ),
                  TeacherTile(
                    teacher: teacher,
                  ),
                ],
              ),
            ),
          ),
          Text(
            moduleModel.title,
            style: AppTextStyles.titleBoldHeading,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildItens(context) {
    List<Widget> list = [];
    Map<String, SituationModel> map = Map.fromIterable(
      situationList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in moduleModel.situationOrder!) {
      if (map[index] != null) {
        bool temResource = studentSituationList.contains(map[index]!.id);
        list.add(Container(
            key: ValueKey(index),
            child: SituationCard(
              updateStudentSituationMap: updateStudentSituationMap,
              situationModel: map[index]!,
              color: temResource ? Colors.yellow : null,
            )));
      }
    }
    return list;
  }
}
