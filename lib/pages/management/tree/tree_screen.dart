import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets%20Example/add_button.dart';
import 'package:sawitcare_app/pages/bricks/Widgets%20Example/gradient_button_rounded.dart';

class Tree extends StatelessWidget {
  const Tree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: AppBar(
        elevation: 0,
        title: const Text(
          "Tree",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_box_rounded),
            ),
          ),
        ],
      ),
    ));
  }
}
