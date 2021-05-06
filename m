From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu,  6 May 2021 13:14:47 +0200
Subject: [LTP] [PATCH 2/2] shell: Implement timeout handling in c
In-Reply-To: <20210506111447.211104-1-lkml@jv-coder.de>
References: <20210506111447.211104-1-lkml@jv-coder.de>
Message-ID: <20210506111447.211104-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The shell implementation of the timeout handling failed to terminate the
sleep process, because the command "sleep $sec && _tst_kill_test &" spawns
two processes: A shell, that is used to execute the sleep and
after sleep terminates it executes _tst_kill_test. The pid stored in $! is the
pid of the shell process.
When the test finished, the timeout process is supposed to be killed, but
only the shell process is killed, not the sleep. If the output of the test
is piped somewhere else, the pipe stays open, until the sleep finished,
because it still has stdout open.
Additionally, if a lot of short tests with high timeouts are executed,
a lot of sleep processes will linger around.

The c implementation fixes these issues. It spawns only a single process
for handling the timeout and works otherwise the same:
It sends SIGINT to the process group after the timeout and if
the process is still there after 10 seconds, it sends SIGKILL.
The only changes are the messages printed by the c implementation:
1. The message format is a bit different (It prints the file and line as prefix)
2. TBROK messages are converted to TWARN, because TBROK is not allowed
    to be used in tst_res.
(See changes in timeout03.sh)

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 lib/newlib_tests/shell/timeout03.sh |  34 ++++-----
 testcases/lib/.gitignore            |   1 +
 testcases/lib/Makefile              |   2 +-
 testcases/lib/tst_test.sh           |  22 +-----
 testcases/lib/tst_timeout_kill.c    | 105 ++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 39 deletions(-)
 create mode 100644 testcases/lib/tst_timeout_kill.c

diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
index 30aa0a149..20733ad27 100755
--- a/lib/newlib_tests/shell/timeout03.sh
+++ b/lib/newlib_tests/shell/timeout03.sh
@@ -4,23 +4,23 @@
 
 # testing shell timeout handling in _tst_kill_test()
 # expected output:
-# timeout03 1 TINFO: timeout per run is 0h 0m 1s
-# timeout03 1 TINFO: testing killing test after TST_TIMEOUT
-# timeout03 1 TBROK: Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
-# timeout03 1 TBROK: test interrupted or timed out
-# timeout03 1 TPASS: test run cleanup after timeout
-# timeout03 1 TINFO: Test is still running, waiting 10s
-# timeout03 1 TINFO: Test is still running, waiting 9s
-# timeout03 1 TINFO: Test is still running, waiting 8s
-# timeout03 1 TINFO: Test is still running, waiting 7s
-# timeout03 1 TINFO: Test is still running, waiting 6s
-# timeout03 1 TINFO: Test is still running, waiting 5s
-# timeout03 1 TINFO: Test is still running, waiting 4s
-# timeout03 1 TINFO: Test is still running, waiting 3s
-# timeout03 1 TINFO: Test is still running, waiting 2s
-# timeout03 1 TINFO: Test is still running, waiting 1s
-# timeout03 1 TBROK: Test still running, sending SIGKILL
-# Killed
+timeout03 1 TINFO: timeout per run is 0h 0m 1s
+timeout03 1 TINFO: testing killing test after TST_TIMEOUT
+tst_timeout_kill.c:42: TWARN: Test timed out, sending SIGINT!If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
+timeout03 1 TBROK: test interrupted or timed out
+timeout03 1 TPASS: test run cleanup after timeout
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 10s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 9s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 8s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 7s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 6s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 5s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 4s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 3s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 2s
+tst_timeout_kill.c:52: TWARN: Test is still running, waiting 1s
+tst_timeout_kill.c:56: TWARN: Test still running, sending SIGKILL
+Killed
 
 TST_TESTFUNC=do_test
 TST_CLEANUP=cleanup
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index bc299b6ee..33f40b003 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -12,3 +12,4 @@
 /tst_rod
 /tst_sleep
 /tst_supported_fs
