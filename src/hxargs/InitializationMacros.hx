package hxargs;

using hxargs.internal.NullExtension;

/**
	Collection of initialization macros to be applied before typing.
**/
@:using(InitializationMacros.InitializationMacrosExtension)
typedef InitializationMacros = {
	/**
		List of built-in initialization macros.
	**/
	final ?builtin: Array<BuiltinInitializationMacro>;

	/**
		List of custom initialization macros.

		Each element should be a call expression string, e.g. `"yourPackage.yourMacroFunction(arg1, arg2)"`
	**/
	final ?custom: Array<String>;
}

class InitializationMacrosExtension {
	/**
		Converts `InitializationMacros` to `Array<Array<String>>` that can be passed to `haxe` command.
	**/
	public static function toCommandOptions(
		macros: InitializationMacros
	): Array<Array<String>> {
		final ret = [];

		macros.builtin.mayIter(x -> ret.push(x.toCommandOption()));
		macros.custom.mayIter(x -> ["--macro", x]);

		return ret;
	}
}
