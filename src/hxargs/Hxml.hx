package hxargs;

using StringTools;

/**
	Object representing the content of a `*.hxml` file.
**/
@:structInit
class Hxml {
	static function formatArgumentList(args: Array<Argument>): String {
		return args.map(arg -> arg.toString()).join("\n");
	}

	static function formatArgumentGroup(args: HaxeArgumentGroup): String {
		return args.toCommandArgumentSections()
			.map(formatArgumentList)
			.filter(s -> s.length > 0)
			.join("\n\n");
	}

	public var headerComment: String = "";
	public var commonArguments: HaxeArgumentGroup = {};
	public final argumentGroups: Array<HaxeArgumentGroup> = [];

	public inline function addNext(argumentGroup: HaxeArgumentGroup): Hxml {
		this.argumentGroups.push(argumentGroup);
		return this;
	}

	public function save(filepath: String) {
		sys.io.File.saveContent(filepath, this.toString());
	}

	public function toString(): String {
		final header = headerComment.split("\n").map(s -> '# $s').join("\n");
		final common = formatArgumentGroup(commonArguments);
		final groups = argumentGroups.map(formatArgumentGroup)
			.filter(s -> s.length > 0)
			.join("\n\n--next\n\n");

		var s = "";
		if (header.length > 0) {
			s += header + "\n\n";
		}
		if (common.length > 0) {
			s += common;
			if (groups.length > 0) s += "\n\n--each\n\n";
		}
		s += groups;

		if (!s.endsWith("\n")) s += "\n";

		return s;
	}
}
