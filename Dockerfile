FROM ruby:3.2.3-slim

# 作業ディレクトリを設定
WORKDIR /rails

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libvips \
    postgresql-client \
    pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Node.jsのインストール（必要な場合）
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*
# Bundlerのバージョンを明示的にインストール
RUN gem install bundler:4.0.1

# Gemfileをコピーしてbundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのコードをすべてコピー
COPY . .

# package.jsonがある場合のみNode modulesをインストール
RUN if [ -f package.json ]; then \
      if [ -f yarn.lock ]; then \
        yarn install --frozen-lockfile; \
      else \
        npm install; \
      fi \
    fi

# アセットをプリコンパイル
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# 環境変数を設定
ENV RAILS_ENV="production" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test" \
    RAILS_SERVE_STATIC_FILES="true"

# ポートを公開
EXPOSE 3000

# 起動コマンド（マイグレーション→サーバー起動）
CMD ["sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"]
