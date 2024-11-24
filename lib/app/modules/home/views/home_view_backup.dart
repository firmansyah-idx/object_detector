/*import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.isCameraInitialized.value
                  ? Stack(children: [
                      CameraPreview(controller.cameraController),
                      Positioned(
                        top: (controller.y.value) * 100,
                        right: (controller.x.value) * 500,
                        child: Container(
                          width: controller.w.value * 100 * context.width / 100,
                          height:
                              controller.h.value * 100 * context.height / 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.green, width: 4)),
                          child: Column(
                            children: [
                              Text(
                                " ${controller.label}",
                              )
                            ],
                          ),
                        ),
                      )
                    ])
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
*/