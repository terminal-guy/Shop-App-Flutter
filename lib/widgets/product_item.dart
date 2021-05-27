import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
// * NOTES
// this checks for the Product ChangeNotiferprovider from widget to the top most widget using Product.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Card(
          elevation: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.screenName,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              product.toggleFavoriteStatus();
// provider method for toggling favorites
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
