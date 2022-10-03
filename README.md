# dummy_keystore

JavaのJWT開発のために以下のファイルを作り、

- private.pem - RSA秘密鍵(パスフレーズなし)
- public.pem - (オプション)上の公開鍵。https://jwt.io でベリファイ用に。
- keystore.p12 - PKCS#12形式のキーストア。署名は自己署名。
- keystore.jks - JKS(Java keystore)形式のキーストア。

1つ上のディレクトリにコピーする。


`private.pem` は `./0.sh` として作成してもいいし、
与えられたものを使ってもいい(ただしパスフレーズなしに変換すること)。

`private.pem` の作成or配置の後に、 `./1.sh` を実行すると、
1つ上のディレクトリに上記ファイルが配置される。

p12やjksのパスワード/パスフレーズは `./1.sh`で決め打ちなので、
後でどうにかする。


# メモ

JKSは今や流行おくれなのでPKCS#12がいいと思う。
