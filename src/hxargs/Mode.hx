package hxargs;

using hxargs.internal.LambdaInline;

@:using(Mode.ModeExtension)
enum Mode {
	Compile(compilerMode: CompilerMode, target: CompilerTarget);
	Interpret(interpreterMode: InterpreterMode, ?options: {
		var ?defines: {
			/** `-D eval-call-stack-depth=<depth>` **/
			var ?callStackDepth: Int;

			/** `-D eval-debugger=[host:port]` **/
			var ?debugger: Any;

			/** `-D eval-stack` **/
			var ?stack: Bool;

			/** `-D eval-times` **/
			var ?times: Bool;
		};
	});
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
						maybe(run).coalesceWith(() -> target.defaultRunCommand())
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

			case Interpret(interpreterMode, options):
				maybe(options).mayDo(opt -> {
					maybe(opt.defines).mayDo(d -> {
						maybe(d.callStackDepth).mayDo(x -> {
							args.push(["-D", 'eval-call-stack-depth=${x}']);
						});
						maybe(d.debugger).mayDo(x -> {
							final hasValue = Std.isOfType(x, Int) || Std.isOfType(x, String);
							if (hasValue) args.push(["-D", 'eval-debugger=${x}']);
							else if (x != false) args.push(["-D", "eval-debugger"]);
						});
						if (d.stack == true) args.push(["-D", "eval-stack"]);
						if (d.times == true) args.push(["-D", "eval-times"]);
					});
				});
				switch interpreterMode {
					case Run:
						args.push(["--interp"]);
					case RunWithArguments(runArgs):
						maybe(main).doOrElse(
							() -> throw new HxArgsError("Missing main module."),
							m -> {
								args.push(["--run", m]);
								maybe(runArgs).mayDo(a -> a.iter(s -> args.push([s])));
							}
						);
					case Display(file, position, displayMode):
						args.push(["--interp"]); // how about --run ?
						var displayArg = '$file@$position';
						if (displayMode != null) displayArg = '$displayArg@$displayMode';
						args.push(["--display", displayArg]);
				}
		}

		return args;
	}

	/**
		Returns `true` if this mode has its own arguments (i.e. corresponds to a `--run` argument).
	**/
	public static function hasOwnArguments(mode: Mode): Bool {
		return switch mode {
			case Compile(_, _):
				false;
			case Interpret(interpreterMode, _):
				switch interpreterMode {
					case Run: false;
					case RunWithArguments(_): true;
					case Display(_, _, _): false;
				}
		};
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
