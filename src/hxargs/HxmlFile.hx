package hxargs;

/**
	Object representing a `*.hxml` file that has been saved.
**/
@:structInit
class HxmlFile {
	public final filepath: String;

	public function toCommand(): Command {
		return {
			command: "haxe",
			arguments: [filepath],
		};
	}
}
