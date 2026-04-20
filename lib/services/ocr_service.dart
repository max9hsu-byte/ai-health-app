import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class OCRResult {
  final String rawText;
  final String? firstNumber;
  OCRResult({required this.rawText, required this.firstNumber});
}

class OCRService {
  final ImagePicker _picker = ImagePicker();

  Future<OCRResult?> pickAndRecognize() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);
    if (file == null) return null;

    final inputImage = InputImage.fromFile(File(file.path));
    final recognizer = TextRecognizer();
    final recognized = await recognizer.processImage(inputImage);
    await recognizer.close();

    final text = recognized.text;
    final match = RegExp(r'\b\d+(?:\.\d+)?\b').firstMatch(text);

    return OCRResult(
      rawText: text,
      firstNumber: match?.group(0),
    );
  }
}
