#!/bin/bash
npm install mime-db --silent
cp node_modules/mime-db/db.json mime-db.json
zip -r mime.zip mime haxelib.json extraParams.hxml mime-db.json README.md -x "*/\.*"
haxelib submit mime.zip
rm mime.zip 2> /dev/null