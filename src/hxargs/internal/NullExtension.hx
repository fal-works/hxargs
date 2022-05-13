package hxargs.internal;

using hxargs.internal.LambdaInline;

inline function doOrElse<T>(
	x: Null<T>,
	ifNull: () -> Void,
	ifSome: T->Void
): Void {
	if (x != null) ifSome(x) else ifNull();
}

inline function mapOr<T, U>(
	x: Null<T>,
	defaultValue: U,
	func: T->U
): U {
	return if (x != null) func(x) else defaultValue;
}

inline function mapOrElse<T, U>(
	x: Null<T>,
	getDefault: () -> U,
	func: T->U
): U {
	return if (x != null) func(x) else getDefault();
}

inline function coalesce<T>(x: Null<T>, other: Null<T>): Null<T>
	return if (x != null) x else other;

inline function coalesceWith<T>(x: Null<T>, func: () -> Null<T>): Null<T>
	return if (x != null) x else func();

inline function mayDo<T>(x: Null<T>, func: T->Void): Void
	if (x != null) func(x);

inline function mayIter<T>(x: Null<Array<T>>, func: T->Void): Void
	mayDo(x, array -> array.iter(func));

inline function orNew<T>(x: Null<Array<T>>): Array<T>
	return if (x != null) x else [];
