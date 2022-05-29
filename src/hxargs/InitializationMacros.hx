package hxargs;

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
		Converts `InitializationMacros` to `Array<Argument>` that can be passed to `haxe` command.
	**/
	public static function toCommandOptions(
		macros: InitializationMacros
	): Array<Argument> {
		final ret = [];

		maybe(macros.builtin).mayDo(a -> a.iter(x -> ret.push(x.toCommandOption())));
		maybe(macros.custom).mayDo(a -> a.iter(x -> ["--macro", x]));

		return ret;
	}
}
