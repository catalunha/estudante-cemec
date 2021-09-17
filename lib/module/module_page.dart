import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/course_tile.dart';
import 'package:estudante/module/controller/module_card_connector.dart';
import 'package:estudante/module/controller/module_model.dart';
import 'package:estudante/team/coordinator_tile.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel coordinator;

  final List<ModuleModel> moduleList;

  const ModulePage({
    Key? key,
    required this.moduleList,
    required this.courseModel,
    required this.coordinator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seus módulos neste curso'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: Colors.orange[200],
              child: CourseTile(
                courseModel: courseModel,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              color: Colors.orange[100],
              child: CoordinatorTile(
                coordinator: coordinator,
              ),
            ),
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
    Map<String, ModuleModel> map = Map.fromIterable(
      moduleList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in courseModel.moduleOrder!) {
      if (map[index] != null) {
        list.add(Container(
            key: ValueKey(index),
            child: ModuleCardConnector(moduleModel: map[index]!)));
      }
    }
    return list;
  }
}
