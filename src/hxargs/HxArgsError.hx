package hxargs;

class HxArgsError extends haxe.Exception {}

class HxArgsConflictError extends HxArgsError {
	public function new(?propertyName: String, ?previous: haxe.Exception) {
		final msg = 'Found merge conflict' + if (propertyName == null) "." else ': $propertyName';
		super(msg, previous);
	}
}
