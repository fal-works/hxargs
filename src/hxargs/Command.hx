package hxargs;

import haxe.SysTools;

/**
	Represents a command with arguments.
**/
@:structInit
class Command {
	public final command: String;
	public final arguments: Array<String> = [];

	/**
		Creates a new `Command` with additional arguments.

		The original instance remains unchanged.
	**/
	public function addArguments(args: Array<String>): Command {
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

		return Sys.command(command, arguments);
	}

	public function quote(): String {
		final quotedArgs = switch Sys.systemName() {
			case "Windows":
				arguments.map(token -> SysTools.quoteWinArg(token, true));
			case _:
				arguments.map(SysTools.quoteUnixArg);
		};

		return '${command} ${quotedArgs.join(" ")}';
	}

	public function toString(): String {
		return '${command} ${arguments.join(" ")}';
	}
}
