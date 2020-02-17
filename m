From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Feb 2020 15:16:21 +0100
Subject: [LTP] [PATCH v3 2/3] Split off executable code from bpf/bpf_common.h
In-Reply-To: <20200217141622.26912-1-mdoucha@suse.cz>
References: <CAEemH2dEco268yqDyDjX25FPs3V7wTBija4HiMrf8nr0W7qVQQ@mail.gmail.com>
 <20200217141622.26912-1-mdoucha@suse.cz>
Message-ID: <20200217141622.26912-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: This patch was split off from the v1 BPF fix. Code cleanup
to prevent future bugs and make the common code more readable.

Changes since v2: None.

 testcases/kernel/syscalls/bpf/Makefile     |  3 ++
 testcases/kernel/syscalls/bpf/bpf_common.c | 45 ++++++++++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_common.h | 39 ++-----------------
 3 files changed, 51 insertions(+), 36 deletions(-)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_common.c

diff --git a/testcases/kernel/syscalls/bpf/Makefile b/testcases/kernel/syscalls/bpf/Makefile
index 990c8c83c..2241bce9b 100644
--- a/testcases/kernel/syscalls/bpf/Makefile
+++ b/testcases/kernel/syscalls/bpf/Makefile
@@ -5,6 +5,9 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+FILTER_OUT_MAKE_TARGETS	:= bpf_common
 CFLAGS			+= -D_GNU_SOURCE
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o bpf_common.o
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
new file mode 100644
index 000000000..fce364af8
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019-2020 Linux Test Project
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "lapi/bpf.h"
+#include "bpf_common.h"
+
+void rlimit_bump_memlock(void)
+{
+	struct rlimit memlock_r;
+
+	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	memlock_r.rlim_cur += BPF_MEMLOCK_ADD;
+	tst_res(TINFO, "Raising RLIMIT_MEMLOCK to %ld",
+		(long)memlock_r.rlim_cur);
+
+	if (memlock_r.rlim_cur <= memlock_r.rlim_max) {
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	} else if ((geteuid() == 0)) {
+		memlock_r.rlim_max += BPF_MEMLOCK_ADD;
+		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
+	} else {
+		tst_res(TINFO, "Can't raise RLIMIT_MEMLOCK, test may fail "
+			"due to lack of max locked memory");
+	}
+}
+
+int bpf_map_create(union bpf_attr *attr)
+{
+	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
+			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
+			tst_brk(TCONF | TTERRNO,
+				"bpf() requires CAP_SYS_ADMIN on this system");
+		} else {
+			tst_brk(TBROK | TTERRNO, "Failed to create array map");
+		}
+	}
+
+	return TST_RET;
+}
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index f700bede2..e46a519eb 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2019 Linux Test Project
+ * Copyright (c) 2019-2020 Linux Test Project
  */
 
 #ifndef LTP_BPF_COMMON_H
@@ -8,40 +8,7 @@
 
 #define BPF_MEMLOCK_ADD (256*1024)
 
-void rlimit_bump_memlock(void)
-{
-	struct rlimit memlock_r;
-
-	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	memlock_r.rlim_cur += BPF_MEMLOCK_ADD;
-	tst_res(TINFO, "Raising RLIMIT_MEMLOCK to %ld",
-		(long)memlock_r.rlim_cur);
-
-	if (memlock_r.rlim_cur <= memlock_r.rlim_max) {
-		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	} else if ((geteuid() == 0)) {
-		memlock_r.rlim_max += BPF_MEMLOCK_ADD;
-		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
-	} else {
-		tst_res(TINFO, "Can't raise RLIMIT_MEMLOCK, test may fail "
-			"due to lack of max locked memory");
-	}
-}
-
-int bpf_map_create(union bpf_attr *attr)
-{
-	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		if (TST_ERR == EPERM) {
-			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
-			tst_brk(TCONF | TTERRNO,
-				"bpf() requires CAP_SYS_ADMIN on this system");
-		} else {
-			tst_brk(TBROK | TTERRNO, "Failed to create array map");
-		}
-	}
-
-	return TST_RET;
-}
+void rlimit_bump_memlock(void);
+int bpf_map_create(union bpf_attr *attr);
 
 #endif
-- 
2.25.0

