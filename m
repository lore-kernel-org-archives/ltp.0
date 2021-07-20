From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:09 +0300
Subject: [LTP] [PATCH 01/16] lib/tst_sched: add ltp tst_sched_*()
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The new tst_sched_*() invoke libc variant first, and if ENOSYS errno
has been returned, tries to invoke syscall directly.

musl implementation returns ENOSYS for some sched_*() functions due
to commit 1e21e78bf7a5 ("add support for thread scheduling (POSIX
TPS option)").

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 include/tst_sched.h | 16 ++++++++++++++++
 lib/tst_sched.c     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/tst_sched.h
 create mode 100644 lib/tst_sched.c

diff --git a/include/tst_sched.h b/include/tst_sched.h
new file mode 100644
index 000000000..0e5d61344
--- /dev/null
+++ b/include/tst_sched.h
@@ -0,0 +1,16 @@
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
+int tst_sched_setparam(pid_t pid, const struct sched_param *param);
+int tst_sched_getparam(pid_t pid, struct sched_param *param);
+int tst_sched_setscheduler(pid_t pid, int policy, const struct sched_param *param);
+int tst_sched_getscheduler(pid_t pid);
+
+#endif /* TST_SCHED_H_ */
diff --git a/lib/tst_sched.c b/lib/tst_sched.c
new file mode 100644
index 000000000..d53273d8e
--- /dev/null
+++ b/lib/tst_sched.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021, BELLSOFT. All rights reserved.
+ */
+
+#include <errno.h>
+#include <unistd.h>
+#include "tst_sched.h"
+#include "lapi/syscalls.h"
+
+#define TST_SCHED_COMMON(SCALL, ...) do {			\
+	int ret = SCALL(__VA_ARGS__);				\
+	if (ret == -1 && errno == ENOSYS)			\
+		return syscall(__NR_##SCALL, __VA_ARGS__);	\
+	return ret;						\
+} while (0)
+
+int tst_sched_setparam(pid_t pid, const struct sched_param *param)
+{
+	TST_SCHED_COMMON(sched_setparam, pid, param);
+}
+
+int tst_sched_getparam(pid_t pid, struct sched_param *param)
+{
+	TST_SCHED_COMMON(sched_getparam, pid, param);
+}
+
+int tst_sched_setscheduler(pid_t pid, int policy, const struct sched_param *param)
+{
+	TST_SCHED_COMMON(sched_setscheduler, pid, policy, param);
+}
+
+int tst_sched_getscheduler(pid_t pid)
+{
+	TST_SCHED_COMMON(sched_getscheduler, pid);
+}
-- 
2.25.1

