import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/bloc/product_list_block.dart';
import 'package:stock_keeper/components/drawer_menu.dart';
import 'package:stock_keeper/data/product.dart';

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({ super.key });

  void _add(BuildContext context) {
    final bloc = BlocProvider.of(context).productEditBloc;
    bloc.setProduct(Product());
    Navigator.of(context).pushNamed('/edit-product');
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).productListBloc;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product Manager'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        child: buildProductList(bloc),
      ),

      drawer: const Drawer(
        child: DrawerMenu(AppPage.productManager),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildProductList(ProductListBloc bloc) {
    return StreamBuilder<List<Product>>(
      stream: bloc.products,
      initialData: const [],
      builder: (context, snapshot) => ListView.builder(
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) => _Item(snapshot.data![index]),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Product product;
  const _Item(this.product);

  void _edit(BuildContext context) {
    final bloc = BlocProvider.of(context).productEditBloc;
    bloc.setProduct(product);
    Navigator.of(context).pushNamed('/edit-product');
  }

  void _delete(ProductListBloc bloc) {
    bloc.delete(product);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).productListBloc;
    return Row(
      children: [
        Expanded(
          child: Text(product.name),
        ),

        IconButton(
          onPressed: () => _edit(context),
          icon: const Icon(Icons.edit),
        ),

        IconButton(
          onPressed: () => _delete(bloc),
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
