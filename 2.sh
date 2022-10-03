#!/bin/sh
# JKSに2個目の秘密キーをストアしてみるテスト
#

# (passなしの)RSA秘密鍵作る
# TODO: 既存ファイルがあればスキップする
openssl genrsa -out private2.pem 2048

# (オプション)RSAだと秘密鍵から公開鍵が作れる
openssl rsa -pubout -in private2.pem -out public2.pem

# CSR(証明書署名要求)作る
openssl req -new -key private2.pem -out csr2.pem \
  -subj "/C=JP/ST=TOKYO/L=MINATO/O=FOOBAR CORP/OU=DEV/CN=y.local"

# CSRに自己署名
openssl x509 -req -in csr2.pem -out cert2.pem -signkey private2.pem -days 3660

# 秘密鍵と証明書をPKCS12形式に変換
openssl pkcs12 -export \
  -name alias2 -out keystore2.p12 \
  -passout pass:storepass \
  -in cert2.pem -inkey private2.pem

# PKCS12キーストアをJKSキーストアに追加
keytool -importkeystore -noprompt \
  -srckeystore keystore2.p12 -srcstoretype PKCS12 -srcstorepass storepass \
  -destkeystore keystore.jks -deststoretype JKS -deststorepass storepass1 -destkeypass keypass1
