import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPopup extends StatelessWidget{
  String error;
  int navigationCount=1;

  ErrorPopup(this.error,this.navigationCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              error,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Exo',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    for(int i=1;i<= navigationCount;i++)
                      Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    padding: EdgeInsets.all(1.0),
                    decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.all(Radius.circular(2.0)),
                        )),
                    child: Container(
                      height: 29.0,
                      width: 69.0,
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.all(Radius.circular(2.0)),
                          )),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}