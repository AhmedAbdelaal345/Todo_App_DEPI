class TodoModel {
  final int id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
