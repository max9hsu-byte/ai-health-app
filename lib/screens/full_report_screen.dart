import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';

class FullReportScreen extends StatelessWidget {
  final AppState appState;
  const FullReportScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('fullReport'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionCard(
            child: SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Text('整體健康總評：目前風險為中等，需注意血糖、血脂與生活型態管理。'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: SizedBox(
              height: 220,
              child: SingleChildScrollView(
                child: Text(
                  '基因風險交叉分析\n\n'
                  '1. 空腹血糖上升 + MTHFR：建議留意葉酸與代謝調節。\n\n'
                  '2. LDL 波動 + APOE E3/E4：與心血管風險相關。\n\n'
                  '3. NAT2：建議降低空污與菸害暴露。'
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () async {
              await appState.exportBasicReport();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.t('reportSaved'))),
                );
              }
            },
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: Text(t.t('export')),
          )
        ],
      ),
    );
  }
}
