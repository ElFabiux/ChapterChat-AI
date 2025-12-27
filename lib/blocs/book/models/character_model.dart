class CharacterModel {
  final String name;
  final String description;

  CharacterModel({required this.name, required this.description});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createdAt': DateTime.now(),
    };
  }
}
