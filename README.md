# Shop App


Pro Info: Instructor

Status: Finished

Url: https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/15100230#content


- ***Module introduction***

    In this module we are going to learn about more UI widgets & patterns and managing state using provider.

- ***Planning the App***

    We are going to have multiple screens and more complex screens with the same data for that we are going to state management solution not grinding like passing data with screens and widget tree.

- ***Defining a data model***

    ### Process through this lecture:

    ---

    - Added a empty product overview file.
    - Added a model called Product.

    **Code for model for product.dart**

    ```dart
    import 'package:flutter/material.dart';

    class Product {
      final String id;
      final String title;
      final String description;
      final double price;
      final String imageUrl;
      bool isFavorite;

      Product({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.imageUrl,
        this.isFavorite = false,
      });
    }
    ```

- ***Working on the "products" Grid  & item widgets***

    There are many widgets that nobody knows cuz this course help for knowing new widgets like gridview and gridtile & gridtilebar.

    ### Process through this lecture:

    ---

    - Added a ProductItem widget with lots of grid widgets like gridtile and gridtitlebar.
    - Added a gridview.builder to dynamically render the data from the list.

    - Code for products_overview_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import '../models/product.dart';
        import '../widgets/product_item.dart';

        class ProductsOverviewScreen extends StatelessWidget {
          final List<Product> loadedProducts = [
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

          @override
          Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('MyShop'),
              ),
              body: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: loadedProducts.length,
                itemBuilder: (context, i) {
                  return ProductItem(
                    id: loadedProducts[i].id,
                    title: loadedProducts[i].title,
                    imageUrl: loadedProducts[i].imageUrl,
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10, // row spacing.
                ),
              ),
            );
          }
        }

        // in last module we used to slivergridDelegateWithFixedExtent but in this module
        // we are using slivergridDelegateWithFixedCrossAxisCount for columns

        ```

    - Code for product_item.dart

        ```dart
        import 'package:flutter/material.dart';

        class ProductItem extends StatelessWidget {
          final String id;
          final String title;
          final String imageUrl;

          const ProductItem({this.id, this.title, this.imageUrl});

          @override
          Widget build(BuildContext context) {
            return GridTile(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                leading: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {},
                ),
              ),
            );
          }
        }
        ```

- ***Styling & Theming The App***

    ### Process through this lecture:

    ---

    - Learned how ClipRRect.
    - Added some fonts and registered it into pubspec.yaml.
    - And added some themedata

- ***Adding navigation to the App***

    We can also pass data through widgets that can be cumbersome cuz in the widget tree. If you want data from the bottom widget to the top most widget it will be hard and cuz passing data through other can mess up. 

    In that case passing data with navigation with named routes can be easy cuz it has the data that we want and we can have modalroute to get the data.

    But with state management like provider it will be super easily to get the data better than digging the widget tree.

    ### Process through this lecture:

    ---

    - Added gesture dector on the image to push to product detail screen.
    - Added a routes at main.dart
    - Added modalroute in productdetailscreen.

    - Code for product_item.dart

        ```dart
        import 'package:flutter/material.dart';
        import '../screens/product_detail_screen.dart';

        class ProductItem extends StatelessWidget {
          final String id;
          final String title;
          final String imageUrl;

          const ProductItem({this.id, this.title, this.imageUrl});

          @override
          Widget build(BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                child: Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProductDetailScreen.screenName,
                        arguments: id,
                      );
                    },
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  leading: IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                    color: Theme.of(context).accentColor,
                  ),
                  title: Text(
                    title,
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
        ```

    - Code for main.dart

        ```dart
        import 'package:flutter/material.dart';
        import './screens/products_overview_screen.dart';
        import './screens/product_detail_screen.dart';

        void main() => runApp(MyApp());

        class MyApp extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato',
              ),
              home: ProductsOverviewScreen(),
              routes: {
                ProductDetailScreen.screenName: (ctx) => ProductDetailScreen(),
              },
            );
          }
        }
        ```

- ***Why State Management? and What is State & State Management***

    ### Why State Management?

    ---

    ![Shop%20App%20e50c5901b24846d9830c3c051d393f54/Flutter__Dart_-_The_Complete_Guide_2021_Edition___Udemy_-_Brave_26-05-2021_14_49_36.png](Shop%20App%20e50c5901b24846d9830c3c051d393f54/Flutter__Dart_-_The_Complete_Guide_2021_Edition___Udemy_-_Brave_26-05-2021_14_49_36.png)

    Passing data through widgets that can be cumbersome cuz in the widget tree. If you want data from the bottom widget to the top most widget it will be hard and cuz passing data through other can mess up. 

    In that case passing data with navigation with named routes can be easy cuz it has the data that we want and we can have modalroute to get the data.

    But with state management like provider it will be super easily to get the data better than digging the widget tree.

    ### What is State & State management ?

    ---

    ![Shop%20App%20e50c5901b24846d9830c3c051d393f54/Flutter__Dart_-_The_Complete_Guide_2021_Edition___Udemy_-_Brave_26-05-2021_15_00_12.png](Shop%20App%20e50c5901b24846d9830c3c051d393f54/Flutter__Dart_-_The_Complete_Guide_2021_Edition___Udemy_-_Brave_26-05-2021_15_00_12.png)

    State is data which affects the user interface when the data changes (state changes). In order to get that data getting cumbersome from digging the widgets from the denominator widget to the top widget

- ***Working with Providers and listeners***

    ### Mixin

    ---

    Mixin is like a bit inheriting another class. The core difference is you bascially merge properties or some methods existing class. But you don't return your class into an instance of that inheritant class.

    ### ChangeNotifier

    ---

    Chanage Notifier are those which material.dart file has have by default. Which Provider uses to tell the data can change.

    ### NotifyListeners

    ---

    If we add more listeners like _items.add() this can be pretty useful that a new data has added.

    ### ChangeNotifierProvider

    ---

    **ChangeNotifierProvider** can be used to create provider which can be changed like products i.e adding items to the products we need to exclusively use changenotifierprovider where it wanna there like on the top of the widget tree or the widget it wanna change. 

    In this application we have only one data to get through all the widgets so we are placing changenotifierprovider on top of the widget tree in materialapp.

    we can have multiple provider but for now we have only one provider so we can easily use the create argument to create a provider.

    ### Provider.of(context)

    ---

    we can get the data from specifing which provider we wanna to get through <> we can specify the provider in between the bracket.

    ### Provider Q&A

    ---

    - Does the app rebuild from top of the tree to the botttom of the tree.

    Ans:  *****No, providers can listen for changes from the specifing in <> brackets. It will go and check for ChangeNotifierProvider where it is. And checks if that we are having a provider that is specified in the <> brackets only that widget only gets rebuild.*

    ### Packages info (update)

    ---

    Packages from [pub.dev](http://pub.dev) can be added with **flutter pub add (the package name).**

    ### Process through this lecture:

    ---

    - Learned about basics of provider.
    - Learned about listeners.

    - Code for products.dart

        ```dart
        import 'package:flutter/material.dart';
        import '../models/product.dart';

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

          void addProduct() {
            // _items.add(value)
            notifyListeners();
          }
        }
        ```

    - Code for products_grid.dart

        ```dart
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
                return ProductItem(
                  id: products[i].id,
                  title: products[i].title,
                  imageUrl: products[i].imageUrl,
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
        ```

- **[DART  DEEP DIVE] Inheritance "extends" vs Mixins "with"**

    ```dart
    class Mammal {
      void breathe() {
        print('Breathe in... Breathe out...');
      }
    }

    mixin Agility {
      var speed = 10;
      void sitDown() {
        print('Sitting down...');
      }
    }

    class Person extends Mammal  with Agility{
      String name;
      int age;
      Person(this.name,this.age);
      
    }

    void main() {
      final pers = Person('Max', 30);
      print(pers.name);
      pers.breathe();
      print(pers.speed);
      pers.sitDown();
    }
    ```

    The difference between inheritance and mixins are:

    - Inheritance have stronger connection with the inheriting child.
    - But mixin doesn't have that type of stronger connecting with the mixing child.
    - You can only inherite one class you can't have another class.
    - But you can have as long as mixins you want.
- ***Listening in different places & ways***

    **EXPLAINED BY CODE**

    - Code for product_detail_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import '../providers/products.dart';

        class ProductDetailScreen extends StatelessWidget {
          // final String title;
          // final String price;
          // ProductDetailScreen(this.title, this.price);

          static const screenName = '/product-detail';

          @override
          Widget build(BuildContext context) {
            final productId = ModalRoute.of(context).settings.arguments as String;
            final loadedProduct =
                Provider.of<Products>(context, listen: false).findById(productId);
            return Scaffold(
              appBar: AppBar(
                title: Text(loadedProduct.title),
              ),
            );
          }
        }

        // we get productId from the navigator.pushNamed as a argument.
        // we are checking using findById. == productId.
        // we can set listen to false cuz if we don't want it to change after the build method runs.
        ```

- ***Using Nested Models & Providers***

    **EXPLAINED BY CODE**

    - Code for Product.dart

        ```dart
        import 'package:flutter/material.dart';

        class Product with ChangeNotifier {
          final String id;
          final String title;
          final String description;
          final double price;
          final String imageUrl;
          bool isFavorite;

          Product({
            @required this.id,
            @required this.title,
            @required this.description,
            @required this.price,
            @required this.imageUrl,
            this.isFavorite = false,
          });

          void toggleFavoriteStatus() {
            isFavorite = !isFavorite;
            notifyListeners();
          }
        }

        // Using ChangeNotifier cuz i want the class to update  with notifylisteners for toggling favorites.
        // isFavorite = !isFavorite change value to the opposite of it.
        ```

    - Code for Product_grid.dart

        ```dart
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
        ```

    - Code for product_item.dart

        ```dart
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
        ```

- ***Exploring alternative syntax***

    ### Default ChangeNotifierProvider

    ---

    This is the recommend method while instantiate your class so whenever you create a object based on a class. If you use to provide that object to the changeNotiferprovider you should use the create method for efficieny.

    ### ChangeNotifierProvider.value

    If you are not using context

    ---

    ```dart
     ChangeNotifierProvider.value
    ```

    Can be used. This is the method that you want to use if you are using something part of list of grid cuz if the widgets by flutter are recycled but the data widget that changes while using change notifier.value you make sure that provider works even if the data changes for the widget. If you had a builder function that would not work correctly. Now it will work correctly because the provider is tied to the data and is attached and deattached to and from the widget. The builder function will cost bugs. that would go beyond the screen boundaries.

- ***Using "Consumer" instead of "Provider.of(context)"***

    ### Why Consumer

    ---

    While the provider.of(context) is ok but it runs the while build method while the data changes that is the charactertic is what we want.

    But if you want to run a subpart or piece of code you can use consumer to re-run that code alone.

- ***Adding shopping cart data***

    ***EXPLAINED BY CODE***

    ```dart
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

      Map<String, CartItem> _items;
    // * NOTES 
    // Returning in Map cuz we will check with the productId with the cartitem id.

      Map<String, CartItem> get items {
        return {..._items};
      } // getter for _items.

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
      }
    }
    ```

- ***Working with Multi providers***

    ### MultiProviders

    ---

    **MultiProviders** are being used while you want to have more than one provider.

    It takes a list [ ] of providers. which can be availabe through the widget tree level.

- ***Connecting The Cart Provider***

    Added a indicator badge on the shopping_cart icon on the Appbar to count the amount of products.

    ### Process through this lecture:

    ---

    - Added a indicator badge on the shopping_cart icon on the Appbar to count the amount of products.
    - Made shopping_cart icon to add shopping items.

    - Code for product_overview_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import 'package:shop_app/providers/cart.dart';
        import 'package:shop_app/providers/products.dart';
        import '../widgets/products_grid.dart';
        import '../widgets/badge.dart';

        enum FilterOptions {
          Favorties,
          All,
        }

        class ProductsOverviewScreen extends StatefulWidget {
          @override
          _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
        }

        class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
          var _showOnlyFavorites = false;

          @override
          Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  PopupMenuButton(
                    onSelected: (FilterOptions selectedValue) {
                      setState(() {
                        if (selectedValue == FilterOptions.Favorties) {
                          _showOnlyFavorites = true;
                        } else {
                          _showOnlyFavorites = false;
                          // ...
                        }
                      });
                    },
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text('Only Favorits'), value: FilterOptions.Favorties),
                      PopupMenuItem(
                        child: Text('Show All'),
                        value: FilterOptions.All,
                      ),
                    ],
                  ),
                  Consumer<Cart>(
                    builder: (_, cart, child) => Badge(
                      child: child,
                      value: cart.itemCount.toString(),
        // The third argument is child, which is there for optimization.
        // If you have a large widget subtree under your Consumer that doesn’t change when the model changes,
        // you can construct it once and get it through the builder.
                    ),
        // This IconButton will not rebuild cuz it is out of widget tree.
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {},
                    ),
                  ),
                ],
                title: Text('MyShop'),
              ),
              body: ProductsGrid(_showOnlyFavorites),
            );
          }
        }
        ```

    - Code for

        ```dart

        ```

- ***Working with shopping cart & Displaying the total \***

    ### Process through this lecture:

    ---

    - Added getter for getting the total amount in cart.dart
    - Added cartscreen route in main.dart
    - 

    - Code for cart.dart

        ```dart
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
        }
        ```

    - Code for cartscreen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import 'package:shop_app/providers/cart.dart';

        class CartScreen extends StatelessWidget {
          static const screenName = '/cart';
          @override
          Widget build(BuildContext context) {
            final cart = Provider.of<Cart>(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('Your Cart'),
              ),
              body: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).primaryTextTheme.headline6.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                            child: Text('ORDER NOW'),
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        ```

