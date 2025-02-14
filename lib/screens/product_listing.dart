import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/models/products.dart';

class ProductListingScreen extends StatelessWidget {
  ProductListingScreen({super.key});

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showAddDialog(context),
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Consumer<Products>(
        builder: (context, products, _) {
          return ListView.builder(
            itemBuilder: (_, index) {
              return Card(
                child: ListTile(
                  title: Text(products.items[index].name),
                ),
              );
            },
            itemCount: products.count,
          );
        },
      ),
    );
  }

  void showAddDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () => doAdd(context),
                child: const Text('Add'),
              ),
            ],
            title: const Text('Add Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                ),
                TextField(
                  controller: descCtrl,
                ),
                TextField(
                  controller: priceCtrl,
                ),
              ],
            ),
          );
        });
  }

  void doAdd(BuildContext context) {
    var product = Product(
        id: 5,
        name: nameCtrl.text,
        desc: descCtrl.text,
        price: double.parse(priceCtrl.text));
    var provider = Provider.of<Products>(context, listen: false);
    provider.add(product);
  }
}
