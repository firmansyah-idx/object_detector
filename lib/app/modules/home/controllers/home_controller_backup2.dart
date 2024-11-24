/*import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:signlang_detect/app/modules/home/services/tflite_service.dart';
import 'package:image/image.dart' as img;

class HomeController extends GetxController {
  CameraController? cameraController;
  late TFLiteService _tfliteService;
  RxList<String> results = <String>[].obs;
  bool isProcessing = false;
  RxBool isCameraInitialized = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadTFLiteModel();
    await initializeCamera();
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
          _processCameraImage(image);
        });
      });
      isCameraInitialized.value = true; // Tandai kamera sudah siap
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _loadTFLiteModel() async {
    _tfliteService = TFLiteService();
    await _tfliteService.loadModelAndLabels(
      'assets/model_unquant.tflite',
      'assets/labels.txt',
    );
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (isProcessing) return;
    isProcessing = true;

    try {
      // Convert image to Tensor format
      final tensorInput = await _preprocessImage(image);

      // Jalankan model untuk mendeteksi objek
      final classifications = _tfliteService.classifyImage(tensorInput);
      results.value = classifications;
    } catch (e) {
      print("Error processing frame: $e");
    }

    isProcessing = false;
  }

  Future<Uint8List> _preprocessImage(CameraImage image) async {
    // Konversi CameraImage ke format yang dapat digunakan
    final bytes = await convertYUV420toImage(image);
    print("deteksi");

    // Decode, resize, dan normalize gambar
    final rawImage = img.decodeImage(bytes);
    final resizedImage = img.copyResize(rawImage!, width: 224, height: 224);

    // Konversi ke Float32List untuk TensorFlow
    final inputImage = Float32List(1 * 224 * 224 * 3);
    final buffer = Float32List.view(inputImage.buffer);

    for (int i = 0; i < 224 * 224; i++) {
      buffer[i * 3 + 0] = resizedImage.getPixel(i % 224, i ~/ 224).r / 255.0;
      buffer[i * 3 + 1] = resizedImage.getPixel(i % 224, i ~/ 224).g / 255.0;
      buffer[i * 3 + 2] = resizedImage.getPixel(i % 224, i ~/ 224).b / 255.0;
    }

    return inputImage.buffer.asUint8List();
  }

  Future<Uint8List> convertYUV420toImage(CameraImage image) async {
    try {
      // Buat buffer kosong untuk menyimpan piksel RGB
      final int width = image.width;
      final int height = image.height;
      final img.Image rgbImage = img.Image(width: width, height: height);

      // Dapatkan plane data (Y, U, V)
      final Plane planeY = image.planes[0];
      final Plane planeU = image.planes[1];
      final Plane planeV = image.planes[2];

      final int yRowStride = planeY.bytesPerRow;
      final int uvRowStride = planeU.bytesPerRow;
      final int uvPixelStride = planeU.bytesPerPixel!;

      // Loop untuk setiap piksel
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          // Indeks dalam array Y, U, dan V
          final int yIndex = y * yRowStride + x;

          // Gunakan pembagian pixel stride untuk U dan V
          final int uvIndex = (y ~/ 2) * uvRowStride + (x ~/ 2) * uvPixelStride;

          // Nilai Y, U, V
          final int yValue = planeY.bytes[yIndex];
          final int uValue = planeU.bytes[uvIndex];
          final int vValue = planeV.bytes[uvIndex];

          // Konversi YUV ke RGB
          int r = (yValue + 1.402 * (vValue - 128)).round();
          int g =
              (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
                  .round();
          int b = (yValue + 1.772 * (uValue - 128)).round();

          // Clamp nilai RGB ke [0, 255]
          r = r.clamp(0, 255);
          g = g.clamp(0, 255);
          b = b.clamp(0, 255);

          // Set piksel di buffer RGB
          rgbImage.setPixelRgb(x, y, r, g, b); // Gunakan setPixelRgb
        }
      }

      // Encode gambar sebagai format PNG
      return Uint8List.fromList(img.encodePng(rgbImage));
    } catch (e) {
      print("Error converting YUV420 to RGB: $e");
      rethrow;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    _tfliteService.close();
    super.onClose();
  }
}
*/
