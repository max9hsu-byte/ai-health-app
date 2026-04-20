# Figma 匯入與重建指引

## 建議 Figma 專案結構
- 01_Design System
- 02_Components
- 03_User App
- 04_Enterprise
- 05_Prototype

## 推薦重建的元件
- Header
- Bottom Navigation
- Primary Button / Secondary Button
- Card
- Tag / Risk Badge
- Input
- Toggle
- Table Row

## 多語系建議
所有 UI 文字請改為 i18n key 管理：
- nav.home
- nav.records
- nav.analysis
- records.common_blood
- records.genetic_test
- gene.risk.low
- gene.risk.medium
- gene.risk.high

## 設計風格
- 主色：深藍
- 輔色：青綠
- 背景：淺灰白
- 視覺關鍵字：高端、醫療、信任、科技

## 注意
SVG 為可編修素材，但不是原生 `.fig`。
若要完全元件化，建議在 Figma 中依畫面重建 Auto Layout 與 Component。
