package hxargs;

class HxArgs {
	/**
		Just for type inference of `HaxeArgumentGroup`.
	**/
	public static function args(arguments: HaxeArgumentGroup): HaxeArgumentGroup
		return arguments;

	/**
		Just for type inference of `Hxml`.
	**/
	public static function hxml(instance: Hxml): Hxml
		return instance;

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
