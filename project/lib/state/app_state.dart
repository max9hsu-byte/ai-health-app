import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../models/export_log.dart';
import '../models/gene_record.dart';
import '../models/health_record.dart';
import '../repositories/health_repository.dart';
import '../services/bluetooth_service.dart';
import '../services/ocr_service.dart';
import '../services/report_export_service.dart';
import '../services/secure_local_storage_service.dart';

class AppState extends ChangeNotifier {
  Locale locale = const Locale('zh', 'TW');

  final repository = HealthRepository(SecureLocalStorageService());
  final exportService = ReportExportService();
  final ocrService = OCRService();
  final bluetoothService = BluetoothService();

  List<HealthRecord> records = [];
  List<GeneRecord> genes = [];
  List<ExportLog> exportLogs = [];
  String recognizedText = '';
  String? lastRecognizedNumber;
  String? selectedBluetoothDevice;

  Future<void> initialize() async {
    records = await repository.getRecords();
    genes = await repository.getGenes();
    exportLogs = await repository.getExports();

    if (records.isEmpty && genes.isEmpty) {
      await _seedDemo();
    }
    notifyListeners();
  }

  Future<void> _seedDemo() async {
    records = const [
      HealthRecord(
        id: 'r1',
        category: 'A. 常規血液檢查',
        subcategory: '血糖',
        item: '空腹血糖',
        value: '98',
        unit: 'mg/dL',
        date: '2026-04-18',
        notes: '晨間檢測',
      ),
      HealthRecord(
        id: 'r2',
        category: 'A. 常規血液檢查',
        subcategory: '血脂',
        item: 'LDL',
        value: '132',
        unit: 'mg/dL',
        date: '2026-04-11',
        notes: '',
      ),
    ];
    genes = const [
      GeneRecord(
        id: 'g1',
        functionName: '脂質代謝',
        geneLocus: 'APOE',
        genotype: 'E3/E4',
        risk: '中',
        description: '與膽固醇代謝與心血管風險相關。',
      ),
      GeneRecord(
        id: 'g2',
        functionName: '葉酸代謝',
        geneLocus: 'MTHFR',
        genotype: 'CT',
        risk: '中',
        description: '與葉酸利用與同型半胱胺酸代謝相關。',
      ),
      GeneRecord(
        id: 'g3',
        functionName: '肺部風險',
        geneLocus: 'NAT2',
        genotype: 'CC',
        risk: '低',
        description: '與致癌物代謝效率相關。',
      ),
    ];
    await repository.saveRecords(records);
    await repository.saveGenes(genes);
  }

  void changeLocale(Locale newLocale) {
    locale = newLocale;
    notifyListeners();
  }

  Future<void> addRecord(HealthRecord record) async {
    records = [record, ...records];
    await repository.saveRecords(records);
    notifyListeners();
  }

  Future<void> runOCR() async {
    final result = await ocrService.pickAndRecognize();
    if (result == null) return;
    recognizedText = result.rawText;
    lastRecognizedNumber = result.firstNumber;
    notifyListeners();
  }

  void setSelectedBluetoothDevice(String? name) {
    selectedBluetoothDevice = name;
    notifyListeners();
  }

  Future<void> exportBasicReport() async {
    final log = await exportService.exportBasicReport(records: records, genes: genes);
    exportLogs = [log, ...exportLogs];
    await repository.saveExports(exportLogs);
    notifyListeners();
  }

  Future<void> shareLatestReport() async {
    if (exportLogs.isEmpty) return;
    await exportService.shareFile(exportLogs.first.filePath);
  }
}
