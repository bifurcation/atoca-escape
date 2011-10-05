#!/bin/bash

# Set up a self-signed signing cert
PREFIX=`mktemp atoca-XXX`;
openssl genpkey -algorithm RSA -out $PREFIX.key
openssl req -new -key $PREFIX.key -out $PREFIX.csr
cat >$PREFIX.conf <<EOF
[skid]
subjectKeyIdentifier=hash
EOF
openssl x509 -req -days 365 -in $PREFIX.csr -signkey $PREFIX.key \
    -out cert.pem -extfile $PREFIX.conf -extensions skid
cat $PREFIX.key >>cert.pem
rm $PREFIX*


