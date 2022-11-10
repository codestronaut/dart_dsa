class Node<T> {
  Node({required this.value, this.next});

  /// The node value
  final T value;

  /// The reference for next node (optional)
  /// next = null means end of the list
  Node<T>? next;

  /// Log
  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  /// LinkedList characteristics
  /// head: the first node of the list
  /// tail: the last node of the list
  Node<E>? head;
  Node<E>? tail;

  /// A LinkedList determined is empty if the head is null
  @override
  bool get isEmpty => head == null;

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  String toString() {
    if (head == null) return 'Empty list';
    return head.toString();
  }

  /// Push will add a new value to the front of the list
  /// Known as Head-First Insertion
  void push(E value) {
    /// The new incoming node will be a new head
    head = Node(value: value, next: head);

    /// If the tail is null
    /// Then the tail is also head
    /// This means there is only 1 element in the list
    tail ??= head;
  }

  /// Append will add a new value to the end of the list
  /// Know as Tail-End Insertion
  void append(E value) {
    /// If the list is currently empty
    /// Then just push the new value
    /// And exit from method
    if (isEmpty) {
      push(value);
      return;
    }

    /// Tail is guarantee not null
    /// Add new node
    tail!.next = Node(value: value);

    /// Chain the current tail to the new node
    tail = tail!.next;
  }

  /// Retrieve node at a particular index
  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  /// Insert a new node after the known node
  /// Has O(1) time complexity (constants time)
  /// But there is no option to inserting before a node
  /// Because we have no reference to the previous node
  Node<E> insertAfter(Node<E> node, E value) {
    /// If the list contain only 1 element
    /// Then just append the new node
    if (head == tail) {
      append(value);
      return tail!;
    }

    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  /// Pop will remove node from the front of the list
  E? pop() {
    /// Getting the current head value
    /// Which is the popped value
    final value = head?.value;

    /// Set new head with the next node
    head = head?.next;

    /// If the list is empty, then set the tail to null
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  /// Remove the last node from list
  /// since removeLast required to loop through the list
  /// to find the node before tail
  /// this operation has O(n) time complexity
  E? removeLast() {
    /// If the list has only 1 node
    /// Then just pop the node
    if (head?.next == null) return pop();

    /// Loop though list until reach the node before tail
    /// We use the next reference of the node to remove last element
    /// Which is tail
    var current = head;
    while (current?.next != tail) {
      current = current?.next;
    }

    /// Get the tail value
    final value = tail?.value;

    /// Rewire the list nodes
    /// Tail is now current (node before tail)
    /// Also, don't forget to make the tail next reference to null
    /// Since this is the last node
    tail = current;
    tail?.next = null;
    return value;
  }

  /// Remove a node after another node
  E? removeAfter(Node<E> node) {
    /// Get the node value
    final value = node.value;

    /// If the next reference of node is equal tail
    /// Then tail now is node
    if (node.next == tail) {
      tail = node;
    }

    /// Rewire the list nodes
    /// Because we remove node after specified node
    /// Then the next reference of node is next-next node
    node.next = node.next?.next;
    return value;
  }

  /// Give the ability to loop through linked list
  /// By extending it with Iterable
  @override
  Iterator<E> get iterator => _LinkedListIterator(this);
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(LinkedList<E> list) : _list = list;
  final LinkedList<E> _list;

  Node<E>? _currentNode;

  @override
  E get current => _currentNode!.value;

  bool _firstPass = true;

  /// Tell the iterable how to move though the collection
  /// In this case a linked list
  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}
