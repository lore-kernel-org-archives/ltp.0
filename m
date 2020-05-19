From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 May 2020 14:07:25 +0200
Subject: [LTP] [PATCH 1/1] C API: Turn .test_variants into array of
 description
Message-ID: <20200519120725.25750-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because all tests which uses .test_variants use array of the test
descriptions and number of the tests can be derived from array length,
change .test_variants from int numer of the tests into test description
and move printing the descriptions into the library.

The only 2 changes in the output are that test description is now
printed before timeout (IMHO more logic but wasn't able to achieve
before handling it in the library) and before all filesystems instead
of for each filesystem test (e.g. copy_file_range01 on my SUT prints
description 2x instead of 14x). Because for SUT with many filesystems
available it'd be unclear which variant is tested, print variant also
on each filesystem.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt               | 26 +++++++---------
 include/tst_test.h                            |  7 +++--
 lib/newlib_tests/variant.c                    | 26 +++++-----------
 lib/tst_test.c                                | 19 ++++++++++--
 .../kernel/syscalls/accept4/accept4_01.c      | 14 ++++-----
 .../syscalls/clock_adjtime/clock_adjtime01.c  | 18 ++++++-----
 .../syscalls/clock_adjtime/clock_adjtime02.c  | 18 ++++++-----
 .../syscalls/clock_getres/clock_getres01.c    | 30 ++++++++++++-------
 .../syscalls/clock_gettime/clock_gettime01.c  | 26 ++++++++--------
 .../syscalls/clock_gettime/clock_gettime02.c  | 18 ++++++-----
 .../syscalls/clock_gettime/clock_gettime03.c  | 21 ++++++++-----
 .../clock_nanosleep/clock_nanosleep01.c       | 21 ++++++++-----
 .../clock_nanosleep/clock_nanosleep03.c       | 22 ++++++++------
 .../clock_nanosleep/clock_nanosleep04.c       | 25 ++++++++--------
 .../syscalls/clock_settime/clock_settime01.c  | 21 ++++++++-----
 .../syscalls/clock_settime/clock_settime02.c  | 18 ++++++-----
 .../copy_file_range/copy_file_range.h         | 17 ++++-------
 .../copy_file_range/copy_file_range01.c       |  3 +-
 .../copy_file_range/copy_file_range02.c       |  3 +-
 .../copy_file_range/copy_file_range03.c       |  4 +--
 testcases/kernel/syscalls/select/select04.c   |  4 +--
 testcases/kernel/syscalls/select/select_var.h | 26 +++++-----------
 .../kernel/syscalls/sendmmsg/sendmmsg01.c     |  4 +--
 .../kernel/syscalls/sendmmsg/sendmmsg_var.h   | 22 +++++---------
 .../syscalls/setdomainname/setdomainname.h    | 19 ++++--------
 .../syscalls/setdomainname/setdomainname01.c  |  2 +-
 .../syscalls/setdomainname/setdomainname02.c  |  2 +-
 .../syscalls/setdomainname/setdomainname03.c  |  2 +-
 .../kernel/syscalls/sigpending/sigpending02.c | 25 +++++-----------
 testcases/kernel/syscalls/stime/stime01.c     |  8 +----
 testcases/kernel/syscalls/stime/stime02.c     |  4 +--
 testcases/kernel/syscalls/stime/stime_var.h   | 20 ++++---------
 32 files changed, 230 insertions(+), 265 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 93ca506d9..bf2623b2b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1685,9 +1685,11 @@ over, rather than that the test library provides support for test variants.
 The idea behind test variants is simple, we run the test several times each
 time with different syscall variant.
 
-The implementation consist of test_variants integer that, if set, denotes number
-of test variants. The test is then forked and executed test_variants times each
-time with different value in global tst_variant variable.
+The implementation consist of '.test_variants' 'NULL' terminated array of
+descriptions that, if set, denotes number of test variants. The test is then
+forked and executed '.test_variants' times each time with different value in
+global 'tst_variant' variable. The description is printed before each run and
+in case of '.all_filesystems = 1' also for each filesystem test.
 
 [source,c]
 -------------------------------------------------------------------------------
