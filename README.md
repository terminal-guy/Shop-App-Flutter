# Shop App

Pro Info: Instructor

Status: Finished

Url: https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15100230#content






- SnackBars & Undoing 'Add to Cart' items
    - Now in Flutter 2 showsnackbar is deprecated and can be used for a quite while but using ScafffoldMessenger.of(context) is the correct way to avoid bugs in the future.
    - 
        - 
        - Note for deprecated showsnackbar
            - Using ScaffoldMessenger for Snackbars
            - If you're working with Flutter 2 or higher, you might see a deprecation warning regarding the ```dart
hideCurrentSnackBar()
``` and ```javascript
showSnackbar()
``` methods.
            - You can get rid of them by using:
            - ```javascript
1. ScaffoldMessenger.of(context).hideCurrentSnackBar() 2. ScaffoldMessenger.of(context).showSnackbar(...)
```
            - instead of
            - ```javascript
1. Scaffold.of(context).hideCurrentSnackBar() 2. Scaffold.of(context).showSnackbar(...)
```
            - 
        - 
    - If you getting stacking snackbars and it's getting messy we can use a method that
    - 
    - Process through this lecture:
        - Learned how snackbars work and learn how to use them.
        - Added a singleItemRemove method in cart.dart
        - Added Scaffoldmessengers in product.dart
            - 
    - 
    - Code for product_item.dart
        - ```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
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
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus();
                // provider method for toggling favorites
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added Item to Cart',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
// scaffoldmessenger will take nearest scaffold to display the snackbar.
// Snackbar widget needs a required argument content.            
color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
} 
```
        - 
    - 
    - Code for cart.dart
        - ```dart
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  // * NOTES
  // Returning in Map cuz we will check with the productId with the cartitem id.

  Map<String, CartItem> get items {
    return {..._items};
  } // getter for _items.

  int get itemCount {
    return _items.length;
  }

  // Getting the totalamount by cartItem price multiplied with cartitem quantity.
  // And we are looping with for each element in the map

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    // * NOTES
    // checking key that if it has the key.
    // For replacing the quantity.
    // adding have the existingcartitem
    // But adding existingCartItemQuantity with plus one.
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // *NOTES
      // if the if check failed checking if put if absent with productid
      // the default quantity as 1
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
	    } // checking if it has the key if it contains we are not doing anything.
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));  // If you have an existing one in the quantity we are the - 1 from the quantity.
    } else {
      _items.remove(productId);
    }  // else we are remove the whole item from the list. if it has the quantity of one.
    notifyListeners();
  }
} 
```
        - 
    - 
- Showing Alert Dialog
    - On Dismissable widget there is confirm dismiss argument which we can pass through if we want to ask the user for confirmation dialog or something like popup.
    - ConfirmDismiss need to return a future. And the future value should be a boolean.
    - Process through this lecture:
    - Learned how to use to get a boolean return value.```javascript
Navigator.of(context).pop(bool)
```
    - Learned how to use alertdialog and showdialog.
    - 
    - ```dart
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartItem({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.productId,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you Sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('Yes'),
              )
            ],
          ),
        );
      },
// confirmDismiss needs to return future and a boolean return type.
// showDialog is a future so we have the future already.
// we need a boolean So, We using Navigator.of(context).pop(bool) to future bool that needs to be returned.

      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
