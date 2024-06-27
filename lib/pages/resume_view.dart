import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';

class ResumeView extends StatelessWidget {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final data = resumeProvider.resume;
    return Scaffold(
        appBar: AppBar(title: const Text('Final Resume')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Text(data.name),
              Text(data.email),
              Text(data.city),
              Text(data.phoneNumber),
              Text(data.linkedInOrGithubLink),
              const Text("Work Experience"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: resumeProvider.resume.workExperience.length,
                itemBuilder: (context, index) {
                  final item = resumeProvider.resume.workExperience[index];
                  return ListTile(
                    title: Text(item.companyName),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.role),
                      Row(
                        children: [
                          Text(DateFormat('MMM d, y').format(DateTime.parse(item.startDate.toString()))),
                          Text(DateFormat('MMM d, y').format(DateTime.parse(item.endDate.toString()))),
                        ],
                      ),
                      Text(item.description),
                    ]),
                  );
                },
              ),
              const Text("Projects"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: resumeProvider.resume.projects.length,
                itemBuilder: (context, index) {
                  final item = resumeProvider.resume.projects[index];
                  return ListTile(
                    title: Text(item.projectName),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.description),
                    ]),
                  );
                },
              ),
              const Text("Education"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: resumeProvider.resume.education.length,
                itemBuilder: (context, index) {
                  final item = resumeProvider.resume.education[index];
                  return ListTile(
                    title: Text(item.universityName),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.degree),
                      Row(
                        children: [
                          Text(DateFormat('MMM y').format(DateTime.parse(item.startDate.toString()))),
                          Text(DateFormat('MMM y').format(DateTime.parse(item.endDate.toString()))),
                        ],
                      ),
                    ]),
                  );
                },
              ),
              const Text("Skills"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: resumeProvider.resume.skills.length,
                itemBuilder: (context, index) {
                  final item = resumeProvider.resume.skills[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(item),
                  );
                },
              ),
            ],
          ),
        ));
  }
}