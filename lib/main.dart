import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/model/resume_model.dart';
import 'package:resume_builder_task/pages/resume_builder_screen.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ResumeAdapter());
  Hive.registerAdapter(ProfileSummaryAdapter());
  Hive.registerAdapter(WorkExperienceAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(EducationAdapter());
  Hive.registerAdapter(SectionTypeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => ResumeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Resume Builder',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ResumeBuilderScreen()),
    );
  }
}
