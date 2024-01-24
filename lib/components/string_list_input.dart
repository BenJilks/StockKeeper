import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/string_list_bloc.dart';

class StringListInput extends StatefulWidget {
  final String title;
  final List<String> initialItems;
  final void Function(List<String>)? onChange;

  const StringListInput({
    required this.title,
    required this.initialItems,
    this.onChange,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _StringListInputState();
}

class _StringListInputState extends State<StringListInput> {
  late final StringListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = StringListBloc(widget.initialItems);

    bloc.stringList.listen((event) {
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
    return StreamBuilder<List<String>>(
      stream: bloc.stringList,
      builder: (context, snapshot) => Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Expanded(child: buildStringList(snapshot.data)),

          TextButton(
            onPressed: () => bloc.add(snapshot.data!, 'Test'),
            child: const Text('Add New'),
          ),
        ],
      ),
    );
  }

  Widget buildStringList(List<String>? list) {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) => bloc.reorder(list!, oldIndex, newIndex),
      buildDefaultDragHandles: false,
      itemCount: list?.length ?? 0,

      itemBuilder: (context, index) => Padding(
        key: Key('$index'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),

        child: _Item(
          value: list?[index] ?? '',
          index: index,
          onDelete: () => bloc.delete(list!, index),
          onChange: (value) => bloc.update(list!, index, value),
          bloc: bloc,
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final String value;
  final int index;
  final void Function() onDelete;
  final void Function(String text) onChange;
  final StringListBloc bloc;

  const _Item({
    required this.value,
    required this.index,
    required this.onDelete,
    required this.onChange,
    required this.bloc,
  });

  @override
  State<StatefulWidget> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
    widget.bloc.stringList.listen((event) {
      if (widget.index < event.length && controller.text != event[widget.index]) {
        controller.text = event[widget.index];
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
              onChanged: (value) => widget.onChange(value),
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