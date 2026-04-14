#!/bin/bash

# --- 設定 ---
TARGET="linea40_l"
UF2_PATH="./build/${TARGET}/zephyr/zmk.uf2"
# 左手側を接続した際のドライブ名（一般的には右手と同じですが、区別が必要なら変更してください）
DRIVE_NAME="NO NAME" 

echo "========================================"
echo "👈 左手側 (linea40_l) のビルドを開始します..."
echo "========================================"

# Kconfigの警告を無視するフラグ
export CMAKE_ARGS="-DCONFIG_ZMK_KCONFIG_WARNINGS_AS_ERRORS=n"

# ビルド実行
INCREMENTAL=true ./build_local.sh build "$TARGET"

if [ $? -ne 0 ]; then
    echo "❌ ビルド失敗"
    exit 1
fi

echo "✅ ビルド成功！ダブルクリック待ち..."

# マウントされるまでループ
while [ ! -d "/Volumes/$DRIVE_NAME" ]; do 
    sleep 1
done

echo "⚡️ 書き込み中..."
# -X オプションは macOS 固有の拡張属性（._ ファイルなど）をコピーしないためのフラグです
cp -X "$UF2_PATH" "/Volumes/$DRIVE_NAME/" 2>/dev/null || true

sleep 2
echo "🎉 完了しました！"