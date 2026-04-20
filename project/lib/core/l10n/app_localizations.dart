import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('zh', 'TW'),
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final instance = Localizations.of<AppLocalizations>(context, AppLocalizations);
    assert(instance != null, 'AppLocalizations missing');
    return instance!;
  }

  static const Map<String, Map<String, String>> _v = {
    'zh_TW': {
      'home': '首頁',
      'records': '健康紀錄',
      'add': '新增',
      'analysis': '分析報告',
      'profile': '我的',
      'language': '語言',
      'save': '儲存',
      'export': '匯出',
      'share': '分享',
      'ocr': 'OCR 拍照辨識',
      'bluetooth': '藍牙同步',
      'scanning': '掃描中',
      'scanDevices': '掃描裝置',
      'noDevices': '尚未找到裝置',
      'pickImage': '拍照或選圖',
      'recognizedText': '辨識文字',
      'category': '分類',
      'subcategory': '子分類',
      'item': '項目',
      'value': '數值',
      'date': '日期',
      'notes': '備註',
      'basicReport': '基本報告',
      'fullReport': '完整分析報告',
      'reportSaved': '報表已匯出至本機',
      'reportShared': '已開啟分享',
      'healthOverview': '健康總覽',
      'aiAlert': 'AI 健康提醒',
      'viewAnalysis': '查看分析',
      'geneticTesting': '基因檢測',
      'encryptStorage': '本機加密已啟用',
    },
    'en': {
      'home': 'Home',
      'records': 'Records',
      'add': 'Add',
      'analysis': 'Analysis',
      'profile': 'Profile',
      'language': 'Language',
      'save': 'Save',
      'export': 'Export',
      'share': 'Share',
      'ocr': 'OCR Capture',
      'bluetooth': 'Bluetooth Sync',
      'scanning': 'Scanning',
      'scanDevices': 'Scan Devices',
      'noDevices': 'No devices found',
      'pickImage': 'Take or Pick Image',
      'recognizedText': 'Recognized Text',
      'category': 'Category',
      'subcategory': 'Subcategory',
      'item': 'Item',
      'value': 'Value',
      'date': 'Date',
      'notes': 'Notes',
      'basicReport': 'Basic Report',
      'fullReport': 'Full Analysis Report',
      'reportSaved': 'Report exported locally',
      'reportShared': 'Share sheet opened',
      'healthOverview': 'Health Overview',
      'aiAlert': 'AI Health Alert',
      'viewAnalysis': 'View Analysis',
      'geneticTesting': 'Genetic Testing',
      'encryptStorage': 'Local encryption enabled',
    },
    'ja': {
      'home': 'ホーム',
      'records': '記録',
      'add': '追加',
      'analysis': '分析',
      'profile': 'マイページ',
      'language': '言語',
      'save': '保存',
      'export': '出力',
      'share': '共有',
      'ocr': 'OCR 撮影認識',
      'bluetooth': 'Bluetooth 同期',
      'scanning': 'スキャン中',
      'scanDevices': 'デバイスを検索',
      'noDevices': 'デバイスが見つかりません',
      'pickImage': '撮影または画像選択',
      'recognizedText': '認識文字',
      'category': '分類',
      'subcategory': 'サブ分類',
      'item': '項目',
      'value': '数値',
      'date': '日付',
      'notes': 'メモ',
      'basicReport': '基本レポート',
      'fullReport': '完全分析レポート',
      'reportSaved': 'レポートを端末に保存しました',
      'reportShared': '共有シートを開きました',
      'healthOverview': '健康概要',
      'aiAlert': 'AI 健康通知',
      'viewAnalysis': '分析を見る',
      'geneticTesting': '遺伝子検査',
      'encryptStorage': 'ローカル暗号化が有効です',
    },
    'ko': {
      'home': '홈',
      'records': '기록',
      'add': '추가',
      'analysis': '분석',
      'profile': '내 정보',
      'language': '언어',
      'save': '저장',
      'export': '내보내기',
      'share': '공유',
      'ocr': 'OCR 촬영 인식',
      'bluetooth': '블루투스 동기화',
      'scanning': '검색 중',
      'scanDevices': '장치 검색',
      'noDevices': '장치를 찾지 못했습니다',
      'pickImage': '촬영 또는 이미지 선택',
      'recognizedText': '인식된 텍스트',
      'category': '분류',
      'subcategory': '하위 분류',
      'item': '항목',
      'value': '값',
      'date': '날짜',
      'notes': '메모',
      'basicReport': '기본 보고서',
      'fullReport': '전체 분석 보고서',
      'reportSaved': '보고서를 기기에 저장했습니다',
      'reportShared': '공유 시트를 열었습니다',
      'healthOverview': '건강 개요',
      'aiAlert': 'AI 건강 알림',
      'viewAnalysis': '분석 보기',
      'geneticTesting': '유전자 검사',
      'encryptStorage': '로컬 암호화 활성화',
    },
  };

  String t(String key) {
    final langKey = locale.countryCode == null ? locale.languageCode : '${locale.languageCode}_${locale.countryCode}';
    return _v[langKey]?[key] ?? _v[locale.languageCode]?[key] ?? _v['en']![key] ?? key;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['zh', 'en', 'ja', 'ko'].contains(locale.languageCode);
  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
