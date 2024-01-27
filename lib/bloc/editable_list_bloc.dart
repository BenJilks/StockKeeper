import 'dart:async';
import 'package:rxdart/rxdart.dart';

class EditableListBloc<T> {
  final BehaviorSubject<List<T>> _stringList;
  EditableListBloc(List<T> initialItems)
    : _stringList = BehaviorSubject.seeded(initialItems);

  Stream<List<T>> get list => _stringList.stream;

  void add(List<T> list, T item) {
      _stringList.sink.add([...list, item]);
  }

  void delete(List<T> list, int index) {
    final newList = [...list];
    newList.removeAt(index);
    _stringList.sink.add(newList);
  }

  void update(List<T> list, int index, T value) {
    final newList = [...list];
    newList[index] = value;
    _stringList.sink.add(newList);
  }

  void reorder(List<T> list, int oldIndex, int newIndex) {
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
