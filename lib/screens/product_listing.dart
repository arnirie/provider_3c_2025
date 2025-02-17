import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/models/cart.dart';
import 'package:provider_state_management/models/products.dart';
import 'package:provider_state_management/screens/product_details.dart';

class ProductListingScreen extends StatelessWidget {
  ProductListingScreen({super.key});

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var products = Provider.of<Products>(context, listen: true); // ui update
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<Cart>(
            builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        // '99+',
                        '${cart.countTotal > 99 ? '99+' : cart.countTotal}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () => showAddDialog(context),
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      // body: ListView.builder(
      //   itemBuilder: (_, index) {
      //     return ListTile(
      //       title: Text(products.items[index].name),
      //     );
      //   },
      //   itemCount: products.count,
      // ),
      body: Consumer<Products>(
        builder: (context, products, _) {
          return ListView.builder(
            itemBuilder: (_, index) {
              var prod = products.items[index];
              return Card(
                child: ListTile(
                  title: Text(prod.name),
                  leading: Icon(
                      prod.isFav ? Icons.favorite : Icons.favorite_outline),
                  trailing: IconButton(
                    onPressed: () => addToCart(context, prod),
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(index: index))),
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
    provider.add(product); //ui update in here
  }

  void addToCart(BuildContext context, Product product) {
    Provider.of<Cart>(context, listen: false)
        .add(CartItem(product: product, qty: 13));
  }
}
