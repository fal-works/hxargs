package hxargs;

class HxArgs {
	/**
		Just for type inference of `HaxeArgumentGroup`.
	**/
	public static inline function args(arguments: HaxeArgumentGroup): HaxeArgumentGroup {
		// type hint is required. See: https://github.com/HaxeFoundation/haxe/issues/10693
		return (arguments : HaxeArgumentGroup);
	}

	/**
		Just for type inference of `Hxml`.
	**/
	public static inline function hxml(instance: Hxml): Hxml {
		// type hint is required. See: https://github.com/HaxeFoundation/haxe/issues/10693
		return (instance : Hxml);
	}

	/**
		Invokes `haxe` command.

		@return Exit code.
	**/
	public static function exec(arguments: HaxeArgumentGroup, ?options: {
		var ?printCommand: Bool;
	}): Int {
		return arguments.toCommand().exec(options);
	}
}
