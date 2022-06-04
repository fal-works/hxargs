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

	/**
		Header comment to be inserted at the beginning of the hxml file.
	**/
	public final headerComment: String = "";

	/**
		Arguments that will be applied with `--each`.
	**/
	public final commonArgumentGroup: HaxeArgumentGroup = {};

	/**
		List of `HaxeArgumentGroup` instances.
		If it has multiple elements, they will be joined with `--next`.
	**/
	public final argumentGroups: Array<HaxeArgumentGroup> = [];

	/**
		Creates a new `Hxml` instance by setting the `headerComment` property.

		The original instance remains unchanged.
	**/
	public function setHeaderComment(s: String): Hxml {
		return {
			headerComment: headerComment,
			commonArgumentGroup: this.commonArgumentGroup,
			argumentGroups: this.argumentGroups,
		};
	}

	/**
		Creates a new `Hxml` instance by setting the `commonArgumentGroup` property.

		The original instance remains unchanged.
	**/
	public function setEach(args: HaxeArgumentGroup): Hxml {
		return {
			headerComment: this.headerComment,
			commonArgumentGroup: args,
			argumentGroups: this.argumentGroups,
		};
	}

	/**
		Creates a new `Hxml` instance by appending `argumentGroup` to the `argumentGroups` property.

		The original instance remains unchanged.
	**/
	public inline function addNext(argumentGroup: HaxeArgumentGroup): Hxml {
		return {
			headerComment: this.headerComment,
			commonArgumentGroup: this.commonArgumentGroup,
			argumentGroups: this.argumentGroups.concat([argumentGroup]),
		};
	}

	/**
		Saves an hxml file.
		Overwrites the file if it already exists.

		@param filepath Any filepath (which typically ends with `.hxml`).
	**/
	public function save(filepath: String) {
		sys.io.File.saveContent(filepath, this.toString());
	}

	public function toString(): String {
		final header = headerComment.split("\n").map(s -> '# $s').join("\n");
		final common = formatArgumentGroup(commonArgumentGroup);
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
