import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resume_builder_task/model/resume_model.dart';

class ResumeProvider with ChangeNotifier {
  Resume resume = Resume(
    name: '',
    role: '',
    city: '',
    phoneNumber: '',
    email: '',
    linkedInOrGithubLink: '',
    profileSummary: ProfileSummary(summary: ''),
    workExperience: [],
    projects: [],
    education: [],
    skills: [],
    sectionOrder: [
      SectionType.personalInfo,
      SectionType.career,
      SectionType.workExperience,
      SectionType.projects,
      SectionType.education,
      SectionType.skills
    ],
  );

  void saveResume() async {
    final box = await Hive.openBox<Resume>('resumes');
    await box.add(resume);
  }

  void addWorkExperience(WorkExperience workExperience) {
    resume.workExperience.add(workExperience);
    notifyListeners();
  }

  void removeWorkExperience(int index) {
    resume.workExperience.removeAt(index);
    notifyListeners();
  }

  void updateWorkExperience(int index, WorkExperience workExperience) {
    resume.workExperience[index] = workExperience;
    notifyListeners();
  }

  void addProject(Project project) {
    resume.projects.add(project);
    notifyListeners();
  }

  void removeProject(int index) {
    resume.projects.removeAt(index);
    notifyListeners();
  }

  void updateProject(int index, Project project) {
    resume.projects[index] = project;
    notifyListeners();
  }

  void addEducation(Education education) {
    resume.education.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    resume.education.removeAt(index);
    notifyListeners();
  }

  void updateEducation(int index, Education education) {
    resume.education[index] = education;
    notifyListeners();
  }

  void addSkill(String skill) {
    resume.skills.add(skill);
    notifyListeners();
  }

  void removeSkill(int index) {
    resume.skills.removeAt(index);
    notifyListeners();
  }

  void updateSkill(int index, String skill) {
    resume.skills[index] = skill;
    notifyListeners();
  }

  void reorderSections(int oldIndex, int newIndex) {
    final item = resume.sectionOrder.removeAt(oldIndex);
    resume.sectionOrder.insert(newIndex, item);
    notifyListeners();
  }
}
