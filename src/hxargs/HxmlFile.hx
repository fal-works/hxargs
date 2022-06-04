package hxargs;

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
