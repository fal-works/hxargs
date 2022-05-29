package hxargs.internal;

using Std;

class Nulls {
	@:noUsing
	public static function merge<T>(
		a: Null<T>,
		b: Null<T>,
		?propertyName: String
	): Null<T> {
		return if (a == null || a == b) b else if (b == null) a else {
			if (a.isOfType(Bool)
				|| a.isOfType(Int)
				|| a.isOfType(Float)
				|| a.isOfType(String)) {
				throw new HxArgsConflictError(propertyName);
			} else if (a.isOfType(Array)) {
				cast mergePrimitiveArrays(
					cast a,
					cast b
				); // Assuming there is no array of objects
			} else {
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
				ret;
			}
		}
	}

	static function mergePrimitiveArrays<T>(a: Array<T>, b: Array<T>): Array<T> {
		final ret = a.copy();
		for (be in b) if (!ret.exists(re -> re == be)) ret.push(be);
		return ret;
	}
}
