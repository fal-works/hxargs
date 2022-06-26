package hxargs.types;

/**
	Value that represents a call expression of any built-in initialization macro.

	@see https://api.haxe.org//haxe/macro/Compiler.html
**/
@:using(BuiltinInitializationMacro.BuiltinInitializationMacroExtension)
enum BuiltinInitializationMacro {
	AddGlobalMetadata(args: {
		var pathFilter: String;
		var meta: String;
		var ?recursive: Bool;
		var ?toTypes: Bool;
		var ?toFields: Bool;
	});
	AddMetadata(args: {
		var meta: String;
		var className: String;
		var ?field: String;
		var ?isStatic: Bool;
	});
	AddNativeArg(argument: String);
	AddNativeLib(name: String);
	AllowPackage(v: String);
	Exclude(pack: String, ?recursive: Bool);
	ExcludeFile(fileName: String);
	FlushDiskCache;
	Include(args: {
		var pack: String;
		var ?recursive: Bool;
		var ?ignore: Array<String>;
		var ?classPaths: Array<String>;
		var ?strict: Bool;
	});
	IncludeFile(file: String, position: haxe.macro.Compiler.IncludePosition);
	Keep(args: {
		var ?path: String;
		var ?paths: Array<String>;
		var ?recursive: Bool;
	});
	NullSafety(args: {
		var path: String;
		var ?mode: haxe.macro.Compiler.NullSafetyMode;
		var ?recursive: Bool;
	});
	PatchType(file: String);
	RemoveField(args: {
		var className: String;
		var field: String;
		var ?isStatic: Bool;
	});
	SetCustomJSGenerator(callbackExpressionString: String);
	SetFieldType(args: {
		var className: String;
		var field: String;
		var type: String;
		var ?isStatic: Bool;
	});
	SetOutput(fileOrDir: String);
}

class BuiltinInitializationMacroExtension {
	public static function toCommandOption(
		mcr: BuiltinInitializationMacro
	): Argument {
		return ["--macro", toString(mcr)];
	}

	public static function toString(mcr: BuiltinInitializationMacro): String {
		return '${getFuncName(mcr)}(${getArgs(mcr).join(", ")})';
	}

	static function getFuncName(mcr: BuiltinInitializationMacro): String {
		final s = mcr.getName();
		return s.charAt(0).toLowerCase() + s.substr(1);
	}

	static function getArgs(mcr: BuiltinInitializationMacro): Array<Null<Any>> {
		return switch mcr {
			case AddGlobalMetadata(args):
				removeTrailingNulls([
					args.pathFilter,
					args.meta,
					args.recursive,
					args.toTypes,
					args.toFields,
				]);
			case AddMetadata(args):
				removeTrailingNulls([
					args.meta,
					args.className,
					args.field,
					args.isStatic,
				]);
			case AddNativeArg(argument):
				[argument];
			case AddNativeLib(name):
				[name];
			case AllowPackage(v):
				[v];
			case Exclude(pack, recursive):
				removeTrailingNulls([pack, recursive]);
			case ExcludeFile(fileName):
				[fileName];
			case FlushDiskCache:
				[];
			case Include(args):
				removeTrailingNulls([
					args.pack,
					args.recursive,
					args.ignore,
					args.classPaths,
					args.strict,
				]);
			case IncludeFile(file, position):
				[file, position];
			case Keep(args):
				removeTrailingNulls([
					args.path,
					args.paths,
					args.recursive,
				]);
			case NullSafety(args):
				removeTrailingNulls([
					args.path,
					args.mode,
					args.recursive,
				]);
			case PatchType(file):
				[file];
			case RemoveField(args):
				removeTrailingNulls([
					args.className,
					args.field,
					args.isStatic,
				]);
			case SetCustomJSGenerator(callbackExpressionString):
				[callbackExpressionString];
			case SetFieldType(args):
				removeTrailingNulls([
					args.className,
					args.field,
					args.type,
					args.isStatic,
				]);
			case SetOutput(fileOrDir):
				[fileOrDir];
		};
	}

	static function removeTrailingNulls(args: Array<Null<Dynamic>>): Array<Null<Any>> {
		while (args.length > 0 && args[args.length - 1] == null) args.pop();
		return args;
	}
}
