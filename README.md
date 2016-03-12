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