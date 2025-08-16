abstract class BaseExercise {
  const BaseExercise(this.name);
  final String name;

  bool isBreak() => false;
}

class Exercise extends BaseExercise {
  const Exercise({required String name, this.description}) : super(name);

  final String? description;

  @override
  String toString() {
    return 'Exercise: $name $description';
  }
}

class Break extends BaseExercise {
  const Break() : super('Break');

  @override
  bool isBreak() => true;
}
