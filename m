From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jun 2018 17:48:43 +0200
Subject: [LTP] [PATCH v2 3/3] cve/cve-2018-1000001: Add Realpath Buffer
	Underflow test
In-Reply-To: <20180620154843.27565-1-pvorel@suse.cz>
References: <20180620154843.27565-1-pvorel@suse.cz>
Message-ID: <20180620154843.27565-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Idea based on glibc source io/tst-getcwd-abspath.c, contributed by
Dmitry V. Levin [1]

[1] https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=52a713fdd0a30e1bd79818e2e3c4ab44ddca1a94;hp=249a5895f120b13290a372a49bb4b499e749806f

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
v1->v2:
* replace errno with TEST_ERRNO
* remove unused headers
---
 runtest/cve                           |  1 +
 testcases/cve/Makefile                |  2 +-
 testcases/cve/libc/Makefile           |  8 ++++
 testcases/cve/libc/cve-2018-1000001.c | 56 +++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 testcases/cve/libc/Makefile
 create mode 100644 testcases/cve/libc/cve-2018-1000001.c

diff --git a/runtest/cve b/runtest/cve
index 2f4171c84..c7031281a 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -33,3 +33,4 @@ cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
 cve-2018-5803 sctp_big_chunk
+cve-2018-1000001_libc_realpath_buffer_underflow cve-2018-1000001
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 3a05dd4fe..e5fc8d44f 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -41,4 +41,4 @@ cve-2017-17053:	CFLAGS += -pthread
 
 cve-2015-3290:	CFLAGS += -pthread
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/cve/libc/Makefile b/testcases/cve/libc/Makefile
new file mode 100644
index 000000000..e23dc473c
--- /dev/null
+++ b/testcases/cve/libc/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Linux Test Project
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/libc/cve-2018-1000001.c b/testcases/cve/libc/cve-2018-1000001.c
new file mode 100644
index 000000000..fd2c52d37
--- /dev/null
+++ b/testcases/cve/libc/cve-2018-1000001.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2018 Petr Vorel <pvorel@suse.cz>
+ * Based on the reproducer posted upstream so other copyrights may apply.
+ *
+ * Author: Dmitry V. Levin <ldv@altlinux.org>
+ * LTP conversion from glibc source: Petr Vorel <pvorel@suse.cz>
+ */
+
+#include "tst_test.h"
+
+#include <errno.h>
+#include <stdlib.h>
+
+#define CHROOT_DIR "cve-2018-1000001"
+
+static void setup(void)
+{
+	SAFE_MKDIR(CHROOT_DIR, 0755);
+	SAFE_CHROOT(CHROOT_DIR);
+}
+
+static void run(unsigned int i)
+{
+	int fail = 0;
+
+	if (!i) {
+		tst_res(TINFO, "testing getcwd()");
+		TESTPTR(getcwd(NULL, 0));
+	} else {
+		tst_res(TINFO, "testing realpath()");
+		TESTPTR(realpath(".", NULL));
+	}
+
+	if (TEST_ERRNO != ENOENT) {
+		tst_res(TFAIL | TTERRNO, "returned unexpected errno");
+		fail = 1;
+	}
+
+	if (TST_RET_PTR != NULL) {
+		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
+				(char *)TST_RET_PTR);
+		fail = 1;
+	}
+
+	if (!fail)
+		tst_res(TPASS, "bug not reproduced");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.17.1

