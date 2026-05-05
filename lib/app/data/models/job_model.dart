class Job {
  final String? id;
  final String? createdByEmail;
  final String? title;
  final String? description;
  final String? skillsRequired;
  final int? minExperience;
  final String? companyName;
  final String? location;
  final String? createdAt;
  final bool? isActive;
  final int? createdBy;

  Job({
    this.id,
    this.createdByEmail,
    this.title,
    this.description,
    this.skillsRequired,
    this.minExperience,
    this.companyName,
    this.location,
    this.createdAt,
    this.isActive,
    this.createdBy,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      createdByEmail: json['created_by_email'],
      title: json['title'],
      description: json['description'],
      skillsRequired: json['skills_required'],
      minExperience: json['min_experience'],
      companyName: json['company_name'],
      location: json['location'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by_email': createdByEmail,
      'title': title,
      'description': description,
      'skills_required': skillsRequired,
      'min_experience': minExperience,
      'company_name': companyName,
      'location': location,
      'created_at': createdAt,
      'is_active': isActive,
      'created_by': createdBy,
    };
  }
}
