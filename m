From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Sep 2019 13:15:58 +0200
Subject: [LTP] [PATCH] syscalls/bpf: auto bump RLIMIT_MEMLOCK
Message-ID: <a9fc2ff0c27317ae8ac2d56a819eeac5a281dd86.1569496399.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

eBPF tests may fail (-EPERM) if max locked memory limit is too low.
User-space tools such as perf started increasing MELOCK limit to
avoid this problem.

LTP follows same approach and will attempt to raise RLIMIT_MEMLOCK
if possible, otherwise prints an info message.

Link: http://lists.linux.it/pipermail/ltp/2019-August/013349.html
Link: https://lkml.org/lkml/2019/7/17/714
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.h | 31 ++++++++++++++++++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_map01.c  |  3 +++
 testcases/kernel/syscalls/bpf/bpf_prog01.c |  3 +++
 3 files changed, 37 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_common.h

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
new file mode 100644
index 000000000000..03e46c5d427e
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Linux Test Project
+ */
+
+#ifndef LTP_BPF_COMMON_H
+#define LTP_BPF_COMMON_H
+
+#define BPF_MEMLOCK_ADD (256*1024)
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
+#endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index 13dde0b4e12f..49d32776ef41 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "tst_test.h"
 #include "lapi/bpf.h"
+#include "bpf_common.h"
 
 #define VAL_SZ 1024
 
@@ -140,6 +141,8 @@ static void setup(void)
 {
 	unsigned int i;
 
+	rlimit_bump_memlock();
+
 	memcpy(key8, "12345678", 8);
 	memset(key4, 0, 4);
 
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index 3252f92774d1..46a909fe2ec4 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -27,6 +27,7 @@
 #include "tst_test.h"
 #include "lapi/socket.h"
 #include "lapi/bpf.h"
+#include "bpf_common.h"
 
 const char MSG[] = "Ahoj!";
 static char *msg;
@@ -94,6 +95,8 @@ int load_prog(int fd)
 
 void setup(void)
 {
+	rlimit_bump_memlock();
+
 	memcpy(prog, PROG, sizeof(PROG));
 	memcpy(msg, MSG, sizeof(MSG));
 }
-- 
1.8.3.1

