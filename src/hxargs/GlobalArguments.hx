package hxargs;

// TODO: merge()

/**
	Haxe global arguments.

	@see https://haxe.org/manual/compiler-usage.html#other-global-arguments
**/
@:using(GlobalArguments.GlobalArgumentsExtension)
typedef GlobalArguments = {
	/** `--xml` **/
	var ?xml: String;

	/** `-v` / `--verbose` **/
	var ?verbose: Bool;

	/** `--dce <std|full|no>` **/
	var ?dce: DceValue;

	/** `--debug` **/
	var ?debug: Bool;

	/** `-r <file>[@name]` / `--resource <file>[@name]` **/
	var ?resources: Array<{
		var file: String;
		var ?name: String;
	}>;

	/** `--prompt` **/
	var ?prompt: Bool;

	/** `--no-traces` **/
	var ?noTraces: Bool;

	/** `--times` **/
	var ?times: Bool;

	/** `--no-inline` **/
	var ?noInline: Bool;

	/** `--no-opt` **/
	var ?noOpt: Bool;

	/** `--remap <package:target>` **/
	var ?remaps: Array<{
		var pkg: String;
		var target: String;
	}>;

	/** `--connect <host:port>` **/
	var ?connect: {
		var ?host: String;
		var port: Int;
	};

	/** `--cwd <dir>` **/
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

		maybe(args.xml).mayDo(file -> add(["--xml", file]));
		if (args.debug == true) add(["--debug"]);
		if (args.verbose == true) add(["-v"]);
		maybe(args.dce).mayDo(value -> add(["--dce", value]));
		maybe(args.resources).mayDo(a -> a.iter(res -> add([
			"-r",
			maybe(res.name).mapOr(res.file, name -> '${res.file}@${name}')
		])));
		if (args.prompt == true) add(["--prompt"]);
		if (args.noTraces == true) add(["--no-traces"]);
		if (args.times == true) add(["--times"]);
		if (args.noInline == true) add(["--no-inline"]);
		if (args.noOpt == true) add(["--no-opt"]);
		maybe(args.remaps).mayDo(a -> {
			a.iter(remap -> add(["--remap", '${remap.pkg}:${remap.target}']));
		});
		maybe(args.connect).mayDo(connect -> add([
			"--connect",
			maybe(connect.host).mapOr(
				'${connect.port}',
				host -> '${host}:${connect.port}'
			)
		]));
		maybe(args.cwd).mayDo(dir -> add(["--cwd", dir]));
		maybe(args.customs).mayDo(a -> a.iter(x -> add([x])));

		return options;
	}
}

enum abstract DceValue(String) to String {
	final Standard = "std";
	final Full = "full";
	final No = "no";
}
