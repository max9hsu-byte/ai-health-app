import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';
import 'full_report_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;
  const HomeScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('healthOverview'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('健康分數'),
                SizedBox(height: 8),
                Text('82', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('中等風險'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FullReportScreen(appState: appState)),
            ),
            child: SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t.t('aiAlert'), style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const SizedBox(
                    height: 96,
                    child: SingleChildScrollView(
                      child: Text('血糖上升趨勢與 APOE 基因風險交叉分析後，建議查看完整分析。'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(t.t('viewAnalysis'), style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.t('encryptStorage'), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                const Text('本機資料以 AES 加密儲存，金鑰保存在系統安全儲存區。'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
