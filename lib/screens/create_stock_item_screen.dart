import 'package:flutter/material.dart';
import 'package:stock_keeper/bloc/block_provider.dart';
import 'package:stock_keeper/data/product.dart';
import 'package:stock_keeper/data/stock_item.dart';

class CreateStockItemScreen extends StatefulWidget {
  const CreateStockItemScreen({ super.key });

  @override
  State<StatefulWidget> createState() => _CreateStockItemState();
}

class _CreateStockItemState extends State<CreateStockItemScreen> {
  Product? selectedProduct;
  String? selectedVariant;
  String? errorMessage;

  void _onSelectProduct(Product? product) {
    setState(() {
      if (selectedProduct != product) {
        selectedVariant = null;
      }

      selectedProduct = product;
    });
  }

  void _onSelectVariant(String? variant) {
    setState(() {
      selectedVariant = variant;
    });
  }

  void _onSave(BuildContext context) {
    // FIXME: this kind of logic is what should belong in a bloc.
    setState(() {
      if (selectedProduct == null) {
        errorMessage = 'No product selected';
        return;
      }

      if (selectedProduct!.variants.isNotEmpty && selectedVariant == null) {
        errorMessage = 'No variant selected';
        return;
      }

      final stockListBloc = BlocProvider.of(context).stockListBloc;
      final stockList = stockListBloc.stock.value;
      for (final item in stockList) {
        if (item.product == selectedProduct && item.stockItem.variantId == selectedVariant) {
          errorMessage = 'Stock item already exists';
          return;
        }
      }

      final productListBloc = BlocProvider.of(context).productListBloc;
      productListBloc.set(selectedProduct!.updateItem(StockItem(
        countInStock: 0,
        variantId: selectedVariant,
      )));

      errorMessage = '';
      selectedProduct = null;
      selectedVariant = null;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Create Stock Item'),
      ),

      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Product'),
          _buildProductSelect(context),

          const SizedBox(height: 20),

          const Text('Variant'),
          _buildVariantSelect(context),

          const Expanded(child: SizedBox()),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                errorMessage ?? '',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),

              TextButton(
                onPressed: () => _onSave(context),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductSelect(BuildContext context) {
    final bloc = BlocProvider.of(context).productListBloc;
    return StreamBuilder(
      stream: bloc.products,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Text('Loading...');
        } else {
          return DropdownButton(
            onChanged: _onSelectProduct,
            isExpanded: true,
            value: selectedProduct,

            items: snapshot.data!.map((product) => DropdownMenuItem<Product>(
              value: product,
              child: Text(product.name),
            )).toList(),
          );
        }
      }
    );
  }

  Widget _buildVariantSelect(BuildContext context) {
    if (selectedProduct == null) {
      return DropdownButton(
        onChanged: (value) {},
        items: const [],
        isExpanded: true,
      );
    }

    return DropdownButton(
      onChanged: _onSelectVariant,
      isExpanded: true,
      value: selectedVariant,

      items: selectedProduct!.variants.map((variant) => DropdownMenuItem<String>(
        value: variant.id,
        child: Text(variant.name),
      )).toList(),
    );
  }
}