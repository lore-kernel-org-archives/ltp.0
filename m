From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  3 Mar 2017 12:53:08 +0100
Subject: [LTP] [PATCH/RFC] sem_post/8-1: improve "child blocked on
	semaphore" detection
Message-ID: <bb0386f4e3b165f3f1897824d02bdeedbcc4bdfb.1488541575.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In POSIX, we can't tell how many processes are blocked on semaphore.
Each child process in this test uses 2 semaphores, first can always
be taken and is used only for its semval, to tell if child started
and presumably will soon block on the second semaphore.

Test assumes that if child holds first semaphore, then it will
take second one within 100us.

This patch replaces that sleep with a wait until child process
state changes to 'S' (sleeping).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sem_post/8-1.c          |  6 ++-
 testcases/open_posix_testsuite/include/proc.h      | 61 ++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 testcases/open_posix_testsuite/include/proc.h

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
index 08e94639acaf..d41a7e47ea91 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
@@ -44,6 +44,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <stdlib.h>
+#include "proc.h"
 
 #define TEST "sem_post_8-1"
 
@@ -184,7 +185,8 @@ int main(void)
 		usleep(100);
 		sem_getvalue(sem_1, &val);
 	} while (val != 1);
-	usleep(100);
+	tst_process_state_wait3(c_1, 'S', 2000);
+	tst_process_state_wait3(c_2, 'S', 2000);
 
 	c_3 = fork();
 	switch (c_3) {
@@ -204,7 +206,7 @@ int main(void)
 		usleep(100);
 		sem_getvalue(sem_1, &val);
 	} while (val != 0);
-	usleep(100);
+	tst_process_state_wait3(c_3, 'S', 2000);
 
 	/* Ok, let's release the lock */
 	fprintf(stderr, "P: release lock\n");
diff --git a/testcases/open_posix_testsuite/include/proc.h b/testcases/open_posix_testsuite/include/proc.h
new file mode 100644
index 000000000000..d58fb13549bd
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/proc.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) 2017 Linux Test Project
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms in version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ */
+
+#ifdef __linux__
+# include <errno.h>
+# include <string.h>
+int tst_process_state_wait3(pid_t pid, const char state,
+	unsigned long maxwait_ms)
+{
+	char proc_path[128], cur_state;
+	int wait_step_ms = 10;
+	unsigned long waited_ms = 0;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%i/stat", pid);
+
+	for (;;) {
+		FILE *f = fopen(proc_path, "r");
+
+		if (!f) {
+			fprintf(stderr, "Failed to open '%s': %s\n",
+				proc_path, strerror(errno));
+			return 1;
+		}
+
+		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
+			fclose(f);
+			fprintf(stderr, "Failed to read '%s': %s\n",
+				proc_path, strerror(errno));
+			return 1;
+		}
+		fclose(f);
+
+		if (state == cur_state)
+			return 0;
+
+		usleep(wait_step_ms * 1000);
+		waited_ms += wait_step_ms;
+
+		if (waited_ms >= maxwait_ms) {
+			fprintf(stderr, "Reached max wait time\n");
+			return 1;
+		}
+	}
+}
+#else
+int tst_process_state_wait3(pid_t pid, const char state,
+	unsigned long maxwait_ms)
+{
+	usleep(maxwait_ms * 1000);
+}
+#endif
-- 
1.8.3.1

