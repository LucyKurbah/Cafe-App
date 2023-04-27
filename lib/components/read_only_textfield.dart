import 'package:flutter/material.dart';

class ReadOnlyTextField extends StatelessWidget {
  final String label;
  final String defaultText;

  ReadOnlyTextField({required this.label, required this.defaultText});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: defaultText);

    return TextField(
      controller: controller,
      // enabled: false,
       style: TextStyle(
                 color: Colors.white,
              ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        // border: OutlineInputBorder(
        //          borderRadius: BorderRadius.circular(12),
        // ),
         border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
      ),
    ),
      ),
    );
  }
}
