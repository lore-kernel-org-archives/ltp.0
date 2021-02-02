From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  2 Feb 2021 14:04:40 +0100
Subject: [LTP] [PATCH 1/2] lib: Add function to detect FIPS mode
Message-ID: <20210202130441.17861-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fips.h | 17 +++++++++++++++++
 include/tst_test.h |  1 +
 lib/tst_fips.c     | 22 ++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 include/tst_fips.h
 create mode 100644 lib/tst_fips.c

diff --git a/include/tst_fips.h b/include/tst_fips.h
new file mode 100644
index 000000000..2bc90e8e8
--- /dev/null
+++ b/include/tst_fips.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef TST_FIPS_H__
+#define TST_FIPS_H__
+
+#define PATH_FIPS	"/proc/sys/crypto/fips_enabled"
+
+/*
+ * Detect whether FIPS enabled
+ * @return 0: FIPS not enabled, 1: FIPS enabled
+ */
+int tst_fips_enabled(void);
+
+#endif /* TST_FIPS_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index c87251870..84cbcbb0c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -42,6 +42,7 @@
 #include "tst_assert.h"
 #include "tst_cgroup.h"
 #include "tst_lockdown.h"
+#include "tst_fips.h"
 #include "tst_taint.h"
 
 /*
diff --git a/lib/tst_fips.c b/lib/tst_fips.c
new file mode 100644
index 000000000..c1d3e284c
--- /dev/null
+++ b/lib/tst_fips.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_fips.h"
+
+int tst_fips_enabled(void)
+{
+	int fips = 0;
+
+	if (access(PATH_FIPS, R_OK) == 0) {
+		SAFE_FILE_SCANF(PATH_FIPS, "%d", &fips);
+	}
+
+	tst_res(TINFO, "FIPS: %s", fips ? "on" : "off");
+	return fips;
+}
-- 
2.30.0

