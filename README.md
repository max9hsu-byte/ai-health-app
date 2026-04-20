# AI Health Flutter Advanced

已整合：
- 本機資料儲存（AES 加密）
- 多語系（繁中 / English / 日本語 / 한국어）
- OCR 拍照辨識（google_mlkit_text_recognition）
- 藍牙裝置掃描與選取（flutter_blue_plus）
- PDF 報表匯出
- 匯出分享（share_plus）
- 基因資料模型整合

## 執行
```bash
flutter pub get
flutter run
```

## 平台注意事項

### Android
需要相機、藍牙、藍牙掃描與儲存分享權限。

### iOS
需於 Info.plist 補充：
- NSCameraUsageDescription
- NSBluetoothAlwaysUsageDescription
- NSBluetoothPeripheralUsageDescription
- NSPhotoLibraryAddUsageDescription

## 說明
- OCR 目前先回傳辨識出的純文字，並提供簡單數值擷取示範。
- 藍牙同步目前實作為「掃描裝置 / 選取裝置」基礎版，後續可依裝置協定擴充實際讀值。
- 本機加密使用 flutter_secure_storage 保存金鑰，再用 AES 加密 JSON 檔。