```
- Adding a 'Manage Products' Page
    - 
        - Process through this lecture:
            - Added a new screen called user_products_screen.dart
            - Added a new widget for rendering user_products called user_product_item.dart
            - Added a UserProductsScreen route to main.dart.
        - Code for user_products_screen.dart
            - ```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const screenName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (_, i) {
            return Column(
              children: [
                UserProductItem(
                  imageUrl: productData.items[i].imageUrl,
                  title: productData.items[i].title,
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}


```
        - Code for user_products_item.dart
            - ```dart
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


```
- Using Forms & Working with Form Inputs
    - Using Singlechildscrollview would be good with a column instead of using listview cuz listview could get rid of some elements that are scrolled out of the view and data input could get lost there. #notes
        - While using Forms we can use TextFormField which has a numerous of options to configure. The One we used is textInputAction. TextInputAction can be used in order like jumping to the next textfield.
        - 
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md) #[[Process through this lecture:]] 
            - Added a new screen for editing product screen.
            - Added editproductscreen route in main.dart.
            - Added onpressed action in add button.
        - [Code for](../Automatically Add Template/notes/Code for.md) edit_screen.dart
            - ```dart
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


```
    - 
    - 
    - 
    - 
    - 
- Listview vs Column
    - ** ListView or Column**
    - When working with Forms, you typically have multiple input fields above each other - that's why you might want to ensure that the list of inputs is scrollable. Especially, since the soft keyboard will also take up some space on the screen.
    - For very long forms (i.e. many input fields) OR in landscape mode (i.e. less vertical space on the screen), you might encounter a strange behavior: User input might get lost if an input fields scrolls out of view.
    - That happens because the ```dart
ListView
``` widget dynamically removes and re-adds widgets as they scroll out of and back into view.
    - For short lists/ portrait-only apps, where only minimal scrolling might be needed, a ```dart
ListView
``` should be fine, since items won't scroll that far out of view (```javascript
ListView
``` has a certain threshold until which it will keep items in memory).
    - But for longer lists or apps that should work in landscape mode as well - or maybe just to be safe - you might want to use a ```javascript
Column
``` (combined with ```javascript
SingleChildScrollView
```) instead. Since ```javascript
SingleChildScrollView
``` doesn't clear widgets that scroll out of view, you are not in danger of losing user input in that case.
    - For example:
        - Form(
        - child: ListView(
        - children: [ ... ],
        - ),
        - ),
    - simply becomes
        - Form(
        - child: SingleChildScrollView(
        - child: Column(
        - children: [ ... ],
        - ),
        - ),
        - ),
    - 
- **Managing Form Input Focus**
    - Focusnode  & FocusScope #[[Flutter Note Search]] 
    - EXPLAINED BY CODE
        - ```dart
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode(); // FocusNode is build into material.dart it use to focusnode. To create a node..
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
				// focusScope is also like mediaquery and theme get the .of(context) parameter.
              // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


```
    - We can also use textfieldform can be used to change the type of keyboard use to shown #notes
        - ```dart
keyboardType: TextInputType.number,
```
    - 
    - 
- Multiline Inputs & Disposing Objects
    - multiline & KeyboardType #[[Flutter Note Search]] 
    - 
    - EXPLAINED By CODE
        - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  // FocusNode is build into material.dart it use to focusnode. To create a node..

// NEW CODE
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
    // disposing focusnode cuz it will lead to memory leaks.
  }
// NEW CODE


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                // Maxlines to get the number of lines spaces you need.
                keyboardType: TextInputType.multiline,
                // multiline keyboard we have more line cuz it will have more lines and we don't want next button feature.
              ),
            ],
          ),
        ),
      ),
    );
  }
}


```
- Image Input and Image preview
    - Image Preview and Image Input unfocused image preview #[[Flutter Note Search]] 
    - 
    - Notes #notes
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md)
            - Added imageUrlController and ImageUrlFocusNode
            - Added a imagefocusnode addListener.
            - And Made a full image preview container
        - [Code for](../Automatically Add Template/notes/Code for.md) edit_product_screen.dart
            - Changed Code : [ added a full func image preview · terminal-guy/Shop-App-Flutter@e757c7f · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/e757c7f1d19deda9c8bc468363513171f0942acc)
            - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  // FocusNode is build into material.dart it use to focusnode. To create a node..

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }
// We have to Display the image after it loses it's focus for that we are adding a listener.

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
// We are checking if it has focus and updating the state with setstate.
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                        // we force Flutter to update the screen.
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


```
    - 
- Submitting Forms
    - Forms #[[Flutter Note Search]] 
    - From form widget we can get key argument which can assign to a globalKey of <FormState>.  And we can call the form key and call the currentstate.save().
    -  #notes
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md).
            - 1. Added a globalkey formstate key for Form widget.
            - 2. We are getting the info for products from the price and extras by textfield by textfield.
            - 3. Adding value to _editedProduct onsaved by onsaved.
            - 
        - [Code for](../Automatically Add Template/notes/Code for.md) edit_product_screen.dart
            - Code Changed: [ added couple of form inputs · terminal-guy/Shop-App-Flutter@79d4228 · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/79d4228161a52f87fee336e062db9bd0b5766cba)
        - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
// We are getting the info for products from the price and extras by textfield by textfield.

  // FocusNode is build into material.dart it use to focusnode. To create a node..

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState.save();
    // To save all the currentState form info
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                        // Adding value to _editedProduct onsaved by onsaved.
                 _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                        // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
  // We are triggering the onfieldSubmitted button after the textinputaction.done.
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                        // we force Flutter to update the screen.
                      },
                      onSaved: (value) {
                // Adding value to _editedProduct onsaved by onsaved.
                        _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
```
- Validating User Inputs
    - UserInputs & Validating User Inputs #[[Flutter Note Search]] 
    - 
    - Validating user inputs #notes
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md) #[[Process through this lecture:]] 
        - Adding validation and checking every validator argument in every textfieldForm.
    - 
    - 
    - Github Code Changes: [ adding validating for all input fields · terminal-guy/Shop-App-Flutter@c8d51e0 · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/c8d51e0e1496f59a9f404236ad41ca10a2772a30)
    - Code for edit_screen_product.dart
        - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // FocusNode is build into material.dart it use to focusnode. To create a node..

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
// Added a globalkey formstate key for Form widget.

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
// We are getting the info for products from the price and extras by textfield by textfield.

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate(); // It is used inorder to check the current validation is true or false;
    if (!isValid) {
      return;
    }
    // If it's false we are stopping the code execution
    _form.currentState.save();
    // To save all the currentState form info
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide Price for the Product';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    // Adding value to _editedProduct onsaved by onsaved.
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide a Description.';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        // We are triggering the onfieldSubmitted button after the textinputaction.done.
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                        // we force Flutter to update the screen.
                      },
                      onSaved: (value) {
                        // Adding value to _editedProduct onsaved by onsaved.
                        _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Image URL.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


```
- Adding Validation to All Inputs
    - Validation to All Inputs and https_text_input. #[[Flutter Note Search]] 
    - Adding validation to All Inputs #notes
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md) #[[Process through this lecture:]] 
            - Adding checks for _updateImageUrl like https and .jpg file check.
            - And validation checks with more checks for price and description.
        - Github Code Changes: [ adding more notes validation checks for userinputs · terminal-guy/Shop-App-Flutter@bcae661 · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/bcae661469caf04142aa7606ff63adc159b15e8d)
        - [Code for](../Automatically Add Template/notes/Code for.md) edit_screen.dart
            - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // FocusNode is build into material.dart it use to focusnode. To create a node..

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
// Added a globalkey formstate key for Form widget.

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
// We are getting the info for products from the price and extras by textfield by textfield.

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
  // We are not updating image container if it doesn't fit this checks.
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              (!_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // To save all the currentState form info
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide Price for the Product';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  } // we are trying to parse it doesn't give error it's like a check. 
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    // Adding value to _editedProduct onsaved by onsaved.
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter a Description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 Characters';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        // We are triggering the onfieldSubmitted button after the textinputaction.done.
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                        // we force Flutter to update the screen.
                      },
                      onSaved: (value) {
                        // Adding value to _editedProduct onsaved by onsaved.
                        _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                        );
                      },
                      validator: (value) {
                      // Validating checks for url
                        if (value.isEmpty) {
                          return 'Please Enter a Image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Please enter a valid image URl';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


```
- Saving New Products
    -  #notes
        - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md) #[[Process through this lecture:]] 
            - Made a addProduct method in Products.dart for adding items.
            - Using provider added _editedProducts to the addProduct method.
            - 
        - [Code for](../Automatically Add Template/notes/Code for.md) Products.dart
            - ```dart
import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      id: DateTime.now().toString(),
      imageUrl: product.imageUrl,
      price: product.price,
    );

    _items.add(newProduct);
    // _items.add(value)
    notifyListeners();
  }
}


```
        - Code for edited_product_screen.dart
            - ```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const screenName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // FocusNode is build into material.dart it use to focusnode. To create a node..

  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
// Added a globalkey formstate key for Form widget.

  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
// We are getting the info for products from the price and extras by textfield by textfield.

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    // We are not updating image container if it doesn't fit this checks.
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              (!_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
    // To save all the currentState form info
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  // focusscope is also like mediaquery and theme get the .of(context) parameter.
                  // in modern phones it automatically does it for use while getting from the normal keyboard with the number keyboard.
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  // Adding value to _editedProduct onsaved by onsaved.
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide Price for the Product';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  } // we are trying to parse it doesn't give error it's like a check.
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    // Adding value to _editedProduct onsaved by onsaved.
                    id: null,
                    title: _editedProduct.title,
                    description: value,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter a Description.';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 Characters';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        // We are triggering the onfieldSubmitted button after the textinputaction.done.
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                        // we force Flutter to update the screen.
                      },
                      onSaved: (value) {
                        // Adding value to _editedProduct onsaved by onsaved.
                        _editedProduct = Product(
                          id: null,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value,
                        );
                      },
                      validator: (value) {
                        // Validating checks for url
                        if (value.isEmpty) {
                          return 'Please Enter a Image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Please enter a valid image URl';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


```
- Time to Update Products
    - modalroute and initial value #[[Flutter Note Search]] 
    - modalroute shouldn't be in initstate it's can be in Update Dependencies but you need to stop it. It can also lead to memory leaks. If you have a controller for textfeild you can't use initialvalue. the controller takes care of it automatically.
    - ```dart
id: _editedProduct.id,
isFavorite: _editedProduct.isFavorite
``` We are passing this cuz we want to have this product has favorite to be lost.
    - 
    - [Process through this lecture:](../Automatically Add Template/notes/Process through this lecture:.md) #[[Process through this lecture:]] 
        - Added navigation from user products screen to edit product screen.
        - Added UpdateProduct in products.dart which is provider file.
        - 
    - Github Code Changes:
        - [ updating products · terminal-guy/Shop-App-Flutter@eea04c2 · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/eea04c21c899db02bb3da1a4db304080a6726d66)
- Deleting the Products
    - Added delete Products method in products.dart
        - Github code Changes:
            - [ adding deleteProduct method · terminal-guy/Shop-App-Flutter@2dfabff · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/2dfabff89e934938d072ff8ba172e432bd1562f0)
    - Added delete products on pressed in user_products_item.dart
        - Github code Changes:
            - [ delete products · terminal-guy/Shop-App-Flutter@8091715 · GitHub](https://github.com/terminal-guy/Shop-App-Flutter/commit/80917150b79629047478705abcddcf1dc0463f63)