@@ -1714,23 +1716,15 @@ static void run(void)
 	...
 }
 
-static void setup(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing foo variant 1");
-	break;
-	case 1:
-		tst_res(TINFO, "Testing foo variant 2");
-	break;
-	}
-}
-
 struct tst_test test = {
 	...
 	.setup = setup,
 	.test_all = run,
-	.test_variants = 2,
+	.test_variants = (const char *[]) {
+		"foo variant 1",
+		"foo variant 2",
+		NULL
+	},
 	...
 };
 -------------------------------------------------------------------------------
diff --git a/include/tst_test.h b/include/tst_test.h
index 5bedb4f6f..d9c737878 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -167,14 +167,15 @@ struct tst_test {
 	unsigned long request_hugepages;
 
 	/*
-	 * If set non-zero denotes number of test variant, the test is executed
-	 * variants times each time with tst_variant set to different number.
+	 * NULL terminated array of descriptions for test variants. The test is
+	 * executed variants times each time with tst_variant set to different
+	 * number.
 	 *
 	 * This allows us to run the same test for different settings. The
 	 * intended use is to test different syscall wrappers/variants but the
 	 * API is generic and does not limit the usage in any way.
 	 */
-	unsigned int test_variants;
+	const char * const *test_variants;
 
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
diff --git a/lib/newlib_tests/variant.c b/lib/newlib_tests/variant.c
index fbab710f1..8dac93071 100644
--- a/lib/newlib_tests/variant.c
+++ b/lib/newlib_tests/variant.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  */
 
 #include "tst_test.h"
@@ -25,23 +26,6 @@ static void do_test(void)
 	tst_res(TINFO, "test() function exitting normaly");
 }
 
-static void setup(void)
-{
-	tst_res(TINFO, "Running test setup()");
-
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Starting tst_brk(TCONF) test");
-	break;
-	case 1:
-		tst_res(TINFO, "Starting tst_res(TPASS) test");
-	break;
-	case 2:
-		tst_res(TINFO, "Starting tst_brk(TBROK) test");
-	break;
-	}
-}
-
 static void cleanup(void)
 {
 	tst_res(TINFO, "Running test cleanup()");
@@ -49,7 +33,11 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test_all = do_test,
-	.test_variants = 3,
-	.setup = setup,
+	.test_variants = (const char *[]) {
+		"tst_brk(TCONF)",
+		"tst_res(TPASS)",
+		"tst_brk(TBROK)",
+		NULL
+	},
 	.cleanup = cleanup,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 0e58060e0..478b9aa42 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1304,7 +1304,13 @@ static int run_tcases_per_fs(void)
 
 	for (i = 0; filesystems[i]; i++) {
 
-		tst_res(TINFO, "Testing on %s", filesystems[i]);
+		if (tst_test->all_filesystems)
+			tst_res(TINFO, "Testing on %s (variant: %s)",
+				filesystems[i],
+				tst_test->test_variants[tst_variant]);
+		else
+			tst_res(TINFO, "Testing on %s", filesystems[i]);
+
 		tdev.fs_type = filesystems[i];
 
 		prepare_device();
@@ -1347,10 +1353,17 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	if (tst_test->test_variants)
-		test_variants = tst_test->test_variants;
+	if (tst_test->test_variants) {
+		test_variants--;
+		while (tst_test->test_variants[test_variants])
+			test_variants++;
+	}
 
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
+		if (tst_test->test_variants)
+			tst_res(TINFO, "Testing variant: %s",
+					tst_test->test_variants[tst_variant]);
+
 		if (tst_test->all_filesystems)
 			ret |= run_tcases_per_fs();
 		else
diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index aaab20c2c..4456ed59a 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -25,11 +25,6 @@
 
 #define PORT_NUM 33333
 
-static const char *variant_desc[] = {
-	"libc accept4()",
-	"__NR_accept4 syscall",
-	"__NR_socketcall SYS_ACCEPT4 syscall"};
-
 static struct sockaddr_in *conn_addr, *accept_addr;
 static int listening_fd;
 
@@ -69,8 +64,6 @@ static int create_listening_socket(void)
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variant_desc[tst_variant]);
-
 	memset(conn_addr, 0, sizeof(*conn_addr));
 	conn_addr->sin_family = AF_INET;
 	conn_addr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
@@ -158,7 +151,12 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_variants = 3,
+	.test_variants = (const char *[]) {
+		"libc accept4()",
+		"__NR_accept4 syscall",
+		"__NR_socketcall SYS_ACCEPT4 syscall",
+		NULL
+	},
 	.test = verify_accept4,
 	.bufs = (struct tst_buffers []) {
 		{&conn_addr, .size = sizeof(*conn_addr)},
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
index 061b2bb22..40dae4b24 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
@@ -107,14 +107,12 @@ struct test_case tc[] = {
 static struct test_variants {
 	int (*clock_adjtime)(clockid_t clk_id, void *timex);
 	enum tst_timex_type type;
-	char *desc;
 } variants[] = {
 #if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
-	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX, .desc = "syscall with old kernel spec"},
+	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX},
 #endif
-
 #if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
-	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX, .desc = "syscall time64 with kernel spec"},
+	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX},
 #endif
 };
 
