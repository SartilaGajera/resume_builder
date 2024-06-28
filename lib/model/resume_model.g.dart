// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResumeAdapter extends TypeAdapter<Resume> {
  @override
  final int typeId = 0;

  @override
  Resume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resume(
      name: fields[0] as String,
      role: fields[1] as String,
      city: fields[2] as String,
      phoneNumber: fields[3] as String,
      email: fields[4] as String,
      linkedInOrGithubLink: fields[5] as String,
      profileSummary: fields[6] as ProfileSummary,
      workExperience: (fields[7] as List).cast<WorkExperience>(),
      projects: (fields[8] as List).cast<Project>(),
      education: (fields[9] as List).cast<Education>(),
      skills: (fields[10] as List).cast<String>(),
      sectionOrder: (fields[11] as List).cast<SectionType>(),
    );
  }

  @override
  void write(BinaryWriter writer, Resume obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.linkedInOrGithubLink)
      ..writeByte(6)
      ..write(obj.profileSummary)
      ..writeByte(7)
      ..write(obj.workExperience)
      ..writeByte(8)
      ..write(obj.projects)
      ..writeByte(9)
      ..write(obj.education)
      ..writeByte(10)
      ..write(obj.skills)
      ..writeByte(11)
      ..write(obj.sectionOrder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProfileSummaryAdapter extends TypeAdapter<ProfileSummary> {
  @override
  final int typeId = 1;

  @override
  ProfileSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileSummary(
      summary: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileSummary obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkExperienceAdapter extends TypeAdapter<WorkExperience> {
  @override
  final int typeId = 2;

  @override
  WorkExperience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkExperience(
      companyName: fields[0] as String,
      role: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      isCurrentlyWorking: fields[4] as bool,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkExperience obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.isCurrentlyWorking)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkExperienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 3;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      projectName: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.projectName)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EducationAdapter extends TypeAdapter<Education> {
  @override
  final int typeId = 4;

  @override
  Education read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Education(
      universityName: fields[0] as String,
      degree: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Education obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.universityName)
      ..writeByte(1)
      ..write(obj.degree)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SectionTypeAdapter extends TypeAdapter<SectionType> {
  @override
  final int typeId = 5;

  @override
  SectionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SectionType.personalInfo;
      case 1:
        return SectionType.career;
      case 2:
        return SectionType.workExperience;
      case 3:
        return SectionType.projects;
      case 4:
        return SectionType.education;
      case 5:
        return SectionType.skills;
      default:
        return SectionType.personalInfo;
    }
  }

  @override
  void write(BinaryWriter writer, SectionType obj) {
    switch (obj) {
      case SectionType.personalInfo:
        writer.writeByte(0);
        break;
      case SectionType.career:
        writer.writeByte(1);
        break;
      case SectionType.workExperience:
        writer.writeByte(2);
        break;
      case SectionType.projects:
        writer.writeByte(3);
        break;
      case SectionType.education:
        writer.writeByte(4);
        break;
      case SectionType.skills:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
