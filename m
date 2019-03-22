From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 18:11:33 +0100
Subject: [LTP] [PATCH v3 1/2] tst_test: Add test multiplex function
In-Reply-To: <20190322171134.899-1-chrubis@suse.cz>
References: <20190322171134.899-1-chrubis@suse.cz>
Message-ID: <20190322171134.899-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test multiplex function is intended for running the test function in
a loop for a different settings. The indended purpose is to run tests
for both libc wrapper and raw syscall as well as for different syscall
variants.

The commit itself adds a test_multiplex() function into the tst_test
structure, if set this function is called in a loop before each test
iteration and is responsible for changing the test variant into next
one. The iterations continue until the function returns zero.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Steve Muckle <smuckle@google.com>
CC: Mark Salyzyn <salyzyn@android.com>
CC: Steve Muckle <smuckle@google.com>
CC: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 66 +++++++++++++++++++++++++++++++++
 include/tst_test.h              | 12 ++++++
 lib/newlib_tests/.gitignore     |  1 +
 lib/newlib_tests/variant.c      | 55 +++++++++++++++++++++++++++
 lib/tst_test.c                  | 22 ++++++++---
 5 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 lib/newlib_tests/variant.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c36b2a424..0f6dc8f12 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1603,6 +1603,72 @@ sturct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.29 Testing similar syscalls in one test
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In some cases kernel has several very similar syscalls that do either the same
+or very similar job. This is most noticeable on i386 where we commonly have
+two or three syscall versions. That is because i386 was first platform that
+Linux was developed on and because of that most mistakes in API happened there
+as well. However this is not limited to i386 at all, it's quite common that
+version two syscall has added missing flags parameters or so.
+
+In such cases it does not make much sense to copy&paste the test code over and
+over, rather than that the test library provides support for test variants.
+The idea behind test variants is simple, we run the test several times each
+time with different syscall variant.
+
+The implemenation consist of test_variant integer that, if set, denotes number
+of test variants. The test is then forked and executed test_variant times each
+time with different value in global tst_variant variable.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static int do_foo(void)
+{
+	switch (tst_variant) {
+	case 0:
+		return foo();
+	case 1:
+		return syscall(__NR_foo);
+	}
+
+	return -1;
+}
+
+static void run(void)
+{
+	...
+
+	TEST(do_foo);
+
+	...
+}
+
+static void setup(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing foo variant 1");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing foo variant 2");
+	break;
+	}
+}
+
+sturct tst_test test = {
+	...
+	.setup = setup,
+	.test_all = run,
+	.test_variants = 2,
+	...
+};
+-------------------------------------------------------------------------------
+
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_test.h b/include/tst_test.h
index da41f776d..cf2447fe3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -114,6 +114,8 @@ int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
+extern unsigned int tst_variant;
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -146,6 +148,16 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 
+	/*
+	 * If set non-zero denotes number of test variant, the test is executed
+	 * variants times each time with tst_variant set to different number.
+	 *
+	 * This allows us to run the same test for different settings. The
+	 * intended use is to test different syscall wrappers/variants but the
+	 * API is generic and does not limit the usage in any way.
+	 */
+	unsigned int test_variants;
+
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
 
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 645ba349e..d92b89872 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -25,3 +25,4 @@ tst_expiration_timer
 test_exec
 test_exec_child
 test_kconfig
+variant
diff --git a/lib/newlib_tests/variant.c b/lib/newlib_tests/variant.c
new file mode 100644
index 000000000..b5816fff0
--- /dev/null
+++ b/lib/newlib_tests/variant.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	switch (tst_variant) {
+	case 0:
+		/* This is skipped after first iteration */
+		tst_brk(TCONF, "Test skipped");
+	break;
+	case 1:
+		/* This test is correctly looped with -i opt */
+		tst_res(TPASS, "Test passed");
+	break;
+	case 2:
+		/* This exits the test immediatelly */
+		tst_brk(TBROK, "Test broken");
+	break;
+	}
+
+	tst_res(TINFO, "test() function exitting normaly");
+}
+
+static void setup(void)
+{
+	tst_res(TINFO, "Running test setup()");
+
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Starting tst_brk TCONF test");
+	break;
+	case 1:
+		tst_res(TINFO, "Starting tst_res TPASS test");
+	break;
+	case 2:
+		tst_res(TINFO, "Starting tst_res TBROK test");
+	break;
+	}
+}
+
+static void cleanup(void)
+{
+	tst_res(TINFO, "Running test cleanup()");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.test_variants = 3,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index ba5eab011..2d88adbd7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1180,9 +1180,12 @@ static int run_tcases_per_fs(void)
 	return ret;
 }
 
+unsigned int tst_variant;
+
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
-	int ret;
+	int ret = 0;
+	unsigned int test_variants = 1;
 
 	lib_pid = getpid();
 	tst_test = self;
@@ -1194,11 +1197,20 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	if (tst_test->all_filesystems)
-		ret = run_tcases_per_fs();
-	else
-		ret = fork_testrun();
+	if (tst_test->test_variants)
+		test_variants = tst_test->test_variants;
+
+	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
+		if (tst_test->all_filesystems)
+			ret |= run_tcases_per_fs();
+		else
+			ret |= fork_testrun();
+
+		if (ret & ~(TCONF))
+			goto exit;
+	}
 
+exit:
 	do_exit(ret);
 }
 
-- 
2.19.2

