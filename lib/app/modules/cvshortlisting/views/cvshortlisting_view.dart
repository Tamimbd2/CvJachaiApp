import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cvshortlisting_controller.dart';

class CvshortlistingView extends GetView<CvshortlistingController> {
  const CvshortlistingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CvshortlistingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CvshortlistingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
