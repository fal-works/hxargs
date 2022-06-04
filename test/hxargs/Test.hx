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

	arguments.exec({ printCommand: true });

	hxml({
		headerComment: "test output hxml",
		commonArgumentGroup: null,
		argumentGroups: [arguments],
	}).save("out/test-output.hxml").run({ printCommand: true });

	arguments.merge({
		options: {
			globals: { debug: true }
		}
	}).exec({ printCommand: true });
}
