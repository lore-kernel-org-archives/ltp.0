From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 17 Jun 2021 18:55:55 +0800
Subject: [LTP] [PATCH 2/3 v2] lib: tst_process_state: Add
 tst_process_exit_wait()
In-Reply-To: <20210617105556.130869-1-xieziyao@huawei.com>
References: <20210617105556.130869-1-xieziyao@huawei.com>
Message-ID: <20210617105556.130869-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tst_process_exit_wait() checks a given pid is present on the system.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Instead of checking /proc/$PID, do kill(2) with signal == 0 to check
for the existence of a $PID.

 include/tst_process_state.h | 12 ++++++++++--
 lib/tst_process_state.c     | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index 32eaf46d9..457ff6056 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
+ * Copyright (C) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

 /*
@@ -12,6 +13,8 @@

 #include <unistd.h>

+#ifdef TST_TEST_H__
+
 /*
  * Waits for process state change.
  *
@@ -23,10 +26,14 @@
  * Z - zombie process
  * T - process is traced
  */
-#ifdef TST_TEST_H__
-
 #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
 	tst_process_state_wait(__FILE__, __LINE__, NULL, (pid), (state), (msec_timeout))
+
+/*
+ * Check that a given pid is present on the system
+ */
+#define TST_PROCESS_EXIT_WAIT(pid, msec_timeout) \
+	tst_process_exit_wait((pid), (msec_timeout))
 #else
 /*
  * The same as above but does not use tst_brkm() interface.
@@ -44,5 +51,6 @@ int tst_process_state_wait2(pid_t pid, const char state);
 int tst_process_state_wait(const char *file, const int lineno,
 			   void (*cleanup_fn)(void), pid_t pid,
 			   const char state, unsigned int msec_timeout);
+int tst_process_exit_wait(pid_t pid, unsigned int msec_timeout);

 #endif /* TST_PROCESS_STATE__ */
diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 2f42895b7..08a9d0966 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

 #include <stdio.h>
@@ -67,3 +68,23 @@ int tst_process_state_wait2(pid_t pid, const char state)
 		usleep(10000);
 	}
 }
+
+int tst_process_exit_wait(pid_t pid, unsigned int msec_timeout)
+{
+	unsigned int msecs = 0;
+
+	for (;;) {
+		if (kill(pid, 0) && errno == ESRCH)
+			break;
+
+		usleep(1000);
+		msecs += 1;
+
+		if (msec_timeout && msecs >= msec_timeout) {
+			errno = ETIMEDOUT;
+			return 0;
+		}
+	}
+
+	return 1;
+}
--
2.17.1

