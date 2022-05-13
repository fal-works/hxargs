package hxargs;

using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

// TODO: target-specific defines

/**
	Haxe compiler target with some options (if available).
**/
@:using(CompilerTarget.CompilerTargetExtension)
enum CompilerTarget {
	JavaScript;
	HashLink;
	Jvm;
	Php(?options: {
		var ?front: String;
		var ?lib: String;
		var ?prefix: String;
	});
	Cpp;
	Lua;
	CSharp(?options: {
		var ?net: {
			var ?libs: Array<{
				var file: String;
				var ?std: Bool;
			}>;
			var ?stds: Array<String>;
		};
		var ?cArgs: Array<String>;
	});
	Python;
	Java(?options: {
		var ?libs: Array<String>;
		var ?cArgs: Array<String>;
	});
	Flash(?options: {
		var ?swf: {
			var ?version: String;
			var ?header: String;
			var ?libs: Array<String>;
			var ?libsExtern: Array<String>;
		};
		var ?strict: Bool;
	});
	Neko;
	Cppia;
}

class CompilerTargetExtension {
	public static function toCommandArguments(
		target: CompilerTarget,
		outfile: String
	): Array<Array<String>> {
		return switch target {
			case JavaScript:
				[["--js", outfile]];
			case HashLink:
				[["--hl", outfile]];
			case Jvm:
				[["--jvm", outfile]];
			case Php(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.front.mayDo(x -> ret.push(["-D", 'php-front=${x}']));
					opt.lib.mayDo(x -> ret.push(["-D", 'php-lib=${x}']));
					opt.prefix.mayDo(x -> ret.push(["-D", 'php-prefix=${x}']));
				});
				ret.push(["--php", outfile]);
				ret;
			case Cpp:
				[["--cpp", outfile]];
			case Lua:
				[["--lua", outfile]];
			case CSharp(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.net.mayDo(net -> {
						net.libs.mayIter(e -> {
							ret.push(["--net-lib", if (e.std == true) '${e.file}@std' else e.file]);
						});
						net.stds.mayIter(x -> ret.push(["--net-std", x]));
					});
					opt.cArgs.mayIter(x -> ret.push(["--c-arg", x]));
				});
				ret.push(["--cs", outfile]);
				ret;
			case Python:
				[["--python", outfile]];
			case Java(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.libs.mayIter(x -> ret.push(["--java-lib", x]));
					opt.cArgs.mayIter(x -> ret.push(["--c-arg", x]));
				});
				ret.push(["--java", outfile]);
				ret;
			case Flash(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.swf.mayDo(swf -> {
						swf.version.mayDo(x -> ret.push(["--swf-version", x]));
						swf.header.mayDo(x -> ret.push(["--swf-header", x]));
						swf.libs.mayIter(x -> ret.push(["--swf-lib", x]));
						swf.libsExtern.mayIter(x -> ret.push(["--swf-lib-extern", x]));
					});
					if (opt.strict == true) ret.push(["--flash-strict"]);
				});
				ret.push(["--flash", outfile]);
				ret;
			case Neko:
				[["--neko", outfile]];
			case Cppia:
				[["--cppia", outfile]];
		}
	}

	public static function defaultRunCommand(
		target: CompilerTarget
	): Null<(path: String) -> Array<String>> {
		return switch target {
			case HashLink: path -> ["hl", path];
			case Jvm: path -> [
					"java",
					"-jar",
					path
				];
			case Neko: path -> ["neko", path];
			case _: null;
		}
	}
}
