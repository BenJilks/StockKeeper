import 'package:stock_keeper/bloc/editable_list_bloc.dart';
import 'package:test/test.dart';

void main() {
  _testBloc();
}

void _testBloc() {
  test('Add item', () {
    final bloc = EditableListBloc<String>([]);

    bloc.add(bloc.list.value, 'a');
    expect(bloc.list.value, ['a']);

    bloc.add(bloc.list.value, 'b');
    expect(bloc.list.value, ['a', 'b']);
  });

  test('Delete item', () {
    final bloc = EditableListBloc<String>(['a', 'b']);

    bloc.delete(bloc.list.value, 1);
    expect(bloc.list.value, ['a']);

    bloc.delete(bloc.list.value, 0);
    expect(bloc.list.value, []);
  });

  test('Update item', () {
    final bloc = EditableListBloc<String>(['a', 'b']);

    bloc.update(bloc.list.value, 1, 'c');
    expect(bloc.list.value, ['a', 'c']);
  });

  test('Reorder', () {
    final bloc = EditableListBloc<String>(['a', 'b']);

    bloc.reorder(bloc.list.value, 1, 0);
    expect(bloc.list.value, ['b', 'a']);
  });
}