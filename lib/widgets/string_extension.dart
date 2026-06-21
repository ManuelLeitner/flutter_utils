extension StringExtension on String {
  bool containsAny(List<String> search) {
    return search.any((s) => contains(s));
  }
}
