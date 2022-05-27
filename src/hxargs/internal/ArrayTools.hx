package hxargs.internal;

inline function ifNonEmpty<T>(array: Array<T>, func: Array<T>->Void): Void
	if (array.length > 0) func(array);
