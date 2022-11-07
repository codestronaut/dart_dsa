class Stack<E> {
  Stack() : _storage = <E>[];

  final List<E> _storage;

  /// Essential operation of stack
  void push(E element) => _storage.add(element);

  E pop() => _storage.removeLast();

  /// Logging
  @override
  String toString() => '--- TOP ---\n'
      '${_storage.reversed.join('\n')}'
      '\n-----------';

  /// Nice to have operation of stack
  E get peek => _storage.last;

  bool get isEmpty => _storage.isEmpty;

  bool get isNotEmpty => !isEmpty;

  Stack.of(Iterable<E> elements) : _storage = List<E>.of(elements);
}
