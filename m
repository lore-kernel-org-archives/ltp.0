From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jun 2018 16:16:48 +0200
Subject: [LTP] [PATCH v3 3/3] cve/cve-2018-1000001: Add Realpath Buffer
	Underflow test
In-Reply-To: <20180621141648.11430-1-pvorel@suse.cz>
References: <20180621141648.11430-1-pvorel@suse.cz>
Message-ID: <20180621141648.11430-3-pvorel@suse.cz>
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
Changes v2->v3:
* Put source into testcases/kernel/syscalls/getcwd/getcwd05.c.
* Put record in several runtest files.
* Minor code simplification.

Kind regards,
Petr
---
 runtest/cve                                 |  1 +
 runtest/ltplite                             |  1 +
 runtest/stress.part3                        |  1 +
 runtest/syscalls                            |  1 +
 testcases/cve/Makefile                      |  2 +-
 testcases/kernel/syscalls/getcwd/.gitignore |  1 +
 testcases/kernel/syscalls/getcwd/getcwd05.c | 56 +++++++++++++++++++++
 7 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/getcwd/getcwd05.c

diff --git a/runtest/cve b/runtest/cve
index 2f4171c84..c7f438be2 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -33,3 +33,4 @@ cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
 cve-2018-5803 sctp_big_chunk
+cve-2018-1000001 getcwd05
diff --git a/runtest/ltplite b/runtest/ltplite
index 249262674..9d4af2da6 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -281,6 +281,7 @@ getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
 getcwd04 getcwd04
+getcwd05 getcwd05
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index d9287197b..8eb02d8b3 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -220,6 +220,7 @@ getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
 getcwd04 getcwd04
+getcwd05 getcwd05
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/runtest/syscalls b/runtest/syscalls
index 65c96edab..edec76f13 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -348,6 +348,7 @@ getcwd01 getcwd01
 getcwd02 getcwd02
 getcwd03 getcwd03
 getcwd04 getcwd04
+getcwd05 getcwd05
 
 getdents01 getdents01
 getdents02 getdents02
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 3a05dd4fe..e5fc8d44f 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -41,4 +41,4 @@ cve-2017-17053:	CFLAGS += -pthread
 
 cve-2015-3290:	CFLAGS += -pthread
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/getcwd/.gitignore b/testcases/kernel/syscalls/getcwd/.gitignore
index 338852b62..99b2ba19f 100644
--- a/testcases/kernel/syscalls/getcwd/.gitignore
+++ b/testcases/kernel/syscalls/getcwd/.gitignore
@@ -2,3 +2,4 @@
 /getcwd02
 /getcwd03
 /getcwd04
+/getcwd05
diff --git a/testcases/kernel/syscalls/getcwd/getcwd05.c b/testcases/kernel/syscalls/getcwd/getcwd05.c
new file mode 100644
index 000000000..182f6b56f
--- /dev/null
+++ b/testcases/kernel/syscalls/getcwd/getcwd05.c
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
+	if (i) {
+		tst_res(TINFO, "testing realpath()");
+		TESTPTR(realpath(".", NULL));
+	} else {
+		tst_res(TINFO, "testing getcwd()");
+		TESTPTR(getcwd(NULL, 0));
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

