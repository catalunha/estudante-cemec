import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/course_tile.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/resource/controller/resource_model.dart';
import 'package:estudante/resource/resource_card.dart';
import 'package:estudante/team/coordinator_tile.dart';
import 'package:estudante/team/teacher_tile.dart';
import 'package:estudante/theme/app_text_styles.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel coordinator;
  final UserModel? teacher;
  final ModuleModel moduleModel;
  final List<ResourceModel> resourceList;
  final List<String> studentResourceList;

  const ResourcePage({
    Key? key,
    required this.resourceList,
    required this.courseModel,
    required this.moduleModel,
    this.teacher,
    required this.coordinator,
    required this.studentResourceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recursos deste curso e môdulo'),
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
    Map<String, ResourceModel> map = Map.fromIterable(
      resourceList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in moduleModel.resourceOrder!) {
      if (map[index] != null) {
        bool temResource = studentResourceList.contains(map[index]!.id);
        list.add(Container(
            key: ValueKey(index),
            child: ResourceCard(
              resourceModel: map[index]!,
              color: temResource ? Colors.yellow : null,
            )));
      }
    }
    return list;
  }
}