- ***Displaying a list of cart items***

    ***EXPLAINED BY CODE***

    - Code for cart_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import 'package:shop_app/providers/cart.dart' show Cart;
        import '../widgets/cart_item.dart';

        class CartScreen extends StatelessWidget {
          static const screenName = '/cart';
          @override
          Widget build(BuildContext context) {
            final cart = Provider.of<Cart>(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('Your Cart'),
              ),
              body: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).primaryTextTheme.headline6.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                            child: Text('ORDER NOW'),
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => CartItem(
                        id: cart.items.values.toList()[i].id,
                        title: cart.items.values.toList()[i].title,
                        quantity: cart.items.values.toList()[i].quantity,
                        price: cart.items.values.toList()[i].price,
                      ),
                      itemCount: cart.items.length,
                    ),
                  ),
        // the cart class refers to the items map 
        // We are interested in the values that are store in the map
        // We can actually access the values interable property which we can convet into a list 
        // we are extracting values to list so i operate on list of values, so we can worked in the concreate valuest stored in the map
                ],
              ),
            );
          }
        }
        ```

- ***Making Cart items dismissable***

    ### Dismissible

    ---

    **Dismissible** is the widget that is used to swipe widget that is used for deleting and many more.

    It can have direction argument that can decided which direction to swipe. It needs a key that is valuekey that needs a unique id.

    And onDismissed argument is needs a function. It can be used while dismissing the widget.

    - Code for cart_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import 'package:shop_app/providers/cart.dart' show Cart;
        import '../widgets/cart_item.dart';

        class CartScreen extends StatelessWidget {
          static const screenName = '/cart';
          @override
          Widget build(BuildContext context) {
            final cart = Provider.of<Cart>(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('Your Cart'),
              ),
              body: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).primaryTextTheme.headline6.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                            child: Text('ORDER NOW'),
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => CartItem(
                        productId: cart.items.keys.toList()[i],
                        id: cart.items.values.toList()[i].id,
                        title: cart.items.values.toList()[i].title,
                        quantity: cart.items.values.toList()[i].quantity,
                        price: cart.items.values.toList()[i].price,
                      ),
                      itemCount: cart.items.length,
                    ),
                  ),
                  // * NOTES
                  // the cart class refers to the items map
                  // We are interested in the values that are store in the map
                  // We can actually access the values interable property which we can convet into a list
                  // we are extracting values to list so i operate on list of values, so we can worked in the concreate valuest stored in the map
                ],
              ),
            );
          }
        }
        ```

    - Code for cart_item.dart

        ```dart
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

- ***Adding Product Detail data***

    ***EXPLAINED BY CODE***

    - Code for product_detail_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import '../providers/products.dart';

        class ProductDetailScreen extends StatelessWidget {
          // final String title;
          // final String price;
          // ProductDetailScreen(this.title, this.price);

          static const screenName = '/product-detail';

          @override
          Widget build(BuildContext context) {
            final productId = ModalRoute.of(context).settings.arguments as String;
            final loadedProduct =
                Provider.of<Products>(context, listen: false).findById(productId);
        // geting loaded product by provider from findbyid method that is checking the prodId == productId.

            return Scaffold(
              appBar: AppBar(
                title: Text(loadedProduct.title),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: ClipRRect(
        // ClipRRect is pretty useful widget while it comes to have a border radius or make something to clip
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          elevation: 20,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            child: Image.network(
                              loadedProduct.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${loadedProduct.price}',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: Text(
                        '${loadedProduct.description}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
        ```

