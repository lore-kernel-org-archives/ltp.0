From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:15 +0300
Subject: [LTP] [PATCH v2 01/16] lib/tst_sched: add ltp sys/libc_sched_*()
 wrappers
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The new wrappers allow to test libc and syscall variants. This is needed
because libc implementation can differ from calling syscall directly.
For example, musl libc implementation returns ENOSYS for some sched_*()
functions due to commit 1e21e78bf7a5 ("add support for thread scheduling
(POSIX TPS option)").

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 include/tst_sched.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 include/tst_sched.h

diff --git a/include/tst_sched.h b/include/tst_sched.h
new file mode 100644
index 000000000..a5dc767b3
--- /dev/null
+++ b/include/tst_sched.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2021, BELLSOFT. All rights reserved.
+ */
+
+#ifndef TST_SCHED_H_
+#define TST_SCHED_H_
+
+#include <sched.h>
+
+#include "lapi/syscalls.h"
+
+struct sched_variants {
+	char *desc;
+
+	int (*sched_setparam)(pid_t pid, const struct sched_param *param);
+	int (*sched_getparam)(pid_t pid, struct sched_param *param);
+	int (*sched_setscheduler)(pid_t pid, int policy, const struct sched_param *param);
+	int (*sched_getscheduler)(pid_t pid);
+};
+
+#define _TST_LIBC_SCHED_SCALL(SCALL, ...)({ \
+	int tst_ret = SCALL(__VA_ARGS__); \
+	if (tst_ret == -1 && errno == ENOSYS) { \
+		tst_brk(TCONF, #SCALL " not supported"); \
+	} \
+	tst_ret; \
+})
+
+static inline int sys_sched_setparam(pid_t pid, const struct sched_param *param)
+{
+	return tst_syscall(__NR_sched_setparam, pid, param);
+}
+
+static inline int sys_sched_getparam(pid_t pid, struct sched_param *param)
+{
+	return tst_syscall(__NR_sched_getparam, pid, param);
+}
+
+static inline int sys_sched_setscheduler(pid_t pid, int policy, const struct sched_param *param)
+{
+	return tst_syscall(__NR_sched_setscheduler, pid, policy, param);
+}
+
+static inline int sys_sched_getscheduler(pid_t pid)
+{
+	return tst_syscall(__NR_sched_getscheduler, pid);
+}
+
+static inline int libc_sched_setparam(pid_t pid, const struct sched_param *param)
+{
+	return _TST_LIBC_SCHED_SCALL(sched_setparam, pid, param);
+}
+
+static inline int libc_sched_getparam(pid_t pid, struct sched_param *param)
+{
+	return _TST_LIBC_SCHED_SCALL(sched_getparam, pid, param);
+}
+
+static inline int libc_sched_setscheduler(pid_t pid, int policy, const struct sched_param *param)
+{
+	return _TST_LIBC_SCHED_SCALL(sched_setscheduler, pid, policy, param);
+}
+
+static inline int libc_sched_getscheduler(pid_t pid)
+{
+	return _TST_LIBC_SCHED_SCALL(sched_getscheduler, pid);
+}
+
+#endif /* TST_SCHED_H_ */
-- 
2.25.1

