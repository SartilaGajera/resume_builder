import 'package:hive/hive.dart';

part 'resume_model.g.dart';

@HiveType(typeId: 0)
class Resume {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  String city;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String email;

  @HiveField(5)
  String linkedInOrGithubLink;

  @HiveField(6)
  ProfileSummary profileSummary;

  @HiveField(7)
  List<WorkExperience> workExperience;

  @HiveField(8)
  List<Project> projects;

  @HiveField(9)
  List<Education> education;

  @HiveField(10)
  List<String> skills;

  @HiveField(11)
  List<SectionType> sectionOrder;

  Resume({
    required this.name,
    required this.role,
    required this.city,
    required this.phoneNumber,
    required this.email,
    required this.linkedInOrGithubLink,
    required this.profileSummary,
    required this.workExperience,
    required this.projects,
    required this.education,
    required this.skills,
    required this.sectionOrder,
  });
}

@HiveType(typeId: 1)
class ProfileSummary {
  @HiveField(0)
  String summary;

  ProfileSummary({required this.summary});
}

@HiveType(typeId: 2)
class WorkExperience {
  @HiveField(0)
  String companyName;

  @HiveField(1)
  String role;

  @HiveField(2)
  String startDate;

  @HiveField(3)
  String endDate;

  @HiveField(4)
  bool isCurrentlyWorking;

  @HiveField(5)
  String description;

  WorkExperience({
    required this.companyName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isCurrentlyWorking,
    required this.description,
  });
}

@HiveType(typeId: 3)
class Project {
  @HiveField(0)
  String projectName;

  @HiveField(1)
  String description;

  Project({required this.projectName, required this.description});
}

@HiveType(typeId: 4)
class Education {
  @HiveField(0)
  String universityName;

  @HiveField(1)
  String degree;

  @HiveField(2)
  String startDate;

  @HiveField(3)
  String endDate;

  Education({
    required this.universityName,
    required this.degree,
    required this.startDate,
    required this.endDate,
  });
}

@HiveType(typeId: 5)
enum SectionType {
  @HiveField(0)
  personalInfo,
  @HiveField(1)
  career,
  @HiveField(2)
  workExperience,
  @HiveField(3)
  projects,
  @HiveField(4)
  education,
  @HiveField(5)
  skills,
}
