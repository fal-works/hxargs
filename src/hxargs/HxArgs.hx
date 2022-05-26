package hxargs;

using Lambda;

class HxArgs {
	/**
		Just for type inference of `HaxeArguments`.
	**/
	@:noUsing
	public static inline function args(arguments: HaxeArguments): HaxeArguments {
		// type hint is required. See: https://github.com/HaxeFoundation/haxe/issues/10693
		return (arguments : HaxeArguments);
	}

	/**
		Invokes `haxe` command.
	**/
	public static function exec(arguments: HaxeArguments, printCommand = false): Void {
		final args = arguments.toCommandArguments().flatten();
		if (printCommand) Sys.println('haxe ${args.join(" ")}');
		Sys.command("haxe", args);
	}
}
