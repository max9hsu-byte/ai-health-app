# Android APK 建置交付說明

這不是已編譯完成的 APK。  
目前執行環境沒有 Flutter SDK / Android SDK，因此無法在這裡直接產出可安裝 APK。

已提供內容：
- Android 權限與 Manifest 範本
- release 建置步驟
- Flutter 套件對應需求
- 測試 APK 與正式 release APK 的指令

## 一、安裝環境
1. 安裝 Flutter Stable
2. 安裝 Android Studio 與 Android SDK
3. 執行：
   flutter doctor

## 二、把這些設定加到你的 Flutter 專案
請以你目前這份專案為主：
AI_Health_Flutter_Advanced_OCR_BLE_Share_Encrypt.zip

將本資料包中的：
- android/app/src/main/AndroidManifest.xml
內容合併到專案對應路徑。

## 三、debug 測試 APK
```bash
flutter pub get
flutter build apk --debug
```

輸出路徑：
build/app/outputs/flutter-apk/app-debug.apk

## 四、release 正式測試 APK
```bash
flutter pub get
flutter build apk --release
```

輸出路徑：
build/app/outputs/flutter-apk/app-release.apk

## 五、AAB 上架版
```bash
flutter build appbundle --release
```

輸出路徑：
build/app/outputs/bundle/release/app-release.aab

## 六、功能對應權限
- OCR 拍照辨識：CAMERA
- 藍牙掃描：BLUETOOTH_SCAN / BLUETOOTH_CONNECT / BLUETOOTH / BLUETOOTH_ADMIN
- Android 12+ 建議使用 nearby devices 權限流程
- 分享檔案：通常不需額外儲存權限，但若你未來改寫到公開下載資料夾，需再補權限策略

## 七、正式版注意
1. release keystore 簽章
2. Proguard / R8 測試
3. Android 12+ 權限彈窗流程
4. OCR 與藍牙真機測試
5. 匯出 PDF 後的分享路徑驗證
6. 本機加密資料升級策略

## 八、目前最接近可安裝 APK 的做法
在本機或雲端 CI（GitHub Actions / Codemagic）拉下 Flutter 專案後直接執行：
```bash
flutter build apk --release
```
