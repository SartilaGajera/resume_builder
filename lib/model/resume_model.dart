class Resume {
  String name;
  String role;
  String city;
  String phoneNumber;
  String email;
  String linkedInOrGithubLink;
  Career career;
  List<WorkExperience> workExperience;
  List<Project> projects;
  List<Education> education;
  List<String> skills;

  Resume({
    this.name = '',
    this.role = '',
    this.city = '',
    this.phoneNumber = '',
    this.email = '',
    this.linkedInOrGithubLink = '',
    required this.career,
    required this.workExperience,
    required this.projects,
    required this.education,
    required this.skills,
  });
}

class Career {
  String title;
  String description;

  Career({this.title = '', this.description = ''});
}

class WorkExperience {
  String companyName;
  String role;
  DateTime startDate;
  DateTime endDate;
  bool isCurrentlyWorking;
  String description;

  WorkExperience({
    this.companyName = '',
    this.role = '',
    required this.startDate,
    required this.endDate,
    this.isCurrentlyWorking = false,
    this.description = '',
  });
}

class Project {
  String projectName;
  String description;

  Project({this.projectName = '', this.description = ''});
}

class Education {
  String universityName;
  DateTime startDate;
  DateTime endDate;
  String degree;

  Education({
    this.universityName = '',
    required this.startDate,
    required this.endDate,
    this.degree = '',
  });
}
