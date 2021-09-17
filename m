From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Sep 2021 16:17:19 +0200
Subject: [LTP] [PATCH] [RFC] lib: shell: Fix timeout process races
Message-ID: <20210917141719.5739-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There were actually several races in the shell library timeout handling.

This commit fixes hopefully all of them by:

* Reimplementing the backgroud timer in C

* Making sure that the timer has started before we leave test setup

The rewrite of the backround timer to C allows us to run all the timeout
logic in a single process, which simplifies the whole problem greatly
since previously we had chain of processes that estabilished signal
handlers to kill it's descendants, which in the end had a few races in
it.

The race that caused the problems is, as far as I can tell, in the way
how shell spawns it's children. I haven't checked the shell code, but I
guess that when shell runs a process in bacground it does vfork() +
exec() and because signals are ignored during the operation. If the
SIGTERM arrives at that point it gets lost.

That means that we created a race window in the shell library each time
we started a new process. The rewrite to C simplifies the code but we
still end up with a single place where this can happen and that is when
we execute the tst_timeout_kill binary. This is now fixed in the shell
library by waiting until the background process gets to a sleep state,
which means that the proces has been executed and waiting for the
timeout.

After these fixes I haven't been able to reproduce the hang with:

cat > debug.sh <<EOF
#!/bin/sh

TST_SETUP="setup"
TST_TESTFUNC="do_test"
. tst_test.sh

setup()
{
        tst_brk TCONF "quit now!"
}

do_test()
{
        tst_res TPASS "pass :)"
}

tst_run
EOF

# while true; do ./debug.sh; done

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/.gitignore         |  1 +
 testcases/lib/Makefile           |  2 +-
 testcases/lib/tst_test.sh        | 47 +++++-----------
 testcases/lib/tst_timeout_kill.c | 93 ++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 35 deletions(-)
 create mode 100644 testcases/lib/tst_timeout_kill.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 5a0e8cba2..f266a3e6b 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -14,3 +14,4 @@
 /tst_sleep
 /tst_supported_fs
 /tst_hexdump
+tst_timeout_kill
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 179b47479..d6b4c7a91 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median tst_hexdump tst_get_free_pids
+			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8f69b0551..2556b28f5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -474,27 +474,6 @@ _tst_multiply_timeout()
 	return 0
 }
 
-_tst_kill_test()
-{
-	local i=10
-
-	trap '' TERM
-	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
-	kill -TERM -$pid
-	tst_sleep 100ms
-
-	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
-		tst_res TINFO "Test is still running, waiting ${i}s"
-		sleep 1
-		i=$((i-1))
-	done
-
-	if kill -0 $pid >/dev/null 2>&1; then
-		tst_res TBROK "Test still running, sending SIGKILL"
-		kill -KILL -$pid
-	fi
-}
-
 _tst_cleanup_timer()
 {
 	if [ -n "$_tst_setup_timer_pid" ]; then
@@ -503,18 +482,6 @@ _tst_cleanup_timer()
 	fi
 }
 
-_tst_timeout_process()
-{
-	local sleep_pid
-
-	sleep $sec &
-	sleep_pid=$!
-	trap "kill $sleep_pid; exit" TERM
-	wait $sleep_pid
-	trap - TERM
-	_tst_kill_test
-}
-
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -539,9 +506,21 @@ _tst_setup_timer()
 
 	_tst_cleanup_timer
 
-	_tst_timeout_process &
+	tst_timeout_kill $sec $pid &
 
 	_tst_setup_timer_pid=$!
+
+	while true; do
+		local state
+
+		state=$(cut -d' ' -f3 "/proc/$_tst_setup_timer_pid/stat")
+
+		if [ "$state" = "S" ]; then
+			break;
+		fi
+
+		tst_sleep 1ms
+	done
 }
 
 tst_require_root()
diff --git a/testcases/lib/tst_timeout_kill.c b/testcases/lib/tst_timeout_kill.c
new file mode 100644
index 000000000..6e97514f1
--- /dev/null
+++ b/testcases/lib/tst_timeout_kill.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <tst_res_flags.h>
+#include <tst_ansi_color.h>
+
+static void print_help(const char *name)
+{
+	fprintf(stderr, "usage: %s timeout pid\n", name);
+}
+
+static void print_msg(int type, const char *msg)
+{
+	const char *strtype = "";
+
+	switch (type) {
+	case TBROK:
+		strtype = "TBROK";
+	break;
+	case TINFO:
+		strtype = "TINFO";
+	break;
+	}
+
+	if (tst_color_enabled(STDERR_FILENO)) {
+		fprintf(stderr, "%s%s: %s%s\n", tst_ttype2color(type),
+			strtype, ANSI_COLOR_RESET, msg);
+	} else {
+		fprintf(stderr, "%s: %s\n", strtype, msg);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int timeout, pid, ret, i;
+
+	if (argc != 3) {
+		print_help(argv[0]);
+		return 1;
+	}
+
+	timeout = atoi(argv[1]);
+	pid = atoi(argv[2]);
+
+	if (timeout < 0) {
+		fprintf(stderr, "Invalid timeout '%s'", argv[1]);
+		print_help(argv[0]);
+		return 1;
+	}
+
+	if (pid <= 1) {
+		fprintf(stderr, "Invalid pid '%s'", argv[2]);
+		print_help(argv[0]);
+		return 1;
+	}
+
+	if (timeout)
+		sleep(timeout);
+
+	print_msg(TBROK, "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1");
+
+	ret = kill(-pid, SIGTERM);
+	if (ret) {
+		print_msg(TBROK, "kill() failed");
+		return 1;
+	}
+
+	usleep(100000);
+
+	i = 10;
+
+	while (!kill(-pid, 0) && i-- > 0) {
+		print_msg(TINFO, "Test is still running...");
+		sleep(1);
+	}
+
+	if (!kill(-pid, 0)) {
+		print_msg(TBROK, "Test is still running, sending SIGKILL");
+		ret = kill(-pid, SIGKILL);
+		if (ret) {
+			print_msg(TBROK, "kill() failed");
+			return 1;
+		}
+	}
+
+	return 0;
+}
-- 
2.32.0

