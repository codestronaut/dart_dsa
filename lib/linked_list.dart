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

class LinkedList<E> {
  /// LinkedList characteristics
  /// head: the first node of the list
  /// tail: the last node of the list
  Node<E>? head;
  Node<E>? tail;

  /// A LinkedList determined is empty if the head is null
  bool get isEmpty => head == null;

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
  /// Has O(1) time complexity (linear time)
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
}
