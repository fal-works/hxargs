package hxargs.cli;

/**
	Command-line argument unit consisting of multiple tokens, e.g. `--main Main`.
**/
@:notNull @:transitive
abstract Argument(Array<String>) from Array<String> to Array<String> {
	public function toString(): String
		return this.join(" ");
}
