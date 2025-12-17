#!/usr/bin/env bash
# Bashシェルスクリプトとして実行することを宣言

set -o errexit
# エラーが発生したら即座にスクリプトを終了

echo "==> Installing dependencies..."
bundle install
# Gemfileに記載された依存関係をインストール

echo "==> Building Tailwind CSS..."
bundle exec rails tailwindcss:build
# Tailwind CSSをビルド（重要！）

echo "==> Precompiling assets..."
bundle exec rails assets:precompile
# アセット（CSS、JavaScript、画像など）をプリコンパイル

bundle exec rails assets:clean
# 古いアセットファイルを削除

echo "==> Running database migrations..."
bundle exec rails db:migrate
# データベースのマイグレーションを実行

echo "==> Build completed successfully!"
# ビルド完了メッセージ