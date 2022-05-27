package hxargs;

using hxargs.internal.LambdaInline;

/**
	A full set of Haxe arguments.

	@see https://haxe.org/manual/compiler-usage.html
**/
@:using(hxargs.HxArgs)
@:using(HaxeArgumentGroup.HaxeArgumentGroupExtension)
typedef HaxeArgumentGroup = {
	/**
		Input data to be passed to the Haxe compiler.
	**/
	var ?input: HaxeInput;

	/**
		Options to be passed to the Haxe compiler.
	**/
	var ?options: HaxeOptions;

	/**
		List of `--cmd <command>` arguments.
	**/
	var ?commands: Array<String>;

	/**
		Lists of `--macro <expr>` arguments.
	**/
	var ?macros: InitializationMacros;

	/**
		Either `Interpret` or `Compile`.
	**/
	var ?mode: Mode;
}

class HaxeArgumentGroupExtension {
	/**
		Converts `HaxeArgumentGroup` to `Array<Array<String>>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(
		arguments: HaxeArgumentGroup
	): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		maybe(arguments.input).mayDo(input -> {
			input.toCommandArguments().iter(args.push);
		});

		maybe(arguments.options).mayDo(options -> {
			options.toCommandArguments().iter(args.push);
		});

		maybe(arguments.macros).mayDo(macros -> {
			macros.toCommandOptions().iter(x -> args.push(x));
		});

		maybe(arguments.commands).mayDo(commands -> {
			commands.iter(command -> args.push(["--cmd", command]));
		});

		// This must be the last
		maybe(arguments.mode).mayDo(mode -> {
			mode.toCommandArguments().iter(args.push);
		});

		return args;
	}
}
