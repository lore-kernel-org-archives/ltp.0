From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Mar 2017 16:33:25 +0100
Subject: [LTP] [PATCH] syscalls/pselect01: Convert to the new API
Message-ID: <20170314153325.9701-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Convert to the new library API

* Make use of tst_timer.h

* The "read from file" test has been moved to pselect03.c

* Speed up the test, now takes ~1.5s previously ~11s

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltplite                               |   1 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/.gitignore          |   2 +
 testcases/kernel/syscalls/pselect/pselect01.c | 152 ++++++++------------------
 testcases/kernel/syscalls/pselect/pselect03.c |  65 +++++++++++
 5 files changed, 115 insertions(+), 107 deletions(-)
 create mode 100644 testcases/kernel/syscalls/pselect/pselect03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index d4580ad..1b8dc62 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -600,6 +600,7 @@ profil01 profil01
 
 pselect01 pselect01
 pselect02 pselect02
+pselect03 pselect03
 
 ptrace01 ptrace01
 ptrace02 ptrace02
diff --git a/runtest/syscalls b/runtest/syscalls
index 89abac5..b7ebe26 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -821,6 +821,8 @@ pselect01 pselect01
 pselect01_64 pselect01_64
 pselect02 pselect02
 pselect02_64 pselect02_64
+pselect03 pselect03
+pselect03_64 pselect03_64
 
 ptrace01 ptrace01
 ptrace02 ptrace02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 9a4727c..99bed26 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -689,6 +689,8 @@
 /pselect/pselect01_64
 /pselect/pselect02
 /pselect/pselect02_64
+/pselect/pselect03
+/pselect/pselect03_64
 /ptrace/_syscalls.h
 /ptrace/ptrace01
 /ptrace/ptrace02
diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
index 21f02db..6f3b77b 100644
--- a/testcases/kernel/syscalls/pselect/pselect01.c
+++ b/testcases/kernel/syscalls/pselect/pselect01.c
@@ -32,133 +32,71 @@
 #include <time.h>
 #include <unistd.h>
 #include <errno.h>
-#include <stdint.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_timer.h"
 
-static void setup(void);
-static void cleanup(void);
+struct tcase {
+	struct timespec tv;
+	unsigned int iterations;
+};
 
-TCID_DEFINE(pselect01);
-int TST_TOTAL = 9;
+static struct tcase tcases[] = {
+	{{1, 0},         1},
+	{{0, 1000000}, 100},
+	{{0, 2000000}, 100},
+	{{0, 10000000}, 10},
+	{{0, 100000000}, 1},
+};
 
