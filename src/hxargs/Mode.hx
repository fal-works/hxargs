package hxargs;

using hxargs.internal.LambdaInline;
using hxargs.internal.NullExtension;

@:using(Mode.ModeExtension)
enum Mode {
	Compile(compilerMode: CompilerMode, target: CompilerTarget);
	Interpret(interpreterMode: InterpreterMode);
}

class ModeExtension {
	/**
		Converts `Mode` to `Array<Array<String>>` that can be passed to `haxe` command.
	**/
	public static function toCommandArguments(
		mode: Mode,
		?main: String
	): Array<Array<String>> {
		final args: Array<Array<String>> = [];
		switch mode {
			case Compile(compilerMode, target):
				var outfile: String;
				final options: Array<Array<String>> = [];
				switch compilerMode {
					case Build(path):
						outfile = path;
					case BuildAndRun(path, run):
						outfile = path;
						run.coalesceWith(() -> target.defaultRunCommand())
							.mayDo(getCommand -> options.push(["--cmd"].concat(getCommand(path))));
					case NoOutput:
						outfile = "_";
						options.push(["--no-output"]);
					case Display(file, position, displayMode):
						outfile = "_";
						var displayArg = '$file@$position';
						if (displayMode != null) displayArg = '$displayArg@$displayMode';
						options.push(["--display", displayArg]);
				}
				target.toCommandArguments(outfile).iter(x -> args.push(x));
				options.iter(x -> args.push(x));

			case Interpret(interpreterMode):
				switch interpreterMode {
					case Run:
						args.push(["--interp"]);
					case RunWithArguments(runArgs):
						main.doOrElse(
							() -> throw new HxArgsError("Missing main module."),
							m -> {
								args.push(["--run", m]);
								runArgs.mayIter(s -> args.push([s]));
							}
						);
					case Macro:
					case Display(file, position, displayMode):
						args.push(["--interp"]); // how about --run ?
						var displayArg = '$file@$position';
						if (displayMode != null) displayArg = '$displayArg@$displayMode';
						args.push(["--display", displayArg]);
				}
		}

		return args;
	}
}

enum CompilerMode {
	/**
		Generate the compilation result in specified file/directory.
	**/
	Build(path: String);

	/**
		Generate the compilation result in specified file/directory and then runs it.

		@param run Function that returns a command-line which executes the generated program.
			Can be omitted when JS, Java, neko or HashLink.
	**/
	BuildAndRun(path: String, ?run: (path: String) -> Array<String>);

	/**
		Compiles but does not generate any file.
	**/
	NoOutput;

	/**
		Outputs completion information.
		Corresponds to the `--display` argument.

		@see https://haxe.org/manual/cr-completion-overview.html
	**/
	Display(
		file: String,
		position: Int,
		?mode: String
	);
}

enum InterpreterMode {
	/**
		Runs the main module.
		Corresponds to the `--interp` argument.
	**/
	Run;

	/**
		Runs the main module with subsequent command line arguments.
		Corresponds to the `--run` argument.

		@param args Command line arguments that will always be passed.
	**/
	RunWithArguments(?args: Array<String>);

	/**
		Just interpret. Used for just invoking the macro.
	**/
	Macro;

	/**
		Outputs completion information.
		Corresponds to the `--display` argument.

		@see https://haxe.org/manual/cr-completion-overview.html
	**/
	Display(
		file: String,
		position: Int,
		?mode: String
	);
}
