import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StringListBloc {
  final BehaviorSubject<List<String>> _stringList;
  StringListBloc(List<String> initialItems)
    : _stringList = BehaviorSubject.seeded(initialItems);

  Stream<List<String>> get stringList => _stringList.stream;

  void add(List<String> list, String item) {
      _stringList.sink.add([...list, item]);
  }

  void delete(List<String> list, int index) {
    final newList = [...list];
    newList.removeAt(index);
    _stringList.sink.add(newList);
  }

  void update(List<String> list, int index, String value) {
    final newList = [...list];
    newList[index] = value;
    _stringList.sink.add(newList);
  }

  void reorder(List<String> list, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final newList = [...list];
    final item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);
    _stringList.sink.add(newList);
  }

  void dispose() {
    _stringList.close();
  }
}
