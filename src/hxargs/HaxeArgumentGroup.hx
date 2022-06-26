package hxargs;

import hxargs.cli.Command;
import hxargs.internal.Nulls;
import hxargs.types.*;

/**
	A full set of Haxe arguments.

	@see https://haxe.org/manual/compiler-usage.html
**/
@:using(HaxeArgumentGroup.HaxeArgumentGroupExtension)
typedef HaxeArgumentGroup = {
	/**
		Filepaths to `*.hxml` files.

		Limitation: The filepaths will always be inserted as the first arguments.
	**/
	var ?baseHxmls: Array<String>;

	/**
		Input data to be passed to the Haxe compiler.
	**/
	var ?input: HaxeInput;

	/**
		Options to be passed to the Haxe compiler.
	**/
	var ?options: HaxeOptions;

	/**
		List of `--cmd <command>` arguments.
	**/
	var ?commands: Array<String>;

	/**
		Lists of `--macro <expr>` arguments.
	**/
	var ?macros: InitializationMacros;

	/**
		Either `Interpret` or `Compile`.
	**/
	var ?mode: Mode;
}

class HaxeArgumentGroupExtension {
	/**
		Invokes `haxe` command.

		This is actually the same as `this.toCommand().execute()`.

		@return Exit code.
	**/
	public static function execute(arguments: HaxeArgumentGroup): Int
		return toCommand(arguments).execute();

	/**
		Converts `HaxeArgumentGroup` to a `haxe` command that can be executed on the CLI.
	**/
	public static function toCommand(arguments: HaxeArgumentGroup): Command {
		return {
			command: "haxe",
			arguments: arguments.toCommandArguments(),
		};
	}

	/**
		Converts `HaxeArgumentGroup` to `Array<Argument>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(
		arguments: HaxeArgumentGroup
	): Array<Argument> {
		return toCommandArgumentSections(arguments).flatten();
	}

	/**
		Converts `HaxeArgumentGroup` to `Array<Array<Argument>>` that can be passed to `haxe` command.
	**/
	public static function toCommandArgumentSections(
		arguments: HaxeArgumentGroup
	): Array<Array<Argument>> {
		final runWithArgs = maybe(arguments.mode).mapOr(
			false,
			mode -> mode.hasOwnArguments()
		);
		final main = maybe(arguments.input).flatMap(input -> input.main);

		final baseHxmls = maybe(arguments.baseHxmls).map(x -> x.map(path -> {
			return ([path] : Argument);
		}));
		final input = maybe(arguments.input).map(x -> x.toCommandArguments(!runWithArgs));
		final options = maybe(arguments.options).map(x -> x.toCommandArguments());
		final macros = maybe(arguments.macros).map(x -> x.toCommandOptions());
		final commands = maybe(arguments.commands).map(x -> {
			return x.map(s -> (["--cmd", s] : Argument));
		});
		final mode = maybe(arguments.mode).map(x -> x.toCommandArguments(main));

		final sections: Array<Maybe<Array<Argument>>> = [
			baseHxmls,
			input,
			options,
			macros
		];
		if (runWithArgs) {
			sections.push(commands);
			sections.push(mode);
		} else {
			sections.push(mode);
			sections.push(commands);
		}

		return sections.map(x -> x.orElse(() -> [])).filter(x -> x.length > 0);
	}

	/**
		Creates a new `Hxml` instance.
	**/
	public static function toHxml(arguments: HaxeArgumentGroup, ?options: {
		var ?headerComment: String;
	}): Hxml {
		final opt = maybe(options).orElse(() -> {});

		return {
			headerComment: opt.headerComment,
			argumentGroups: [arguments],
		}
	}

	/**
		Creates a new `HaxeArgumentGroup` instance by merging all properties recursively.

		The original instance remains unchanged.

		Throws error if any conflict is found.
	**/
	public static function merge(
		_this: HaxeArgumentGroup,
		other: HaxeArgumentGroup
	): HaxeArgumentGroup {
		final ret = Nulls.merge(_this, other);
		if (ret == null)
			throw new HxArgsError("Failed to merge HaxeArgumentGroup instances.");

		return ret;
	}
}
