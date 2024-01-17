import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manage/controllers/search_controller.dart';

class SearchBook extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchBook({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<SearchBookController>();

    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        labelText: 'Search Book',
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: searchController.onSearchChanged,
    );
  }
}
