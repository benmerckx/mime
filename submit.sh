#!/bin/bash
npm install mime-db --silent
awk 'FNR==NR{s=(!s)?$0:s RS $0;next} /<<<DB>>>/{sub(/<<<DB>>>/, s)} 1' node_modules/mime-db/db.json Mime.hx > mime/Mime.hx
zip -r mime.zip mime haxelib.json README.md -x "*/\.*"
haxelib submit mime.zip
rm mime.zip 2> /dev/null