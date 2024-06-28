import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/model/resume_model.dart';
import 'package:resume_builder_task/pages/resume_preview.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';
import 'package:resume_builder_task/widgets/appColors.dart';
import 'package:resume_builder_task/widgets/appTextStyle.dart';
import 'package:resume_builder_task/widgets/commonAppBar.dart';

class ResumeListScreen extends StatelessWidget {
  const ResumeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CommonAppBar(title: 'All Resumes'),
      body: FutureBuilder(
        future: Hive.openBox<Resume>('resumes'),
        builder: (context, AsyncSnapshot<Box<Resume>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final box = snapshot.data!;
          final resumes = box.values.toList();

          if (resumes.isEmpty) {
            return const Center(child: Text('No resumes found.'));
          }

          return ListView.builder(
            itemCount: resumes.length,
            itemBuilder: (context, index) {
              final resume = resumes[index];
              return Card(
                child: ListTile(
                  title: buildTitle(resume.name),
                  subtitle: buildSubTitle(resume.role),
                  onTap: () {
                    Provider.of<ResumeProvider>(context, listen: false).resume = resume;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResumePreviewScreen(),
                      ),
                    );
                  },
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}
Widget buildVerticalDivider() {
  return const VerticalDivider(
    color: AppColors.lightTextColor,
    indent: 3,
    endIndent: 3,
  );
}

Widget buildDesc(String text) {
  return Text(text, style: AppTextStyles.medium.copyWith(fontSize: 12, color: AppColors.lightTextColor));
}

Widget buildSubTitle(String text) {
  return Text(text, style: AppTextStyles.semiBold.copyWith(fontSize: 12, color: AppColors.lightTextColor));
}

Widget buildTitle(String text) {
  return Text(text, style: AppTextStyles.semiBold.copyWith(fontSize: 16, color: AppColors.primaryColor));
}

Widget buildDivider({bool isThick = false}) {
  return Divider(
    color: AppColors.primaryColor,
    thickness: isThick ? 2 : 1,
  );
}

Widget buildSpacer() {
  return const SizedBox(height: 8.0);
}
