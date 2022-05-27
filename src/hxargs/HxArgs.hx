package hxargs;

class HxArgs {
	/**
		Just for type inference of `HaxeArgumentGroup`.
	**/
	@:noUsing
	public static inline function args(arguments: HaxeArgumentGroup): HaxeArgumentGroup {
		// type hint is required. See: https://github.com/HaxeFoundation/haxe/issues/10693
		return (arguments : HaxeArgumentGroup);
	}

	/**
		Invokes `haxe` command.
	**/
	public static function exec(arguments: HaxeArgumentGroup, printCommand = false): Void {
		final args = arguments.toCommandArgumentSections()
			.map(section -> section.map(arg -> arg.toString()).join(" "));

		if (printCommand) Sys.println('haxe ${args.join(" ")}');
		Sys.command("haxe", args);
	}
}
