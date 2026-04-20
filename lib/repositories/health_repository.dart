import '../models/export_log.dart';
import '../models/gene_record.dart';
import '../models/health_record.dart';
import '../services/secure_local_storage_service.dart';

class HealthRepository {
  final SecureLocalStorageService storage;
  HealthRepository(this.storage);

  static const _recordsFile = 'health_records.sec';
  static const _genesFile = 'gene_records.sec';
  static const _exportsFile = 'export_logs.sec';

  Future<List<HealthRecord>> getRecords() async {
    final data = await storage.readEncryptedList(_recordsFile);
    return data.map(HealthRecord.fromJson).toList();
  }

  Future<void> saveRecords(List<HealthRecord> items) async {
    await storage.writeEncryptedList(_recordsFile, items.map((e) => e.toJson()).toList());
  }

  Future<List<GeneRecord>> getGenes() async {
    final data = await storage.readEncryptedList(_genesFile);
    return data.map(GeneRecord.fromJson).toList();
  }

  Future<void> saveGenes(List<GeneRecord> items) async {
    await storage.writeEncryptedList(_genesFile, items.map((e) => e.toJson()).toList());
  }

  Future<List<ExportLog>> getExports() async {
    final data = await storage.readEncryptedList(_exportsFile);
    return data.map(ExportLog.fromJson).toList();
  }

  Future<void> saveExports(List<ExportLog> items) async {
    await storage.writeEncryptedList(_exportsFile, items.map((e) => e.toJson()).toList());
  }
}
