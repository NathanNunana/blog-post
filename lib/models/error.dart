part of blog_models;

class Failure implements Exception {
  const Failure({required this.message});
  final String message;
}
