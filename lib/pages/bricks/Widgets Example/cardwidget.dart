import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const BalanceCard(
      {required this.title,
      this.body =
          """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.receipt_long_rounded,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(99, 201, 142, 1),
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
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(53, 113, 78, 1),
              Color.fromRGBO(31, 122, 69, 1).withOpacity(.8)
            ],
            focal: Alignment.topCenter,
            radius: .85,
          )),
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
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 75,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        gradient: LinearGradient(
                            colors: [Colors.black54, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: GestureDetector(
                        onTap: onMoreTap,
                        child: Center(
                            child: Text(
                          "More",
                          style:
                              TextStyle(color: Color.fromRGBO(99, 201, 142, 1)),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Text(
                //   body,
                //   style:
                //       TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
                // ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white.withOpacity(.9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        subIcon,
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(subInfoTitle),
                            Text(
                              subInfoText,
                              style: TextStyle(
                                color: Color.fromRGBO(99, 201, 142, 1),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
