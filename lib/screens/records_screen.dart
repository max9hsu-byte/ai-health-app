import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/risk_badge.dart';
import '../widgets/section_card.dart';

class RecordsScreen extends StatelessWidget {
  final AppState appState;
  const RecordsScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('records'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...appState.records.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SectionCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.item, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text('${r.value} ${r.unit}'),
                      Text(r.date),
                    ]),
                  ),
                  const RiskBadge('中'),
                ],
              ),
            ),
          )),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.t('geneticTesting'), style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ...appState.genes.map((g) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${g.functionName} / ${g.geneLocus}'),
                  subtitle: Text('基因型：${g.genotype}'),
                  trailing: RiskBadge(g.risk),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
