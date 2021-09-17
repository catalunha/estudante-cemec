import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/course_tile.dart';
import 'package:estudante/team/coordinator_tile.dart';
import 'package:estudante/theme/app_icon.dart';
import 'package:estudante/user/user_model.dart';
import 'package:estudante/widget/text_description.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel? coordinator;

  const CourseCard({
    Key? key,
    required this.courseModel,
    required this.coordinator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CourseTile(
            courseModel: courseModel,
          ),
          CoordinatorTile(
            coordinator: coordinator,
          ),
          TextDescription(
            firstWord: '',
            text: courseModel.description,
          ),
          Wrap(
            children: [
              IconButton(
                tooltip: 'Modulos deste curso',
                icon: Icon(AppIconData.module),
                onPressed: () async {
                  Navigator.pushNamed(context, '/module',
                      arguments: courseModel.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
