import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:pinsmap/services/database.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:get/get.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String content;
  final String Locname;
  final Function onPressed;

  AlertWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.Locname,
    required this.onPressed,
  }) : super(key: key);

  final databaseRef _databaseRef = databaseRef();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        this.title,
        style: TextStyle(
          color: Color(0xff5857C2),
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.subtitle1!.merge(
              TextStyle(
                // color: Color(0xffE50C0C),
                fontWeight: FontWeight.bold,
              ),
            ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 25,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                elevation: 0,
                child: Text(
                  'No',
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                ),
                color: Color(0xffE50C0C),
                // minWidth: Get.width,
                padding: EdgeInsets.symmetric(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 40,
              // width: ,
              decoration: BoxDecoration(),
              child: MaterialButton(
                onPressed: () async{
                  print(Locname);
                  await _databaseRef.deleteData(Locname);                                    
                  Get.offAll(HomeLayout());
                },
                elevation: 0,
                child: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.subtitle2!.merge(
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                ),
                color: Color(0xff5857C2),
                // minWidth: Get.width,
                padding: EdgeInsets.symmetric(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
