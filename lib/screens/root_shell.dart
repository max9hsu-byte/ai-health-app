import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import 'add_screen.dart';
import 'analysis_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'records_screen.dart';

class RootShell extends StatefulWidget {
  final AppState appState;
  const RootShell({super.key, required this.appState});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final pages = [
      HomeScreen(appState: widget.appState),
      RecordsScreen(appState: widget.appState),
      AddScreen(appState: widget.appState),
      AnalysisScreen(appState: widget.appState),
      ProfileScreen(appState: widget.appState),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: t.t('home')),
          NavigationDestination(icon: const Icon(Icons.monitor_heart_outlined), label: t.t('records')),
          NavigationDestination(icon: const Icon(Icons.add_circle_outline), label: t.t('add')),
          NavigationDestination(icon: const Icon(Icons.analytics_outlined), label: t.t('analysis')),
          NavigationDestination(icon: const Icon(Icons.person_outline), label: t.t('profile')),
        ],
      ),
    );
  }
}
