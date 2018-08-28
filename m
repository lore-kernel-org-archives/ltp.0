From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 16:40:06 +0200
Subject: [LTP] [PATCH RFC v3 2/3] lib: introduce tst_timeout_remaining()
In-Reply-To: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
Message-ID: <5730db8dee0c566014c99bc0d264326fe1c923cc.1535466715.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which returns number of seconds remaining till timeout.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_test.h        |   1 +
 lib/newlib_tests/test18   | Bin 0 -> 384032 bytes
 lib/newlib_tests/test18.c |  32 ++++++++++++++++++++++++++++++++
 lib/tst_test.c            |  21 +++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100755 lib/newlib_tests/test18
 create mode 100644 lib/newlib_tests/test18.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf3873ab..c0c9a7c7b995 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -217,6 +217,7 @@ const char *tst_strsig(int sig);
  */
 const char *tst_strstatus(int status);
 
+unsigned int tst_timeout_remaining(void);
 void tst_set_timeout(int timeout);
 
 #ifndef TST_NO_DEFAULT_MAIN
diff --git a/lib/newlib_tests/test18 b/lib/newlib_tests/test18
new file mode 100755
index 000000000000..01dc1d7976fe
Binary files /dev/null and b/lib/newlib_tests/test18 differ
diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test18.c
new file mode 100644
index 000000000000..aba007d3689c
--- /dev/null
+++ b/lib/newlib_tests/test18.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2018, Linux Test Project
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
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	unsigned int remaining = tst_timeout_remaining();
+	if (remaining >= 200)
+		tst_res(TPASS, "Timeout remaining: %d", remaining);
+	else
+		tst_res(TFAIL, "Timeout remaining: %d", remaining);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357d2fcc..75619fabffa4 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -47,6 +47,8 @@ static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
+static clockid_t tst_clock;
+static struct timespec tst_start_time;
 
 struct results {
 	int passed;
@@ -758,6 +760,7 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
+	tst_clock = tst_timer_find_clock();
 
 	parse_opts(argc, argv);
 
@@ -992,6 +995,21 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
+unsigned int tst_timeout_remaining(void)
+{
+	static struct timespec now;
+	unsigned int elapsed;
+
+	if (tst_clock_gettime(tst_clock, &now))
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+
+	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
+	if (results->timeout > elapsed)
+		return results->timeout - elapsed;
+
+	return 0;
+}
+
 void tst_set_timeout(int timeout)
 {
 	char *mul = getenv("LTP_TIMEOUT_MUL");
@@ -1012,6 +1030,9 @@ void tst_set_timeout(int timeout)
 		results->timeout = results->timeout * m + 0.5;
 	}
 
+	if (tst_clock_gettime(tst_clock, &tst_start_time))
+		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
 		results->timeout % 60);
-- 
1.8.3.1

