import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (!controller.isCameraInitialized.value) {
                return const Center(child: CircularProgressIndicator());
              }
              //print(controller.label.value);
              return Stack(
                children: [
                  SizedBox(
                      width: size.width,
                      height: size.height,
                      child: CameraPreview(controller.cameraController)),
                  Positioned(
                    top: (controller.y.value) * 700,
                    right: (controller.x.value) * 400,
                    child: Container(
                      width: controller.w.value * 100 * Get.width / 100,
                      height: controller.h.value * 100 * Get.height / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green, width: 4),
                      ),
                      child: Text(
                        controller.label.value,
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
