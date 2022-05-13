package hxargs.internal;

inline function iter<T>(iterable:Iterable<T>, func:T->Void):Void
	inline Lambda.iter(iterable, func);

inline function proc<T>(value:T, func:T->Void):Void
	func(value);
