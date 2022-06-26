package hxargs;

/**
	Exception that may be thrown from `hxargs`.
**/
class HxArgsError extends haxe.Exception {}

/**
	Exception that may be thrown if any conflict is found when merging objects.
**/
class HxArgsConflictError extends HxArgsError {
	public function new(?propertyName: String, ?previous: haxe.Exception) {
		final msg = 'Found merge conflict'
			+ if (propertyName == null) "." else ': $propertyName';
		super(msg, previous);
	}
}
