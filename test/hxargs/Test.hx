package hxargs;

import hxargs.HxArgs.*;

function main() {
	Sys.println("[1]");

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

	arguments.toCommand().execute({ printCommand: true });

	Sys.println("[2]");

	hxml({
		headerComment: "test output hxml",
		commonArgumentGroup: null,
		argumentGroups: [arguments],
	}).save("out/test-output.hxml").toCommand().execute({ printCommand: true });

	Sys.println("[3]");

	arguments.merge({
		options: {
			globals: { debug: true }
		}
	}).toCommand().execute({ printCommand: true });
}
