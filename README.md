# mime

Packages [mime-db](https://github.com/jshttp/mime-db) for haxelib

```haxe
Mime.lookup('/path/to/file.txt');   // text/plain
Mime.lookup('file.txt');            // text/plain
Mime.lookup('.TXT');                // text/plain
Mime.lookup('htm');                 // text/html

Mime.extension('text/html');        // html
Mime.extension('application/pdf');  // pdf

Mime.db.get('text/html');           // {compressible => true, extensions => [html,htm,shtml], source => iana}				
```

You will need to download [db.json ](https://raw.githubusercontent.com/jshttp/mime-db/master/db.json) and configure it using the -resource compile flag, the resource must be named mime-db:

```
-resource db.json@mime-db
```
