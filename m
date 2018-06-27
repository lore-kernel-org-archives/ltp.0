From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 17:22:17 +0200
Subject: [LTP] [PATCH 2/2] [WORK-IN-PROGRESS] lib/tst_test: Dump stack for
	test processes stuck in kernel
In-Reply-To: <20180627152217.7067-1-chrubis@suse.cz>
References: <20180627152217.7067-1-chrubis@suse.cz>
Message-ID: <20180627152217.7067-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a small helper library to find a process(es) given a
process group ID and dump their stacks.

Example output:

$ ./shmctl05
tst_test.c:1015: INFO: Timeout per run is 0h 00m 10s
Test timeouted, sending SIGKILL!
tst_test.c:1059: TFAIL: Test process child stuck in the kernel!
tst_find_pid.c:90: INFO: Pid 1272 stuck in kernel!
Kernel stacktrace follows:
[<ffffffffa3c12564>] __switch_to_asm+0x34/0x70
[<ffffffffa3c12570>] __switch_to_asm+0x40/0x70
[<ffffffffa3625761>] __switch_to+0x2c1/0x6e0
[<ffffffffa393e194>] call_rwsem_down_read_failed+0x14/0x30
[<ffffffffa3704802>] acct_collect+0x42/0x1a0
[<ffffffffa367d36a>] do_exit+0x74a/0xaf0
[<ffffffffa3c13d27>] rewind_stack_do_exit+0x17/0x20
[<ffffffffffffffff>] 0xffffffffffffffff
tst_test.c:1061: FAIL: Congratulation, likely test hit a kernel bug.

TODO: The main test process uses signal handler and alarm to call _exit if the
      child process that executes the actuall test timeouts. We need to redesign
      this if we want to dump the stack in that case as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---
 include/tst_dump_stacks.h |  25 +++++++++++
 lib/tst_dump_stacks.c     | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c            |   3 +-
 3 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 include/tst_dump_stacks.h
 create mode 100644 lib/tst_dump_stacks.c

diff --git a/include/tst_dump_stacks.h b/include/tst_dump_stacks.h
new file mode 100644
index 000000000..643cc58a8
--- /dev/null
+++ b/include/tst_dump_stacks.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+#ifndef TST_DUMP_STACKS__
+#define TST_DUMP_STACKS__
+
+void tst_dump_stacks_by_pgid(pid_t pgid);
+
+void tst_dump_stack_by_pid(pid_t pid);
+
+#endif /* TST_DUMP_STACKS__ */
diff --git a/lib/tst_dump_stacks.c b/lib/tst_dump_stacks.c
new file mode 100644
index 000000000..aa97c6820
--- /dev/null
+++ b/lib/tst_dump_stacks.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
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
+#include <ctype.h>
+#include <stdio.h>
+
+#define TST_NO_DEFAULT_MAIN 1
+#include "tst_test.h"
+
+static void *process_search_init(void)
+{
+	DIR *dir = SAFE_OPENDIR("/proc/");
+
+	return dir;
+}
+
+static int is_number(const char *str)
+{
+	do {
+		if (!isdigit(*str))
+			return 0;
+	} while (*(++str));
+
+	return 1;
+}
+
+static int process_search_pgid_next(void *pid_search, pid_t pgid)
+{
+	struct dirent *ent;
+	DIR *dir = pid_search;
+	char path[1024];
+	int ppgid, pid;
+	FILE *f;
+
+	while ((ent = readdir(dir))) {
+		if (ent->d_type != DT_DIR)
+			continue;
+		if (!is_number(ent->d_name))
+			continue;
+
+		snprintf(path, sizeof(path), "/proc/%s/stat", ent->d_name);
+
+		f = fopen(path, "r");
+		if (!f)
+			continue;
+
+		if (fscanf(f, "%i %*s %*c %*i %i", &pid, &ppgid) != 2) {
+			tst_res(TWARN, "fscanf(%s) failed!", ent->d_name);
+			fclose(f);
+			continue;
+		}
+
+		fclose(f);
+
+		if (ppgid == pgid)
+			break;
+	}
+
+	if (ent)
+		return pid;
+
+	closedir(dir);
+	return -1;
+}
+
+void tst_dump_stack_by_pid(pid_t pid)
+{
+	int fd, len;
+	char buf[512];
+	char path[1024];
+
+	tst_res(TINFO, "Pid %i stuck in kernel!", pid);
+
+	fprintf(stderr, "Kernel stacktrace follows:\n");
+	fflush(stderr);
+
+	snprintf(path, sizeof(path), "/proc/%i/stack", pid);
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+
+	while ((len = SAFE_READ(0, fd, buf, sizeof(buf))) > 0)
+		SAFE_WRITE(1, 2, buf, len);
+
+	SAFE_CLOSE(fd);
+}
+
+void tst_dump_stacks_by_pgid(pid_t pgid)
+{
+	void *ps = process_search_init();
+	int pid;
+
+	while ((pid = process_search_pgid_next(ps, pgid)) != -1)
+		tst_dump_stack_by_pid(pid);
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 329168a24..d9476c02c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1058,7 +1058,8 @@ static int fork_testrun(void)
 		if (retries++ <= 14)
 			continue;
 
-		tst_res(TFAIL, "Test process child stuck in the kernel!");
+		tst_res(TFAIL, "Test process child(ren) stuck in the kernel!");
+		tst_dump_stacks_by_pgid(test_pid);
 		tst_brk(TFAIL, "Congratulation, likely test hit a kernel bug.");
 	}
 
-- 
2.13.6

