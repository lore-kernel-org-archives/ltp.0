From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Aug 2021 13:22:09 +0200
Subject: [LTP] [PATCH v2 1/4] Add tst_get_free_gid() helper function to LTP
 library
Message-ID: <20210826112212.26394-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

The man page does not say anything about how setgroups() interacts with
setuid()/setgid() so I've decided to use any unassigned gid for the non-member
setgid subtests.

 include/tst_uid.h | 18 ++++++++++++++++++
 lib/tst_uid.c     | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/tst_uid.h
 create mode 100644 lib/tst_uid.c

diff --git a/include/tst_uid.h b/include/tst_uid.h
new file mode 100644
index 000000000..7135a9cad
--- /dev/null
+++ b/include/tst_uid.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2021 Linux Test Project
+ */
+
+#ifndef TST_UID_H_
+#define TST_UID_H_
+
+#include <sys/types.h>
+
+/*
+ * Find unassigned gid. The skip argument can be used to ignore e.g. the main
+ * group of a specific user in case it's not listed in the group file. If you
+ * do not need to skip any specific gid, simply set it to 0.
+ */
+gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
+#define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
+
+#endif /* TST_UID_H_ */
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
new file mode 100644
index 000000000..a73cafa46
--- /dev/null
+++ b/lib/tst_uid.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Linux Test Project
+ */
+
+#include <sys/types.h>
+#include <grp.h>
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_uid.h"
+
+#define MAX_GID 32767
+
+gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
+{
+	gid_t ret;
+
+	errno = 0;
+
+	for (ret = 0; ret < MAX_GID; ret++) {
+		if (ret == skip || getgrgid(ret))
+			continue;
+
+		if (errno == 0 || errno == ENOENT || errno == ESRCH)
+			return ret;
+
+		tst_brk_(file, lineno, TBROK|TERRNO, "Group ID lookup failed");
+		return (gid_t)-1;
+	}
+
+	tst_brk_(file, lineno, TBROK, "No free group ID found");
+	return (gid_t)-1;
+}
-- 
2.32.0

