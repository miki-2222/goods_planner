#!/bin/bash
# bashシェルで実行することを宣言

set -e
# エラーが発生したら即座にスクリプトを終了
# 問題を早期発見できる

rm -f /app/tmp/pids/server.pid
# -f オプション: ファイルがなくてもエラーにならない
# 毎回確実にPIDファイルを削除

exec "$@"
# Dockerfileで指定されたメインコマンドを実行
# 例: bundle exec puma -C config/puma.rb