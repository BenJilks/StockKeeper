import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/components/string_list_input.dart';
import 'package:stock_keeper/data/product.dart';

class ProductEditor extends StatelessWidget {
  const ProductEditor({ super.key });

  void _save(BuildContext context, ProductEditBloc editBloc) {
    final listBloc = BlocProvider.of(context).productListBloc;
    listBloc.set(editBloc.product.value);
    Navigator.of(context).pop();
  }

  void _discard(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).productEditBloc;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product Editor'),
      ),

      body: StreamBuilder<Product>(
        stream: bloc.product,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Text('Loading...');
          } else {
            return buildEditForm(context, bloc, snapshot.data!);
          }
        },
      ),
    );
  }

  Widget buildEditForm(BuildContext context, ProductEditBloc bloc, Product product) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildNameField(bloc, product),

          const SizedBox(height: 20),
          Expanded(
            child: buildVariantsCard(bloc, product),
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _discard(context),
                child: const Text('Discard'),
              ),

              const SizedBox(width: 10),

              TextButton(
                onPressed: () => _save(context, bloc),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNameField(ProductEditBloc bloc, Product product) {
    return TextFormField(
      initialValue: product.name,
      onChanged: (value) => bloc.setName(product, value),
      decoration: const InputDecoration(
        labelText: 'Name',
      ),
    );
  }

  Widget buildVariantsCard(ProductEditBloc bloc, Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StringListInput(
          title: 'Variants',
          initialItems: product.variants,
          onChange: (list) => {
            bloc.setVariants(product, list)
          },
        ),
      ),
    );
  }
}
