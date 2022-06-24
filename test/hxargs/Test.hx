package hxargs;

import hxargs.HxArgs.*;

function main() {
	hxargs.Config.printBeforeExecution = true;

	Sys.println("");
	Sys.println("[1] HxArgs.haxeArguments");

	final arguments = haxeArguments({
		input: {
			classPaths: ["src", "test"],
			main: "TestProject",
		},
		options: {
			// globals: { debug: true },
		},
		commands: ["echo (completed)"],
		mode: Interpret(Run),
	});

	arguments.toCommand().execute();

	Sys.println("");
	Sys.println("[2] HxArgs.hxml");

	hxml({
		headerComment: "test output hxml",
		commonArgumentGroup: null,
		argumentGroups: [arguments],
	}).save("out/test-output.hxml").toCommand().execute();

	Sys.println("");
	Sys.println("[3] HaxeArgumentGroup.merge");

	arguments.merge({
		options: {
			globals: { debug: true }
		}
	}).toCommand().execute();

	Sys.println("");
}
