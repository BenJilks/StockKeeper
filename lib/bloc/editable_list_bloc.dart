import 'package:rxdart/rxdart.dart';

class EditableListBloc<T> {
  final BehaviorSubject<List<T>> _list;
  EditableListBloc(List<T> initialItems)
    : _list = BehaviorSubject.seeded(initialItems);

  ValueStream<List<T>> get list => _list.stream;

  void add(List<T> list, T item) {
      _list.sink.add([...list, item]);
  }

  void delete(List<T> list, int index) {
    final newList = [...list];
    newList.removeAt(index);
    _list.sink.add(newList);
  }

  void update(List<T> list, int index, T value) {
    final newList = [...list];
    newList[index] = value;
    _list.sink.add(newList);
  }

  void reorder(List<T> list, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final newList = [...list];
    final item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);
    _list.sink.add(newList);
  }

  void dispose() {
    _list.close();
  }
}