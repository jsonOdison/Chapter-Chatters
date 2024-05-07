import 'package:flutter/material.dart';

Widget searchWidget(Function searchMethod) {
  final TextEditingController searchController = TextEditingController();
  return Container(
    height: 90,
    color: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          onPressed: () => searchMethod(),
          icon: const Icon(Icons.search),
          color: Colors.white,
        )
      ],
    ),
  );
}
