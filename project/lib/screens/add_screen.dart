import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../models/health_record.dart';
import '../state/app_state.dart';
import 'bluetooth_screen.dart';
import 'ocr_screen.dart';

class AddScreen extends StatefulWidget {
  final AppState appState;
  const AddScreen({super.key, required this.appState});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String category = 'A. 常規血液檢查';
  String subcategory = '血糖';
  String item = '空腹血糖';
  final valueController = TextEditingController();
  final dateController = TextEditingController(text: '2026-04-19');
  final notesController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (valueController.text.isEmpty && widget.appState.lastRecognizedNumber != null) {
      valueController.text = widget.appState.lastRecognizedNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('add'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OCRScreen(appState: widget.appState))),
                icon: const Icon(Icons.document_scanner_outlined),
                label: Text(t.t('ocr')),
              ),
              FilledButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BluetoothScreen(appState: widget.appState))),
                icon: const Icon(Icons.bluetooth_searching),
                label: Text(t.t('bluetooth')),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: category,
            decoration: InputDecoration(labelText: t.t('category')),
            items: const [
              DropdownMenuItem(value: 'A. 常規血液檢查', child: Text('A. 常規血液檢查')),
              DropdownMenuItem(value: 'B. 進階血液檢查', child: Text('B. 進階血液檢查')),
              DropdownMenuItem(value: 'C. 特定血液檢查', child: Text('C. 特定血液檢查')),
              DropdownMenuItem(value: 'D. 癌症篩檢', child: Text('D. 癌症篩檢')),
              DropdownMenuItem(value: 'E. 基因檢測', child: Text('E. 基因檢測')),
            ],
            onChanged: (v) => setState(() => category = v ?? category),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: subcategory,
            decoration: InputDecoration(labelText: t.t('subcategory')),
            items: const [
              DropdownMenuItem(value: '血糖', child: Text('血糖')),
              DropdownMenuItem(value: '血脂', child: Text('血脂')),
              DropdownMenuItem(value: '肝功能', child: Text('肝功能')),
            ],
            onChanged: (v) => setState(() => subcategory = v ?? subcategory),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: item,
            decoration: InputDecoration(labelText: t.t('item')),
            items: const [
              DropdownMenuItem(value: '空腹血糖', child: Text('空腹血糖')),
              DropdownMenuItem(value: 'HbA1c', child: Text('HbA1c')),
              DropdownMenuItem(value: 'LDL', child: Text('LDL')),
            ],
            onChanged: (v) => setState(() => item = v ?? item),
          ),
          const SizedBox(height: 12),
          TextField(controller: valueController, decoration: InputDecoration(labelText: t.t('value'))),
          const SizedBox(height: 12),
          TextField(controller: dateController, decoration: InputDecoration(labelText: t.t('date'))),
          const SizedBox(height: 12),
          TextField(controller: notesController, maxLines: 4, decoration: InputDecoration(labelText: t.t('notes'))),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () async {
              final record = HealthRecord(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                category: category,
                subcategory: subcategory,
                item: item,
                value: valueController.text.trim(),
                unit: item.contains('糖') || item == 'LDL' ? 'mg/dL' : '',
                date: dateController.text.trim(),
                notes: notesController.text.trim(),
              );
              await widget.appState.addRecord(record);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.t('save'))));
              }
            },
            child: Text(t.t('save')),
          )
        ],
      ),
    );
  }
}
