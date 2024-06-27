import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/model/resume_model.dart';
import 'package:resume_builder_task/pages/resume_view.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';

class ResumeBuilderScreen extends StatelessWidget {
  const ResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Builder'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPersonalInfoSection(resumeProvider),
          _buildCareerSection(resumeProvider),
          _buildWorkExperienceSection(resumeProvider),
          _buildProjectSection(resumeProvider),
          _buildEducationSection(resumeProvider),
          _buildSkillsSection(resumeProvider, context),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResumeView()),
              );
            },
            child: const Text('Save Resume'),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personal Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (value) {
            resumeProvider.resume.name = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Role'),
          onChanged: (value) {
            resumeProvider.resume.role = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'City'),
          onChanged: (value) {
            resumeProvider.resume.city = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Phone Number'),
          onChanged: (value) {
            resumeProvider.resume.phoneNumber = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (value) {
            resumeProvider.resume.email = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'LinkedIn/GitHub Link'),
          onChanged: (value) {
            resumeProvider.resume.linkedInOrGithubLink = value;
            resumeProvider.notifyListeners();
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildCareerSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Career', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextField(
          decoration: const InputDecoration(labelText: 'Title'),
          onChanged: (value) {
            resumeProvider.resume.career.title = value;
            resumeProvider.notifyListeners();
          },
        ),
        TextField(
          maxLength: 200,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Description'),
          onChanged: (value) {
            resumeProvider.resume.career.description = value;
            resumeProvider.notifyListeners();
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildWorkExperienceSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Work Experience', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addWorkExperience(
                  WorkExperience(
                    companyName: 'New Company',
                    role: 'New Role',
                    startDate: DateTime.now(),
                    endDate: DateTime.now(),
                    isCurrentlyWorking: false,
                    description: 'Description',
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.workExperience.length,
          itemBuilder: (context, index) {
            final workExperience = resumeProvider.resume.workExperience[index];
            return ListTile(
              title: Text(workExperience.companyName),
              subtitle: Text(workExperience.role),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit work experience
                      showDialog(
                        context: context,
                        builder: (context) {
                          final companyNameController = TextEditingController(text: workExperience.companyName);
                          final roleController = TextEditingController(text: workExperience.role);
                          final startDateController =
                              TextEditingController(text: workExperience.startDate.toIso8601String());
                          final endDateController =
                              TextEditingController(text: workExperience.endDate.toIso8601String());
                          final isCurrentlyWorkingController =
                              TextEditingController(text: workExperience.isCurrentlyWorking.toString());
                          final descriptionController = TextEditingController(text: workExperience.description);

                          return AlertDialog(
                            title: const Text('Edit Work Experience'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: companyNameController,
                                  decoration: const InputDecoration(labelText: 'Company Name'),
                                ),
                                TextField(
                                  controller: roleController,
                                  decoration: const InputDecoration(labelText: 'Role'),
                                ),
                                TextField(
                                  controller: startDateController,
                                  decoration: const InputDecoration(labelText: 'Start Date'),
                                ),
                                TextField(
                                  controller: endDateController,
                                  decoration: const InputDecoration(labelText: 'End Date'),
                                ),
                                TextField(
                                  controller: isCurrentlyWorkingController,
                                  decoration: const InputDecoration(labelText: 'Is Currently Working'),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(labelText: 'Description'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  resumeProvider.updateWorkExperience(
                                    index,
                                    WorkExperience(
                                      companyName: companyNameController.text,
                                      role: roleController.text,
                                      startDate: DateTime.parse(startDateController.text),
                                      endDate: DateTime.parse(endDateController.text),
                                      isCurrentlyWorking: isCurrentlyWorkingController.text.toLowerCase() == 'true',
                                      description: descriptionController.text,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Delete work experience
                      resumeProvider.removeWorkExperience(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Reorder work experience
            resumeProvider.reorderWorkExperience(0, 1);
          },
          child: const Text('Reorder Work Experience'),
        ),
      ],
    );
  }

  Widget _buildProjectSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addProject(Project(projectName: 'Project name', description: 'Describe about project'));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.projects.length,
          itemBuilder: (context, index) {
            final project = resumeProvider.resume.projects[index];
            return ListTile(
              title: Text(project.projectName),
              subtitle: Text(project.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit project
                      showDialog(
                        context: context,
                        builder: (context) {
                          final projectNameController = TextEditingController(text: project.projectName);
                          final descriptionController = TextEditingController(text: project.description);

                          return AlertDialog(
                            title: const Text('Edit Project'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: projectNameController,
                                  decoration: const InputDecoration(labelText: 'Project Name'),
                                ),
                                TextField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(labelText: 'Description'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  resumeProvider.updateProject(
                                    index,
                                    Project(
                                      projectName: projectNameController.text,
                                      description: descriptionController.text,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Delete project
                      resumeProvider.removeProject(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildEducationSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Education', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addEducation(Education(
                    universityName: 'University name',
                    degree: 'Degree',
                    startDate: DateTime.now(),
                    endDate: DateTime.now()));
              },
              child: const Icon(Icons.add),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.education.length,
          itemBuilder: (context, index) {
            final education = resumeProvider.resume.education[index];
            return ListTile(
              title: Text(education.universityName),
              subtitle: Text(education.degree),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit education
                      showDialog(
                        context: context,
                        builder: (context) {
                          final universityNameController = TextEditingController(text: education.universityName);
                          final startDateController =
                              TextEditingController(text: education.startDate.toIso8601String());
                          final endDateController = TextEditingController(text: education.endDate.toIso8601String());
                          final degreeController = TextEditingController(text: education.degree);

                          return AlertDialog(
                            title: const Text('Edit Education'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: universityNameController,
                                  decoration: const InputDecoration(labelText: 'University Name'),
                                ),
                                TextField(
                                  controller: startDateController,
                                  decoration: const InputDecoration(labelText: 'Start Date'),
                                ),
                                TextField(
                                  controller: endDateController,
                                  decoration: const InputDecoration(labelText: 'End Date'),
                                ),
                                TextField(
                                  controller: degreeController,
                                  decoration: const InputDecoration(labelText: 'Degree'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  resumeProvider.updateEducation(
                                    index,
                                    Education(
                                      universityName: universityNameController.text,
                                      startDate: DateTime.parse(startDateController.text),
                                      endDate: DateTime.parse(endDateController.text),
                                      degree: degreeController.text,
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Delete education
                      resumeProvider.removeEducation(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildSkillsSection(ResumeProvider resumeProvider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.skills.length,
          itemBuilder: (context, index) {
            final skill = resumeProvider.resume.skills[index];
            return ListTile(
              title: Text(skill),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit skill
                      showDialog(
                        context: context,
                        builder: (context) {
                          final skillController = TextEditingController(text: skill);

                          return AlertDialog(
                            title: const Text('Edit Skill'),
                            content: TextField(
                              controller: skillController,
                              decoration: const InputDecoration(labelText: 'Skill'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  resumeProvider.updateSkill(index, skillController.text);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Delete skill
                      resumeProvider.removeSkill(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Add new skill
            showDialog(
              context: context,
              builder: (context) {
                final skillController = TextEditingController();

                return AlertDialog(
                  title: const Text('Add Skill'),
                  content: TextField(
                    controller: skillController,
                    decoration: const InputDecoration(labelText: 'Skill'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        resumeProvider.addSkill(skillController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Add Skill'),
        ),
      ],
    );
  }
}