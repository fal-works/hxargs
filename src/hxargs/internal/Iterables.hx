package hxargs.internal;

inline function iter<T>(iterable: Iterable<T>, func: T->Void): Void {
	inline Lambda.iter(iterable, func);
}

inline function flatten<T>(iterable: Iterable<Iterable<T>>): Array<T>
	return Lambda.flatten(iterable); // already inline

inline function exists<T>(iterable: Iterable<T>, func: T->Bool): Bool
	return Lambda.exists(iterable, func);
