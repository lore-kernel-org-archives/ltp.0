From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 14 Apr 2017 18:15:17 +0800
Subject: [LTP] [PATCH 3/3] syscalls/shmat03.c: add new regression test
In-Reply-To: <1492164917-9329-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1492164917-9329-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1492164917-9329-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This kernel bug has been fixed in:

commit 95e91b831f87ac8e1f8ed50c14d709089b4e01b8
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Mon Feb 27 14:28:24 2017 -0800

	ipc/shm: Fix shmat mmap nil-page protection

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                               |   1 +
 runtest/stress.part3                          |   1 +
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 testcases/kernel/syscalls/.gitignore          |   1 +
 testcases/kernel/syscalls/ipc/shmat/shmat03.c | 133 ++++++++++++++++++++++++++
 6 files changed, 138 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 03bba7f..0c2e5be 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -828,6 +828,7 @@ setuid04 setuid04
 
 shmat01 shmat01
 shmat02 shmat02
+shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index b028a7f..bd84752 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -718,6 +718,7 @@ setuid04 setuid04
 
 shmat01 shmat01
 shmat02 shmat02
+shmat03 shmat03
 
 shmctl02 shmctl02
 shmctl03 shmctl03
diff --git a/runtest/syscalls b/runtest/syscalls
index 6276a90..5909456 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1162,6 +1162,7 @@ setxattr03 setxattr03
 
 shmat01 shmat01
 shmat02 shmat02
+shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index de32c6b..91060b9 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -52,6 +52,7 @@ semop05 semop05
 
 shmat01 shmat01
 shmat02 shmat02
+shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 2b61fa2..d5985cd 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -439,6 +439,7 @@
 /ipc/semop/semop05
 /ipc/shmat/shmat01
 /ipc/shmat/shmat02
+/ipc/shmat/shmat03
 /ipc/shmctl/shmctl01
 /ipc/shmctl/shmctl02
 /ipc/shmctl/shmctl03
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
new file mode 100644
index 0000000..1194f1b
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2017 Fujitsu Ltd.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+ * DESCRIPTION
+ * This is a regression test for nil-page protection mechanisms implemented
+ * in shmat(). Both root user and regular user shouldn't map nil-page in
+ * shmat() and was killed by SIGSEGV when writing data to nil-page.  However
+ * root user could succeed to map nil-page.
+ *
+ * This bug has been fixed in:
+ * commit 95e91b831f87ac8e1f8ed50c14d709089b4e01b8
+ * Author: Davidlohr Bueso <dave@stgolabs.net>
+ * Date:   Mon Feb 27 14:28:24 2017 -0800
+ *
+ *     ipc/shm: Fix shmat mmap nil-page protection
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+#define LOCATION ((void *)1)
+
+static int shm_id = -1;
+
+static struct tcase {
+	int exp_usr;
+	char *des;
+} tcases[] = {
+	{0, "root user"},
+	{1, "regular user"}
+};
+
+static void verify_shmat(int exp_user)
+{
+	void *addr;
+	struct passwd *pw;
+
+	if (exp_user) {
+		pw = SAFE_GETPWNAM("nobody");
+		SAFE_SETUID(pw->pw_uid);
+	}
+
+	addr = shmat(shm_id, LOCATION, SHM_RND);
+	if (addr != (void *)-1)
+		tst_res(TINFO, "shmat() attached a nil-page unexpectedly");
+	else
+		tst_res(TINFO, "shmat() didn't attach a nil-page");
+
+	((char *)addr)[0] = 'A';
+	tst_res(TINFO, "shmat() wrote data to shmaddr:%p unexpectedly", addr);
+
+	SAFE_SHMDT(addr);
+
+	exit(0);
+}
+
+static void do_shmat(unsigned int n)
+{
+	pid_t pid;
+	int status;
+	struct tcase *tc = &tcases[n];
+
+	pid = SAFE_FORK();
+	if (!pid)
+		verify_shmat(tc->exp_usr);
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status)) {
+		tst_res(TFAIL, "%s mapped nil-page in shmat() unexpectedly",
+			tc->des);
+		return;
+	}
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "%s didn't map nil-page in shmat(), and was "
+			"killed by %s as expected", tc->des,
+			tst_strsig(WTERMSIG(status)));
+	} else {
+		tst_res(TFAIL, "%s didn't map nil-page in shmat(), and was "
+			"killed by %s unexpectedly", tc->des,
+			tst_strsig(WTERMSIG(status)));
+	}
+}
+
+static void setup(void)
+{
+	key_t shm_key;
+
+	shm_key = GETIPCKEY();
+	shm_id = SAFE_SHMGET(shm_key, 4096, 0777 | IPC_CREAT);
+}
+
+static void cleanup(void)
+{
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.tid = "shmat03",
+	.needs_root = 1,
+	.forks_child = 1,
+	.test = do_shmat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup
+};
-- 
1.8.3.1



