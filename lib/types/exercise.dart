abstract class BaseExercise {
  BaseExercise(this.name);
  String name;

  bool isBreak() => false;
}

class Exercise extends BaseExercise {
  String? description;

  Exercise({required String name, this.description}) : super(name);

  Exercise.fromJson(Map<String, dynamic> json) : super(json['name'] as String) {
    description = json['description'] as String;
    if (description == '') {
      description = null;
    }
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description ?? '',
  };

  @override
  String toString() {
    return 'Exercise: $name $description';
  }
}

class Break extends BaseExercise {
  Break() : super('Break');

  @override
  bool isBreak() => true;
}
