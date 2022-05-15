package hxargs;

using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

/**
	Haxe compiler target with some options (if available).
**/
@:using(CompilerTarget.CompilerTargetExtension)
enum CompilerTarget {
	/** `--js` **/
	JavaScript(?options: {
		var ?defines: {
			/** `-D js_classic` **/
			var ?classic: Bool;

			/** `-D js_es=<version>` **/
			var ?es: Int;

			/** `-D js_enums_as_arrays` **/
			var ?enumAsArrays: Bool;

			/** `-D  js-global=<name>` **/
			var ?global: String;

			/** `-D js_unflatten` **/
			var ?unflatten: Bool;

			/** `-D shallow-expose` **/
			var ?shallowExpose: Bool;

			/** `-D source-map` **/
			var ?sourceMap: Bool;

			/** `-D source-map-content` **/
			var ?sourceMapContent: Bool;
		};
	});

	/** `--hl` **/
	HashLink(?options: {
		var ?defines: {
			/** `-D hl-ver=<version:x.x.x>` **/
			var ?hlVer: String;

			/** `-D no-compilation` **/
			var ?noCompilation: Bool;
		};
	});

	/** `--jvm` **/
	Jvm;

	/** `--php` **/
	Php(?options: {
		var ?defines: {
			/** `-D php-front=<filename>` **/
			var ?front: String;

			/** `-D php-lib=<filename>` **/
			var ?lib: String;

			/** `-D php-prefix=<name>` **/
			var ?prefix: String;

			/** `-D source-map` **/
			var ?sourceMap: Bool;

			/** `-D real_position` **/
			var ?realPosition: Bool;
		};
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

			/** `-D file-extension=<ext>` **/
			var ?fileExtension: String;

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

			/** `-D no-debug` **/
			var ?noDebug: Bool;

			/** `-D objc` **/
			var ?objC: Bool;
		};
	});

	/** `--lua` **/
	Lua(?options: {
		var ?defines: {
			/** `-D lua_jit` **/
			var ?jit: Bool;

			/** `-D lua_vanilla` **/
			var ?vanilla: Bool;

			/** `-D lua_ver=<version>` **/
			var ?luaVer: String;
		};
	});

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
		var ?defines: {
			/** `-D core_api_serialize` **/
			var ?coreApiSerialize: Bool;

			/** `-D cs_ver=<version>` **/
			var ?csVer: String;

			/** `-D dll_import` **/
			var ?dllImport: Bool;

			/** `-D erase_generics` **/
			var ?eraseGenerics: Bool;

			/** `-D fast_cast` **/
			var ?fastCast: Bool;

			/** `-D keep_old_output` **/
			var ?keepOldOutput: Bool;

			/** `-D net_ver=<version>` **/
			var ?netVer: Int;

			/** `-D netcore_ver=<version:x.x.x>` **/
			var ?netcoreVer: String;

			/** `-D net_target=<name>` **/
			var ?netTarget: String;

			/** `-D no-compilation` **/
			var ?noCompilation: Bool;

			/** `-D no_root` **/
			var ?noRoot: Bool;

			/** `-D real_position` **/
			var ?realPosition: Bool;

			/** `-D  std-encoding-utf8` **/
			var ?stdEncodingUtf8: Bool;

			/** `-D unsafe` **/
			var ?unsafe: Bool;
		};
	});

	/** `--python` **/
	Python(?options: {
		var ?defines: {
			/** `-D python-version=<version>` **/
			var ?pythonVer: String;

			/** `-D std-encoding-utf8` **/
			var ?stdEncodingUtf8: Bool;
		};
	});

	/** `--java` **/
	Java(?options: {
		var ?libs: Array<String>;
		var ?cArgs: Array<String>;
		var ?defines: {
			/** `-D fast_cast` **/
			var ?fastCast: Bool;

			/** `-D java_ver=<version>` **/
			var ?javaVer: Int;

			/** `-D jvm` **/
			var ?jvm: Bool;

			/** `-D jvm.compression-level=<level:0-9>` **/
			var ?jvmCompressionLevel: Int;

			/** `-D jvm.dynamic-level=<level:0-2>` **/
			var ?jvmDynamicLevel: Int;

			/** `-D keep_old_output` **/
			var ?keepOldOutput: Bool;

			/** `-D no-compilation` **/
			var ?noCompilation: Bool;

			/** `-D real_position` **/
			var ?realPosition: Bool;

			/** `-D std-encoding-utf8` **/
			var ?stdEncodingUtf8: Bool;
		};
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
	Neko(?options: {
		var ?defines: {
			/** `-D neko_source` **/
			var ?nekoSource: Bool;

			/** `-D neko_v1` **/
			var ?nekoV1: Bool;

			/** `-D use_nekoc` **/
			var ?useNekoc: Bool;
		};
	});

	/** `--cppia` **/
	Cppia(?options: {
		var ?defines: {
			/** `-D nocppiaast` **/
			var ?noCppiaAst: Bool;
		};
	});
}

class CompilerTargetExtension {
	public static function toCommandArguments(
		target: CompilerTarget,
		outfile: String
	): Array<Array<String>> {
		final args: Array<Array<String>> = [];
		inline function optFlag(input: Null<Bool>, optionName: String): Void
			if (input == true) args.push([optionName]);
		inline function optVal<T>(input: Null<T>, optionName: String): Void
			input.mayDo(x -> args.push([optionName, Std.string(x)]));
		inline function optVals<T>(input: Null<Array<T>>, optionName: String): Void
			input.mayIter(x -> args.push([optionName, Std.string(x)]));
		inline function dFlag(input: Null<Bool>, name: String): Void
			if (input == true) args.push(["-D", name]);
		inline function dVal<T>(input: Null<T>, name: String): Void
			input.mayDo(x -> args.push(["-D", '${name}=${Std.string(x)}']));

		switch target {
			case JavaScript(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.classic, "js_classic");
						dVal(d.es, "js_es");
						dFlag(d.enumAsArrays, "js_enums_as_arrays");
						dVal(d.global, "$2");
						dFlag(d.unflatten, "js_unflatten");
						dFlag(d.shallowExpose, "shallow-expose");
						dFlag(d.sourceMap, "source-map");
						dFlag(d.sourceMapContent, "source-map-content");
					});
				});
				args.push(["--js", outfile]);

			case HashLink(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dVal(d.hlVer, "hl-ver");
						dFlag(d.noCompilation, "no-compilation");
					});
				});
				args.push(["--hl", outfile]);

			case Jvm:
				[["--jvm", outfile]];
			case Php(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dVal(d.front, "php-front");
						dVal(d.lib, "php-lib");
						dVal(d.prefix, "php-prefix");
						dFlag(d.sourceMap, "source-map");
						dFlag(d.realPosition, "real_position");
					});
				});
				args.push(["--php", outfile]);

			case Cpp(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.annotateSource, "annotate_source");
						dFlag(d.disableUnicodeStrings, "disable_unicode_strings");
						dFlag(d.dllExport, "dll_export");
						dFlag(d.dynamicInterfaceClosures, "dynamic_interface_closures");
						dVal(d.fileExtension, "file-extension");
						dFlag(d.forceNativeProperty, "force_native_property");
						dFlag(d.hxcppGcGenerational, "hxcpp_gc_generational");
						dFlag(d.hxcppDebugger, "hxcpp_debugger");
						dFlag(d.hxcppSmartString, "hxcpp_smart_strings");
						dFlag(d.includePrefix, "include_prefix");
						dFlag(d.noCompilation, "no-compilation");
						dFlag(d.noDebug, "no-debug");
						dFlag(d.objC, "objc");
					});
				});
				args.push(["--cpp", outfile]);

			case Lua(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.jit, "lua_jit");
						dFlag(d.vanilla, "lua_vanilla");
						dVal(d.luaVer, "lua_ver");
					});
				});
				args.push(["--lua", outfile]);

			case CSharp(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.coreApiSerialize, "core_api_serialize");
						dVal(d.csVer, "cs_ver");
						dFlag(d.dllImport, "dll_import");
						dFlag(d.eraseGenerics, "erase_generics");
						dFlag(d.fastCast, "fast_cast");
						dFlag(d.keepOldOutput, "keep_old_output");
						dVal(d.netVer, "net_ver");
						dVal(d.netcoreVer, "netcore_ver");
						dVal(d.netTarget, "net_target");
						dFlag(d.noCompilation, "no-compilation");
						dFlag(d.noRoot, "no_root");
						dFlag(d.realPosition, "real_position");
						dFlag(d.stdEncodingUtf8, "std-encoding-utf8");
						dFlag(d.unsafe, "unsafe");
					});
					opt.net.mayDo(net -> {
						net.libs.mayIter(e -> {
							args.push(["--net-lib", if (e.std == true) '${e.file}@std' else e.file]);
						});
						optVals(net.stds, "--net-std");
					});
					optVals(opt.cArgs, "--c-arg");
				});
				args.push(["--cs", outfile]);

			case Python(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dVal(d.pythonVer, "python_version");
						dFlag(d.stdEncodingUtf8, "std-encoding-utf8");
					});
				});
				args.push(["--python", outfile]);

			case Java(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.fastCast, "fast_cast");
						dVal(d.javaVer, "java_ver");
						dFlag(d.jvm, "jvm");
						dVal(d.jvmCompressionLevel, "jvm.compression-level");
						dVal(d.jvmDynamicLevel, "jvm.dynamic-level");
						dFlag(d.keepOldOutput, "keep_old_output");
						dFlag(d.noCompilation, "no-compilation");
						dFlag(d.realPosition, "real_position");
						dFlag(d.stdEncodingUtf8, "std-encoding-utf8");
					});
					optVals(opt.libs, "--java-lib");
					optVals(opt.cArgs, "--c-arg");
				});
				args.push(["--java", outfile]);

			case Flash(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.advancedTelemetry, "advanced-telemetry");
						dFlag(d.fdb, "fdb");
						dFlag(d.useStage, "flash_use_tage");
						dFlag(d.haxeBoot, "haxe_boot");
						dFlag(d.networkSandbox, "network-sandbox");
						dFlag(d.noOverride, "no-flash-override");
						dFlag(d.noSwfCompress, "no_swf_compress");
						dFlag(d.swc, "swc");
						dVal(d.swfCompressLevel, "swf_compress_level");
						dVal(d.swfDebugPassword, "swf_debug_password");
						dFlag(d.swfDirectBlit, "swf_direct_blit");
						dFlag(d.swfGpu, "swf_gpu");
						dVal(d.swfMetadata, "swf_metadata");
						dFlag(d.swfPreloaderFrame, "swf_preloader_frame");
						dFlag(d.swfProtected, "swf_protected");
						dVal(d.swfScriptTimeout, "swf_script_timeout");
						dFlag(d.swfUseDoAbc, "swf_use_doabc");
					});
					opt.swf.mayDo(swf -> {
						optVal(swf.version, "--swf-version");
						optVal(swf.header, "--swf-header");
						optVals(swf.libs, "--swf-lib");
						optVals(swf.libsExtern, "--swf-lib-extern");
					});
					optFlag(opt.strict, "--flash-strict");
				});
				args.push(["--swf", outfile]);

			case Neko(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.nekoSource, "neko_source");
						dFlag(d.nekoV1, "neko_v1");
						dFlag(d.useNekoc, "use_nekoc");
					});
				});
				args.push(["--neko", outfile]);

			case Cppia(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						dFlag(d.noCppiaAst, "nocppiaast");
					});
				});
				args.push(["--cppia", outfile]);
		}

		return args;
	}

	public static function defaultRunCommand(
		target: CompilerTarget
	): Null<(path: String) -> Array<String>> {
		return switch target {
			case HashLink(_): path -> ["hl", path];
			case Jvm: path -> [
					"java",
					"-jar",
					path
				];
			case Neko(_): path -> ["neko", path];
			case _: null;
		}
	}
}