-#define FILENAME "pselect01_test"
-#define LOOP_COUNT 4
-
-static int fd;
-
-static void pselect_verify(void)
+static void verify_pselect(unsigned int n)
 {
 	fd_set readfds;
-	struct timespec tv, tv_start, tv_end;
-	long real_nsec, total_nsec;
-	double real_sec;
-	int total_sec, retval;
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
-	tv.tv_sec = 0;
-	tv.tv_nsec = 0;
+	struct timespec tv;
+	long long requested_us, slept_us = 0;
+	unsigned int i;
+	int threshold;
+	struct tcase *t = &tcases[n];
 
-	retval = pselect(fd, &readfds, 0, 0, &tv, NULL);
-	if (retval >= 0)
-		tst_resm(TPASS, "pselect() succeeded retval=%i", retval);
-	else
-		tst_resm(TFAIL | TERRNO, "pselect() failed unexpectedly");
+	tst_res(TINFO, "pselect() sleeping for %li secs %li nsec %i iterations",
+			t->tv.tv_sec, t->tv.tv_nsec, t->iterations);
 
-	for (total_sec = 1; total_sec <= LOOP_COUNT; total_sec++) {
+	for (i = 0; i < t->iterations; i++) {
 		FD_ZERO(&readfds);
 		FD_SET(0, &readfds);
 
-		tv.tv_sec = total_sec;
-		tv.tv_nsec = 0;
+		tv = t->tv;
 
-		tst_resm(TINFO,
-			 "Testing basic pselect sanity,Sleeping for %jd secs",
-			 (intmax_t) tv.tv_sec);
-		clock_gettime(CLOCK_MONOTONIC, &tv_start);
+		tst_timer_start(CLOCK_MONOTONIC);
 		pselect(0, &readfds, NULL, NULL, &tv, NULL);
-		clock_gettime(CLOCK_MONOTONIC, &tv_end);
+		tst_timer_stop();
 
-		real_sec = (0.5 + (tv_end.tv_sec - tv_start.tv_sec +
-				   1e-9 * (tv_end.tv_nsec - tv_start.tv_nsec)));
-		if (abs(real_sec - total_sec) < 0.2 * total_sec)
-			tst_resm(TPASS, "Sleep time was correct "
-				 "(%lf/%d < 20 %%)", real_sec, total_sec);
-		else
-			tst_resm(TFAIL, "Sleep time was incorrect (%d/%lf "
-				 ">= 20%%)", total_sec, real_sec);
+		slept_us += tst_timer_elapsed_us();
 	}
 
-#ifdef DEBUG
-	tst_resm(TINFO, "Now checking nsec sleep precision");
-#endif
-	for (total_nsec = 1e8; total_nsec <= LOOP_COUNT * 1e8;
-	     total_nsec += 1e8) {
-		FD_ZERO(&readfds);
-		FD_SET(0, &readfds);
-
-		tv.tv_sec = 0;
-		tv.tv_nsec = total_nsec;
+	requested_us = tst_timespec_to_us(t->tv) * t->iterations;
+	threshold = requested_us / 100 + 200 * t->iterations;
 
-		tst_resm(TINFO,
-			 "Testing basic pselect sanity,Sleeping for %ld nano secs",
-			 tv.tv_nsec);
-		clock_gettime(CLOCK_MONOTONIC, &tv_start);
-		pselect(0, &readfds, NULL, NULL, &tv, NULL);
-		clock_gettime(CLOCK_MONOTONIC, &tv_end);
-
-		real_nsec = (tv_end.tv_sec - tv_start.tv_sec) * 1e9 +
-		    tv_end.tv_nsec - tv_start.tv_nsec;
-
-		/* allow 20% error */
-		if (abs(real_nsec - tv.tv_nsec) < 0.2 * total_nsec) {
-			tst_resm(TPASS, "Sleep time was correct");
-		} else {
-			tst_resm(TWARN,
-				 "This test could fail if the system was under load");
-			tst_resm(TWARN,
-				 "due to the limitation of the way it calculates the");
-			tst_resm(TWARN, "system call execution time.");
-			tst_resm(TFAIL,
-				 "Sleep time was incorrect:%ld nsec vs expected %ld nsec",
-				 real_nsec, total_nsec);
-		}
+	if (slept_us < requested_us) {
+		tst_res(TFAIL,
+			"pselect() woken up too early %llius, expected %llius",
+			slept_us, requested_us);
+		return;
 	}
-}
-
-int main(int argc, char *argv[])
-{
-	int lc;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		pselect_verify();
+	if (slept_us - requested_us > threshold) {
+		tst_res(TFAIL,
+			"pselect() slept for too long %llius, expected %llius, threshold %i",
+			slept_us, requested_us, threshold);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	tst_timer_check(CLOCK_MONOTONIC);
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, FILENAME, O_CREAT | O_RDWR, 0777);
-
-	TEST_PAUSE;
+	tst_res(TPASS, "pselect() slept for %llius, requested %llius, treshold %i",
+		slept_us, requested_us, threshold);
 }
 
-static void cleanup(void)
-{
-	if (fd && close(fd))
-		tst_resm(TWARN | TERRNO, "close() failed");
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "pselect01",
+	.test = verify_pselect,
+	.tcnt = ARRAY_SIZE(tcases),
+};
diff --git a/testcases/kernel/syscalls/pselect/pselect03.c b/testcases/kernel/syscalls/pselect/pselect03.c
new file mode 100644
index 0000000..a92531e
--- /dev/null
+++ b/testcases/kernel/syscalls/pselect/pselect03.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+ /*
+  * This is basic test for pselect() returning without error.
+  */
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/select.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "tst_test.h"
+
+static int fd;
+
+static void verify_pselect(void)
+{
+	fd_set readfds;
+	struct timespec tv = {0};
+
+	FD_ZERO(&readfds);
+	FD_SET(fd, &readfds);
+
+	TEST(pselect(fd, &readfds, 0, 0, &tv, NULL));
+	if (TEST_RETURN >= 0)
+		tst_res(TPASS, "pselect() succeeded retval=%li", TEST_RETURN);
+	else
+		tst_res(TFAIL | TTERRNO, "pselect() failed unexpectedly");
+}
+
+static void setup(void)
+{
+	fd = SAFE_OPEN("pselect03_file", O_CREAT | O_RDWR, 0777);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tid = "pselect03",
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_pselect,
+};
-- 
2.10.2

