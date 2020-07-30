import 'package:ecommerce/data_model/index.dart';
import 'package:ecommerce/network/network_manager.dart';
import 'package:ecommerce/util/ui_screen_utils.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {

  ProductsDm _productsDm;
  AddProductScreen(this._productsDm);

  @override
  Widget build(BuildContext context) {
    return _AddProductStateful(_productsDm);
  }

}

class _AddProductStateful extends StatefulWidget {

  ProductsDm _productsDm;
  _AddProductStateful(this._productsDm);

  @override
  State<StatefulWidget> createState() {
    return _AddProductState(_productsDm);
  }

}

class _AddProductState extends State<_AddProductStateful> {

  ProductsDm _productsDm;
  _AddProductState(this._productsDm);

  bool _isLoading = true;
  List<ProductInsertDm> _insertItems;
  List<String> _response;

  @override
  void initState() {
    super.initState();
    NetworkManager.getInstance().getProductInsertItems(_productsDm.definitionUrl).then((data) {
      _insertItems = data;
      _response = new List();
      for(int i = 0; i < _insertItems.length; i++) {
        if(_insertItems[i].defaultValue != null) {
          _response.add("${_insertItems[i].defaultValue}");
        } else {
          _response.add("");
        }
      }
      try {
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        //Sometime setstate() may get called before build method called.
        //In such cases, delaying this time delay will help to call build().
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isLoading = false;
          });
        });
        print('Exception at _AddProductState - $e');
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
                      bottom: MediaQuery.of(context).size.width * 0.05,
                    ),
                    alignment: AlignmentDirectional.topCenter,
                    child: Text(
                      "Insert ${_productsDm.name} Item",
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
                        ? UiScreenUtils.buildLoadingWidget(context, "Loading Insert Items...")
                        : (_insertItems == null)
                        ? UiScreenUtils.buildErrorWidget(context)
                        : (_insertItems.length == 0)
                        ? UiScreenUtils.buildNoItemsWidget(context, "No Insert Items Found...")
                        : _buildList(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    bool isValid = true;
                    for(int i = 0; i < _insertItems.length; i++) {
                      if(_insertItems[i].mandatory && _response[i].trim().isEmpty) {
                        UiScreenUtils.showToast(context, "${_insertItems[i].validationMessage}");
                        isValid = false;
                        break;
                      } else if(_insertItems[i].mandatory && _insertItems[i].type == "int" && RegExp(r'^[a-zA-Z]+$').hasMatch(_response[i])) {
                        UiScreenUtils.showToast(context, "${_insertItems[i].validationMessage}");
                        isValid = false;
                        break;
                      }
                    }
                    if(isValid) {
                      UiScreenUtils.showToast(context, "Submitted Successfully");
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.03,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        bottom: MediaQuery.of(context).size.width * 0.03,
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "Submit Item",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'QuickSandBold',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, position) {
        return _buildInsertItem(_insertItems[position], position);
      },
      itemCount: _insertItems.length,
    );
  }

  Widget _buildInsertItem(ProductInsertDm insertItem, int position) {

    List<Widget> widgetList = new List();

    widgetList.add(
      Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.width * 0.05,
        ),
        alignment: AlignmentDirectional.topStart,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "${insertItem.caption}",
              style: TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.black87,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
              ),
              child: Text(
                (insertItem.mandatory) ? "*" : "",
              style: TextStyle(
                fontFamily: "QuicksandBold",
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.red,
              ),
            ),
            ),
          ],
        ),
      )
    );

    if(insertItem.type == "text" || insertItem.type == "int") {

      widgetList.add(
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              bottom: MediaQuery.of(context).size.width * 0.01,
              top: MediaQuery.of(context).size.width * 0.01,
            ),
            child: TextFormField(
              onChanged: (text) {
                _response[position] = text;
              },
              autofocus: false,
              keyboardType: (insertItem.type == "int")
                  ? TextInputType.numberWithOptions(decimal: false, signed: true)
                  : TextInputType.text,
              controller: new TextEditingController(
                text: "${_response[position]}",
              ),
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Colors.blueGrey,
                  fontSize: MediaQuery.of(context).size.width * 0.045
              ),
              validator: (text) {
                if(insertItem.mandatory && text.isEmpty) {
                  return "${insertItem.validationMessage}";
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                /*errorText: (insertItem.mandatory) ? "${insertItem.validationMessage}" : "",*/
              ),
            ),

          )
      );

    } else if(insertItem.type == "bool") {

      widgetList.add(
        Container(
          alignment: AlignmentDirectional.topStart,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Checkbox(
                    value: (_response[position] == "True") ? true : false,
                    onChanged: (newValue) {
                      if(_response[position] != "True") {
                        setState(() {
                          _response[position] = "True";
                        });
                      }
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Checkbox(
                    value: (_response[position] == "False") ? true : false,
                    onChanged: (newValue) {
                      if(_response[position] != "False") {
                        setState(() {
                          _response[position] = "False";
                        });
                      }
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                ),
                child: Text(
                  "No",
                  style: TextStyle(
                    fontFamily: "QuicksandBold",
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        )
      );

    }

    return Container(
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgetList,
      ),
    );

  }

}