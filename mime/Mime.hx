package mime;

import haxe.DynamicAccess;
import haxe.Resource;
import haxe.io.Path;
import haxe.Json;
#if macro
import haxe.macro.Context;
#end

typedef TypeInfo = {
	?source: String,
	?compressible: Bool,
	?extensions: Array<String>,
	?charset: String
}

class Mime {
	/*public static function __init__() {
		#if !macro
		var res = Resource.getString('mime-db');
		trace(res);
		if (res == null) throw 'Res is empty';
		db = Json.parse(res);
		#end
	}*/
	#if !macro
	public static var db(default, null): DynamicAccess<TypeInfo> = Json.parse(Resource.getString('mime-db'));

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
	#end
	
	public static function init() {
		#if macro
		var path = Context.resolvePath('mime-db.json');
		if (path == null) throw 'Could not find mime-db.json in classpath';
		Context.addResource('mime-db', sys.io.File.getBytes(path));
		#end
	}
}
