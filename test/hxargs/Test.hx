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
		mode: Interpret(Run),
	}).exec(true);
}
