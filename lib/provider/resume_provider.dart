import 'package:flutter/material.dart';
import 'package:resume_builder_task/model/resume_model.dart';

class ResumeProvider with ChangeNotifier {
  Resume _resume = Resume(
    career: Career(),
    workExperience: [],
    projects: [],
    education: [],
    skills: [],
  );

  Resume get resume => _resume;

  void updateResume(Resume resume) {
    _resume = resume;
    notifyListeners();
  }

  void addWorkExperience(WorkExperience workExperience) {
    _resume.workExperience.add(workExperience);
    notifyListeners();
  }

  void removeWorkExperience(int index) {
    _resume.workExperience.removeAt(index);
    notifyListeners();
  }

  void updateWorkExperience(int index, WorkExperience workExperience) {
    _resume.workExperience[index] = workExperience;
    notifyListeners();
  }

  void reorderWorkExperience(int oldIndex, int newIndex) {
    final workExperience = _resume.workExperience.removeAt(oldIndex);
    _resume.workExperience.insert(newIndex, workExperience);
    notifyListeners();
  }

  void addProject(Project project) {
    _resume.projects.add(project);
    notifyListeners();
  }

  void removeProject(int index) {
    _resume.projects.removeAt(index);
    notifyListeners();
  }

  void updateProject(int index, Project project) {
    _resume.projects[index] = project;
    notifyListeners();
  }

  void addEducation(Education education) {
    _resume.education.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    _resume.education.removeAt(index);
    notifyListeners();
  }

  void updateEducation(int index, Education education) {
    _resume.education[index] = education;
    notifyListeners();
  }

  void addSkill(String skill) {
    _resume.skills.add(skill);
    notifyListeners();
  }

  void removeSkill(int index) {
    _resume.skills.removeAt(index);
    notifyListeners();
  }

  void updateSkill(int index, String skill) {
    _resume.skills[index] = skill;
    notifyListeners();
  }
}
