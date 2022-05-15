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
		var ?front: String;
		var ?lib: String;
		var ?prefix: String;
		var ?defines: {
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
		inline function addDef(s: String): Void
			args.push(["-D", s]);

		switch target {
			case JavaScript(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.classic == true) addDef("js_classic");
						d.es.mayDo(x -> addDef('js_es=${x}'));
						if (d.enumAsArrays == true) addDef("js_enums_as_arrays");
						d.global.mayDo(x -> addDef('js_global=${x}'));
						if (d.unflatten == true) addDef("js_unflatten");
						if (d.shallowExpose == true) addDef("shallow-expose");
						if (d.sourceMap == true) addDef("source-map");
						if (d.sourceMapContent == true) addDef("source-map-content");
					});
				});
				args.push(["--js", outfile]);

			case HashLink(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						d.hlVer.mayDo(x -> addDef('hl-ver=${x}'));
						if (d.noCompilation == true) addDef("no-compilation");
					});
				});
				args.push(["--hl", outfile]);

			case Jvm:
				[["--jvm", outfile]];
			case Php(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.sourceMap == true) addDef("source-map");
						if (d.realPosition == true) addDef("real_position");
					});
					opt.front.mayDo(x -> addDef('php-front=${x}'));
					opt.lib.mayDo(x -> addDef('php-lib=${x}'));
					opt.prefix.mayDo(x -> addDef('php-prefix=${x}'));
				});
				args.push(["--php", outfile]);

			case Cpp(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.annotateSource == true) addDef("annotate_source");
						if (d.disableUnicodeStrings == true)
							addDef("disable_unicode_strings");
						if (d.dllExport == true) addDef("dll_export");
						if (d.dynamicInterfaceClosures == true)
							addDef("dynamic_interface_closures");
						d.fileExtension.mayDo(x -> addDef('file-extension=${x}'));
						if (d.forceNativeProperty == true) addDef("force_native_property");
						if (d.hxcppGcGenerational == true) addDef("hxcpp_gc_generational");
						if (d.hxcppDebugger == true) addDef("hxcpp_debugger");
						if (d.hxcppSmartString == true) addDef("hxcpp_smart_strings");
						if (d.includePrefix == true) addDef("include_prefix");
						if (d.noCompilation == true) addDef("no-compilation");
						if (d.noDebug == true) addDef("no-debug");
						if (d.objC == true) addDef("objc");
					});
				});
				args.push(["--cpp", outfile]);

			case Lua(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.jit == true) addDef("lua_jit");
						if (d.vanilla == true) addDef("lua_vanilla");
						d.luaVer.mayDo(x -> addDef('lua_ver=${x}'));
					});
				});
				args.push(["--lua", outfile]);

			case CSharp(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.coreApiSerialize == true) addDef("core_api_serialize");
						d.csVer.mayDo(x -> addDef('cs_ver=${x}'));
						if (d.dllImport == true) addDef("dll_import");
						if (d.eraseGenerics == true) addDef("erase_generics");
						if (d.fastCast == true) addDef("fast_cast");
						if (d.keepOldOutput == true) addDef("keep_old_output");
						d.netVer.mayDo(x -> addDef('net_ver=${x}'));
						d.netcoreVer.mayDo(x -> addDef('netcore_ver=${x}'));
						d.netTarget.mayDo(x -> addDef('net_target=${x}'));
						if (d.noCompilation == true) addDef("no-compilation");
						if (d.noRoot == true) addDef("no_root");
						if (d.realPosition == true) addDef("real_position");
						if (d.stdEncodingUtf8 == true) addDef("std-encoding-utf8");
						if (d.unsafe == true) addDef("unsafe");
					});
					opt.net.mayDo(net -> {
						net.libs.mayIter(e -> {
							args.push(["--net-lib", if (e.std == true) '${e.file}@std' else e.file]);
						});
						net.stds.mayIter(x -> args.push(["--net-std", x]));
					});
					opt.cArgs.mayIter(x -> args.push(["--c-arg", x]));
				});
				args.push(["--cs", outfile]);

			case Python(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						d.pythonVer.mayDo(x -> addDef('python_version=${x}'));
						if (d.stdEncodingUtf8 == true) addDef("std-encoding-utf8");
					});
				});
				args.push(["--python", outfile]);

			case Java(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.fastCast == true) addDef("fast_cast");
						d.javaVer.mayDo(x -> addDef('java_ver=${x}'));
						if (d.jvm == true) addDef("jvm");
						d.jvmCompressionLevel.mayDo(x -> {
							addDef('jvm.compression-level=${x}');
						});
						d.jvmDynamicLevel.mayDo(x -> addDef('jvm.dynamic-level=${x}'));
						if (d.keepOldOutput == true) addDef("keep_old_output");
						if (d.noCompilation == true) addDef("no-compilation");
						if (d.realPosition == true) addDef("real_position");
						if (d.stdEncodingUtf8 == true) addDef("std-encoding-utf8");
					});
					opt.libs.mayIter(x -> args.push(["--java-lib", x]));
					opt.cArgs.mayIter(x -> args.push(["--c-arg", x]));
				});
				args.push(["--java", outfile]);

			case Flash(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.advancedTelemetry == true) addDef("advanced-telemetry");
						if (d.fdb == true) addDef("fdb");
						if (d.useStage == true) addDef("flash_use_tage");
						if (d.haxeBoot == true) addDef("haxe_boot");
						if (d.networkSandbox == true) addDef("network-sandbox");
						if (d.noOverride == true) addDef("no-flash-override");
						if (d.noSwfCompress == true) addDef("no_swf_compress");
						if (d.swc == true) addDef("swc");
						d.swfCompressLevel.mayDo(x -> addDef('swf_compress_level=${x}'));
						d.swfDebugPassword.mayDo(x -> addDef('swf_debug_password=${x}'));
						if (d.swfDirectBlit == true) addDef("swf_direct_blit");
						if (d.swfGpu == true) addDef("swf_gpu");
						d.swfMetadata.mayDo(x -> addDef('swf_metadata=${x}'));
						if (d.swfPreloaderFrame == true) addDef("swf_preloader_frame");
						if (d.swfProtected == true) addDef("swf_protected");
						d.swfScriptTimeout.mayDo(x -> addDef('swf_script_timeout=${x}'));
						if (d.swfUseDoAbc == true) addDef("swf_use_doabc");
					});
					opt.swf.mayDo(swf -> {
						swf.version.mayDo(x -> args.push(["--swf-version", x]));
						swf.header.mayDo(x -> args.push(["--swf-header", x]));
						swf.libs.mayIter(x -> args.push(["--swf-lib", x]));
						swf.libsExtern.mayIter(x -> args.push(["--swf-lib-extern", x]));
					});
					if (opt.strict == true) args.push(["--flash-strict"]);
				});
				args.push(["--swf", outfile]);

			case Neko(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.nekoSource == true) addDef("neko_source");
						if (d.nekoV1 == true) addDef("neko_v1");
						if (d.useNekoc == true) addDef("use_nekoc");
					});
				});
				args.push(["--neko", outfile]);

			case Cppia(options):
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.noCppiaAst == true) addDef("nocppiaast");
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
