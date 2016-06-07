From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jun 2016 14:45:07 +0200
Subject: [LTP] [PATCH 3/3] lib/tst_test.c: Kill all children on timeout
Message-ID: <20160607124506.GA4236@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Run actuall test in a separate process group

* Deliver SIGKILL to all children on timeout

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/.gitignore |  1 +
 lib/newlib_tests/test13.c   | 37 +++++++++++++++++++++++++++++++++++++
 lib/tst_test.c              |  6 ++++--
 3 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 lib/newlib_tests/test13.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index dccf4c8..ea19310 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -10,3 +10,4 @@ test09
 test10
 test11
 test12
+test13
diff --git a/lib/newlib_tests/test13.c b/lib/newlib_tests/test13.c
new file mode 100644
index 0000000..7ad5172
--- /dev/null
+++ b/lib/newlib_tests/test13.c
@@ -0,0 +1,37 @@
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
+ * Test for timeout & children.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	SAFE_FORK();
+	SAFE_FORK();
+	SAFE_FORK();
+
+	tst_res(TINFO, "Pausing process pid %i", getpid());
+	pause();
+}
+
+static struct tst_test test = {
+	.tid = "test13",
+	.timeout = 1,
+	.forks_child = 1,
+	.test_all = do_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index eef54e4..9122f57 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -660,7 +660,7 @@ static unsigned int timeout = 300;
 
 static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	kill(test_pid, SIGKILL);
+	kill(-test_pid, SIGKILL);
 }
 
 static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
@@ -702,8 +702,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
 
-	if (!test_pid)
+	if (!test_pid) {
+		SAFE_SETPGID(0, 0);
 		testrun();
+	}
 
 	SAFE_WAITPID(test_pid, &status, 0);
 
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