- ***Providing an orders objects***

    ### Process through this lecture:

    ---

    - Added order provider in main.dart
    - Added a orders model and a provider.
    - Adding a clear method in cart provider.

    ***EXPLAINED BY CODE***

    - Code for orders.dart

        ```dart
        import 'package:flutter/foundation.dart';
        import './cart.dart';

        class OrderItem {
          final String id;
          final double amount;
          final List<CartItem> products;
          final DateTime dateTime;

          OrderItem({
            @required this.id,
            @required this.amount,
            @required this.products,
            @required this.dateTime,
          });
        }

        class Orders with ChangeNotifier {
          List<OrderItem> _orders = [];

          List<OrderItem> get orders {
            return [..._orders];
          }
        // We are using a getter cuz we don't want access _orders from any other file.
        // using spread operator is the best while the data type is dynamic.

          void addOrder(List<CartItem> cartproducts, double total) {
            _orders.insert(
                0,
                OrderItem(
                  id: DateTime.now().toString(),
                  amount: total,
                  dateTime: DateTime.now(),
                  products: cartproducts,
                ));
            notifyListeners();
          }
        // * NOTES
        // we can insert order by the index at 0.
        // And it can increase the index by one while we add new elements.

        }
        ```

- ***Adding Orders***

    ### Process through this lecture:

    ---

    - Made Order now button to work.
    - added a clear method to set the value to empty map.

    ***EXPLAINED BY CODE***

    - Code for cart_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import 'package:shop_app/providers/cart.dart' show Cart;
        import 'package:shop_app/providers/orders.dart';
        import '../widgets/cart_item.dart';

        class CartScreen extends StatelessWidget {
          static const screenName = '/cart';
          @override
          Widget build(BuildContext context) {
            final cart = Provider.of<Cart>(context);

            return Scaffold(
              appBar: AppBar(
                title: Text('Your Cart'),
              ),
              body: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).primaryTextTheme.headline6.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          TextButton(
                            child: Text('ORDER NOW'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Provider.of<Orders>(context, listen: false).addOrder(
                                  cart.items.values.toList(), cart.totalAmount);
                              cart.clear();
                            },
        // We are added addOrder method.
        // we are using cart.items.values.toList() cuz we are using maps.
        // We are not listening cuz we don't want to listen to changes we are only interest in dispatch of the order.
        // We are calling cart.clear to clear the current cart items after we click the order now button
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, i) => CartItem(
                        productId: cart.items.keys.toList()[i],
                        id: cart.items.values.toList()[i].id,
                        title: cart.items.values.toList()[i].title,
                        quantity: cart.items.values.toList()[i].quantity,
                        price: cart.items.values.toList()[i].price,
                      ),
                      itemCount: cart.items.length,
                    ),
                  ),
                  // * NOTES
                  // the cart class refers to the items map
                  // We are interested in the values that are store in the map
                  // We can actually access the values interable property which we can convet into a list
                  // we are extracting values to list so i operate on list of values, so we can worked in the concreate valuest stored in the map
                ],
              ),
            );
          }
        }
        ```

- ***Adding orders screen***

    ***EXPLAINED BY CODE***

    - Code for orders_screen.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:provider/provider.dart';
        import '../providers/orders.dart' show Orders // we are just using orders not orderitem;
        import '../widgets/order_item.dart';

        class OrdersScreen extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            final orderData = Provider.of<Orders>(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('Your Orders'),
              ),
              body: ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
              ),
            );
          }
        }
        ```

    - Code for order_item.dart

        ```dart
        import 'package:flutter/material.dart';
        import '../providers/orders.dart' as ord; // we can't use show becuase we are using orderitem provider.
        import 'package:intl/intl.dart';

        class OrderItem extends StatelessWidget {
          final ord.OrderItem order;

          OrderItem(this.order);
          @override
          Widget build(BuildContext context) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Text('\$${order.amount}'),
                    subtitle: Text(
                      DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.expand_more),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            );
          }
        }
        ```

