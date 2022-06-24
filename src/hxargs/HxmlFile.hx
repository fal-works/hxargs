package hxargs;

/**
	Object representing a `*.hxml` file that has been saved.
**/
@:structInit
class HxmlFile {
	/**
		Filepath to a corresponding `*.hxml` file.
	**/
	public final filepath: String;

	/**
		Invokes `haxe` command.

		This is actually the same as `this.toCommand().execute()`.

		@return Exit code.
	**/
	public function execute(): Int
		return this.toCommand().execute();

	/**
		Converts `this` to a `haxe` command that can be executed on the CLI.
	**/
	public function toCommand(): Command {
		return {
			command: "haxe",
			arguments: [filepath],
		};
	}
}
