import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  Future<void> startScan() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 6));
  }

  Stream<List<ScanResult>> scanResults() => FlutterBluePlus.scanResults;

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }
}
