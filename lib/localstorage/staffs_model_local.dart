class Staff {
  final String title;
  final String image;
  final String designation;
  final String? phone;
  final String? email;
  final String office;
  final String? dept;

  const Staff(
      {required this.title,
      required this.image,
      required this.designation,
      this.phone,
      this.email,
      required this.office,
      this.dept});
}
