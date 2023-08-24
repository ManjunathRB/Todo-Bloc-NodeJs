class Todos {
  Todos({
    required this.todo,
    required this.isCompleted,
    required this.id,
    required this.date,
  });
  late String todo;
  late bool isCompleted;
  late int id;
  late String date;

  Todos.fromJson(Map<String, dynamic> json) {
    todo = json['todo'];
    isCompleted = json['isCompleted'] == "true";
    id = json['id'] as int;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['todo'] = todo;
    data['isCompleted'] = isCompleted;
    data['id'] = id;
    data['date'] = date;
    return data;
  }
}
