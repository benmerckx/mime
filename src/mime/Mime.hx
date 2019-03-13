package mime;

import haxe.DynamicAccess;
import haxe.Resource;
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
	#if !macro
	public static var db(default, never): DynamicAccess<TypeInfo> = 
		Json.parse(Resource.getString('mime-db'));

	@:isVar
	public static var extensions(get, never): Map<String, String>;
	static function get_extensions()
		return if (extensions != null) extensions else {
			var extensions = new Map();
			for (type in db.keys())
				switch db.get(type) {
					case {extensions: e} if (e != null):
						for (extension in e)
							extensions.set(extension, type);
				}
			extensions;
		}

	public static function lookup(path: String): Null<String>
		return extensions.get(
			path.split('.').pop().toLowerCase()
		);

	public static function extension(type: String): Null<String>
		return switch db.get(type) {
			case {extensions: e} if (e != null): e[0];
			default: null;
		}
	#end
	
	public static function init() {
		#if macro
		switch Context.resolvePath('mime-db.json') {
			case null: throw 'Could not find mime-db.json in classpath';
			case path: Context.addResource('mime-db', sys.io.File.getBytes(path));
		}
		#end
	}
}
