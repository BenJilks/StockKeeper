import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_edit_bloc.dart';
import 'package:stock_keeper/components/string_list_input.dart';
import 'package:stock_keeper/data/product.dart';

class ProductEditor extends StatelessWidget {
  const ProductEditor({ super.key });
  
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
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: snapshot.data?.name,
                onChanged: (value) => bloc.setName(snapshot.data!, value),
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),

              const SizedBox(height: 20),
              buildVariantsCard(bloc, snapshot.data),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVariantsCard(ProductEditBloc bloc, Product? product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StringListInput(
          title: 'Variants',
          initialItems: product?.variants ?? [],
          onChange: (list) => {
            if (product != null) {
              bloc.setVariants(product, list)
            }
          },
        ),
      ),
    );
  }
}
