/*import 'package:camera/camera.dart';
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
  String label = "";

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
  }

  initTFlite() async {
    await Tflite.loadModel(
            model: "assets/model.tflite",
            labels: "assets/labels.txt",
            isAsset: true,
            numThreads: 1,
            useGpuDelegate: false)
        .then((value) {
      print("Model successfully loaded");
    }).catchError((e) {
      print("Error loading model: $e");
    });
  }

  initCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize().then((value) {
      cameraController.startImageStream((image) {
        cameraCount++;
        if (cameraCount % 10 == 0) {
          cameraCount = 0;
          objectDetector(image);
        }
        update();
      });
    });
    isCameraInitialized.value = true;
    update();
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((e) {
          return e.bytes;
        }).toList(),
        
        asynch: false,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0, // defaults to 127.5
        imageStd: 255.0, // defaults to 127.5
        threshold: 0.1
        /*imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        threshold: 0.4*/
        );
    if (detector != null) {
      //print("Result it $detector");
      var ourDetecteObject = detector.first;

      print(ourDetecteObject);
      if (detector.first['confidence'] * 100 > 45) {
        label = detector.first['label'].toString();
        h.value = ourDetecteObject['rect']['h'];
        w.value = ourDetecteObject['rect']['w'];
        x.value = ourDetecteObject['rect']['x'];
        y.value = ourDetecteObject['rect']['y'];
      }
      //update();
    }
  }
}
*/