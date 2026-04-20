import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../core/l10n/app_localizations.dart';
import '../state/app_state.dart';
import '../widgets/section_card.dart';

class BluetoothScreen extends StatefulWidget {
  final AppState appState;
  const BluetoothScreen({super.key, required this.appState});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  StreamSubscription<List<ScanResult>>? sub;
  List<ScanResult> results = [];

  @override
  void initState() {
    super.initState();
    sub = widget.appState.bluetoothService.scanResults().listen((items) {
      if (mounted) {
        setState(() => results = items);
      }
    });
  }

  @override
  void dispose() {
    sub?.cancel();
    widget.appState.bluetoothService.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.t('bluetooth'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.icon(
            onPressed: () async {
              await widget.appState.bluetoothService.startScan();
            },
            icon: const Icon(Icons.bluetooth_searching),
            label: Text(t.t('scanDevices')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: SizedBox(
              height: 360,
              child: results.isEmpty
                  ? Center(child: Text(t.t('noDevices')))
                  : ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, i) {
                        final r = results[i];
                        final name = r.device.platformName.isEmpty ? 'Unknown Device' : r.device.platformName;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(name),
                          subtitle: Text(r.device.remoteId.str),
                          trailing: TextButton(
                            onPressed: () {
                              widget.appState.setSelectedBluetoothDevice(name);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('已選取：$name')),
                              );
                            },
                            child: const Text('選取'),
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 16),
          if (widget.appState.selectedBluetoothDevice != null)
            SectionCard(child: Text('目前選取裝置：${widget.appState.selectedBluetoothDevice}')),
        ],
      ),
    );
  }
}