@@ -188,8 +186,6 @@ static void setup(void)
 	size_t i;
 	int rval;
 
-	tst_res(TINFO, "Testing variant: %s", tv->desc);
-
 	saved.type = tv->type;
 	rval = tv->clock_adjtime(CLOCK_REALTIME, tst_timex_get(&saved));
 	if (rval < 0) {
@@ -257,7 +253,15 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tc),
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+#if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.needs_root = 1,
 	.restore_wallclock = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
index 8ef4dadb6..bdb2bd79e 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
@@ -113,14 +113,12 @@ struct test_case tc[] = {
 static struct test_variants {
 	int (*clock_adjtime)(clockid_t clk_id, void *timex);
 	enum tst_timex_type type;
-	char *desc;
 } variants[] = {
 #if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
-	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX, .desc = "syscall with old kernel spec"},
+	{.clock_adjtime = sys_clock_adjtime, .type = TST_KERN_OLD_TIMEX},
 #endif
-
 #if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
-	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX, .desc = "syscall time64 with kernel spec"},
+	{.clock_adjtime = sys_clock_adjtime64, .type = TST_KERN_TIMEX},
 #endif
 };
 
@@ -194,8 +192,6 @@ static void setup(void)
 	size_t i;
 	int rval;
 
-	tst_res(TINFO, "Testing variant: %s", tv->desc);
-
 	bad_addr = tst_get_bad_addr(NULL);
 
 	saved.type = tv->type;
@@ -257,7 +253,15 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tc),
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+#if (__NR_clock_adjtime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_adjtime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.needs_root = 1,
 	.restore_wallclock = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 84a0feb34..2a596848e 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -40,26 +40,22 @@ static struct test_variants {
 	int (*func)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
 	struct tst_ts **spec;
-	char *desc;
 } variants[] = {
-	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &tspec, .desc = "vDSO or syscall with libc spec"},
-	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &nspec, .desc = "vDSO or syscall with libc spec with NULL res"},
-
+	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &tspec},
+	{ .func = libc_clock_getres, .type = TST_LIBC_TIMESPEC, .spec = &nspec},
 #if (__NR_clock_getres != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &tspec, .desc = "syscall with old kernel spec"},
-	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &nspec, .desc = "syscall with old kernel spec with NULL res"},
+	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &tspec},
+	{ .func = sys_clock_getres, .type = TST_KERN_OLD_TIMESPEC, .spec = &nspec},
 #endif
-
 #if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &tspec, .desc = "syscall time64 with kernel spec"},
