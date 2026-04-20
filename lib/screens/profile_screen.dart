import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppState appState;
  const ProfileScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('profile'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text(t.t('language')),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen(appState: appState, mode: SettingsMode.language))),
          ),
          ListTile(
            title: Text('匯出與分享'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen(appState: appState, mode: SettingsMode.exportShare))),
          ),
          ListTile(
            title: Text('隱私與本機加密'),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen(appState: appState, mode: SettingsMode.privacy))),
          ),
        ],
      ),
    );
  }
}
