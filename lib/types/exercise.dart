class BaseExercise {
  const BaseExercise();
}

class Exercise extends BaseExercise {
  const Exercise({required this.name, this.description});

  final String name;
  final String? description;

  @override
  String toString() {
    return 'Exercise: $name $description';
  }
}

class Break extends BaseExercise {
  const Break();
}
