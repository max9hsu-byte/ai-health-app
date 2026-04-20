# Android build.gradle / Gradle 注意事項

## minSdkVersion 建議
由於你有：
- flutter_secure_storage
- google_mlkit_text_recognition
- flutter_blue_plus

建議：
- minSdkVersion 23 以上
- targetSdkVersion 使用 Flutter 目前 stable 預設或 34+

## release 建議
android/app/build.gradle 或 build.gradle.kts 中確認：
- minSdkVersion >= 23
- multidex 如有需要再加
- release 簽章設定完成

## 常用建置指令
flutter clean
flutter pub get
flutter build apk --release
