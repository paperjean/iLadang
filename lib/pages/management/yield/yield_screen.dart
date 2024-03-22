import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/cardwidget.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/cardwidget1.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/price_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/delivery_record.dart';
import 'package:sawitcare_app/pages/management/yield/bar_graph.dart';
import 'package:sawitcare_app/pages/management/yield/ServicePage.dart';

class Yield extends StatefulWidget {
  const Yield({Key? key}) : super(key: key);

  @override
  State<Yield> createState() => _YieldState();
}

class _YieldState extends State<Yield> {
  final List<double> monthlySummary = [
    10.0,
    20.3,
    30.0,
    20.1,
    25.9,
    10.1,
    20.1,
    30.0,
    20.5,
    25.5,
    30.1,
    10.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yield',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            
            Container(
  color: Colors.white,
  height: 280,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 2.0), // Added bottom padding to the Yearly Summary
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yearly Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: MyBarGraph(
            monthlySummary: monthlySummary,
          ),
        ),
        SizedBox(height: 8), // Added some space between the bar graph and the year text
        Text(
          '2024', 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
      ],
    ),
  ),
),


             
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryRecord()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: BalanceCard(
                  title: "Total Delivery",
                  body: "Your current balance is",
                  subInfoText: " 9.3 Tan",
                  subInfoTitle: "Up until 13 Apr 2023",
                  onMoreTap: () {},
                ),
              ),
            ),



            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryRecord()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: BalanceCard1(
                  title: "Market Price Today",
                  body: "",
                  subInfoText: "RM 3,850",
                  subInfoTitle: "/Tan",
                  onMoreTap: () {},
                ),
              ),
            ),  

            SizedBox(height: 12),
            Padding(
  padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(31, 255, 251, 251),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServicePage()),
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: 150,
          width: 280,
          color: Colors.white,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/service.jfif', 
                  fit: BoxFit.cover,
                ),
              ),
              
              Container(
                color: Color.fromARGB(255, 81, 97, 87).withOpacity(0.5), // Adjust opacity as needed
                child: Center(
                  child: Text(
                    'Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
