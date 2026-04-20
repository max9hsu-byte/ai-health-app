# GitHub 上傳最短流程

## 如果你完全不熟 Git
最簡單方法：
1. 到 GitHub 建立一個新的 repository
2. 用 GitHub Desktop 上傳整個解壓後的專案資料夾
3. Push 到 main branch
4. 回 Codemagic 連接這個 repository

## 如果你會用命令列
```bash
git init
git add .
git commit -m "Initial AI Health App codemagic build setup"
git branch -M main
git remote add origin <你的 GitHub repo URL>
git push -u origin main
```
