package hxargs;

using hxargs.HaxeInput;
using hxargs.HaxeOptions;
using hxargs.InitializationMacros;
using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

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

		arguments.input.mayDo(input -> input.toCommandArguments().iter(args.push));

		arguments.options.mayDo(options -> options.toCommandArguments().iter(args.push));

		arguments.macros.mayDo(macros -> macros.toCommandOptions().iter(x -> args.push(x)));

		arguments.commands.mayIter(command -> args.push(["--cmd", command]));

		// This must be the last
		arguments.mode.mayDo(mode -> mode.toCommandArguments().iter(args.push));

		return args;
	}
}
