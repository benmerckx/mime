package mime;

import haxe.DynamicAccess;
import haxe.Resource;
import haxe.Json;

#if macro
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;
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
		#if (java || cpp)
			Json.parse(Resource.getString('mime-db'));
		#else
			data();
		#end

	@:isVar
	public static var extensions(get, null): Map<String, String>;
	static function get_extensions()
		return if (extensions != null) extensions else {
			extensions = new Map();
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
		if(Context.defined('java') || Context.defined('cpp')) {
			Context.addResource('mime-db', sys.io.File.getBytes(
				Context.resolvePath('mime-db.json')
			));
		}
		#end
	}
	
	public static macro function data() {
		#if macro
		var path = Context.resolvePath('mime-db.json');
		return Context.parseInlineString(
			File.getContent(path),
			Context.makePosition({file: path, min: 0, max: FileSystem.stat(path).size})
		);
		#end
	}
}
