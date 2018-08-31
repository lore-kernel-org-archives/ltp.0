From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 31 Aug 2018 15:13:22 +0800
Subject: [LTP] [PATCH v2 4/4] syscalls/mlock202: Add new testcase
In-Reply-To: <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
 <1535699602-28185-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1535699602-28185-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check various errnos for mlock2(2) since kernel v2.6.9.

Note:
1) We use tst_syscall() to check if mlock2() is supported.
2) since kernel v2.6.9, the limits and permissions of mlock2()
   changed, so we just check mlock2() since the version.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 +
 runtest/stress.part3                        |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mlock2/.gitignore |   1 +
 testcases/kernel/syscalls/mlock2/mlock202.c | 113 ++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mlock2/mlock202.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 270c649..7ebe632 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -444,6 +444,7 @@ mlock01 mlock01
 mlock02 mlock02
 
 mlock201 mlock201
+mlock202 mlock202
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 6850572..0804172 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -370,6 +370,7 @@ mlock01 mlock01
 mlock02 mlock02
 
 mlock201 mlock201
+mlock202 mlock202
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/runtest/syscalls b/runtest/syscalls
index 5d84d48..2615254 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -634,6 +634,7 @@ mlock03 mlock03 -i 20
 mlock04 mlock04
 
 mlock201 mlock201
+mlock202 mlock202
 
 qmm01 mmap001 -m 1
 mmap01 mmap01
diff --git a/testcases/kernel/syscalls/mlock2/.gitignore b/testcases/kernel/syscalls/mlock2/.gitignore
index 431eff8..8daf0f9 100644
--- a/testcases/kernel/syscalls/mlock2/.gitignore
+++ b/testcases/kernel/syscalls/mlock2/.gitignore
@@ -1 +1,2 @@
 /mlock201
+/mlock202
diff --git a/testcases/kernel/syscalls/mlock2/mlock202.c b/testcases/kernel/syscalls/mlock2/mlock202.c
new file mode 100644
index 0000000..630da65
--- /dev/null
+++ b/testcases/kernel/syscalls/mlock2/mlock202.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+/*
+ * Description:
+ * Check various errnos for mlock2(2) since kernel v2.6.9:
+ * 1) mlock2() fails and returns EINVAL if unknown flag is specified.
+ * 2) mlock2() fails and returns ENOMEM if the caller is not
+ *    privileged(CAP_IPC_LOCK) and tries to lock more memory than the
+ *    RLIMIT_MEMLOCK limit.
+ * 3) mlock2() fails and returns EPERM if the caller is not
+ *    privileged(CAP_IPC_LOCK) and its RLIMIT_MEMLOCK limit is 0.
+ * 4) mlock2() fails and returns ENOMEM if some of the specified address
+ *    range does not correspond to mapped pages in the address space
+ *    of the caller.
+ */
+#include <errno.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define PAGES 8
+
+static size_t pgsz;
+static size_t max_sz1, max_sz2;
+static char *addr, *unmapped_addr;
+static struct passwd *nobody;
+
+static struct tcase {
+	char **taddr;
+	int flag;
+	size_t *max_size;
+	/* 1: nobody 0: root */
+	int user;
+	int exp_err;
+} tcases[] = {
+	{&addr, -1, NULL, 0, EINVAL},
+	{&addr, 0, &max_sz1, 1, ENOMEM},
+	{&addr, 0, &max_sz2, 1, EPERM},
+	{&unmapped_addr, 0, NULL, 0, ENOMEM},
+};
+
+static void verify_mlock2(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct rlimit orig_limit, new_limit;
+
+	if (tc->user) {
+		SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &orig_limit);
+		new_limit.rlim_cur = *tc->max_size;
+		new_limit.rlim_max = *tc->max_size;
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &new_limit);
+		SAFE_SETEUID(nobody->pw_uid);
+	}
+
+	TEST(tst_syscall(__NR_mlock2, *tc->taddr, pgsz, tc->flag));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "mlock2() succeeded");
+		SAFE_MUNLOCK(*tc->taddr, pgsz);
+		goto end;
+	}
+
+	if (TST_ERR != tc->exp_err) {
+		tst_res(TFAIL | TTERRNO,
+			"mlock2() failed unexpectedly, expected %s",
+			tst_strerrno(tc->exp_err));
+	} else {
+		tst_res(TPASS | TTERRNO, "mlock2() failed as expected");
+	}
+
+end:
+	if (tc->user) {
+		SAFE_SETEUID(0);
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &orig_limit);
+	}
+}
+
+static void setup(void)
+{
+	pgsz = getpagesize();
+	nobody = SAFE_GETPWNAM("nobody");
+
+	addr = SAFE_MMAP(NULL, pgsz, PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	unmapped_addr = SAFE_MMAP(NULL, pgsz * PAGES, PROT_READ,
+				  MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	SAFE_MUNMAP(unmapped_addr, pgsz * PAGES);
+	unmapped_addr = unmapped_addr + pgsz * PAGES / 2;
+
+	max_sz1 = pgsz - 1;
+}
+
+static void cleanup(void)
+{
+	if (addr)
+		SAFE_MUNMAP(addr, pgsz);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_mlock2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.min_kver = "2.6.9",
+};
-- 
1.8.3.1



