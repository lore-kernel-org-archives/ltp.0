From: Erico Nunes <ernunes@redhat.com>
Date: Tue, 28 Jul 2020 18:22:05 +0200
Subject: [LTP] [PATCH v2 1/3] lib: add function to check for kernel lockdown
Message-ID: <20200728162207.332109-1-ernunes@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some syscalls are not available if the kernel is booted using the
'lockdown' feature. That can cause some tests to report fail, showing
a message like:

  Lockdown: iopl01: iopl is restricted; see man kernel_lockdown.7

This patch adds a function that can be used by tests to check for this
case, so it can be handled accordingly.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
v2:
- just return the lockdown status so tests can handle as needed, instead
  of just always skipping the test.
- handle fgets return value to avoid compiler warning (can't return any
  sensible value so I just ported what I have seen in other similar
  cases).
---
 include/tst_lockdown.h |  8 ++++++++
 include/tst_test.h     |  1 +
 lib/tst_lockdown.c     | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 include/tst_lockdown.h
 create mode 100644 lib/tst_lockdown.c

diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
new file mode 100644
index 000000000..383026b1e
--- /dev/null
+++ b/include/tst_lockdown.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef TST_LOCKDOWN_H
+#define TST_LOCKDOWN_H
+
+int tst_lockdown_enabled(void);
+
+#endif /* TST_LOCKDOWN_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index b84f7b9dd..b02de4597 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -40,6 +40,7 @@
 #include "tst_hugepage.h"
 #include "tst_assert.h"
 #include "tst_cgroup.h"
+#include "tst_lockdown.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
new file mode 100644
index 000000000..024047aae
--- /dev/null
+++ b/lib/tst_lockdown.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_stdio.h"
+#include "tst_lockdown.h"
+
+int tst_lockdown_enabled(void)
+{
+	char line[BUFSIZ];
+	const char *lockdown_path = "/sys/kernel/security/lockdown";
+	FILE *file;
+
+	if (access("/sys/kernel/security/lockdown", F_OK) != 0) {
+		tst_res(TINFO, "Unable to determine system lockdown state\n");
+		return 0;
+	}
+
+	file = SAFE_FOPEN(lockdown_path, "r");
+	if (!fgets(line, sizeof(line), file))
+		tst_brk(TBROK | TERRNO, "fgets %s", lockdown_path);
+	SAFE_FCLOSE(file);
+
+	return (strstr(line, "[none]") == NULL);
+}
-- 
2.26.2

