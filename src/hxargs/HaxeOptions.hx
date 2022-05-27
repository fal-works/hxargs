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

		maybe(options.defines).mayDo(defines -> {
			defines.toCommandOptions().iter(x -> args.push(x));
		});

		maybe(options.globals).mayDo(globals -> {
			globals.toCommandOptions().iter(x -> args.push(x));
		});

		return args;
	}
}
