import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../models/export_log.dart';
import '../models/gene_record.dart';
import '../models/health_record.dart';

class ReportExportService {
  Future<ExportLog> exportBasicReport({
    required List<HealthRecord> records,
    required List<GeneRecord> genes,
  }) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final format = DateFormat('yyyy-MM-dd HH:mm:ss');

    pdf.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Header(level: 0, child: pw.Text('AI Health Basic Report')),
          pw.Paragraph(text: 'Created: ${format.format(now)}'),
          pw.Header(level: 1, child: pw.Text('Health Records')),
          ...records.take(15).map(
            (r) => pw.Bullet(text: '${r.date} | ${r.item}: ${r.value} ${r.unit}'),
          ),
          pw.SizedBox(height: 12),
          pw.Header(level: 1, child: pw.Text('Genetic Summary')),
          ...genes.take(10).map(
            (g) => pw.Bullet(text: '${g.functionName} | ${g.geneLocus} | ${g.genotype} | ${g.risk}'),
          ),
          pw.SizedBox(height: 12),
          pw.Header(level: 1, child: pw.Text('Cross Analysis')),
          pw.Paragraph(
            text: 'Elevated glucose combined with APOE-related lipid risk may indicate increased attention needed for metabolic and cardiovascular management.',
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final exportsDir = Directory('${dir.path}/exports');
    if (!await exportsDir.exists()) {
      await exportsDir.create(recursive: true);
    }

    final path = '${exportsDir.path}/health_report_${now.millisecondsSinceEpoch}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    return ExportLog(
      id: now.microsecondsSinceEpoch.toString(),
      filePath: path,
      createdAt: format.format(now),
      reportType: 'basic_pdf',
    );
  }

  Future<void> shareFile(String path) async {
    await Share.shareXFiles([XFile(path)]);
  }
}
