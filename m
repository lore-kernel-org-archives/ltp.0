From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 13:58:07 +0200
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
Message-ID: <20160607115806.GA1740@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit moves the actuall test to a child process. The parent process now
serves two purposes. It sets up an alarm timer that kills the test on a timeout
and also does the library setup and cleanup which means that the test temporary
directory is removed even if the test crashed in one of the functions exported
in tst_test structure.

The timeout is defined per test run, which is either one execution of
test_all() function or single loop over the test() function. The timeout is
reset after each test run by the test library by sending SIGUSR1 to the parent.

The default timeout is set to 300 seconds and can be overriden by setting
tst_test->timeout variable.

There is also LTP_TIMEOUT_MUL env variable that, if set to float > 1, is used
to multiply the timeout before the start of a test. This is especially intended
for slow machines where the default timeout may not be enough. In that
case you can double all timeouts just by exporting LTP_TIMEOUT_MUL=2
before starting the testrun.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h          |  3 ++
 lib/newlib_tests/.gitignore |  3 ++
 lib/newlib_tests/test10.c   | 33 +++++++++++++++
 lib/newlib_tests/test11.c   | 34 ++++++++++++++++
 lib/newlib_tests/test12.c   | 32 +++++++++++++++
 lib/tst_test.c              | 98 +++++++++++++++++++++++++++++++++++++++------
 6 files changed, 190 insertions(+), 13 deletions(-)
 create mode 100644 lib/newlib_tests/test10.c
 create mode 100644 lib/newlib_tests/test11.c
 create mode 100644 lib/newlib_tests/test12.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 88b46d6..ddd9060 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -84,6 +84,9 @@ struct tst_test {
 	int needs_device:1;
 	int needs_checkpoints:1;
 
+	/* override default timeout per test run */
+	unsigned int timeout;
+
 	void (*setup)(void);
 	void (*cleanup)(void);
 
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index e3ec6aa..dccf4c8 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -7,3 +7,6 @@ test06
 test07
 test08
 test09
+test10
+test11
+test12
diff --git a/lib/newlib_tests/test10.c b/lib/newlib_tests/test10.c
new file mode 100644
index 0000000..01d4807
--- /dev/null
+++ b/lib/newlib_tests/test10.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Test for watchdog timeout.
+ */
+
+#include "tst_test.h"
+
+
+static void do_test(void)
+{
+	sleep(2);
+	tst_res(TPASS, "Not reached");
+}
+
+static struct tst_test test = {
+	.tid = "test10",
+	.test_all = do_test,
+	.timeout = 1,
+};
diff --git a/lib/newlib_tests/test11.c b/lib/newlib_tests/test11.c
new file mode 100644
index 0000000..1354f52
--- /dev/null
+++ b/lib/newlib_tests/test11.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Test for segfault.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	volatile char *ptr = NULL;
+
+	*ptr = 0;
+
+	tst_res(TPASS, "Not reached");
+}
+
+static struct tst_test test = {
+	.tid = "test11",
+	.test_all = do_test,
+};
diff --git a/lib/newlib_tests/test12.c b/lib/newlib_tests/test12.c
new file mode 100644
index 0000000..c7901f4
--- /dev/null
+++ b/lib/newlib_tests/test12.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Test for timeout override.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	sleep(1);
+	tst_res(TPASS, "Passed!");
+}
+
+static struct tst_test test = {
+	.tid = "test12",
+	.timeout = 2,
+	.test_all = do_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8ec246..eef54e4 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -220,17 +220,19 @@ void tst_vres_(const char *file, const int lineno, int ttype,
 void tst_vbrk_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va) __attribute__((noreturn));
 
-static void do_cleanup(void);
+static void do_test_cleanup(void)
+{
+	if (tst_test->cleanup)
+		tst_test->cleanup();
+}
 
 void tst_vbrk_(const char *file, const int lineno, int ttype,
                const char *fmt, va_list va)
 {
 	print_result(file, lineno, ttype, fmt, va);
 
-	if (getpid() == main_pid) {
-		do_cleanup();
-		cleanup_ipc();
-	}
+	if (getpid() == main_pid)
+		do_test_cleanup();
 
 	exit(TTYPE_RESULT(ttype));
 }
@@ -550,7 +552,10 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->resource_files)
 		copy_resources();
+}
 
+static void do_test_setup(void)
+{
 	main_pid = getpid();
 
 	if (tst_test->setup)
@@ -562,9 +567,6 @@ static void do_setup(int argc, char *argv[])
 
 static void do_cleanup(void)
 {
-	if (tst_test->cleanup)
-		tst_test->cleanup();
-
 	if (tst_test->needs_device && tdev.dev)
 		tst_release_device(tdev.dev);
 
@@ -619,16 +621,13 @@ static unsigned long long get_time_ms(void)
 	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
 }
 
-void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+static void testrun(void)
 {
 	unsigned int i = 0;
 	unsigned long long stop_time = 0;
 	int cont = 1;
 
-	tst_test = self;
-	TCID = tst_test->tid;
-
-	do_setup(argc, argv);
+	do_test_setup();
 
 	if (duration > 0)
 		stop_time = get_time_ms() + (unsigned long long)(duration * 1000);
@@ -648,8 +647,81 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 			break;
 
 		run_tests();
+
+		kill(getppid(), SIGUSR1);
 	}
 
+	do_test_cleanup();
+	exit(0);
+}
+
+static pid_t test_pid;
+static unsigned int timeout = 300;
+
+static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	kill(test_pid, SIGKILL);
+}
+
+static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+	alarm(timeout);
+}
+
+void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+{
+	int status;
+	char *mul;
+
+	tst_test = self;
+	TCID = tst_test->tid;
+
+	do_setup(argc, argv);
+
+	if (tst_test->timeout)
+		timeout = tst_test->timeout;
+
+	mul = getenv("LTP_TIMEOUT_MUL");
+	if (mul) {
+		float m = atof(mul);
+
+		if (m < 1)
+			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul);
+
+		timeout = timeout * m + 0.5;
+	}
+
+	tst_res(TINFO, "Timeout per run is %us", timeout);
+
+	SAFE_SIGNAL(SIGALRM, alarm_handler);
+	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
+
+	alarm(timeout);
+
+	test_pid = fork();
+	if (test_pid < 0)
+		tst_brk(TBROK | TERRNO, "fork()");
+
+	if (!test_pid)
+		testrun();
+
+	SAFE_WAITPID(test_pid, &status, 0);
+
+	alarm(0);
+
 	do_cleanup();
+
+	if (WIFEXITED(status) && WEXITSTATUS(status))
+		exit(WEXITSTATUS(status));
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
+		tst_res(TINFO, "If you are running on slow machine, "
+			       "try exporting LTP_TIMEOUT_MUL > 1");
+		tst_brk(TBROK, "Test killed! (timeout?)");
+	}
+
+	if (WIFSIGNALED(status))
+		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
+
 	do_exit();
 }
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
