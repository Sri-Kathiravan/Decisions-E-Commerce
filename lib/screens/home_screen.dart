import 'package:ecommerce/data_model/index.dart';
import 'package:ecommerce/network/network_manager.dart';
import 'package:ecommerce/screens/add_product_screen.dart';
import 'package:ecommerce/util/ui_screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _HomeScreenStateFul();
  }

}

class _HomeScreenStateFul extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<_HomeScreenStateFul> {

  bool _isLoading = true;
  List<ProductsDm> _allProducts;

  @override
  void initState() {
    super.initState();
    NetworkManager.getInstance().getProducts().then((data) {
      try {
        setState(() {
          _allProducts = data;
          _isLoading = false;
        });
      } catch (e) {
        //Sometime setstate() may get called before build method called.
        //In such cases, delaying this time delay will help to call build().
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _allProducts = data;
            _isLoading = false;
          });
        });
        print('Exception at _HomeScreenState - $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.width * 0.1,
                  ),
                    alignment: AlignmentDirectional.topCenter,
                    child: Text(
                      "E-Commerce",
                      style: TextStyle(
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        color: Colors.black87,
                      ),
                    )
                ),
                Expanded(
                  child: Container(
                    child: (_isLoading)
                        ? UiScreenUtils.buildLoadingWidget(context, "Loading Products...")
                        : (_allProducts == null)
                        ? UiScreenUtils.buildErrorWidget(context)
                        : (_allProducts.length == 0)
                        ? UiScreenUtils.buildNoItemsWidget(context, "No Products Found...")
                        : _buildList(),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _buildList() {
    return GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: ((MediaQuery.of(context).size.width * .3) /
            (MediaQuery.of(context).size.width * .3)),
      ),
      itemBuilder: (context, position) {
        return _buildProductWidgets(_allProducts[position]);
      },
      itemCount: _allProducts.length,
      scrollDirection: Axis.vertical,
    );
  }

  Widget _buildProductWidgets(ProductsDm product) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductScreen(product)),);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.02,
          bottom: MediaQuery.of(context).size.width * 0.02,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * 0.03)
          ),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Icon(
                  Icons.image,
                  color: Colors.grey[300],
                  size: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(MediaQuery.of(context).size.width * 0.03),
                  bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.03)
                ),
                color: Colors.blue,
              ),
              child: Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  bottom: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Text(
                  "Add ${product.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}