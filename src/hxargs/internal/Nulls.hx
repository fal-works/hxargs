package hxargs.internal;

class Nulls {
	@:noUsing
	public static function merge<T>(
		a: Null<T>,
		b: Null<T>,
		?propertyName: String
	): Null<T> {
		return if (a == null || a == b) {
			b;
		} else if (b == null) {
			a;
		} else if (Std.isOfType(a, Array)) {
			cast concatArrays(cast a, cast b);
		} else switch Type.typeof(a) {
			case TObject: mergeObjects(a, b);
			case _: throw new HxArgsConflictError(propertyName);
		}
	}

	static function concatArrays<T>(a: Array<T>, b: Array<T>): Array<T>
		return a.concat(b);

	static function mergeObjects(a: Dynamic, b: Dynamic): Dynamic {
		final ret: Dynamic = {};
		for (key in Reflect.fields(a)) {
			Reflect.setField(ret, key, Reflect.field(a, key));
		}
		for (key in Reflect.fields(b)) {
			final newValue = merge(
				Reflect.field(ret, key),
				Reflect.field(b, key),
				key
			);
			if (newValue != null) Reflect.setField(ret, key, newValue);
		}
		return ret;
	}
}
