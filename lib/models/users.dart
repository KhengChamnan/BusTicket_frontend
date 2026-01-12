class Users {
  final String id;
  final String email;
  final String fullname;
  final String credit;
  final String? avatarImage;

  Users({
    required this.id,
    required this.email,
    required this.fullname,
    required this.credit,
    this.avatarImage,
  });
}