import 'package:estudante/course/controller/course_card_connector.dart';
import 'package:estudante/course/controller/course_model.dart';
import 'package:estudante/course/course_card.dart';
import 'package:estudante/theme/app_colors.dart';
import 'package:estudante/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userPhotoUrl;
  final String userDisplayName;
  final VoidCallback signOut;
  final List<CourseModel> courseList;

  const HomePage({
    Key? key,
    required this.userPhotoUrl,
    required this.userDisplayName,
    required this.signOut,
    required this.courseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          // height: 90,
          color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ListTile(
                  onTap: signOut,
                  title: Text(
                    'Olá, $userDisplayName.',
                    style: AppTextStyles.titleRegular,
                  ),
                  subtitle: Text('Veja seus cursos.'),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(userPhotoUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                children: [
                  // IconButton(
                  //     tooltip: 'Ir para cursos arquivados',
                  //     onPressed: () => Navigator.pushNamed(
                  //           context,
                  //           '/course_archived',
                  //         ),
                  //     icon: Icon(AppIconData.archived))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: courseList
                    .map((e) => CourseCardConnector(courseModel: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
