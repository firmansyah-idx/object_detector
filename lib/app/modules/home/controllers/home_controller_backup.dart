/*import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  Rx<String> answer = "".obs;
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  CameraImage? cameraImage;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );

      cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
      );
      // Inisialisasi kamera
      await cameraController!.initialize().then((value) {
        cameraController!.startImageStream((image) {
          if (true) {}
          cameraImage = image;
          applymodelonimages();
        });
      });
      isCameraInitialized.value = true; // Tandai kamera sudah siap
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  applymodelonimages() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map(
            (plane) {
              return plane.bytes;
            },
          ).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 3,
          threshold: 0.1,
          asynch: true);

      answer.value = 'No Detect';

      predictions!.forEach(
        (prediction) {
          answer.value +=
              // ignore: prefer_interpolation_to_compose_strings
              prediction['label'].toString().substring(0, 1).toUpperCase() +
                  prediction['label'].toString().substring(1) +
                  " " +
                  (prediction['confidence'] as double).toStringAsFixed(3) +
                  '\n';
        },
      );
    }
  }

  @override
  void onClose() async {
    super.onClose();
    await Tflite.close();
    cameraController!.dispose();
  }
}
*/