-	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &nspec, .desc = "syscall time64 with kernel spec with NULL res"},
+	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &tspec},
+	{ .func = sys_clock_getres64, .type = TST_KERN_TIMESPEC, .spec = &nspec},
 #endif
 };
 
 static void setup(void)
 {
 	tspec->type = variants[tst_variant].type;
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void do_test(unsigned int i)
@@ -91,7 +87,19 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcase),
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+		"vDSO or syscall with libc spec with NULL res",
+#if (__NR_clock_getres != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+		"syscall with old kernel spec with NULL res",
+#endif
+#if (__NR_clock_getres_time64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+		"syscall time64 with kernel spec with NULL res",
+#endif
+		NULL
+	},
 	.setup = setup,
 	.bufs = (struct tst_buffers []) {
 		{&tspec, .size = sizeof(*tspec)},
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index 769ac32cd..95a869844 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -61,24 +61,16 @@ static struct tst_ts spec;
 static struct test_variants {
 	int (*func)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
-static void setup(void)
-{
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
-}
-
 static void verify_clock_gettime(unsigned int i)
 {
 	struct test_variants *tv = &variants[tst_variant];
@@ -118,7 +110,15 @@ static void verify_clock_gettime(unsigned int i)
 static struct tst_test test = {
 	.test = verify_clock_gettime,
 	.tcnt = ARRAY_SIZE(tc),
-	.test_variants = ARRAY_SIZE(variants),
-	.setup = setup,
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+#if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
index f26db7c57..bdc7c9e71 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
@@ -89,21 +89,17 @@ static struct tst_ts spec;
 static struct test_variants {
 	int (*func)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %d: %s", tst_variant, variants[tst_variant].desc);
-
 	bad_addr = tst_get_bad_addr(NULL);
 }
 
@@ -141,7 +137,15 @@ static void verify_clock_gettime(unsigned int i)
 static struct tst_test test = {
 	.test = verify_clock_gettime,
 	.tcnt = ARRAY_SIZE(tc),
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+#if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.setup = setup,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index e6b9c9c78..f0a0132ca 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -43,16 +43,13 @@ static int parent_ns;
 static struct test_variants {
 	int (*func)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .func = libc_clock_gettime, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .func = sys_clock_gettime, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .func = sys_clock_gettime64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
@@ -120,7 +117,6 @@ static void setup(void)
 	struct test_variants *tv = &variants[tst_variant];
 
 	now.type = then.type = parent_then.type = tv->type;
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	parent_ns = SAFE_OPEN("/proc/self/ns/time_for_children", O_RDONLY);
 }
 
@@ -134,7 +130,16 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_ns_clock,
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+#if (__NR_clock_gettime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_gettime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 4542995f2..da652dff9 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -86,23 +86,19 @@ static struct tst_ts *rm;
 static struct test_variants {
 	int (*func)(clockid_t clock_id, int flags, void *request, void *remain);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
 void setup(void)
 {
 	rq->type = variants[tst_variant].type;
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	SAFE_SIGNAL(SIGINT, sighandler);
 }
 
@@ -183,7 +179,16 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.setup = setup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
index 0a7ea5586..4e21cd34c 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
@@ -27,16 +27,13 @@ static struct test_variants {
 	int (*gettime)(clockid_t clk_id, void *ts);
 	int (*func)(clockid_t clock_id, int flags, void *request, void *remain);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .gettime = libc_clock_gettime, .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .gettime = libc_clock_gettime, .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .gettime = sys_clock_gettime, .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .gettime = sys_clock_gettime64, .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
@@ -54,8 +51,6 @@ static void verify_clock_nanosleep(void)
 	struct test_variants *tv = &variants[tst_variant];
 	struct tst_ts start, end, sleep_abs;
 
-	tst_res(TINFO, "Testing variant: %s", tv->desc);
-
 	start.type = end.type = sleep_abs.type = tv->type;
 
 	SAFE_UNSHARE(CLONE_NEWTIME);
@@ -106,7 +101,16 @@ static void verify_clock_nanosleep(void)
 
 static struct tst_test test = {
 	.test_all = verify_clock_nanosleep,
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep04.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep04.c
index 1f2d3c4f8..6bd685ee1 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep04.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep04.c
@@ -19,24 +19,16 @@ static struct test_variants {
 	int (*gettime)(clockid_t clk_id, void *ts);
 	int (*func)(clockid_t clock_id, int flags, void *request, void *remain);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .gettime = libc_clock_gettime, .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .gettime = libc_clock_gettime, .func = libc_clock_nanosleep, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .gettime = sys_clock_gettime, .func = sys_clock_nanosleep, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .gettime = sys_clock_gettime64, .func = sys_clock_nanosleep64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
-void setup(void)
-{
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
-}
-
 static void do_test(unsigned int i)
 {
 	struct test_variants *tv = &variants[tst_variant];
@@ -65,6 +57,13 @@ static void do_test(unsigned int i)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-	.test_variants = ARRAY_SIZE(variants),
-	.setup = setup,
+	.test_variants = (const char *[]) {
+#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 };
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime01.c b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
index ba6045fc5..a1d2bd115 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime01.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime01.c
@@ -27,23 +27,19 @@ static struct test_variants {
 	int (*gettime)(clockid_t clk_id, void *ts);
 	int (*settime)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
-	{ .gettime = libc_clock_gettime, .settime = libc_clock_settime, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
-
+	{ .gettime = libc_clock_gettime, .settime = libc_clock_settime, .type = TST_LIBC_TIMESPEC},
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
 static void setup(void)
 {
 	begin->type = change->type = end->type = variants[tst_variant].type;
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 }
 
 static void do_clock_gettime(struct test_variants *tv, struct tst_ts *ts)
@@ -105,7 +101,16 @@ static void verify_clock_settime(void)
 
 static struct tst_test test = {
 	.test_all = verify_clock_settime,
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+		"vDSO or syscall with libc spec",
+#if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.setup = setup,
 	.needs_root = 1,
 	.restore_wallclock = 1,
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime02.c b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
index 0a8245dd4..2ed896a9e 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime02.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime02.c
@@ -95,21 +95,17 @@ static struct test_variants {
 	int (*gettime)(clockid_t clk_id, void *ts);
 	int (*settime)(clockid_t clk_id, void *ts);
 	enum tst_ts_type type;
-	char *desc;
 } variants[] = {
 #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .gettime = sys_clock_gettime, .settime = sys_clock_settime, .type = TST_KERN_OLD_TIMESPEC},
 #endif
-
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .gettime = sys_clock_gettime64, .settime = sys_clock_settime64, .type = TST_KERN_TIMESPEC},
 #endif
 };
 
 static void setup(void)
 {
-	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
-
 	bad_addr = tst_get_bad_addr(NULL);
 }
 
@@ -163,7 +159,15 @@ static void verify_clock_settime(unsigned int i)
 
 static struct tst_test test = {
 	.test = verify_clock_settime,
-	.test_variants = ARRAY_SIZE(variants),
+	.test_variants = (const char *[]) {
+#if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
+		"syscall with old kernel spec",
+#endif
+#if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+		"syscall time64 with kernel spec",
+#endif
+		NULL
+	},
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
index 1d80ab0f7..400135138 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
@@ -11,8 +11,6 @@
 #include "lapi/syscalls.h"
 #include "lapi/fs.h"
 
-#define TEST_VARIANTS	2
-
 #define MNTPOINT	"mnt_point"
 #define FILE_SRC_PATH   "file_src"
 #define FILE_DEST_PATH  "file_dest"
@@ -29,16 +27,11 @@
 #define CONTSIZE	(sizeof(CONTENT) - 1)
 #define MIN_OFF   65537
 
-static void syscall_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing libc copy_file_range()");
-		break;
-	case 1:
-		tst_res(TINFO, "Testing __NR_copy_file_range syscall");
-	}
-}
+static const char *variant_desc[] = {
+	"libc copy_file_range()",
+	"__NR_copy_file_range syscall",
+	NULL
+};
 
 static int sys_copy_file_range(int fd_in, loff_t *off_in,
 		int fd_out, loff_t *off_out, size_t len, unsigned int flags)
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index 7d27007a3..59728aad9 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -213,7 +213,6 @@ static void copy_file_range_verify(unsigned int n)
 
 static void setup(void)
 {
-	syscall_info();
 	page_size = getpagesize();
 	cross_sup = verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH);
 }
@@ -231,5 +230,5 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.test = copy_file_range_verify,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index fa679c4d3..3a1c26cba 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -182,7 +182,6 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	syscall_info();
 	char dev_path[1024];
 
 	cross_sup = verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH);
@@ -248,5 +247,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.needs_root = 1,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
index 253eb57ad..300df4c04 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range03.c
@@ -58,8 +58,6 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	syscall_info();
-
 	fd_dest = SAFE_OPEN(FILE_DEST_PATH, O_RDWR | O_CREAT, 0664);
 	fd_src  = SAFE_OPEN(FILE_SRC_PATH,  O_RDWR | O_CREAT, 0664);
 	SAFE_WRITE(1, fd_src,  CONTENT,  CONTSIZE);
@@ -73,5 +71,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 784ec9211..c2047d5df 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -42,8 +42,6 @@ static int sample_fn(int clk_id, long long usec)
 
 static void setup(void)
 {
-	select_info();
-
 	SAFE_PIPE(fds);
 }
 
@@ -60,6 +58,6 @@ static struct tst_test test = {
 	.scall = "select()",
 	.sample = sample_fn,
 	.setup = setup,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index b19a1d1bf..52e4b8693 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -59,24 +59,12 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 	return -1;
 }
 
-static void select_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing libc select()");
-	break;
-	case 1:
-		tst_res(TINFO, "Testing SYS_select syscall");
-	break;
-	case 2:
-		tst_res(TINFO, "Testing SYS_pselect6 syscall");
-	break;
-	case 3:
-		tst_res(TINFO, "Testing SYS__newselect syscall");
-	break;
-	}
-}
-
-#define TEST_VARIANTS 4
+static const char *variant_desc[] = {
+	"libc select()",
+	"SYS_select syscall",
+	"SYS_pselect6 syscall",
+	"SYS__newselect syscall",
+	NULL
+};
 
 #endif /* SELECT_VAR__ */
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index 37084102e..c6c2827f5 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -95,8 +95,6 @@ static void setup(void)
 	rcv_msg[0].msg_hdr.msg_iovlen = 1;
 	rcv_msg[1].msg_hdr.msg_iov = rcv2;
 	rcv_msg[1].msg_hdr.msg_iovlen = 1;
-
-	test_info();
 }
 
 static void cleanup(void)
@@ -111,7 +109,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 	.bufs = (struct tst_buffers []) {
 		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
 		{&snd2, .iov_sizes = (int[]){6, -1}},
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
index f00cf056a..8643df17a 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg_var.h
@@ -18,7 +18,7 @@ static int do_sendmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
 #ifdef HAVE_SENDMMSG
 		return sendmmsg(sockfd, msgvec, vlen, flags);
 #else
-		tst_brk(TCONF, "libc sendmmsg not present");
+		tst_brk(TCONF, "libc sendmmsg() not present");
 #endif
 	}
 
@@ -36,25 +36,17 @@ static int do_recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
 #ifdef HAVE_RECVMMSG
 		return recvmmsg(sockfd, msgvec, vlen, flags, timeout);
 #else
-		tst_brk(TCONF, "libc recvmmsg not present");
+		tst_brk(TCONF, "libc recvmmsg() not present");
 #endif
 	}
 
 	return -1;
 }
 
-static void test_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing direct sendmmsg and recvmmsg syscalls");
-		break;
-	case 1:
-		tst_res(TINFO, "Testing libc sendmmsg and recvmmsg syscalls");
-		break;
-	}
-}
-
-#define TEST_VARIANTS 2
+static const char *variant_desc[] = {
+	"raw sendmmsg() and recvmmsg() syscalls",
+	"libc sendmmsg() and recvmmsg()",
+	NULL
+};
 
 #endif /* SENDMMSG_VAR__ */
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname.h b/testcases/kernel/syscalls/setdomainname/setdomainname.h
index 12c8a088f..37dde3365 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname.h
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname.h
@@ -27,19 +27,11 @@
 
 static char backup[_UTSNAME_DOMAIN_LENGTH];
 
-#define TEST_VARIANTS 2
-
-static void setdomainname_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing libc set" SYSCALL_NAME "()");
-		break;
-	case 1:
-		tst_res(TINFO, "Testing __NR_set" SYSCALL_NAME " syscall");
-		break;
-	}
-}
+static const char *variant_desc[] = {
+	"libc set" SYSCALL_NAME "()",
+	"__NR_set" SYSCALL_NAME " syscall",
+	NULL
+};
 
 static int do_setdomainname(char *new, size_t len)
 {
@@ -56,7 +48,6 @@ static int do_setdomainname(char *new, size_t len)
 
 static void setup(void)
 {
-	setdomainname_info();
 	if ((GET_SYSCALL(backup, sizeof(backup))) < 0)
 		tst_brk(TBROK | TERRNO, "get" SYSCALL_NAME "() failed");
 }
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname01.c b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
index 4c2c53124..301690fa5 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname01.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname01.c
@@ -31,5 +31,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname02.c b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
index 875ed0c44..64c02dc60 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname02.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname02.c
@@ -50,5 +50,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_setdomainname,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/setdomainname/setdomainname03.c b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
index b8d17d8da..ae412ca3d 100644
--- a/testcases/kernel/syscalls/setdomainname/setdomainname03.c
+++ b/testcases/kernel/syscalls/setdomainname/setdomainname03.c
@@ -50,5 +50,5 @@ static struct tst_test test = {
 	.setup = setup_setuid,
 	.cleanup = cleanup_setuid,
 	.test_all = do_test,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index b9a3c5e84..cade43453 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) International Business Machines  Corp., 2002
- * Copyright (c) Linux Test Project, 2009-2019
+ * Copyright (c) Linux Test Project, 2009-2020
  *
  * AUTHORS
  * Paul Larson
@@ -18,21 +18,6 @@
 #include "ltp_signal.h"
 #include "lapi/syscalls.h"
 
-static void sigpending_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing libc sigpending()");
-	break;
-	case 1:
-		tst_res(TINFO, "Testing __NR_sigpending syscall");
-	break;
-	case 2:
-		tst_res(TINFO, "Testing __NR_rt_sigpending syscall");
-	break;
-	}
-}
-
 static int tested_sigpending(sigset_t *sigset)
 {
 	switch (tst_variant) {
@@ -156,12 +141,16 @@ static void test_efault_on_invalid_sigset(void)
 
 static void run(void)
 {
-	sigpending_info();
 	test_sigpending();
 	test_efault_on_invalid_sigset();
 }
 
 static struct tst_test test = {
 	.test_all = run,
-	.test_variants = 3,
+	.test_variants = (const char *[]) {
+		"libc sigpending()",
+		"__NR_sigpending syscall",
+		"__NR_rt_sigpending syscall",
+		NULL
+	},
 };
diff --git a/testcases/kernel/syscalls/stime/stime01.c b/testcases/kernel/syscalls/stime/stime01.c
index 82a340258..147c70301 100644
--- a/testcases/kernel/syscalls/stime/stime01.c
+++ b/testcases/kernel/syscalls/stime/stime01.c
@@ -52,15 +52,9 @@ static void run(void)
 	}
 }
 
