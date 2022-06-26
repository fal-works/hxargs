package hxargs.types;

import haxe.extern.EitherType;

/**
	Collection of `-D` arguments that are not dependent on a specific target.
**/
@:using(Defines.DefinesExtension)
typedef Defines = {
	/**
		Built-in defines.
	**/
	var ?builtin: {
		/** `-D absolute_path` **/
		var ?absolutePath: Bool;

		/** `-D check_xml_proxy` **/
		var ?checkXmlProxy: Bool;

		/** `-D dce-debug` **/
		var ?dceDebug: Bool;

		/** `-D dump=<mode> **/
		var ?dump: String;

		/** `-D dump-dependencies` **/
		var ?dumpDependencies: Bool;

		/** `-D dump-ignore-var-ids` **/
		var ?dumpIgnoreVarIds: Bool;

		/** `-D dump-path=<path>` **/
		var ?dumpPath: String;

		/** `-D filter-times` **/
		var ?filterTimes: Bool;

		/** `-D keep-inline-positions` **/
		var ?keepInlinePositions: Bool;

		/** `-D loop-unroll-max-cost=<cost>` **/
		var ?loopUnrollMaxCost: Int;

		/** `-D macro-times` **/
		var ?macroTimes: Bool;

		/** `-D no-deprecation-warnings` **/
		var ?noDeprecationWarnings: Bool;

		/** `-D no-macro-cache` **/
		var ?noMacroCache: Bool;

		/** `-D no-tre` **/
		var ?noTre: Bool;

		/** `-D old-error-format` **/
		var ?oldErrorFormat: Bool;

		/** `-D source-header=<value>` **/
		var ?sourceHeader: String;

		/** `-D warn-var-shadowing` **/
		var ?warnVarShadowing: Bool;
	};

	/**
		Custom defines.
	**/
	var ?custom: Array<CustomDefine>;
}

class DefinesExtension {
	/**
		Converts `Defines` to `Array<Argument>` that can be passed to `haxe` command.
	**/
	public static function toCommandOptions(defines: Defines): Array<Argument> {
		final list: Array<String> = [];

		maybe(defines.builtin).mayDo(d -> {
			if (d.absolutePath == true) list.push("absolute_path");
			if (d.checkXmlProxy == true) list.push("check_xml_proxy");
			if (d.dceDebug == true) list.push("dce-debug");
			maybe(d.dump).mayDo(x -> list.push('dump=${x}'));
			if (d.dumpDependencies == true) list.push("dump-dependencies");
			if (d.dumpIgnoreVarIds == true) list.push("dump-ignore-var-ids");
			maybe(d.dumpPath).mayDo(x -> list.push('dump-path=${x}'));
			if (d.filterTimes == true) list.push("filter-times");
			if (d.keepInlinePositions == true) list.push("keep-inline-positions");
			maybe(d.loopUnrollMaxCost).mayDo(x -> list.push('loop-unroll-max-cost=${x}'));
			if (d.macroTimes == true) list.push("macro-times");
			if (d.noDeprecationWarnings == true) list.push("no-deprecation-warnings");
			if (d.noMacroCache == true) list.push("no-macro-cache");
			if (d.noTre == true) list.push("no-tre");
			if (d.oldErrorFormat == true) list.push("old-error-format");
			maybe(d.sourceHeader).mayDo(x -> list.push('source-header=${x}'));
			if (d.warnVarShadowing == true) list.push("warn-var-shadowing");
		});

		maybe(defines.custom).mayDo(x -> x.iter(d -> list.push(d.toString())));

		return list.map(x -> ["-D", x]);
	}
}

/**
	Value representing a custom `-D` argument.
**/
@:using(Defines.CustomDefineExtension)
enum CustomDefine {
	Flag(name: String);
	Value(name: String, ?value: E3<String, Int, Float>);
}

typedef E3<T1, T2, T3> = EitherType<EitherType<T1, T2>, T3>;

class CustomDefineExtension {
	/**
		Converts `CustomDefine` to `String`.
	**/
	public static function toString(define: CustomDefine): String {
		return switch define {
			case Flag(name): name;
			case Value(name, value): '$name=$value';
		}
	}
}
