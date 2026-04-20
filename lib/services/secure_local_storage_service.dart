import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class SecureLocalStorageService {
  static const _keyName = 'ai_health_aes_key';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<File> _getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

  Future<enc.Key> _getOrCreateKey() async {
    String? saved = await secureStorage.read(key: _keyName);
    if (saved == null) {
      final random = Random.secure();
      final bytes = List<int>.generate(32, (_) => random.nextInt(256));
      saved = base64Encode(bytes);
      await secureStorage.write(key: _keyName, value: saved);
    }
    return enc.Key(base64Decode(saved));
  }

  Future<List<Map<String, dynamic>>> readEncryptedList(String filename) async {
    final file = await _getFile(filename);
    if (!await file.exists()) {
      await writeEncryptedList(filename, []);
      return [];
    }
    final raw = await file.readAsString();
    if (raw.trim().isEmpty) {
      return [];
    }

    final key = await _getOrCreateKey();
    final parts = raw.split(':');
    if (parts.length != 2) {
      return [];
    }
    final iv = enc.IV.fromBase64(parts[0]);
    final encrypted = enc.Encrypted.fromBase64(parts[1]);
    final encrypter = enc.Encrypter(enc.AES(key));
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    final decoded = jsonDecode(decrypted) as List<dynamic>;
    return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<void> writeEncryptedList(String filename, List<Map<String, dynamic>> value) async {
    final file = await _getFile(filename);
    final key = await _getOrCreateKey();
    final iv = enc.IV.fromSecureRandom(16);
    final encrypter = enc.Encrypter(enc.AES(key));
    final encrypted = encrypter.encrypt(jsonEncode(value), iv: iv);
    await file.writeAsString('${iv.base64}:${encrypted.base64}');
  }
}
