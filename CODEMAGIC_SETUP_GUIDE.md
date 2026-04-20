# Codemagic 一鍵打包教學

這份專案已加入 `codemagic.yaml`，可直接在 Codemagic 建立自動打包流程。

## 你要做的事

### 1. 建立 GitHub 倉庫
把這個資料包解壓後，整個專案上傳到 GitHub。

### 2. 到 Codemagic 建立 App
- 登入 Codemagic
- 選擇 GitHub repository
- 選到這個專案
- Codemagic 會自動讀到 `codemagic.yaml`

### 3. 直接選 workflow 打包
你會看到三個流程：
- `android-apk-debug`：測試 APK
- `android-apk-release`：正式 APK
- `android-aab-release`：Play 商店 AAB

## 如果你只想先拿到可以安裝的 APK
先跑：
- `android-apk-debug`

## 如果你要正式上架
你還要補 Android signing。

### A. 在 Codemagic 設定 keystore
到：
- Team settings
- Code signing identities
- Android keystores

新增一組名稱：
- `ai_health_keystore`

### B. 需要的資料
- keystore 檔案（`.jks`）
- keystore password
- key alias
- key password

## 如果 build 失敗最常見原因
1. Flutter plugin 版本相依衝突
2. Android 權限或 minSdk 設定
3. release signing 尚未設定
4. OCR / 藍牙 plugin 需要 Android 原生設定補齊

## 建議打包順序
1. 先跑 debug APK
2. 真機安裝測試
3. 再補簽章跑 release APK
4. 最後跑 AAB 上架版
