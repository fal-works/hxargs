package hxargs;

import haxe.SysTools;

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
		Just for type inference of `Hxml`.
	**/
	@:noUsing
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
		final args = arguments.toCommandArgumentSections().flatten().flatten();

		if (options != null) {
			if (options.printCommand == true) {
				final quotedArgs = switch Sys.systemName() {
					case "Windows":
						args.map(token -> SysTools.quoteWinArg(token, true));
					case _:
						args.map(SysTools.quoteUnixArg);
				};
				Sys.println('haxe ${quotedArgs.join(" ")}');
			}
		}

		return Sys.command("haxe", args);
	}
}
