class Plan {
  int id;
  String title;
  String description;
  bool isDone;

  Plan({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });
}