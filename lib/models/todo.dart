class Todo {
  String title;
  bool completed;

  Todo({
    required this.title,
    required this.completed,
  });

  toJson() {
    return {
      "title": title,
      "completed": completed,
    };
  }

  static fromJson(jsonData) {
    return Todo(
      title: jsonData['title'],
      completed: jsonData['completed'],
    );
  }
}
