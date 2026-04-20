import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';

enum SettingsMode { language, exportShare, privacy }

class SettingsScreen extends StatelessWidget {
  final AppState appState;
  final SettingsMode mode;
  const SettingsScreen({super.key, required this.appState, required this.mode});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    String title = mode == SettingsMode.language ? t.t('language') : mode == SettingsMode.exportShare ? '匯出與分享' : '隱私與本機加密';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (mode == SettingsMode.language)
            SectionCard(
              child: Column(
                children: [
                  RadioListTile(value: const Locale('zh', 'TW'), groupValue: appState.locale, onChanged: (v) => appState.changeLocale(v!), title: const Text('繁體中文')),
                  RadioListTile(value: const Locale('en'), groupValue: appState.locale, onChanged: (v) => appState.changeLocale(v!), title: const Text('English')),
                  RadioListTile(value: const Locale('ja'), groupValue: appState.locale, onChanged: (v) => appState.changeLocale(v!), title: const Text('日本語')),
                  RadioListTile(value: const Locale('ko'), groupValue: appState.locale, onChanged: (v) => appState.changeLocale(v!), title: const Text('한국어')),
                ],
              ),
            ),
          if (mode == SettingsMode.exportShare)
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('最近匯出紀錄', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: appState.exportLogs.isEmpty
                        ? const Center(child: Text('尚無匯出紀錄'))
                        : ListView.builder(
                            itemCount: appState.exportLogs.length,
                            itemBuilder: (_, i) {
                              final log = appState.exportLogs[i];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(log.createdAt),
                                subtitle: Text(log.filePath),
                                trailing: TextButton(
                                  onPressed: () async {
                                    await appState.exportService.shareFile(log.filePath);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(t.t('reportShared'))),
                                      );
                                    }
                                  },
                                  child: Text(t.t('share')),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: appState.exportLogs.isEmpty ? null : () async {
                      await appState.shareLatestReport();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.t('reportShared'))),
                        );
                      }
                    },
                    icon: const Icon(Icons.share_outlined),
                    label: Text(t.t('share')),
                  ),
                ],
              ),
            ),
          if (mode == SettingsMode.privacy)
            const SectionCard(
              child: SizedBox(
                height: 180,
                child: SingleChildScrollView(
                  child: Text(
                    '資料預設儲存在本機，並使用 AES 加密。\n\n'
                    '加密金鑰保存在系統安全儲存區。\n\n'
                    '若未來加入 ESG / Email / 藍牙 / 伺服器傳輸，應另加上使用者授權流程。'
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
