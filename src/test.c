#include <stdio.h>
#include <unistd.h>
#include <sys/prctl.h>

#include "hello-tp.h"

int main(int argc, char *argv[]) {
	pid_t pid1;

	tracepoint(hello_world, my_first_tracepoint, 0, "Parent trace before fork.");

	pid1 = fork();
	if (pid1 == 0) {
		prctl(PR_SET_NAME,"lttng-test-child\0", NULL, NULL, NULL);
		tracepoint(hello_world, my_first_tracepoint, 0, "Child trace.");
	}
	else {
		tracepoint(hello_world, my_first_tracepoint, 0, "Parent trace.");
	}

	return 0;
} 
