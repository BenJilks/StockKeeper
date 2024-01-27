import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_keeper/bloc/editable_list_bloc.dart';
import 'package:stock_keeper/components/editable_list.dart';

void main() {
  _testBloc();
  _testWidget();
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
    final bloc = EditableListBloc<String>(['a', 'b', 'c']);

    bloc.reorder(bloc.list.value, 1, 0);
    expect(bloc.list.value, ['b', 'a', 'c']);

    bloc.reorder(bloc.list.value, 0, 2);
    expect(bloc.list.value, ['a', 'b', 'c']);
  });
}

void _testWidget() {
  testWidgets('Editable List', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: Card(
        child: EditableList<String>(
          title: 'Title',
          initialItems: const ['A'],

          display: (item) => item,
          update: (item, value) => value,
          defaultValue: () => 'Default',
        ),
      ),
    ));

    // Initial state of having one item called 'A'
    await tester.pump();
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('Default'), findsNothing);

    // Press the 'Add New' button
    await tester.tap(find.byKey(const Key('add-button')));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);

    // Press the 'Add New' button again
    await tester.tap(find.byKey(const Key('add-button')));
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('Default'), findsExactly(2));

    // Change the first default to be 'B'
    await tester.enterText(find.text('Default').first, 'B');
    await tester.pump();
    expect(find.text('A'), findsOneWidget);
    expect(find.text('B'), findsOneWidget);
    expect(find.text('Default'), findsOneWidget);
  });
}