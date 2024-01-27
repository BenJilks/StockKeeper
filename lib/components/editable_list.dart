import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/editable_list_bloc.dart';

class EditableList<T> extends StatefulWidget {
  final String title;
  final List<T> initialItems;
  final void Function(List<T>)? onChange;

  final String Function(T value) display;
  final T Function(T item, String newValue) update;
  final T Function() defaultValue; 

  const EditableList({
    required this.title,
    required this.initialItems,
    this.onChange,

    required this.display,
    required this.update,
    required this.defaultValue,

    super.key,
  });

  @override
  State<StatefulWidget> createState() => _EditableListState<T>();
}

class _EditableListState<T> extends State<EditableList<T>> {
  late final EditableListBloc<T> bloc;

  @override
  void initState() {
    super.initState();
    bloc = EditableListBloc<T>(widget.initialItems);

    bloc.list.listen((event) {
      if (widget.onChange != null) {
        widget.onChange!(event);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: bloc.list,
      builder: (context, snapshot) => Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Expanded(child: buildStringList(snapshot.data)),

          TextButton(
            key: const Key('add-button'),
            onPressed: () => bloc.add(snapshot.data!, widget.defaultValue()),
            child: const Text('Add New'),
          ),
        ],
      ),
    );
  }

  Widget buildStringList(List<T>? list) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) => bloc.reorder(list!, oldIndex, newIndex),
      buildDefaultDragHandles: false,
      itemCount: list?.length ?? 0,

      itemBuilder: (context, index) => Padding(
        key: Key('$index'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: _Item<T>(
          item: list![index],
          index: index,
          onDelete: () => bloc.delete(list, index),
          onChange: (value) => bloc.update(list, index, value),
          bloc: bloc,

          display: widget.display,
          update: widget.update,
        ),
      ),
    );
  }
}

class _Item<T> extends StatefulWidget {
  final T item;
  final int index;
  final void Function() onDelete;
  final void Function(T value) onChange;
  final EditableListBloc bloc;

  final String Function(T value) display;
  final T Function(T item, String newValue) update;

  const _Item({
    required this.item,
    required this.index,
    required this.onDelete,
    required this.onChange,
    required this.bloc,

    required this.display,
    required this.update,
  });

  @override
  State<StatefulWidget> createState() => _ItemState<T>();
}

class _ItemState<T> extends State<_Item<T>> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.display(widget.item));
    widget.bloc.list.listen((event) {
      if (widget.index >= event.length) {
        return;
      }

      // This happens on a reorder, so no need to update the value.
      final newText = widget.display(event[widget.index]);
      if (controller.text != newText) {
        controller.text = newText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReorderableDragStartListener(
          index: widget.index,
          child: const Icon(Icons.drag_handle),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                widget.onChange(widget.update(widget.item, value));
              },
            ),
          ),
        ),

        IconButton(
          onPressed: widget.onDelete,
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}