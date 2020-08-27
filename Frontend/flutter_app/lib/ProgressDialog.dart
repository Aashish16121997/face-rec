import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        height: 100.0,
        width: 220.0,
        padding: EdgeInsets.all(20.0),
        decoration: ShapeDecoration(
            color:Color(0xFF202020).withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius:
              new BorderRadius.all(Radius.circular(10.0)),
            )),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(width: 30.0,),
            Text(
              "Loading ...",
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }




}