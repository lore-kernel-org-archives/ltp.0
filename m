From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 16:51:11 +0100
Subject: [LTP] [PATCH v2 1/2] tst_test: Add test multiplex function
In-Reply-To: <20190321155112.13449-1-chrubis@suse.cz>
References: <20190321155112.13449-1-chrubis@suse.cz>
Message-ID: <20190321155112.13449-2-chrubis@suse.cz>
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
---
 doc/test-writing-guidelines.txt | 80 +++++++++++++++++++++++++++++++++
 include/tst_test.h              | 14 ++++++
 lib/tst_test.c                  | 11 ++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index c36b2a424..e5aa456e2 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1603,6 +1603,86 @@ sturct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.29 Testing similar syscalls in one test
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In some cases kernel has several very similar syscalls that do either the same
+or very similar job. This is most noticeable on i386 where we commonly have
+two or three syscall versions because i386 was first platform that Linux was
+developed on and because of that most mistakes in API happened there as well.
+However this is not limited to i386 at all, it's quite common that version two
+syscall has added missing flags parameters or so.
+
+In such cases it does not make much sense to copy&paste the test code over and
+over, rather than that the test library provides mutiplexing support. The idea
+behind multiplexing is simple, we run the test function several times each
+time with different syscall variant.
+
+The implemenation consist of multiplex fuction that is called before each
+iteration of the run function, this fuction is responsible for switching the
+syscall variant and also controlls the number of iterations. The testrun is
+done once the function returns zero.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static int mpx = -1;
+
+static int foo_mpx(void)
+{
+	switch (++mpx) {
+	case 0:
+		tst_res(TINFO, "Testing foo variant 1");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing foo variant 2");
+	break;
+	case 2:
+		mpx = -1;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int do_foo(void)
+{
+	switch (mpx) {
+	case 0:
+		return foo();
+	case 1:
+		return syscall(__NR_foo);
+	}
+
+	return -1;
+}
+
+static void setup(void)
+{
+	...
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
+
+sturct tst_test test = {
+	...
+	.setup = setup,
+	.test_all = run,
+	.test_multiplex = foo_mpx,
+	...
+};
+-------------------------------------------------------------------------------
+
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_test.h b/include/tst_test.h
index da41f776d..b747b24d5 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -146,6 +146,20 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 
+	/*
+	 * If set this function is used to mutiplex between different test
+	 * variants.
+	 *
+	 * Multiplexers are the way how to run the same test for different
+	 * settings. The intended use is to test different syscall
+	 * wrappers/variants but the API is generic and does not limit the
+	 * usage in any way.
+	 *
+	 * Each time the function is called it switches to next test variant,
+	 * returns zero if all variants has been iterated over.
+	 */
+	int (*test_multiplex)(void);
+
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index ba5eab011..aae7651c2 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1009,8 +1009,15 @@ static void testrun(void)
 		if (!cont)
 			break;
 
-		run_tests();
-		heartbeat();
+		if (tst_test->test_multiplex) {
+			while (tst_test->test_multiplex()) {
+				run_tests();
+				heartbeat();
+			}
+		} else {
+			run_tests();
+			heartbeat();
+		}
 	}
 
 	do_test_cleanup();
-- 
2.19.2

