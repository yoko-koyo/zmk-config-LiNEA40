#!/bin/bash

# 設定: 生成されたファイルのパス
LEFT_UF2="./build/seeeduino_xiao_ble_roBa_L/zephyr/zmk.uf2"
RIGHT_UF2="./build/seeeduino_xiao_ble_roBa_R/zephyr/zmk.uf2"
DRIVE_NAME="NO NAME" # もしマウント名が違う場合は書き換えてください

echo "キーボードをダブルクリックしてブートローダーモードにしてください..."

while true; do
    if [ -d "/Volumes/$DRIVE_NAME" ]; then
        echo "デバイスを検出しました: $DRIVE_NAME"
        
        echo "どちらを書き込みますか？ (l/r/q): "
        read -n 1 side
        echo ""

        if [ "$side" == "l" ]; then
            cp "$LEFT_UF2" "/Volumes/$DRIVE_NAME/" && echo "左側を書き込みました！"
        elif [ "$side" == "r" ]; then
            cp "$RIGHT_UF2" "/Volumes/$DRIVE_NAME/" && echo "右側を書き込みました！"
        elif [ "$side" == "q" ]; then
            break
        fi
        
        echo "完了。ドライブが解除されるのを待っています..."
        while [ -d "/Volumes/$DRIVE_NAME" ]; do sleep 1; done
        echo "解除されました。続けてもう片方を行うか、Ctrl+Cで終了してください。"
    fi
    sleep 1
done
