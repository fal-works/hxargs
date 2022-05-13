package hxargs;

import haxe.extern.EitherType;

/**
	Value representing a `-D` argument.
**/
@:using(Define.DefineExtension)
enum Define {
	Flag(name: String);
	Value(name: String, ?value: E3<String, Int, Float>);
}

typedef E3<T1, T2, T3> = EitherType<EitherType<T1, T2>, T3>;

class DefineExtension {
	/**
		Converts `Define` to `Array<String>` that can be passed to `haxe` command.
	**/
	public static function toCommandOption(define: Define): Array<String> {
		return switch define {
			case Flag(name): ["-D", name];
			case Value(name, value): ["-D", '$name=$value'];
		}
	}
}