- ***Using a Side Drawer***

    ### Drawer

    ---

    **Drawer** widget is the widget the is used to make drawer we can use any widget to make drawer but we are using appbar in this module cuz this is main topic of the section.

     automaticallyImplyLeading: false,   is used for we don't want back button in appbar.

    ### Process through this lecture:

    ---

    - Adding Orders screen to main.dart routes.
    - Added drawer to order_screen and product_overview_screen.
    - Added a custom Drawer widget name AppDrawer.
    - 

    - Code for app_drawer.dart

        ```dart
        import 'package:flutter/material.dart';
        import 'package:shop_app/screens/orders_screen.dart';

        class AppDrawer extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return Drawer(
              child: Column(
                children: [
                  AppBar(
                    title: Text('Hello Friend!'),
                    automaticallyImplyLeading: false,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.shop),
                    title: Text('Shop'),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Orders'),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.screenName);
                    },
                  ),
                ],
              ),
            );
          }
        }
        ```

- ***Making Orders Expandable & Stateful Widgets vs Providers***

    ***EXPLAINED BY CODE***

    - Code for order_item.dart

        ```dart
        import 'package:flutter/material.dart';
        import '../providers/orders.dart' as ord;
        import 'package:intl/intl.dart';
        import 'dart:math';

        class OrderItem extends StatefulWidget {
          final ord.OrderItem order;

          OrderItem(this.order);

          @override
          _OrderItemState createState() => _OrderItemState();
        }

        class _OrderItemState extends State<OrderItem> {
          var _expanded = false;
          @override
          Widget build(BuildContext context) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Text('\$${widget.order.amount}'),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
                    ),
                    trailing: IconButton(
                      icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                    ),
                  ),
        // we are checking if expanded is true if it's tre the container will build.
                  if (_expanded)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height: min(widget.order.products.length * 20.0 + 10, 100),
                      child: ListView(
        // we are dynamically mapping we didn't all the time in this course
                          children: widget.order.products
                              .map((prod) => Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        prod.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${prod.quantity}x \$${prod.price}',
                                        style:
                                            TextStyle(fontSize: 18, color: Colors.grey),
                                      )
                                    ],
                                  ))
                              .toList()),
                    ),
                ],
              ),
            );
          }
        }
        ```