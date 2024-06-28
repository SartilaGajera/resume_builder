import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_builder_task/model/resume_model.dart';
import 'package:resume_builder_task/pages/resume_list.dart';
import 'package:resume_builder_task/provider/resume_provider.dart';
import 'package:resume_builder_task/widgets/appColors.dart';
import 'package:resume_builder_task/widgets/appTextStyle.dart';
import 'package:resume_builder_task/widgets/commonAppBar.dart';

class ResumePreviewScreen extends StatelessWidget {
  const ResumePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final resume = resumeProvider.resume;

    return Scaffold(
      appBar: const CommonAppBar(title: 'Resume Preview'),
      body: ListView(
        children: resume.sectionOrder.map((section) {
          switch (section) {
            case SectionType.personalInfo:
              return _buildPersonalInfoSection(resume);
            case SectionType.career:
              return _buildSummarySection(resume);
            case SectionType.workExperience:
              return _buildWorkExperienceSection(resume);
            case SectionType.projects:
              return _buildProjectSection(resume);
            case SectionType.education:
              return _buildEducationSection(resume);
            case SectionType.skills:
              return _buildSkillsSection(resume);
            default:
              return const SizedBox.shrink();
          }
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resumeProvider.saveResume();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resume saved!')),
          );
        },
        mini: true,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.save_alt_rounded,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(resume.name.toUpperCase(),
              style: AppTextStyles.bold.copyWith(fontSize: 18, color: AppColors.primaryColor)),
          buildTitle('(${resume.role})'),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDesc(resume.city),
                buildVerticalDivider(),
                buildDesc(resume.phoneNumber),
                buildVerticalDivider(),
                buildDesc(resume.email)
              ],
            ),
          ),
          Text(resume.linkedInOrGithubLink,
              style: AppTextStyles.semiBold.copyWith(
                  fontSize: 12,
                  color: AppColors.linkColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.linkColor,
                  decorationStyle: TextDecorationStyle.solid)),
          buildSpacer(),
          buildDivider(isThick: true)
        ],
      ),
    );
  }

  Widget _buildSummarySection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('Profile Summary'),
          buildDivider(),
          buildDesc(resume.profileSummary.summary),
          buildSpacer()
        ],
      ),
    );
  }

  Widget _buildWorkExperienceSection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('Work Experience'),
          buildDivider(),
          ...resume.workExperience.map((workExperience) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSubTitle(workExperience.companyName),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      buildDesc(workExperience.role),
                      buildVerticalDivider(),
                      buildDesc(workExperience.isCurrentlyWorking
                          ? "${workExperience.startDate} - Present"
                          : "${workExperience.startDate}"
                              " - ${workExperience.endDate}"),
                    ],
                  ),
                ),
                buildDesc(workExperience.description),
                buildSpacer(),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProjectSection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('Projects'),
          buildDivider(),
          ...resume.projects.map((project) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSubTitle("Project Name: ${project.projectName}"),
                buildDesc('Description: ${project.description}'),
                buildSpacer()
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEducationSection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('Education'),
          buildDivider(),
          ...resume.education.map((education) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      buildSubTitle(education.universityName),
                      buildVerticalDivider(),
                      buildSubTitle(
                          '${education.startDate} - ${education.endDate}')
                    ],
                  ),
                ),
                buildDesc(education.degree),
                buildSpacer()
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(Resume resume) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle('Skills'),
          buildDivider(),
          ...resume.skills.map((skill) {
            return buildDesc(skill);
          }),
          buildSpacer()
        ],
      ),
    );
  }
}
