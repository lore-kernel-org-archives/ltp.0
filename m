From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jun 2017 14:33:58 +0200
Subject: [LTP] [PATCH v2] syscalls: Add timer measurement library
In-Reply-To: <20170620114951.GC5369@rei.lan>
References: <20170614124239.21109-1-chrubis@suse.cz>
 <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
 <20170620114951.GC5369@rei.lan>
Message-ID: <20170620123358.GD5369@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
What about this patch:

From 5cc450f19eb526cb19c33f4f13796e3c2a6f0bff Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jun 2017 14:33:59 +0200
Subject: [PATCH] Fix clock_gettime linking problems.

---
 include/tst_clocks.h |   29 +++++++++++++++++++++++++++++
 lib/tst_clocks.c     |   37 +++++++++++++++++++++++++++++++++++++
 lib/tst_timer.c      |   13 +++++++------
 lib/tst_timer_test.c |    3 ++-
 4 files changed, 75 insertions(+), 7 deletions(-)
 create mode 100644 include/tst_clocks.h
 create mode 100644 lib/tst_clocks.c

diff --git a/include/tst_clocks.h b/include/tst_clocks.h
new file mode 100644
index 0000000..ee2f645
--- /dev/null
+++ b/include/tst_clocks.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+/*
+ * clock_gettime() and clock_getres() functions
+ */
+
+#ifndef TST_CLOCKS__
+#define TST_CLOCKS__
+
+int tst_clock_getres(clockid_t clk_id, struct timespec *res);
+
+int tst_clock_gettime(clockid_t clk_id, struct timespec *ts);
+
+#endif /* TST_CLOCKS__ */
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
new file mode 100644
index 0000000..87413a3
--- /dev/null
+++ b/lib/tst_clocks.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
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
+/*
+ * clock_gettime() and clock_getres() functions
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <time.h>
+#include <sys/syscall.h>
+
+#include "tst_clocks.h"
+
+int tst_clock_getres(clockid_t clk_id, struct timespec *res)
+{
+	return syscall(SYS_clock_getres, clk_id, res);
+}
+
+int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
+{
+	return syscall(SYS_clock_gettime, clk_id, ts);
+}
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index bd3f277..afdb441 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -25,6 +25,7 @@
 
 #include "test.h"
 #include "tst_timer.h"
+#include "tst_clocks.h"
 #include "lapi/posix_clocks.h"
 
 static struct timespec start_time, stop_time;
@@ -56,7 +57,7 @@ static const char *clock_name(clockid_t clk_id)
 
 void tst_timer_check(clockid_t clk_id)
 {
-	if (clock_gettime(clk_id, &start_time)) {
+	if (tst_clock_gettime(clk_id, &start_time)) {
 		if (errno == EINVAL) {
 			tst_brkm(TCONF, NULL,
 			         "Clock id %s(%u) not supported by kernel",
@@ -64,7 +65,7 @@ void tst_timer_check(clockid_t clk_id)
 			return;
 		}
 
-		tst_brkm(TBROK | TERRNO, NULL, "clock_gettime() failed");
+		tst_brkm(TBROK | TERRNO, NULL, "tst_clock_gettime() failed");
 	}
 }
 
@@ -72,14 +73,14 @@ void tst_timer_start(clockid_t clk_id)
 {
 	clock_id = clk_id;
 
-	if (clock_gettime(clock_id, &start_time))
-		tst_resm(TWARN | TERRNO, "clock_gettime() failed");
+	if (tst_clock_gettime(clock_id, &start_time))
+		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 void tst_timer_stop(void)
 {
-	if (clock_gettime(clock_id, &stop_time))
-		tst_resm(TWARN | TERRNO, "clock_gettime() failed");
+	if (tst_clock_gettime(clock_id, &stop_time))
+		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
 struct timespec tst_timer_elapsed(void)
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 4627a4e..8921547 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -23,6 +23,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_timer_test.h"
+#include "tst_clocks.h"
 
 #define MAX_SAMPLES 500
 
@@ -339,7 +340,7 @@ static void timer_setup(void)
 	struct timespec t;
 	int ret;
 
-	clock_getres(CLOCK_MONOTONIC, &t);
+	tst_clock_getres(CLOCK_MONOTONIC, &t);
 
 	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
 
-- 
1.7.10.4


-- 
Cyril Hrubis
chrubis@suse.cz
