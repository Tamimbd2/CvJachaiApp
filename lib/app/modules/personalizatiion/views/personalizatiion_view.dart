import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/personalizatiion_controller.dart';

class PersonalizatiionView extends GetView<PersonalizatiionController> {
  const PersonalizatiionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PersonalizatiionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PersonalizatiionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
