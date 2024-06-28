import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/model/resume_model.dart';
import 'package:resume_builder_task/pages/resume_list.dart';
import 'package:resume_builder_task/pages/resume_preview.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';
import 'package:resume_builder_task/widgets/appColors.dart';
import 'package:resume_builder_task/widgets/appTextField.dart';
import 'package:resume_builder_task/widgets/commonAppBar.dart';

class ResumeBuilderScreen extends StatelessWidget {
  const ResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);

    return Scaffold(
        appBar: const CommonAppBar(title: 'Resume Builder'),
        body: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                shrinkWrap: true,
                children: resumeProvider.resume.sectionOrder.map((e) {
                  Widget sectionWidget;
                  switch (e) {
                    case SectionType.personalInfo:
                      sectionWidget = _buildPersonalInfoSection(resumeProvider);
                      break;
                    case SectionType.career:
                      sectionWidget = _buildCareerSection(resumeProvider);
                      break;
                    case SectionType.workExperience:
                      sectionWidget = _buildWorkExperienceSection(resumeProvider);
                      break;
                    case SectionType.projects:
                      sectionWidget = _buildProjectSection(resumeProvider);
                      break;
                    case SectionType.education:
                      sectionWidget = _buildEducationSection(resumeProvider);
                      break;
                    case SectionType.skills:
                      sectionWidget = _buildSkillsSection(resumeProvider, context);
                      break;
                    default:
                      sectionWidget = const SizedBox.shrink();
                  }
                  return ListTile(
                    key: Key(e.toString()),
                    title: sectionWidget,
                  );
                }).toList(),
                onReorder: (oldIndex, newIndex) {
                  resumeProvider.reorderSections(oldIndex, newIndex);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(AppColors.secondaryColor)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResumePreviewScreen(),
                      ),
                    );
                  },
                  child: buildSubTitle('Preview Resume'),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(AppColors.secondaryColor)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResumeListScreen(),
                      ),
                    );
                  },
                  child: buildSubTitle('View All Resumes'),
                ),
              ],
            ),
            buildSpacer()
          ],
        ));
  }

  Widget _buildPersonalInfoSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Personal Info'),
        buildSpacer(),
        CommonTextField(
            hintText: 'Full Name',
            onChanged: (value) {
              resumeProvider.resume.name = value;
              resumeProvider.notifyListeners();
            }),
        buildSpacer(),
        CommonTextField(
          hintText: 'Role',
          onChanged: (value) {
            resumeProvider.resume.role = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer(),
        CommonTextField(
          hintText: 'City',
          onChanged: (value) {
            resumeProvider.resume.city = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer(),
        CommonTextField(
          hintText: 'Phone Number',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            resumeProvider.resume.phoneNumber = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer(),
        CommonTextField(
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            resumeProvider.resume.email = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer(),
        CommonTextField(
          hintText: 'LinkedIn/GitHub Link',
          onChanged: (value) {
            resumeProvider.resume.linkedInOrGithubLink = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer(),
      ],
    );
  }

  Widget _buildCareerSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Profile Summary'),
        buildSpacer(),
        CommonTextField(
          maxLength: 200,
          maxLines: 5,
          hintText: 'Description',
          onChanged: (value) {
            resumeProvider.resume.profileSummary.summary = value;
            resumeProvider.notifyListeners();
          },
        ),
        buildSpacer()
      ],
    );
  }

  Widget _buildWorkExperienceSection(ResumeProvider resumeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildTitle('Work Experience'),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addWorkExperience(
                  WorkExperience(
                    companyName: 'Company Name',
                    role: 'Role',
                    startDate: DateFormat('MMM y').format(DateTime.now()),
                    endDate: DateFormat('MMM y').format(DateTime.now()),
                    isCurrentlyWorking: false,
                    description: 'Description',
                  ),
                );
              },
              child: const Icon(Icons.add_circle, size: 20, color: AppColors.primaryColor),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.workExperience.length,
          itemBuilder: (context, index) {
            final workExperience = resumeProvider.resume.workExperience[index];
            return Card(
              child: ListTile(
                title: Text(workExperience.companyName),
                subtitle: Text(workExperience.role),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit, size: 15, color: AppColors.lightTextColor),
                      onTap: () {
                        // Edit work experience
                        showDialog(
                          context: context,
                          builder: (context) {
                            final companyNameController = TextEditingController(text: workExperience.companyName);
                            final roleController = TextEditingController(text: workExperience.role);
                            final startDateController = TextEditingController(text: workExperience.startDate);
                            final endDateController = TextEditingController(text: workExperience.endDate);
                            ValueNotifier<bool> isCurrentlyWorkingController = ValueNotifier<bool>(false);
                            final descriptionController = TextEditingController(text: workExperience.description);

                            return AlertDialog(
                              title: const Text('Edit Work Experience'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonTextField(hintText: 'Company Name', controller: companyNameController),
                                    buildSpacer(),
                                    CommonTextField(controller: roleController, hintText: 'Role'),
                                    buildSpacer(),
                                    CommonTextField(controller: startDateController, hintText: 'Start Date'),
                                    buildSpacer(),
                                    ValueListenableBuilder(
                                        valueListenable: isCurrentlyWorkingController,
                                        builder: (context, v, c) {
                                          return Column(
                                            children: [
                                              isCurrentlyWorkingController.value
                                                  ? const SizedBox.shrink()
                                                  : CommonTextField(
                                                      controller: endDateController, hintText: 'End Date'),
                                              buildSpacer(),
                                              Row(
                                                children: [
                                                  buildDesc('Currently Working'),
                                                  Checkbox(
                                                      activeColor: AppColors.primaryColor,
                                                      value: isCurrentlyWorkingController.value,
                                                      onChanged: (bool? v) {
                                                        isCurrentlyWorkingController.value =
                                                            !isCurrentlyWorkingController.value;
                                                      }),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                    buildSpacer(),
                                    CommonTextField(
                                        controller: descriptionController,
                                        hintText: 'Description',
                                        maxLines: 5,
                                        maxLength: 100),
                                    buildSpacer(),
                                  ],
                                ),
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
                                        startDate: startDateController.text,
                                        endDate: (endDateController.text),
                                        isCurrentlyWorking: isCurrentlyWorkingController.value,
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
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Icon(Icons.delete_outline, size: 15, color: AppColors.lightTextColor),
                      onTap: () {
                        // Delete work experience
                        resumeProvider.removeWorkExperience(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
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
            buildTitle('Projects'),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addProject(Project(projectName: 'Project name', description: 'Describe about project'));
              },
              child: const Icon(
                Icons.add_circle,
                size: 20,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.projects.length,
          itemBuilder: (context, index) {
            final project = resumeProvider.resume.projects[index];
            return Card(
              child: ListTile(
                title: Text(project.projectName),
                subtitle: Text(project.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                        color: AppColors.lightTextColor,
                      ),
                      onTap: () {
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
                                  CommonTextField(controller: projectNameController, hintText: 'Project Name'),
                                  buildSpacer(),
                                  CommonTextField(
                                      controller: descriptionController,
                                      hintText: 'Description',
                                      maxLength: 100,
                                      maxLines: 5),
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
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete_outline,
                        size: 15,
                        color: AppColors.lightTextColor,
                      ),
                      onTap: () {
                        // Delete project
                        resumeProvider.removeProject(index);
                      },
                    ),
                  ],
                ),
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
            buildTitle('Education'),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resumeProvider.addEducation(Education(
                    universityName: 'University name',
                    degree: 'Degree',
                    startDate: DateFormat('MMM y').format(DateTime.now()),
                    endDate: DateFormat('MMM y').format(DateTime.now())));
              },
              child: const Icon(Icons.add_circle, size: 20, color: AppColors.primaryColor),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.education.length,
          itemBuilder: (context, index) {
            final education = resumeProvider.resume.education[index];
            return Card(
              child: ListTile(
                title: Text(education.universityName),
                subtitle: Text(education.degree),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Edit education
                        showDialog(
                          context: context,
                          builder: (context) {
                            final universityNameController = TextEditingController(text: education.universityName);
                            final startDateController =
                                TextEditingController(text: education.startDate);
                            final endDateController = TextEditingController(text: education.endDate);
                            final degreeController = TextEditingController(text: education.degree);

                            return AlertDialog(
                              title: const Text('Edit Education'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CommonTextField(
                                      controller: universityNameController, hintText: 'University/School Name'),
                                 buildSpacer(), CommonTextField(controller: startDateController, hintText: 'Start Date'),
                                 buildSpacer(), CommonTextField(controller: endDateController, hintText: 'End Date'),
                                 buildSpacer(), CommonTextField(controller: degreeController, hintText: 'Degree'),
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
                                        startDate: startDateController.text,
                                        endDate: endDateController.text,
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
                      child: const Icon(Icons.edit, size: 15, color: AppColors.lightTextColor),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          // Delete education
                          resumeProvider.removeEducation(index),
                      child: const Icon(Icons.delete_outline, size: 15, color: AppColors.lightTextColor),
                    )
                  ],
                ),
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
        Row(
          children: [
            buildTitle('Skills'),
            const Spacer(),
            GestureDetector(
              onTap: () {
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
              child: const Icon(Icons.add_circle, size: 20, color: AppColors.primaryColor),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: resumeProvider.resume.skills.length,
          itemBuilder: (context, index) {
            final skill = resumeProvider.resume.skills[index];
            return Card(
              child: ListTile(
                title: Text(skill),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit, size: 15, color: AppColors.lightTextColor),
                      onTap: () {
                        // Edit skill
                        showDialog(
                          context: context,
                          builder: (context) {
                            final skillController = TextEditingController(text: skill);

                            return AlertDialog(
                              title: const Text('Edit Skill'),
                              content: CommonTextField(controller: skillController, hintText: 'Skill'),
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
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Icon(Icons.delete_outline, size: 15, color: AppColors.lightTextColor),
                      onTap: () {
                        // Delete skill
                        resumeProvider.removeSkill(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        buildSpacer()
      ],
    );
  }
}
