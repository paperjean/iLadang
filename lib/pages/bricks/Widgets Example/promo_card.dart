import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  ImageCard({Key? key, required this.text, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xff53E88B), Color(0xff15BE77)])),
      child: Stack(
        children: [
          ClipRRect(
            // Radius
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.25),
                        offset: Offset(1, 5),
                        blurRadius: 3,
                      ),
                      Shadow(
                        color: Colors.black.withOpacity(.25),
                        offset: Offset(1, 5),
                        blurRadius: 3,
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
