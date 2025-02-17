import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/models/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.index});

  // final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<Products>(
      builder: (context, products, _) => Scaffold(
        appBar: AppBar(
          title: Text(products.items[index].name),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .toggleFavorite(products.items[index]);
                // Navigator.of(context).pop();
              },
              icon: Icon(products.items[index].isFav
                  ? Icons.favorite
                  : Icons.favorite_border),
            ),
          ],
        ),
      ),
    );
  }
}
