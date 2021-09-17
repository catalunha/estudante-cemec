import 'package:estudante/theme/app_icon.dart';
import 'package:estudante/user/user_model.dart';
import 'package:flutter/material.dart';

class TeacherTile extends StatelessWidget {
  final UserModel? teacher;
  const TeacherTile({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return teacher != null
        ? ListTile(
            leading: teacher!.photoURL == null
                ? Icon(AppIconData.undefined)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      teacher!.photoURL!,
                      height: 58,
                      width: 58,
                    ),
                  ),
            title: Text(teacher!.displayName ?? ''),
            subtitle: Text('email: ${teacher!.email}\nuserId: ${teacher!.id}'),
            trailing: Icon(AppIconData.teacher),
          )
        : ListTile(
            leading: Icon(
              AppIconData.undefined,
            ),
            title: Text('Professor não disponivel'),
          );
  }
}
