package hxargs;

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
		Converts `HaxeArgumentGroup` to `Array<Array<Argument>>` that can be passed to `haxe` command.
	**/
	public static function toCommandArgumentSections(
		arguments: HaxeArgumentGroup
	): Array<Array<Argument>> {
		final sections: Array<Array<Argument>> = [];
		final runWithArgs = maybe(arguments.mode).mapOr(
			false,
			mode -> mode.hasOwnArguments()
		);
		final main = maybe(arguments.input).flatMap(input -> input.main);

		maybe(arguments.input).mayDo(input -> {
			input.toCommandArguments(!runWithArgs).ifNonEmpty(x -> sections.push(x));
		});

		maybe(arguments.options).mayDo(options -> {
			options.toCommandArguments().ifNonEmpty(x -> sections.push(x));
		});

		maybe(arguments.macros).mayDo(macros -> {
			macros.toCommandOptions().ifNonEmpty(x -> sections.push(x));
		});

		maybe(arguments.commands).mayDo(commands -> {
			commands.ifNonEmpty(x -> sections.push(x.map(s -> ["--cmd", s])));
		});

		// This must be the last
		maybe(arguments.mode).mayDo(mode -> {
			mode.toCommandArguments(main).ifNonEmpty(x -> sections.push(x));
		});

		return sections;
	}
}
