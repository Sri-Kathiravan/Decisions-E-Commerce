import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UiScreenUtils {

  //This class contains some of the commonly used UI Widgets

  static Widget buildLoadingWidget(BuildContext context, String text) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05
              ),
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                "$text",
                style: TextStyle(
                  fontFamily: "QuicksandMedium",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black45,
                ),
              )
          ),
        ],
      ),
    );
  }

  static Widget buildNoItemsWidget(BuildContext context, String text) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.center,
            child: Icon(
              Icons.warning,
              color: Colors.black45,
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05
              ),
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                "$text",
                style: TextStyle(
                  fontFamily: "QuicksandMedium",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black45,
                ),
              )
          ),
        ],
      ),
    );
  }

  static Widget buildErrorWidget(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.center,
            child: Icon(
              Icons.network_check,
              color: Colors.black45,
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05
              ),
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                "Something went wrong\nPlease check your internet connection",
                style: TextStyle(
                  fontFamily: "QuicksandMedium",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black45,
                ),
              )
          ),
        ],
      ),
    );
  }

  static void showToast(BuildContext context, String str) {
    Toast.show("$str", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

}