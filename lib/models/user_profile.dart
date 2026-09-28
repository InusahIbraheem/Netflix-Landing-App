class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.plan,
    required this.memberSince,
  });

  final String name;
  final String email;
  final String avatarUrl;
  final String plan;
  final String memberSince;
}
