extension StringComparision on String {
  int compareNumberedString(String other) {
    var aIterator = _iterate().iterator;
    var bIterator = other._iterate().iterator;
    while (true) {
      var aHasNext = aIterator.moveNext();
      var bHasNext = bIterator.moveNext();
      if (!aHasNext && !bHasNext) return 0;
      if (!aHasNext) return -1;
      if (!bHasNext) return 1;

      dynamic a = aIterator.current;
      dynamic b = bIterator.current;

      if (aIterator.current.isDigit() && bIterator.current.isDigit()) {
        a = int.parse(a);
        b = int.parse(b);
      }
      var cmp = a.compareTo(b);
      if (cmp != 0) return cmp;
    }
  }

  bool isDigit([int i = 0]) => codeUnitAt(i) >= 48 && codeUnitAt(i) <= 57;
  Iterable<String> _iterate() sync* {
    String cur = "";
    var i = 0;
    while (i < length) {
      if (cur.isEmpty || cur.isDigit() == isDigit(i)) {
        cur += this[i];
        i++;
      } else {
        yield cur;
        cur = "";
      }
    }
    if (cur.isNotEmpty) yield cur;
  }
}
