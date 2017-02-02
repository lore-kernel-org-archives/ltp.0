From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  2 Feb 2017 17:58:50 +0100
Subject: [LTP] [PATCH] madvise09: Add MADV_FREE test
Message-ID: <20170202165850.18436-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We test the madvise(MADV_FREE) by running a process in a memory cgroup
with fairly small memory limits. The test process forks a child, moves
it to the newly created cgroup. The child allocates memory, marks it
MADV_FREE then forks a memory hungry child that allocates and faults
memory in a loop. Due to undeterministic nature of the OOM (that kills
the memory hungry child sooner or later) we have to retry at two levels.
First problem is that rarely it gets too rogue and both processes in the
cgroup gets killed. The second is that sometimes the memory hungry child
is killed too fast (before the kernel has chance to free the pages), so
we rerun it a (for a few times) if that happens.

The test expects memory cgroup mounted in the standard /sys/fs/cgroup/
path, which is OK since the functionality tested was added to kernel
4.5 and the test would be skipped on older distros anyway.

Also the test expects that the MADV_FREE pages will not be freed
immediatelly hence the test will fail if the whole system is under
memory pressure.

The memory limits were choosen to be 2MB and 4MB for memsw limit. I've
tried to use to base these on usage_in_bytes but that turned out to be
source of random errors. It worked fine and produces stable numbers 99%
of the time but then the numbers have changed and caused the test to
fail in fork() with ENOMEM.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/madvise/madvise09.c | 229 ++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dc03c4c..ec0b316 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -753,6 +753,7 @@ madvise05 madvise05
 madvise06 madvise06
 madvise07 madvise07
 madvise08 madvise08
+madvise09 madvise09
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 91dccef..e5a6b47 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -514,6 +514,7 @@
 /madvise/madvise06
 /madvise/madvise07
 /madvise/madvise08
+/madvise/madvise09
 /mallopt/mallopt01
 /mbind/mbind01
 /memcmp/memcmp01
diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
new file mode 100644
index 0000000..a4bece8
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -0,0 +1,229 @@
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
+ * Check that memory marked with MADV_FREE is freed on memory pressure.
+ *
+ * o Fork a child and move it into a memory cgroup
+ *
+ * o Allocate pages and fill them with a pattern
+ *
+ * o Madvise pages with MADV_FREE
+ *
+ * o Check that madvised pages were not freed immediatelly
+ *
+ * o Write to some of the madvised pages again, these must not be freed
+ *
+ * o Set memory limits
+ *   - limit_in_bytes = 2MB
+ *   - memsw.limit_in_bytes = 4MB
+ *
+ *   The reason for doubling the limit_in_bytes is to have safe margin
+ *   for forking the memory hungy child etc. And the reason to setting
+ *   memsw.limit_in_bytes to twice of that is to give the system chance
+ *   to try to free some memory before cgroup OOM kicks in and kills
+ *   the memory hungry child.
+ *
+ * o Run a memory hungry child that allocates memory in loop until it's
+ *   killed by cgroup OOM
+ *
+ * o Once the child is killed the MADV_FREE pages that were not written to
+ *   should be freed, the test passes if there is at least one
+ */
+
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <errno.h>
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define MEMCG_PATH "/sys/fs/cgroup/memory/"
+
+static char cgroup_path[PATH_MAX];
+static char tasks_path[PATH_MAX];
+static char limit_in_bytes_path[PATH_MAX];
+static char memsw_limit_in_bytes_path[PATH_MAX];
+
+#define PAGES 32
+
+static void memory_pressure_child(void)
+{
+	size_t i, page_size = getpagesize();
+	char *ptr;
+
+	for (;;) {
+		ptr = mmap(NULL, 1000 * page_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+		for (i = 0; i < 1000 * page_size; i++)
+			ptr[i] = i % 100;
+	}
+
+	abort();
+}
+
+static void setup_cgroup_paths(int pid)
+{
+	snprintf(cgroup_path, sizeof(cgroup_path),
+		 MEMCG_PATH "ltp_madvise09_%i/", pid);
+	snprintf(tasks_path, sizeof(tasks_path), "%s/tasks", cgroup_path);
+	snprintf(limit_in_bytes_path, sizeof(limit_in_bytes_path),
+		 "%s/memory.limit_in_bytes", cgroup_path);
+	snprintf(memsw_limit_in_bytes_path, sizeof(memsw_limit_in_bytes_path),
+		 "%s/memory.memsw.limit_in_bytes", cgroup_path);
+}
+
+static void child(void)
+{
+	size_t i, page_size = getpagesize();
+	char *ptr;
+	unsigned int usage, old_limit, old_memsw_limit;
+	int status, pid, retries = 10;
+
+	SAFE_MKDIR(cgroup_path, 0777);
+	SAFE_FILE_PRINTF(tasks_path, "%i", getpid());
+
+	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
+	                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	for (i = 0; i < PAGES * page_size; i++)
+		ptr[i] = 'a';
+
+	if (madvise(ptr, PAGES * page_size, MADV_FREE)) {
+		if (errno == EINVAL)
+			tst_brk(TCONF | TERRNO, "MADV_FREE is not supported");
+
+		tst_brk(TBROK | TERRNO, "MADV_FREE failed");
+	}
+
+	if (ptr[page_size] != 'a')
+		tst_res(TFAIL, "MADV_FREE pages were freed immediatelly");
+	else
+		tst_res(TPASS, "MADV_FREE pages were not freed immediatelly");
+
+	ptr[0] = 'b';
+	ptr[10 * page_size] = 'b';
+
+	usage = (1024 * 1024);
+	tst_res(TINFO, "Setting memory limits to %u %u", 2 * usage, 4 * usage);
+
+	SAFE_FILE_SCANF(limit_in_bytes_path, "%u", &old_limit);
+	SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
+	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", 2 * usage);
+	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 4 * usage);
+
+	do {
+		pid = SAFE_FORK();
+		if (!pid)
+			memory_pressure_child();
+
+		tst_res(TINFO, "Memory hungry child %i started.", pid);
+
+		SAFE_WAIT(&status);
+	} while (--retries > 0 && ptr[page_size]);
+
+	if (ptr[0] == 0 || ptr[10 * page_size] == 0)
+		tst_res(TFAIL, "Page modified after MADV_FREE was freed");
+	else
+		tst_res(TPASS, "Page modified after MADV_FREE was not freed");
+
+	char map[PAGES+1];
+	unsigned int freed = 0;
+
+	for (i = 0; i < PAGES; i++) {
+		if (ptr[i * page_size]) {
+			map[i] = 'p';
+		} else {
+			map[i] = '_';
+			freed++;
+		}
+	}
+	map[PAGES] = '\0';
+
+	tst_res(TINFO, "Memory map: %s", map);
+
+	if (freed)
+		tst_res(TPASS, "Pages MADV_FREE were freed on low memory");
+	else
+		tst_res(TFAIL, "No MADV_FREE page was freed on low memory");
+
+	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
+	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", old_limit);
+
+	SAFE_MUNMAP(ptr, PAGES);
+
+	exit(0);
+}
+
+static void cleanup(void)
+{
+	if (cgroup_path[0] && !access(cgroup_path, F_OK))
+		rmdir(cgroup_path);
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+
+retry:
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		setup_cgroup_paths(getpid());
+		child();
+	}
+
+	setup_cgroup_paths(pid);
+	SAFE_WAIT(&status);
+	cleanup();
+
+	/*
+	 * Rarely cgroup OOM kills both children not only the one that allocates
+	 * memory in loop, hence we retry here if that happens.
+	 */
+	if (WIFSIGNALED(status)) {
+		tst_res(TINFO, "Both children killed, retrying...");
+		goto retry;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status))
+		tst_brk(TBROK, "Child exitted unexpectedly");
+}
+
+static void setup(void)
+{
+	if (access(MEMCG_PATH, F_OK)) {
+		tst_brk(TCONF, "'" MEMCG_PATH
+			"' not present, CONFIG_MEMCG missing?");
+	}
+}
+
+static struct tst_test test = {
+	.tid = "madvise09",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.10.2

