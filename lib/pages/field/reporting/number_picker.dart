import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final List<String> textArray;
  final Function(int) onChange;

  NumberPicker({required this.textArray, required this.onChange, Key? key})
      : super(key: key);

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromRGBO(228, 234, 240, 0.88),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularArrow(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
              ),
              onPressed: () {
                if (_currentIndex <= 0) {
                  return;
                }
                widget.onChange(_currentIndex);
                setState(() {
                  _currentIndex -= 1;
                });
              }),
          Text(
            widget.textArray[_currentIndex],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromRGBO(105, 109, 110, 1)),
          ),
          CircularArrow(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              ),
              onPressed: () {
                if (_currentIndex >= widget.textArray.length - 1) {
                  return;
                }
                widget.onChange(_currentIndex);
                setState(() {
                  _currentIndex += 1;
                });
              }),
        ],
      ),
    );
  }
}

class CircularArrow extends StatelessWidget {
  final Icon icon;
  final Function() onPressed;
  const CircularArrow({required this.icon, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: CircleAvatar(
          backgroundColor: Color.fromRGBO(43, 128, 90, 1), child: icon),
      iconSize: 40,
    );
  }
}
