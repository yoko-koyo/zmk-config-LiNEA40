#!/bin/bash

# --- 設定 ---
TARGET="linea40_r"
UF2_PATH="./build/${TARGET}/zephyr/zmk.uf2"
DRIVE_NAME="NO NAME" 

echo "========================================"
echo "👉 右手側 (linea40_r) のビルドを開始します..."
echo "========================================"

# Kconfigの警告を無視するフラグ（-DCONFIG_ZMK_KCONFIG_WARNINGS_AS_ERRORS=n）を追加
# これにより LVGL 関連の古い警告でビルドが止まるのを防ぎます
export CMAKE_ARGS="-DCONFIG_ZMK_KCONFIG_WARNINGS_AS_ERRORS=n"

# ビルド実行
INCREMENTAL=true ./build_local.sh build "$TARGET"

if [ $? -ne 0 ]; then
    echo "❌ ビルド失敗"
    exit 1
fi

echo "✅ ビルド成功！ダブルクリック待ち..."

while [ ! -d "/Volumes/$DRIVE_NAME" ]; do 
    sleep 1
done

echo "⚡️ 書き込み中..."
cp -X "$UF2_PATH" "/Volumes/$DRIVE_NAME/" 2>/dev/null || true

sleep 2
echo "🎉 完了しました！"