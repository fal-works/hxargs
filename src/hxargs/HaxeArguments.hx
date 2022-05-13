package hxargs;

using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

/**
	Object representing Haxe arguments.

	@see https://haxe.org/manual/compiler-usage.html
**/
@:using(hxargs.HxArgs)
@:using(HaxeArguments.HaxeArgumentsExtension)
typedef HaxeArguments = {
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

class HaxeArgumentsExtension {
	/**
		Converts `HaxeArguments` to `Array<String>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(arguments: HaxeArguments): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		arguments.input.toCommandArguments().iter(args.push);

		arguments.options.toCommandArguments().iter(args.push);

		arguments.mode.toCommandArguments().iter(args.push); // This must be the last

		return args;
	}
}