-static void setup(void)
-{
-	stime_info();
-}
-
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.restore_wallclock = 1,
-	.setup = setup,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/stime/stime02.c b/testcases/kernel/syscalls/stime/stime02.c
index 126a49ade..10dc0496e 100644
--- a/testcases/kernel/syscalls/stime/stime02.c
+++ b/testcases/kernel/syscalls/stime/stime02.c
@@ -47,8 +47,6 @@ static void setup(void)
 	time_t curr_time;
 	struct passwd *ltpuser;
 
-	stime_info();
-
 	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETUID(ltpuser->pw_uid);
 
@@ -62,5 +60,5 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.needs_root = 1,
-	.test_variants = TEST_VARIANTS,
+	.test_variants = variant_desc,
 };
diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index b33c5704e..8027fc528 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -38,19 +38,11 @@ static int do_stime(time_t *ntime)
 	return -1;
 }
 
-static void stime_info(void)
-{
-	switch (tst_variant) {
-	case 0:
-		tst_res(TINFO, "Testing libc stime()");
-	break;
-	case 1:
-		tst_res(TINFO, "Testing SYS_stime syscall");
-	break;
-	case 2:
-		tst_res(TINFO, "Testing SYS_settimeofday syscall");
-	break;
-	}
-}
+static const char *variant_desc[] = {
+	"libc stime()",
+	"SYS_stime syscall",
+	"SYS_settimeofday syscall",
+	NULL
+};
 
 #endif /* STIME_VAR__ */
-- 
2.26.2

