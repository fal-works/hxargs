package hxargs;

using hxargs.internal.LambdaInline;

@:using(HaxeOptions.HaxeOptionsExtension)
typedef HaxeOptions = {
	/**
		Conditional compilation flags.
	**/
	final ?defines: Defines;

	/**
		Other global arguments.
	**/
	final ?globals: GlobalArguments;
}

class HaxeOptionsExtension {
	public static function toCommandArguments(options: HaxeOptions): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		final defines = options.defines;
		if (defines != null) defines.toCommandOptions().iter(x -> args.push(x));

		final globals = options.globals;
		if (globals != null) globals.toCommandOptions().iter(x -> args.push(x));

		return args;
	}
}
