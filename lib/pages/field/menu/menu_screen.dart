import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/cardwidget.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/price_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/delivery_record.dart';
import 'package:sawitcare_app/pages/management/yield/bar_graph.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 47, 47, 47),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 47, 47, 47),
              elevation: 0,
              centerTitle: false,
              title: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: const Center(
          child: Text("This is the Menu Page"),
        ));
  }
}
