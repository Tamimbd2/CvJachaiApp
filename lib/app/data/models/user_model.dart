class UserModel {
  final String? refresh;
  final String? access;
  final UserData? user;

  UserModel({
    this.refresh,
    this.access,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      refresh: json['refresh'],
      access: json['access'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  final String? email;
  final String? fullName;
  final bool? isStaff;

  UserData({
    this.email,
    this.fullName,
    this.isStaff,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      fullName: json['full_name'],
      isStaff: json['is_staff'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_name'] = fullName;
    data['is_staff'] = isStaff;
    return data;
  }
}
