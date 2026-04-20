import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';

class OCRScreen extends StatelessWidget {
  final AppState appState;
  const OCRScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('ocr'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () async {
              await appState.runOCR();
            },
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(t.t('pickImage')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.t('recognizedText'), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                SizedBox(
                  height: 260,
                  child: SingleChildScrollView(
                    child: Text(appState.recognizedText.isEmpty ? '尚未辨識' : appState.recognizedText),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (appState.lastRecognizedNumber != null)
            SectionCard(
              child: Text('偵測到第一個數值：${appState.lastRecognizedNumber}'),
            ),
        ],
      ),
    );
  }
}
