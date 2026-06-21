import 'dart:math';

extension CompareExtension<T extends Comparable<T>> on List<T> {
  int compareTo(List<T> other) {
    sort();
    other.sort();
    for (var i = 0; i < min(other.length, length); i++) {
      var cmp = this[i].compareTo(other[i]);
      if (cmp != 0) return cmp;
    }

    return length.compareTo(other.length);
  }
}

extension IterableExtension<T> on Iterable<T> {
  bool intersects<R>(Iterable<T> other, {R Function(T)? map}) =>
      any((e) => other.any((i) => map != null ? map(e) == map(i) : e == i));

  Iterable<T> intersection<R>(Iterable<T> other, {R Function(T)? map}) =>
      where((e) => other.any((i) => map != null ? map(e) == map(i) : e == i));

  Iterable<T> intersectionByMap<O, R>(
    Iterable<O> other, {
    required R Function(T) mapThis,
    required R Function(O) mapArg,
  }) => where((e) => other.any((i) => mapThis(e) == mapArg(i)));
}

bool typeEquals<A, B>() {
  var a = A;
  var b = B;
  return a == b;
}
