class FitnessPlan {
  final String title;
  final String description;
  final String type;
  final String imageUrl;  // image field

  FitnessPlan({
    required this.title,
    required this.description,
    required this.type,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'type': type,
      'imageUrl': imageUrl,  // add this
    };
  }
}
