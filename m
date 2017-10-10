From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 14:32:05 +0200
Subject: [LTP] [PATCH v2 15/15] fs/fs_fill: Add a test to fill a FS in a few
	threads
In-Reply-To: <20171010123205.20147-1-chrubis@suse.cz>
References: <20171010123205.20147-1-chrubis@suse.cz>
Message-ID: <20171010123205.20147-15-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Runs CPU+2 threads that write into FS until they got ENOSPC, then delete
a file and continue.

Older exfat fails with EIO instead of ENOSPC, it has been fixed in:

commit ca112f07b115a419250b6526e71345dcd29e4d67
Author: relan <relan@users.noreply.github.com>
Date:   Tue Dec 27 17:22:12 2016 +0300

    Propagate ENOSPC on write.

at:

https://github.com/relan/exfat/

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/fs                             |   2 +
 testcases/kernel/fs/fs_fill/.gitignore |   1 +
 testcases/kernel/fs/fs_fill/Makefile   |  22 +++++++
 testcases/kernel/fs/fs_fill/fs_fill.c  | 114 +++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 testcases/kernel/fs/fs_fill/.gitignore
 create mode 100644 testcases/kernel/fs/fs_fill/Makefile
 create mode 100644 testcases/kernel/fs/fs_fill/fs_fill.c

diff --git a/runtest/fs b/runtest/fs
index 33a8412fd..3fa210a9f 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -76,3 +76,5 @@ fs_racer fs_racer.sh -t 5
 quota_remount_test01 quota_remount_test01.sh
 
 isofs isofs.sh
+
+fs_fill fs_fill
diff --git a/testcases/kernel/fs/fs_fill/.gitignore b/testcases/kernel/fs/fs_fill/.gitignore
new file mode 100644
index 000000000..ebdfb439f
--- /dev/null
+++ b/testcases/kernel/fs/fs_fill/.gitignore
@@ -0,0 +1 @@
+fs_fill
diff --git a/testcases/kernel/fs/fs_fill/Makefile b/testcases/kernel/fs/fs_fill/Makefile
new file mode 100644
index 000000000..f0e092b13
--- /dev/null
+++ b/testcases/kernel/fs/fs_fill/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2017 Linux Test Project
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS += -pthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
new file mode 100644
index 000000000..c9ce39619
--- /dev/null
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -0,0 +1,114 @@
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
+ * Runs several threads that fills up the filesystem repeatedly.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+
+#define MNTPOINT "mntpoint"
+
+static volatile int run;
+static unsigned int nthreads;
+static int enospc_cnt;
+
+struct worker {
+	char dir[PATH_MAX];
+};
+
+static void *worker(void *p)
+{
+	struct worker *w = p;
+	DIR *d;
+	struct dirent *ent;
+	char file[PATH_MAX];
+
+	SAFE_MKDIR(w->dir, 0700);
+
+	while (run) {
+		tst_fill_fs(w->dir, 0);
+
+		tst_atomic_inc(&enospc_cnt);
+
+		d = SAFE_OPENDIR(w->dir);
+		while ((ent = SAFE_READDIR(d))) {
+
+			if (!strcmp(ent->d_name, ".") ||
+			    !strcmp(ent->d_name, ".."))
+				continue;
+
+			snprintf(file, sizeof(file), "%s/%s",
+				 w->dir, ent->d_name);
+
+			tst_res(TINFO, "Unlinking %s", file);
+
+			SAFE_UNLINK(file);
+			break;
+		}
+		SAFE_CLOSEDIR(d);
+	}
+
+	return NULL;
+}
+
+static void testrun(void)
+{
+	struct worker workers[nthreads];
+	pthread_t threads[nthreads];
+	unsigned int i;
+
+	run = 1;
+	for (i = 0; i < nthreads; i++) {
+		snprintf(workers[i].dir, sizeof(workers[i].dir),
+			 MNTPOINT "/thread%i", i + 1);
+		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, &workers[i]);
+	}
+
+	sleep(2);
+
+	run = 0;
+	for (i = 0; i < nthreads; i++)
+		SAFE_PTHREAD_JOIN(threads[i], NULL);
+
+	tst_res(TPASS, "Got %i ENOSPC", enospc_cnt);
+}
+
+static void setup(void)
+{
+	nthreads = tst_ncpus_conf() + 2;
+
+	tst_res(TINFO, "Running %i writer threads", nthreads);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.setup = setup,
+	.test_all = testrun,
+};
-- 
2.13.5

