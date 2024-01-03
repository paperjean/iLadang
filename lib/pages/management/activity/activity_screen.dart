import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/promo_card.dart';
import 'package:sawitcare_app/pages/bricks/Widgets Example/horizontal_card.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            centerTitle: false,
            title: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity',
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: ListView(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ImageCard(
                  text: 'Harvest',
                  imageUrl: 'assets/harvest_activity.png',
                ),
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Harvest()),
                // );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Fertilization',
                imageUrl: 'assets/activity_fertilize.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Herbicide',
                imageUrl: 'assets/herbicide_activity.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImageCard(
                text: 'Pruning',
                imageUrl: 'assets/pruning_activity.jpeg',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => MapGrid()),
                  // );
                },
                child: ImageCard(
                  text: 'Road Maintenance',
                  imageUrl: 'assets/roadfix_activity.png',
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
