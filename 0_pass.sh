#!/bin/sh
# (passありの)RSA秘密鍵作るテスト
openssl genrsa -aes128 -passout pass:keypass -out private_pass.pem 2048

# (オプション)RSAだと秘密鍵から公開鍵が作れる
openssl rsa -in private_pass.pem -passin pass:keypass -pubout -out public_pass.pem

# 親ディレクトリにコピー
cp -a private_pass.pem public_pass.pem ../
