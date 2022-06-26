package hxargs.cli;

import haxe.SysTools;

/**
	Represents a command with arguments.
**/
@:structInit
class Command {
	public final command: String;
	public final arguments: Array<Argument> = [];

	/**
		Creates a new `Command` with additional arguments.

		The original instance remains unchanged.
	**/
	public function addArguments(args: Array<Argument>): Command {
		return {
			command: command,
			arguments: arguments.concat(args),
		};
	}

	/**
		Executes `this` command on the CLI.

		@return Exit code.
	**/
	public function execute(): Int {
		if (Config.printBeforeExecution) Sys.println(this.quote());

		return Sys.command(command, arguments.flatten());
	}

	public function quote(): String {
		final argTokens = arguments.flatten();
		final quotedArgs = switch Sys.systemName() {
			case "Windows":
				argTokens.map(token -> SysTools.quoteWinArg(token, true));
			case _:
				argTokens.map(SysTools.quoteUnixArg);
		};

		return '${command} ${quotedArgs.join(" ")}';
	}

	public function toString(): String {
		return '${command} ${arguments.flatten().join(" ")}';
	}
}
