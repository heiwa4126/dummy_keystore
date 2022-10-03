#!/bin/sh
# https://stackoverflow.com/questions/18621508/getting-a-privatekey-object-from-a-p12-file-in-java
keytool -list -v -keystore keystore.p12 -storetype PKCS12 -storepass storepass
