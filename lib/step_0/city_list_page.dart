import 'package:flutter/material.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: const Center(
        child: Text('市区町村の一覧画面です'),
      ),
    );
  }
}
