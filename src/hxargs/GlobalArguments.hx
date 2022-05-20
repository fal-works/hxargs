package hxargs;

using hxargs.InitializationMacros;
using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

// TODO: merge()

/**
	Haxe global arguments.

	@see https://haxe.org/manual/compiler-usage.html#other-global-arguments
**/
@:using(GlobalArguments.GlobalArgumentsExtension)
typedef GlobalArguments = {
	var ?xml: String;
	var ?verbose: Bool;
	var ?dce: DceValue;
	var ?debug: Bool;
	var ?resources: Array<{
		var file: String;
		var ?name: String;
	}>;
	var ?prompt: Bool;
	var ?commands: Array<String>;
	var ?macros: InitializationMacros;
	var ?noTraces: Bool;
	var ?times: Bool;
	var ?noInline: Bool;
	var ?noOpt: Bool;
	var ?remaps: Array<{
		var pkg: String;
		var target: String;
	}>;
	var ?connect: {
		var ?host: String;
		var port: Int;
	};
	var ?cwd: String;

	/**
		Any command-line options that start with `-` or `--`.
	**/
	var ?customs: Array<String>;
}

class GlobalArgumentsExtension {
	/**
		Converts `GlobalArgument` to `Array<Array<String>>` that can be passed to `haxe` command.
	**/
	public static function toCommandOptions(args: GlobalArguments): Array<Array<String>> {
		final options: Array<Array<String>> = [];
		inline function add(option: Array<String>): Void
			options.push(option);

		args.xml.mayDo(file -> add(["--xml", file]));
		if (args.debug == true) add(["--debug"]);
		if (args.verbose == true) add(["-v"]);
		args.dce.mayDo(value -> add(["--dce", value]));
		args.resources.mayIter(res -> add([
			"-r",
			res.name.mapOr(res.file, name -> '${res.file}@${name}')
		]));
		if (args.prompt == true) add(["--prompt"]);
		args.macros.mayDo(macros -> macros.toCommandOptions().iter(x -> add(x)));
		args.commands.mayIter(command -> add(["--cmd", command]));
		if (args.noTraces == true) add(["--no-traces"]);
		if (args.times == true) add(["--times"]);
		if (args.noInline == true) add(["--no-inline"]);
		if (args.noOpt == true) add(["--no-opt"]);
		args.remaps.mayIter(remap -> add(["--remap", '${remap.pkg}:${remap.target}']));
		args.connect.mayDo(connect -> add([
			"--connect",
			connect.host.mapOr('${connect.port}', host -> '${host}:${connect.port}')
		]));
		args.cwd.mayDo(dir -> add(["--cwd", dir]));
		args.customs.mayIter(x -> add([x]));

		return options;
	}
}

enum abstract DceValue(String) to String {
	final Standard = "std";
	final Full = "full";
	final No = "no";
}
