#!/bin/bash

which lttng >/dev/null || { echo "Lttng is not present in \$PATH." ; exit 1 ; }
[ -x ./test ] || { echo "Please compile test first." ; exit 1 ; }

lttng create s1
lttng enable-event --userspace hello_world:my_first_tracepoint
lttng add-context --userspace -t vpid -t vtid -t procname
lttng start
LD_PRELOAD=liblttng-ust-fork.so ./test
lttng stop
lttng view 
lttng destroy
