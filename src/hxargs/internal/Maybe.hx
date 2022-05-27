package hxargs.internal;

using hxargs.internal.LambdaInline;

@:noUsing
inline function maybe<T>(value: Null<T>): Maybe<T>
	return Maybe.of(value);

@:transitive
abstract Maybe<T>(Null<T>) from Null<T> to Null<T> {
	@:noUsing
	public static inline function of<T>(value: T): Maybe<T>
		return new Maybe(value);

	public inline function or(defaultValue: T): T
		return if (this != null) this else defaultValue;

	public inline function orElse(getDefault: () -> T): T
		return or(getDefault());

	public inline function doOrElse(ifNull: () -> Void, ifSome: T->Void): Void {
		@:nullSafety(Off)
		if (this != null) ifSome(this) else ifNull();
	}

	public inline function mapOr<U>(defaultValue: U, func: T->U): U {
		@:nullSafety(Off)
		return if (this != null) func(this) else defaultValue;
	}

	public inline function mapOrElse<U>(getDefault: () -> U, func: T->U): U
		return mapOr(getDefault(), func);

	public inline function coalesce(other: Null<T>): Maybe<T>
		return new Maybe(if (this != null) this else other);

	public inline function coalesceWith(getOther: () -> Null<T>): Maybe<T>
		return coalesce(getOther());

	public inline function mayDo(func: T->Void): Void {
		@:nullSafety(Off)
		if (this != null) func(this);
	}

	inline function new(value: Null<T>)
		this = value;
}
