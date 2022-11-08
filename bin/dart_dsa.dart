import 'package:dart_dsa/linked_list.dart';
import 'package:dart_dsa/stack.dart';

void main(List<String> arguments) {
  // challenge1();
  // challenge2();
  exampleLinkedList();
}

/// Challenge #1
/// Reverse list using stack
void challenge1() {
  final list = ['A', 'P', 'P', 'L', 'E'];
  printInReverse(list);
}

void printInReverse<E>(List<E> elements) {
  final stack = Stack<E>();
  // Push list element to the stack
  for (final element in elements) {
    stack.push(element);
  }

  // Use .pop to print elements in reverse
  while (stack.isNotEmpty) {
    print(stack.pop());
  }
}

/// Challenge #2
/// Balance the parentheses
/// Test Cases:
/// 1. h((e))llo(world)() => balanced parentheses
/// 2. (hello world => unbalanced parentheses
void challenge2() {
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

/// Linked List example
void exampleLinkedList() {
  final list = LinkedList<int>();
  list.push(3);
  list.push(2);
  list.push(1);

  for (final item in list) {
    print(item);
  }
}
