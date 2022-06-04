package hxargs;

import hxargs.HxArgs.*;

function main() {
	final arguments = args({
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

	arguments.toCommand().exec({ printCommand: true });

	hxml({
		headerComment: "test output hxml",
		commonArgumentGroup: null,
		argumentGroups: [arguments],
	}).save("out/test-output.hxml").toCommand().exec({ printCommand: true });

	arguments.merge({
		options: {
			globals: { debug: true }
		}
	}).toCommand().exec({ printCommand: true });
}
