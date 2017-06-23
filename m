From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 23 Jun 2017 14:22:09 +0200
Subject: [LTP] [PATCH v3 7/9] Test for CVE-2017-5669 in shmat
In-Reply-To: <20170623122211.29575-1-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
Message-ID: <20170623122211.29575-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xiao Yang and myself independently wrote the same test. Xiao's version can be
seen here: http://lists.linux.it/pipermail/ltp/2017-June/004695.html

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/cve                   |  1 +
 runtest/syscalls              |  1 +
 testcases/cve/.gitignore      |  1 +
 testcases/cve/cve-2017-5669.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 testcases/cve/cve-2017-5669.c

diff --git a/runtest/cve b/runtest/cve
index 6556ffb0f..166c98c8a 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -4,3 +4,4 @@ cve-2014-0196 cve-2014-0196
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
+cve-2017-5669 cve-2017-5669
diff --git a/runtest/syscalls b/runtest/syscalls
index 85755eb12..12ef696f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1164,6 +1164,7 @@ setxattr03 setxattr03
 shmat01 shmat01
 shmat02 shmat02
 shmat03 shmat03
+cve-2017-5669 cve-2017-5669
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index ff5844263..715cbab38 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -2,3 +2,4 @@ cve-2012-0957
 cve-2014-0196
 cve-2016-4997
 cve-2016-7117
+cve-2017-5669
diff --git a/testcases/cve/cve-2017-5669.c b/testcases/cve/cve-2017-5669.c
new file mode 100644
index 000000000..62e12e236
--- /dev/null
+++ b/testcases/cve/cve-2017-5669.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2017 Fujitsu Ltd. (Xiao Yang <yangx.jy@cn.fujitsu.com>)
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
+/*
+ * Test for CVE-2017-5669 which allows us to map the nil page using shmat.
+ *
+ * When the bug is present shmat(..., (void *)1, SHM_RND) will round address
+ * 0x1 down to zero and give us the (nil/null) page. With the current bug fix
+ * in place, shmat it will return EINVAL instead. We also check to see if the
+ * returned address is outside the nil page in case an alternative fix has
+ * been applied.
+ *
+ * In any case we manage to map some memory we also try to write to it. This
+ * is just to see if we get an access error or some other unexpected behaviour.
+ *
+ * See commit 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ */
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+static int shm_id;
+static void *shm_addr;
+
+static void cleanup(void)
+{
+	if (shm_addr)
+		SAFE_SHMDT(shm_addr);
+	shm_addr = 0;
+
+	if (shm_id)
+		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
+	shm_id = 0;
+}
+
+static void run(void)
+{
+	shm_id = SAFE_SHMGET(IPC_PRIVATE, getpagesize(), 0777);
+
+	tst_res(TINFO, "Attempting to attach shared memory to null page");
+	shm_addr = shmat(shm_id, ((void *)1), SHM_RND);
+	if (shm_addr == (void *)-1) {
+		if (errno == EINVAL) {
+			tst_res(TPASS, "shmat returned EINVAL");
+			shm_addr = 0;
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"The bug was not triggered, but the shmat error is unexpected");
+	}
+
+	tst_res(TINFO, "Mapped shared memory to %p", shm_addr);
+
+	if (!((size_t)shm_addr & (~0U << 16)))
+		tst_res(TFAIL,
+			"We have mapped a VM address within the first 64Kb");
+	else
+		tst_res(TPASS,
+			"The kernel assigned a different VM address");
+
+	((char *)shm_addr)[0] = 'P';
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.12.2

