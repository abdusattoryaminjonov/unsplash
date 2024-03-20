class ImageModel {
  final String id;
  final String? username;
  final String imageUrl;

  const ImageModel({
    required this.id,
    this.username,
    required this.imageUrl,
  });
}