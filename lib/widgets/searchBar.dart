import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  const CustomSearchBar({super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: double.infinity),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Search for item...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          suffixIcon: IconButton(
              onPressed: (){
                onSearch(controller.text);
              },
              icon: Icon(Icons.search)
          )
        ),
      ),
    );
  }
}
