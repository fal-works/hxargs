package hxargs;

using hxargs.internal.LambdaInline;

@:using(HaxeOptions.HaxeOptionsExtension)
typedef HaxeOptions = {
	/**
		Names of conditional compilation flags.
	**/
	final ?defines: Array<Define>; // std or custom

	/**
		Other global arguments.
	**/
	final ?globals: GlobalArguments;
}

class HaxeOptionsExtension {
	public static function toCommandArguments(options: HaxeOptions): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		final defines = options.defines;
		if (defines != null) defines.iter(def -> args.push(def.toCommandOption()));

		final globals = options.globals;
		if (globals != null) globals.toCommandOptions().iter(x -> args.push(x));

		return args;
	}
}
