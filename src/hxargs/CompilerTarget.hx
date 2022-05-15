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

			/** `-D unsafe` **/
			var ?unsafe: Bool;
		};
	});

	/** `--python` **/
	Python(?options: {
		var ?defines: {
			var ?pythonVer: String;
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
	Cppia;
}

class CompilerTargetExtension {
	public static function toCommandArguments(
		target: CompilerTarget,
		outfile: String
	): Array<Array<String>> {
		return switch target {
			case JavaScript(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.classic == true) ret.push(["-D", "js_classic"]);
						d.es.mayDo(x -> ret.push(["-D", 'js_es=${x}']));
						if (d.enumAsArrays == true) ret.push(["-D", "js_enums_as_arrays"]);
						if (d.unflatten == true) ret.push(["-D", "js_unflatten"]);
						if (d.shallowExpose == true) ret.push(["-D", "shallow-expose"]);
						if (d.sourceMap == true) ret.push(["-D", "source-map"]);
						if (d.sourceMapContent == true) ret.push(["-D", "source-map-content"]);
					});
				});
				ret.push(["--js", outfile]);
				ret;
			case HashLink(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						d.hlVer.mayDo(x -> ret.push(["-D", 'hl-ver=${x}']));
						if (d.noCompilation == true) ret.push(["-D", "no-compilation"]);
					});
				});
				ret.push(["--hl", outfile]);
				ret;
			case Jvm:
				[["--jvm", outfile]];
			case Php(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.sourceMap == true) ret.push(["-D", "source-map"]);
						if (d.realPosition == true) ret.push(["-D", "real_position"]);
					});
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
					});
				});
				ret.push(["--cpp", outfile]);
				ret;
			case Lua(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.jit == true) ret.push(["-D", "lua_jit"]);
						if (d.vanilla == true) ret.push(["-D", "lua_vanilla"]);
						d.luaVer.mayDo(x -> ret.push(["-D", 'lua_ver=${x}']));
					});
				});
				ret.push(["--lua", outfile]);
				ret;
			case CSharp(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.coreApiSerialize == true) ret.push(["-D", "core_api_serialize"]);
						d.csVer.mayDo(x -> ret.push(["-D", 'cs_ver=${x}']));
						if (d.dllImport == true) ret.push(["-D", "dll_import"]);
						if (d.eraseGenerics == true) ret.push(["-D", "erase_generics"]);
						if (d.fastCast == true) ret.push(["-D", "fast_cast"]);
						if (d.keepOldOutput == true) ret.push(["-D", "keep_old_output"]);
						d.netVer.mayDo(x -> ret.push(["-D", 'net_ver=${x}']));
						d.netcoreVer.mayDo(x -> ret.push(["-D", 'netcore_ver=${x}']));
						d.netTarget.mayDo(x -> ret.push(["-D", 'net_target=${x}']));
						if (d.noCompilation == true) ret.push(["-D", "no-compilation"]);
						if (d.noRoot == true) ret.push(["-D", "no_root"]);
						if (d.realPosition == true) ret.push(["-D", "real_position"]);
						if (d.unsafe == true) ret.push(["-D", "unsafe"]);
					});
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
			case Python(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						d.pythonVer.mayDo(x -> ret.push(["-D", 'python_version=${x}']));
					});
				});
				ret.push(["--python", outfile]);
				ret;
			case Java(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.fastCast == true) ret.push(["-D", "fast_cast"]);
						d.javaVer.mayDo(x -> ret.push(["-D", 'java_ver=${x}']));
						if (d.jvm == true) ret.push(["-D", "jvm"]);
						d.jvmCompressionLevel.mayDo(x -> {
							ret.push(["-D", 'jvm.compression-level=${x}']);
						});
						d.jvmDynamicLevel.mayDo(x -> ret.push(["-D", 'jvm.dynamic-level=${x}']));
						if (d.keepOldOutput == true) ret.push(["-D", "keep_old_output"]);
						if (d.noCompilation == true) ret.push(["-D", "no-compilation"]);
						if (d.realPosition == true) ret.push(["-D", "real_position"]);
					});
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
			case Neko(options):
				final ret = [];
				options.mayDo(opt -> {
					opt.defines.mayDo(d -> {
						if (d.nekoSource == true) ret.push(["-D", "neko_source"]);
						if (d.nekoV1 == true) ret.push(["-D", "neko_v1"]);
						if (d.useNekoc == true) ret.push(["-D", "use_nekoc"]);
					});
				});
				ret.push(["--neko", outfile]);
				ret;
			case Cppia:
				[["--cppia", outfile]];
		}
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
