package hxargs;

@:structInit
class HxmlFile {
	public final filepath: String;

	public function run(?options: {
		var ?additionalArguments: HaxeArgumentGroup;
		var ?printCommand: Bool;
	}): Int {
		final opt = maybe(options).orElse(() -> {});
		var args = [filepath];
		maybe(opt.additionalArguments).mayDo(x -> {
			args = args.concat(x.toCommandLineArguments());
		});

		if (opt.printCommand == true) Sys.println('haxe ${args.join(" ")}');

		return Sys.command("haxe", args);
	}
}
