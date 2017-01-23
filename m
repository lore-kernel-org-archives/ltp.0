From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 23 Jan 2017 18:31:14 +0800
Subject: [LTP] [PATCH v2 1/3] lib/tst_safe_sysv_ipc.c : Add
	tst_safe_sysv_ipc.c
In-Reply-To: <20170119143903.GC9193@rei.lan>
References: <20170119143903.GC9193@rei.lan>
Message-ID: <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add SAFE_MSGGET(), SAFE_MSGSND(), SAFE_MSGRCV() and
SAFE_MSGCTL() macros to simplify IPC related cases.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_safe_sysv_ipc.h | 40 +++++++++++++++++++++++
 include/tst_test.h          |  1 +
 lib/tst_safe_sysv_ipc.c     | 78 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 include/tst_safe_sysv_ipc.h
 create mode 100644 lib/tst_safe_sysv_ipc.c

diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
new file mode 100644
index 0000000..29ded4f
--- /dev/null
+++ b/include/tst_safe_sysv_ipc.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2017 Xiao yang <yangx.jy@cn.fujitsu.com>
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
+#ifndef TST_SAFE_SYSV_IPC_H__
+# define TST_SAFE_SYSV_IPC_H__
+
+int safe_msgget(const char *file, const int lineno, key_t key, int msgflg);
+#define SAFE_MSGGET(key, msgflg) \
+	safe_msgget(__FILE__, __LINE__, (key), (msgflg))
+
+int safe_msgsnd(const char *file, const int lineno, int msqid, const void *msgp,
+		size_t msgsz, int msgflg);
+#define SAFE_MSGSND(msqid, msgp, msgsz, msgflg) \
+	safe_msgsnd(__FILE__, __LINE__, (msqid), (msgp), (msgsz), (msgflg))
+
+ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
+		size_t msgsz, long msgtyp, int msgflg);
+#define SAFE_MSGRCV(msqid, msgp, msgsz, msgtyp, msgflg) \
+	safe_msgrcv(__FILE__, __LINE__, (msqid), (msgp), (msgsz), (msgtyp), (msgflg))
+
+int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
+		struct msqid_ds *buf);
+#define SAFE_MSGCTL(msqid, cmd, buf) \
+	safe_msgctl(__FILE__, __LINE__, (msqid), (cmd), (buf))
+
+#endif
diff --git a/include/tst_test.h b/include/tst_test.h
index acb4b93..c68d880 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -34,6 +34,7 @@
 #include "tst_kvercmp.h"
 #include "tst_clone.h"
 #include "tst_kernel.h"
+#include "tst_safe_sysv_ipc.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
new file mode 100644
index 0000000..79b12d7
--- /dev/null
+++ b/lib/tst_safe_sysv_ipc.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright (c) 2017 Xiao yang <yangx.jy@cn.fujitsu.com>
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
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+int safe_msgget(const char *file, const int lineno, key_t key, int msgflg)
+{
+	int rval;
+
+	rval = msgget(key, msgflg);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: msgget() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_msgsnd(const char *file, const int lineno, int msqid, const void *msgp,
+		size_t msgsz, int msgflg)
+{
+	int rval;
+
+	rval = msgsnd(msqid, msgp, msgsz, msgflg);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: msgsnd() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+ssize_t safe_msgrcv(const char *file, const int lineno, int msqid, void *msgp,
+		size_t msgsz, long msgtyp, int msgflg)
+{
+	ssize_t rval;
+
+	rval = msgrcv(msqid, msgp, msgsz, msgtyp, msgflg);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: msgrcv() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
+
+int safe_msgctl(const char *file, const int lineno, int msqid, int cmd,
+		struct msqid_ds *buf)
+{
+	int  rval;
+
+	rval = msgctl(msqid, cmd, buf);
+	if (rval == -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: msgctl() failed",
+			file, lineno);
+	}
+
+	return rval;
+}
-- 
1.8.3.1



