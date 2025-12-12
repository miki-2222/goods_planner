#!/usr/bin/env bash
set -o errexit

echo "=== Installing dependencies ==="
bundle install

echo "=== Building Tailwind CSS ==="
bundle exec rails tailwindcss:build

echo "=== Precompiling assets ==="
bundle exec rails assets:precompile

echo "=== Cleaning old assets ==="
bundle exec rails assets:clean

echo "=== Running database migrations ==="
bundle exec rails db:migrate

echo "=== Build completed successfully ==="