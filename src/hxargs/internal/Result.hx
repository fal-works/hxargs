package hxargs.internal;

enum Result<T> {
	Ok(value: T);
	Failed(message: String);
}

class ResultExtension {
	public static function unwrap<T>(result: Result<T>): T {
		return switch result {
			case Ok(value): value;
			case Failed(message): throw new HxArgsError(message);
		}
	}
}
