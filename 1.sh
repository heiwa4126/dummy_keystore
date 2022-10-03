#!/bin/sh
# 参考: https://qiita.com/yasushi-jp/items/89bd88e13949c73d0f16

# 先に0.shでRSA秘密キーを作る。
# またはパスなしのprivate.pemを置く。

# (オプション)RSAだと秘密鍵から公開鍵が作れる
openssl rsa -pubout -in private.pem -out public.pem

# CSR(証明書署名要求)作る
openssl req -new -key private.pem -out csr.pem \
  -subj "/C=JP/ST=TOKYO/L=MINATO/O=FOOBAR CORP/OU=DEV/CN=x.local"

# CSRに自己署名
openssl x509 -req -in csr.pem -out cert.pem -signkey private.pem -days 3660

# 秘密鍵と証明書をPKCS12形式に変換
openssl pkcs12 -export \
  -name alias1 -out keystore.p12 \
  -passout pass:storepass \
  -in cert.pem -inkey private.pem

# PKCS12キーストアをJKSキーストアに変換
keytool -importkeystore -noprompt \
  -srckeystore keystore.p12 -srcstoretype PKCS12 -srcstorepass storepass \
  -destkeystore keystore.jks -deststoretype JKS -deststorepass storepass1 -destkeypass keypass1

# 親ディレクトリにコピー
cp -a keystore.jks keystore.p12 private.pem public.pem ../
