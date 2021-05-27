import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, i) {
        return ChangeNotifierProvider(
          create: (context) => products[i],
          child: ProductItem(
              // id: products[i].id,
              // title: products[i].title,
              // imageUrl: products[i].imageUrl,
              ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10, // row spacing.
      ),
    );
  }
}

// * NOTES
// adding changenotifierprovider to get the product items and did comment out the code for named parameter cuz managing it from product_item.dart file
