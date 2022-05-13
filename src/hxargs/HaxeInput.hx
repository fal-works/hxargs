package hxargs;

import hxargs.internal.Result;

using hxargs.internal.NullExtension;

@:using(HaxeInput.HaxeInputExtension)
typedef HaxeInput = {
	/**
		Directory paths where Haxe source files or packages can be found.
	**/
	final ?classPaths: Array<String>;

	/**
		Names of Haxe libraries.

		To require specific versions, use `name:version` or `name:git:url` instead of just `name`
		(this does not apply if you are using lix, which is an alternative package manager for Haxe).
	**/
	final ?libraries: Array<String>;

	/**
		Path to the main module, which has a `main()` function.
	**/
	final ?main: String;

	/**
		Paths to the entry point modules other than the main module.

		In most cases you don't need to specify this, but sometimes it is useful for:
		- compiling a project without a main module (such as libraries), or
		- compiling modules that are not reachable from the main module.

		@see https://code.haxe.org/category/compilation/compiling-libraries-without-main-class.html
	**/
	final ?entryPoints: Array<String>;
}

class HaxeInputExtension {
	/**
		@return `Ok` if valid, otherwise `Failed`.
	**/
	public static function validate(input: HaxeInput): Result<HaxeInput> {
		return if (input.main != null || {
			input.entryPoints.mapOr(false, x -> x.length > 0);
		}) Ok(input) else Failed("No entry point specified.");
	}

	/**
		Converts `HaxeInput` to `Array<Array<String>>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(input: HaxeInput): Array<Array<String>> {
		final args: Array<Array<String>> = [];

		input.classPaths.mayIter(path -> args.push(["-p", path]));
		input.libraries.mayIter(name -> args.push(["-lib", name]));
		input.main.mayDo(path -> args.push(["-m", path]));
		input.entryPoints.mayIter(path -> args.push([path]));

		return args;
	}
}
