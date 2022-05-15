package hxargs;

using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

// TODO: target-specific defines

/**
	Haxe compiler target with some options (if available).
**/
@:using(CompilerTarget.CompilerTargetExtension)
enum CompilerTarget {
	/** `--js` **/
	JavaScript;

	/** `--hl` **/
	HashLink;

	/** `--jvm` **/
	Jvm;

	/** `--php` **/
	Php(?options: {
		var ?front: String;
		var ?lib: String;
		var ?prefix: String;
	});

	/** `--cpp` **/
	Cpp(?options: {
		var ?defines: {
			/** `-D annotate_source` **/
			var ?annotateSource: Bool;

			/** `-D disable_unicode_strings` **/
			var ?disableUnicodeStrings: Bool;

			/** `-D dll_export` **/
			var ?dllExport: Bool;

			/** `-D dynamic_interface_closures` **/
			var ?dynamicInterfaceClosures: Bool;

			/** `-D force_native_property` **/
			var ?forceNativeProperty: Bool;

			/** `-D hxcpp_gc_generational` **/
			var ?hxcppGcGenerational: Bool;

			/** `-D hxcpp_debugger` **/
			var ?hxcppDebugger: Bool;

			/** `-D hxcpp_smart_strings` **/
			var ?hxcppSmartString: Bool;

			/** `-D include_prefix` **/
			var ?includePrefix: Bool;

			/** `-D no-compilation` **/
			var ?noCompilation: Bool;

			/** `-D objc` **/
			var ?objC: Bool;

			/** `-D scriptable` **/
			var ?scriptable: Bool;

			/** `-D vcproj` **/
			var ?vcproj: Bool;
		};
	});

	/** `--lua` **/
	Lua;

	/** `--cs` **/
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

	/** `--python` **/
	Python;

	/** `--java` **/
	Java(?options: {
		var ?libs: Array<String>;
		var ?cArgs: Array<String>;
	});

	/** `--swf` **/
	Flash(?options: {
		var ?swf: {
			var ?version: String;
			var ?header: String;
			var ?libs: Array<String>;
			var ?libsExtern: Array<String>;
		};
		var ?strict: Bool;
		var ?defines: {
			/** `-D advanced-telemetry` **/
			var ?advancedTelemetry: Bool;

			/** `-D fdb` **/
			var ?fdb: Bool;

			/** `-D flash_use_stage` **/
			var ?useStage: Bool;

			/** `-D haxe_boot` **/
			var ?haxeBoot: Bool;

			/** `-D network-sandbox` **/
			var ?networkSandbox: Bool;

			/** `-D no-flash-override` **/
			var ?noOverride: Bool;

			/** `-D no_swf_compress` **/
			var ?noSwfCompress: Bool;

			/** `-D swc` **/
			var ?swc: Bool;

			/** `-D swf_compress_level=<level:1-9>` **/
			var ?swfCompressLevel: Int;

			/** `-D swf_debug_password=<password>` **/
			var ?swfDebugPassword: String;

			/** `-D swf_direct_blit` **/
			var ?swfDirectBlit: Bool;

			/** `-D swf_gpu` **/
			var ?swfGpu: Bool;

			/** `-D swf_metadata` **/
			var ?swfMetadata: String;

			/** `-D swf_preloader_frame` **/
			var ?swfPreloaderFrame: Bool;

			/** `-D swf_protected` **/
			var ?swfProtected: Bool;

			/** `-D swf_script_timeout=<seconds>` **/
			var ?swfScriptTimeout: Float;

			/** `-D swf_use_doabc` **/
			var ?swfUseDoAbc: Bool;
		};
	});

	/** `--neko` / `-x` **/
	Neko;

	/** `--cppia` **/
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
			case Cpp(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.annotateSource == true) ret.push(["-D", "annotate_source"]);
						if (d.disableUnicodeStrings == true)
							ret.push(["-D", "disable_unicode_strings"]);
						if (d.dllExport == true) ret.push(["-D", "dll_export"]);
						if (d.dynamicInterfaceClosures == true)
							ret.push(["-D", "dynamic_interface_closures"]);
						if (d.forceNativeProperty == true) ret.push(["-D", "force_native_property"]);
						if (d.hxcppGcGenerational == true) ret.push(["-D", "hxcpp_gc_generational"]);
						if (d.hxcppDebugger == true) ret.push(["-D", "hxcpp_debugger"]);
						if (d.hxcppSmartString == true) ret.push(["-D", "hxcpp_smart_strings"]);
						if (d.includePrefix == true) ret.push(["-D", "include_prefix"]);
						if (d.noCompilation == true) ret.push(["-D", "no-compilation"]);
						if (d.objC == true) ret.push(["-D", "objc"]);
						if (d.scriptable == true) ret.push(["-D", "scriptable"]);
						if (d.vcproj == true) ret.push(["-D", "vcproj"]);
					});
				});
				ret.push(["--cpp", outfile]);
				ret;
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
					opt.defines.mayDo(d -> {
						if (d.advancedTelemetry == true) ret.push(["-D", "advanced-telemetry"]);
						if (d.fdb == true) ret.push(["-D", "fdb"]);
						if (d.useStage == true) ret.push(["-D", "flash_use_tage"]);
						if (d.haxeBoot == true) ret.push(["-D", "haxe_boot"]);
						if (d.networkSandbox == true) ret.push(["-D", "network-sandbox"]);
						if (d.noOverride == true) ret.push(["-D", "no-flash-override"]);
						if (d.noSwfCompress == true) ret.push(["-D", "no_swf_compress"]);
						if (d.swc == true) ret.push(["-D", "swc"]);
						d.swfCompressLevel.mayDo(x -> ret.push(["-D", 'swf_compress_level=${x}']));
						d.swfDebugPassword.mayDo(x -> ret.push(["-D", 'swf_debug_password=${x}']));
						if (d.swfDirectBlit == true) ret.push(["-D", "swf_direct_blit"]);
						if (d.swfGpu == true) ret.push(["-D", "swf_gpu"]);
						d.swfMetadata.mayDo(x -> ret.push(["-D", 'swf_metadata=${x}']));
						if (d.swfPreloaderFrame == true) ret.push(["-D", "swf_preloader_frame"]);
						if (d.swfProtected == true) ret.push(["-D", "swf_protected"]);
						d.swfScriptTimeout.mayDo(x -> ret.push(["-D", 'swf_script_timeout=${x}']));
						if (d.swfUseDoAbc == true) ret.push(["-D", "swf_use_doabc"]);
					});
				});
				ret.push(["--swf", outfile]);
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