+/tst_timeout_kill
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f77da0d56..6ae987f8c 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -29,6 +29,6 @@ INSTALL_TARGETS		:= *.sh
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
-			   tst_get_median
+			   tst_get_median tst_timeout_kill
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 951518785..d4904fa61 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -443,25 +443,6 @@ _tst_multiply_timeout()
 	return 0
 }
 
-_tst_kill_test()
-{
-	local i=10
-
-	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
-	kill -INT -$pid
-	tst_sleep 100ms
-
-	while kill -0 $pid 2>&1 > /dev/null && [ $i -gt 0 ]; do
-		tst_res TINFO "Test is still running, waiting ${i}s"
-		sleep 1
-		i=$((i-1))
-	done
-
-	if kill -0 $pid 2>&1 > /dev/null; then
-		tst_res TBROK "Test still running, sending SIGKILL"
-		kill -KILL -$pid
-	fi
-}
 
 _tst_setup_timer()
 {
@@ -486,8 +467,7 @@ _tst_setup_timer()
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
 	_tst_cleanup_timer
-	sleep $sec && _tst_kill_test &
-
+	tst_timeout_kill $sec $pid &
 	_tst_setup_timer_pid=$!
 }
 
diff --git a/testcases/lib/tst_timeout_kill.c b/testcases/lib/tst_timeout_kill.c
new file mode 100644
index 000000000..acaed2473
--- /dev/null
+++ b/testcases/lib/tst_timeout_kill.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+
+static void print_help(void)
+{
+	printf("Usage: tst_timeout_kill interval pid\n\n");
+	printf("       Terminates process group pid after interval seconds\n");
+}
+
+static int kill_safe(__pid_t pid, int signal) {
+	int rc;
+
+	rc = kill(pid, signal);
+	if (rc == -1) {
+		/* The process terminated already */
+		if (errno == ESRCH)
+			return ESRCH;
+		tst_brk(TBROK, "Unable to send signals to process '%d'\n", pid);
+	}
+	return 0;
+}
+
+static int do_timeout(int interval, __pid_t pid)
+{
+	int i;
+
+	sleep(interval);
+
+	tst_res(TWARN, "Test timed out, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1");
+
+	if (kill_safe(-pid, SIGINT) == ESRCH)
+		return 0;
+
+	usleep(100000);
+
+	for (i = 0; i < 10; ++i) {
+		if (kill_safe(pid, 0) == ESRCH)
+			return 0;
+		tst_res(TWARN, "Test is still running, waiting %ds", 10 - i);
+		sleep(1);
+	}
+
+	tst_res(TWARN, "Test still running, sending SIGKILL");
+	kill(-pid, SIGKILL);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	unsigned long interval, pid;
+	char *end;
+
+	while ((opt = getopt(argc, argv, ":h")) != -1) {
+		switch (opt) {
+		case 'h':
+			print_help();
+			return 0;
+		default:
+			print_help();
+			return 1;
+		}
+	}
+
+	if (optind >= argc - 1) {
+		fprintf(stderr, "ERROR: Expected interval and pid argument\n\n");
+		print_help();
+		return 1;
+	}
+
+	interval = strtoul(argv[optind], &end, 10);
+	if (end != argv[optind] + strlen(argv[optind])) {
+		fprintf(stderr, "ERROR: Invalid interval '%s'\n\n", argv[optind]);
+		print_help();
+		return 1;
+	}
+	optind++;
+
+	pid = strtol(argv[optind], &end, 10);
+	if (end != argv[optind] + strlen(argv[optind])) {
+		fprintf(stderr, "ERROR: Invalid pid '%s'\n\n", argv[optind]);
+		print_help();
+		return 1;
+	}
+
+	if (kill_safe(pid, 0) == ESRCH) {
+		fprintf(stderr, "ERROR: Process with pid '%ld' does not exist\n", pid);
+		return 1;
+	}
+
+	return do_timeout(interval, pid);
+}
-- 
2.25.1

