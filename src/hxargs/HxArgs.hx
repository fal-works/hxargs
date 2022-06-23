package hxargs;

class HxArgs {
	/**
		Just for type inference of `HaxeArgumentGroup`.
	**/
	public static function haxeArguments(arguments: HaxeArgumentGroup): HaxeArgumentGroup
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
	public static function executeHaxe(arguments: HaxeArgumentGroup, ?options: {
		var ?printCommand: Bool;
	}): Int {
		return arguments.toCommand().execute(options);
	}
}
