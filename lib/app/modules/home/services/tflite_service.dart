/*import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter _interpreter;
  List<String> _labels = [];

  Future<void> loadModelAndLabels(String modelPath, String labelsPath) async {
    try {
      // Load TFLite model
      _interpreter = await Interpreter.fromAsset(modelPath);

      // Load labels
      final labelData = await rootBundle.loadString(labelsPath);
      _labels = labelData.split('\n').map((label) => label.trim()).toList();
    } catch (e) {
      print("Error loading model or labels: $e");
    }
  }

  List<String> classifyImage(Uint8List inputImage) {
    // Define input and output tensors
    var outputShape = _interpreter.getOutputTensor(0).shape;

    // Prepare input buffer (Assumes input image is already resized and normalized)
    var inputBuffer = inputImage.buffer.asUint8List();

    // Prepare output buffer
    var outputBuffer = List<double>.filled(outputShape[1], 0);

    // Run inference
    _interpreter.run(inputBuffer, outputBuffer);

    // Map probabilities to labels
    var labeledResults = <String, double>{};
    for (int i = 0; i < outputBuffer.length; i++) {
      labeledResults[_labels[i]] = outputBuffer[i];
    }

    // Sort results by probability
    var sortedResults = labeledResults.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedResults
        .map((e) => "${e.key}: ${e.value.toStringAsFixed(2)}")
        .toList();
  }

  void close() {
    _interpreter.close();
  }
}
*/