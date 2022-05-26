package hxargs;

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
	final input: HaxeInput;

	/**
		Options to be passed to the Haxe compiler.
	**/
	final options: HaxeOptions;

	/**
		Either `Interpret` or `Compile`.
	**/
	final mode: Mode;
}

class HaxeArgumentGroupExtension {
	/**
		Converts `HaxeArgumentGroup` to `Array<String>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(
		arguments: HaxeArgumentGroup
	): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		arguments.input.toCommandArguments().iter(args.push);

		arguments.options.toCommandArguments().iter(args.push);

		arguments.mode.toCommandArguments().iter(args.push); // This must be the last

		return args;
	}
}
