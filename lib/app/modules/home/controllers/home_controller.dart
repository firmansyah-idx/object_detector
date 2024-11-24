import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;
  RxDouble x = 0.0.obs;
  RxDouble y = 0.0.obs;
  RxDouble w = 0.0.obs;
  RxDouble h = 0.0.obs;
  RxString label = "".obs;

  @override
  void onInit() async {
    super.onInit();
    initCamera();
    initTFlite();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
    label.listen((value) => print("Label updated: $value"));
  }

  initTFlite() async {
    await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt")
        .then((value) {
      print("Model successfully loaded");
    }).catchError((e) {
      print("Error loading model: $e");
    });
  }

  initCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController.initialize().then((value) {
      cameraController.startImageStream((image) {
        cameraCount++;
        if (cameraCount % 10 == 0) {
          cameraCount = 0;
          objectDetector(image);
        }
      });
    });
    isCameraInitialized.value = true;
  }

  objectDetector(CameraImage image) async {
    var recognitions = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(), // required
        model: "SSDMobileNet",
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5, // defaults to 127.5
        imageStd: 127.5, // defaults to 127.5
        rotation: 90, // defaults to 90, Android only     // defaults to 5
        threshold: 0.1, // defaults to 0.1
        asynch: true // defaults to true
        );
    if (recognitions != null && recognitions.isNotEmpty) {
      var ourDetecteObject = recognitions.first;
      print(ourDetecteObject);
      if (recognitions.first['confidenceInClass'] * 100 > 65) {
        print('${recognitions.first['detectedClass']}---' +
            recognitions.first['confidenceInClass'].toString());

        label.value = recognitions.first['detectedClass'].toString();
        h.value = ourDetecteObject['rect']['h'];
        w.value = ourDetecteObject['rect']['w'];
        x.value = ourDetecteObject['rect']['x'];
        y.value = ourDetecteObject['rect']['y'];
      } else {
        label.value = "";
        h.value = 0;
        w.value = 0;
        x.value = 0;
        y.value = 0;
      }
    }
  }
}
