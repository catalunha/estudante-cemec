import 'package:estudante/situation/controller/situation_model.dart';
import 'package:estudante/situation/situation_tile.dart';
import 'package:estudante/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class SituationCard extends StatelessWidget {
  final SituationModel situationModel;
  final Color? color;
  final Function(String) updateStudentSituationMap;

  const SituationCard({
    Key? key,
    required this.situationModel,
    this.color,
    required this.updateStudentSituationMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).bottomAppBarColor,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SituationTile(
            situationModel: situationModel,
          ),
          Wrap(
            children: [
              // IconButton(
              //   tooltip: 'Editar este recurso',
              //   icon: Icon(AppIconData.edit),
              //   onPressed: () async {
              //     Navigator.pushNamed(context, '/situation_addedit',
              //         arguments: situationModel.id);
              //   },
              // ),
              IconButton(
                tooltip: 'Solução desta situação',
                icon: Icon(AppIconData.solution),
                onPressed: () async {
                  bool can = await canLaunch(situationModel.solutionUrl);
                  if (can) {
                    await launch(situationModel.solutionUrl);
                  }
                },
              ),
              // IconButton(
              //   tooltip: 'Marcar como resolvida',
              //   icon: Icon(AppIconData.check),
              //   onPressed: () {
              //     updateStudentSituationMap(situationModel.id);
              //   },
              // ),
            ],
          )
        ],
      ),
    );
  }
}
