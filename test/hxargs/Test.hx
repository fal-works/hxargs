package hxargs;

import hxargs.HxArgs.args;

function main() {
	args({
		input: {
			classPaths: ["src", "test"],
			main: "TestProject",
		},
		options: {
			globals: { debug: true },
		},
		commands: ["echo (completed)"],
		mode: Interpret(Run),
	}).exec({ printCommand: true });
}
