import 'package:flutter/material.dart';

class BalanceCard1 extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const BalanceCard1(
      {required this.title,
      this.body =
          """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.attach_money_outlined,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(43, 128, 90, 1),
        radius: 25,
      ),
      this.subInfoText = "545 miles",
      this.subInfoTitle = "Directions",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
          
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color.fromARGB(255, 227, 226, 226),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        subIcon,
                        SizedBox(width: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subInfoText,
                              style: TextStyle(
                                color: Color.fromRGBO(105, 109, 110, 1),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(subInfoTitle,),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
