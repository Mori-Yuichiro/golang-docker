# web-service-gin

ginとmysqlを使った簡単なwebアプリケーションです。

# 環境構築
## 開発環境
以下のコマンドを実行して、開発環境のイメージを作成
```
docker compose -f docker-compose.build.yml build
```
以下のコマンドを実行し、開発環境を起動する
```
docker compoes up
```

## 本番環境
以下のコマンドを実行して、本番環境のイメージを作成
```
docker build --target production -t gin_production:latest .
```