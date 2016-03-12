package mime;

import haxe.DynamicAccess;
import haxe.io.Path;

typedef TypeInfo = {
	?source: String,
	?compressible: Bool,
	?extensions: Array<String>,
	?charset: String
}

class Mime {
	public static var db(default, null): DynamicAccess<TypeInfo> = <<<DB>>>;
	
	public static function lookup(path: String): Null<String> {
		var extension = path.indexOf('.') > -1 ? Path.extension(path).toLowerCase() : path.toLowerCase();
		for (type in db.keys()) {
			var entry = db.get(type);
			if (entry.extensions != null && entry.extensions.indexOf(extension) > -1)
				return type;
		}
		return null;
	}
	
	public static function extension(type: String): Null<String> {
		if (!db.exists(type)) return null;
		var entry = db.get(type);
		if (entry.extensions == null) return null;
		return entry.extensions[0];
	}
}