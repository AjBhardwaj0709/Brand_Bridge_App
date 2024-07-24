class UserProfile {
  final String name;
  final String username;
  final String bio;

  UserProfile({required this.name, required this.username, required this.bio});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        name: json['name'], username: json['username'], bio: json['bio']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'username': username, 'bio': bio};
  }
}
