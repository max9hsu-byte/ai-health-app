import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';
import 'full_report_screen.dart';

class AnalysisScreen extends StatelessWidget {
  final AppState appState;
  const AnalysisScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('analysis'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('健康分數'),
                SizedBox(height: 8),
                Text('78', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SectionCard(
            child: SizedBox(
              height: 140,
              child: SingleChildScrollView(
                child: Text('血糖上升趨勢 + APOE / MTHFR 相關風險交叉分析後，建議管理代謝與脂質風險。'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FullReportScreen(appState: appState))),
            child: Text(t.t('fullReport')),
          ),
        ],
      ),
    );
  }
}
