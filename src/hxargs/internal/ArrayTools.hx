package hxargs.internal;

inline function nullIfEmpty<T>(array: Array<T>): Null<Array<T>>
	return if (array.length > 0) array else null;
