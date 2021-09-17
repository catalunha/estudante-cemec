import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/team/teacher_tile.dart';
import 'package:estudante/theme/app_icon.dart';
import 'package:estudante/theme/app_text_styles.dart';
import 'package:estudante/user/user_model.dart';
import 'package:estudante/widget/text_description.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel moduleModel;
  final UserModel? teacher;
  final int countResourcesOfStudent;
  final int countSituationOfStudent;
  const ModuleCard(
      {Key? key,
      required this.moduleModel,
      this.teacher,
      required this.countResourcesOfStudent,
      required this.countSituationOfStudent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child:
                Text('${moduleModel.title}', style: AppTextStyles.trailingBold),
            color: Colors.blue.shade50,
          ),
          TeacherTile(
            teacher: teacher,
          ),
          TextDescription(
            firstWord: '',
            text: moduleModel.description,
          ),
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Ver recursos para este môdulo',
                        icon: Icon(AppIconData.resourse),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/resource',
                              arguments: moduleModel.id);
                        },
                      ),
                      Text(
                          '$countResourcesOfStudent / ${moduleModel.resourceOrder?.length}'),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Ver situações para este môdulo',
                        icon: Icon(AppIconData.situation),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/situation',
                              arguments: moduleModel.id);
                        },
                      ),
                      Text(
                          '$countSituationOfStudent / ${moduleModel.situationOrder?.length}'),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
