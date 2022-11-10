import 'package:dart_dsa/linked_list.dart';
import 'package:dart_dsa/stack.dart';

void main(List<String> arguments) {
  // stackChallenge1();
  // stackChallenge2();
  // linkedListChallenge1();
  linkedListChallenge1();
  linkedListChallenge2();
  linkedListChallenge3();
  linkedListChallenge4();
}

/// Challenge #1 - Stack
/// Reverse list using stack
void stackChallenge1() {
  final list = ['A', 'P', 'P', 'L', 'E'];
  printInReverse(list);
}

void printInReverse<E>(List<E> elements) {
  final stack = Stack<E>();
  for (final element in elements) {
    stack.push(element);
  }
  while (stack.isNotEmpty) {
    print(stack.pop());
  }
}

/// Challenge #2 - Stack
/// Balance the parentheses
void stackChallenge2() {
  final testCase1 = balanceParentheses('h((e))llo(world)()');
  print('h((e))llo(world)(): $testCase1');
  final testCase2 = balanceParentheses('(hello world');
  print('(hello world: $testCase2');
  final testCase3 = balanceParentheses('hello) (world');
  print('hello) (world: $testCase3');
}

bool balanceParentheses(String text) {
  final stack = Stack<int>();
  final open = '('.codeUnitAt(0);
  final close = ')'.codeUnitAt(0);

  for (int codeUnit in text.codeUnits) {
    if (codeUnit == open) {
      stack.push(codeUnit);
    } else if (codeUnit == close) {
      if (stack.isEmpty) {
        return false;
      } else {
        stack.pop();
      }
    }
  }
  return stack.isEmpty;
}

/// Challenge #1 - Linked List
/// Print list in reverse
void linkedListChallenge1() {
  final list = LinkedList<int>();
  list.append(1);
  list.append(2);
  list.append(3);

  print(list);
  printLinkedListInReverse(list);
}

void printLinkedListInReverse<E>(LinkedList<E> list) {
  printNodeRecursively(list.head);
}

void printNodeRecursively<T>(Node<T>? node) {
  if (node == null) return;
  printNodeRecursively(node.next);
  print(node.value);
}

/// Challenge #2 - Linked List
/// Find middle node in linked list
void linkedListChallenge2() {
  final list1 = LinkedList<int>();
  list1.append(1);
  list1.append(2);
  list1.append(3);
  list1.append(4);
  final middle1 = getMiddleNode(list1);
  print(list1);
  print('middle: ${middle1?.value}');

  final list2 = LinkedList<int>();
  list2.append(1);
  list2.append(2);
  list2.append(3);
  final middle2 = getMiddleNode(list2);
  print(list2);
  print('middle: ${middle2?.value}');
}

Node<E>? getMiddleNode<E>(LinkedList<E> list) {
  /// Using the Two Ptr concept
  var slow = list.head; // 1st pointer
  var fast = list.head; // 2nd pointer

  while (fast?.next != null) {
    fast = fast?.next?.next;
    slow = slow?.next;
  }

  return slow;
}

/// Challenge #3 - Linked List
/// Reverse a linked list
/// This challenge is done by manipulating the list nodes
void linkedListChallenge3() {
  final list = LinkedList<int>();
  list.append(1);
  list.append(2);
  list.append(3);
  print(list);
  list.reverse();
  print(list);
}

extension ReversibleLinkedList<E> on LinkedList<E> {
  void reverse() {
    /// Step 1
    /// Using the Two Ptr concept
    var prev = head; // 1st pointer
    var curr = head?.next; // 2nd pointer
    prev?.next = null;
    while (curr != null) {
      /// Step 2
      /// The next reference of the current need to save
      var next = curr.next;

      /// Step 3
      /// Change the next reference of current to previous
      curr.next = prev;

      /// Step 4
      /// Shift the ptr
      prev = curr;
      curr = next;
    }

    /// Step 5
    /// Change head to the new one
    head = prev;
  }
}

/// Challenge #4 - Linked List
/// Remove all occurrences of a specific element from list
void linkedListChallenge4() {
  final list = LinkedList<int>();
  list.append(1);
  list.append(3);
  list.append(3);
  list.append(3);
  list.append(4);
  print(list);
  list.removeAll(3);
  print(list);
}

extension RemovableLinkedList<E> on LinkedList<E> {
  void removeAll(E value) {
    /// Handle occurence at head
    while (head != null && head!.value == value) {
      head = head!.next;
    }

    /// Using the Two Ptr concept
    var prev = head; // 1st pointer
    var curr = head?.next; // 2nd pointer
    while (curr != null) {
      /// Pop the occurence node from list
      if (curr.value == value) {
        prev?.next = curr.next;
        curr = prev?.next;
        continue;
      }

      /// Shift the pointers
      prev = curr;
      curr = curr.next;
    }
    tail = prev;
  }
}
