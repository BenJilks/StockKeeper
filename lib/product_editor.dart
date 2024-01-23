import 'package:flutter/material.dart';
import 'package:stock_keeper/components/string_list_input.dart';

class ProductEditor extends StatefulWidget {
  const ProductEditor({ super.key });
  
  @override
  State<ProductEditor> createState() => _ProductEditorState();
}

class _ProductEditorState extends State<ProductEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product Editor'),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),

            SizedBox(height: 20),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: StringListInput(
                  title: 'Variants',
                  initialItems: ['a', 'b'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
