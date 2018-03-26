From: Xiong Zhou <xzhou@redhat.com>
Date: Mon, 26 Mar 2018 21:28:15 +0800
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
Message-ID: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/Makefile  |   3 +
 testcases/kernel/syscalls/fcntl/fcntl37.c | 146 ++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl37.c

diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index ae37214..7a06aa7 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -27,6 +27,9 @@ fcntl34_64: LDLIBS += -lpthread
 fcntl36: LDLIBS += -lpthread
 fcntl36_64: LDLIBS += -lpthread
 
+fcntl37: LDLIBS += -lpthread
+fcntl37_64: LDLIBS += -lpthread
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
new file mode 100644
index 0000000..bac2168
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2018 RedHat Inc. All Rights Reserved.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Xiong Zhou <xzhou@redhat.com>
+ *
+ * This is testing for
+ *
+ *	"Record locks are not inherited by a child created via fork(2),
+ *	 but are preserved across an execve(2)."
+ *
+ * from fcntl(2) man page.
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <limits.h>
+
+#include "lapi/fcntl.h"
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+static const char fname[] = "tst_lock_execve";
+static const char flag_fname[] = "/tmp/execved";
+static void cleanup(void);
+
+static void *thread_fn(void *arg)
+{
+	int fd = *(int *)arg;
+	tst_res(TINFO, "Thread running. fd %d", fd);
+	/* Just need to be alive when execve. */
+	sleep(5);
+	SAFE_CLOSE(fd);
+	return NULL;
+}
+
+static void checklock(int fd)
+{
+	pid_t pid = SAFE_FORK();
+	if (pid == 0) {
+		struct flock flck = {
+			.l_type = F_WRLCK,
+			.l_whence = SEEK_SET,
+			.l_start = 0,
+			.l_len = 1,
+		};
+		SAFE_FCNTL(fd, F_GETLK, &flck);
+		if (flck.l_type == F_UNLCK)
+			tst_res(TFAIL, "Record lock gets lost after execve");
+		else
+			tst_res(TPASS, "Record lock survives execve");
+		SAFE_CLOSE(fd);
+		_exit(0);
+	}
+	waitpid(pid, NULL, 0);
+}
+
+static void test01(void)
+{
+	int fd, ret;
+	struct stat stat_buf;
+
+	/*
+	 * If tmp/tst_lock_execve exists, execve to run checklock.
+	 */
+	ret = stat(flag_fname, &stat_buf);
+	if (ret == 0) {
+		checklock(fd);
+		cleanup();
+		_exit(0);
+	}
+
+	/*
+	 * If tmp/tst_lock_execve does not exist, initialize it.
+	 */
+	SAFE_OPEN(flag_fname, O_RDWR|O_CREAT, 0755);
+	fd = SAFE_OPEN(fname, O_RDWR|O_CREAT, 0755);
+	struct flock64 flck = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+		.l_start  = 0,
+		.l_len    = 1,
+	};
+	SAFE_FCNTL(fd, F_SETLK, &flck);
+
+	/*
+	 * Creat thread and keep it running after placing posix
+	 * write lock.
+	 */
+	pthread_t th;
+	SAFE_PTHREAD_CREATE(&th, NULL, thread_fn, (void *)&fd);
+	sleep(1);
+
+	/*
+	 * Clear CLOEXEC
+	 */
+	int flags=SAFE_FCNTL(fd, F_GETFD);
+	flags &= ~FD_CLOEXEC;
+	SAFE_FCNTL(fd, F_SETFD, flags);
+
+	/*
+	 * Get full path name of running programm then execve.
+	 */
+	char prog_name[PATH_MAX];
+	ret = readlink("/proc/self/exe", prog_name, PATH_MAX);
+	char * const newargv[] = { prog_name, NULL, NULL };
+	tst_res(TINFO, "execve %s with %s locked", prog_name, fname);
+	execve(prog_name, newargv, NULL);
+	/*
+	 * Failure info for debug
+	 */
+	perror("execve ");
+}
+
+static void cleanup(void)
+{
+	SAFE_UNLINK(flag_fname);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.test_all = test01,
+	.cleanup = cleanup,
+};
-- 
1.8.3.1

