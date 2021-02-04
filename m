From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 4 Feb 2021 20:12:38 +0800
Subject: [LTP] [PATCH v2 1/5] tst_mallinfo.c: Add a common print helper for
 mallinfo
In-Reply-To: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
Message-ID: <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This function can be used for mallopt and subsequent mallinfo/mallinfo2 test.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 configure.ac           |  1 +
 include/tst_mallinfo.h | 17 +++++++++++++++++
 lib/tst_mallinfo.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 include/tst_mallinfo.h
 create mode 100644 lib/tst_mallinfo.c

diff --git a/configure.ac b/configure.ac
index 8bdb96300..223900ca1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -94,6 +94,7 @@ AC_CHECK_FUNCS_ONCE([ \
     io_uring_register \
     io_uring_enter \
     kcmp \
+    mallinfo \
     mallopt \
     mkdirat \
     mknodat \
diff --git a/include/tst_mallinfo.h b/include/tst_mallinfo.h
new file mode 100644
index 000000000..bd69d032c
--- /dev/null
+++ b/include/tst_mallinfo.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+#ifndef TST_MALLINFO_H__
+#define TST_MALLINFO_H__
+
+#include <malloc.h>
+#include "config.h"
+
+#ifdef HAVE_MALLINFO
+void tst_print_mallinfo(const char *msg, struct mallinfo *m);
+#endif
+
+#endif
diff --git a/lib/tst_mallinfo.c b/lib/tst_mallinfo.c
new file mode 100644
index 000000000..229e5aa2e
--- /dev/null
+++ b/lib/tst_mallinfo.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_mallinfo.h"
+
+// To DO for mallinfo2
+#ifdef HAVE_MALLINFO
+void tst_print_mallinfo(const char *msg, struct mallinfo *m)
+{
+	tst_res(TINFO, "%s...", msg);
+#define P(f) tst_res(TINFO, "%s: %d", #f, m->f)
+	P(arena);
+	P(ordblks);
+	P(smblks);
+	P(hblks);
+	P(hblkhd);
+	P(usmblks);
+	P(fsmblks);
+	P(uordblks);
+	P(fordblks);
+	P(keepcost);
+}
+#endif
-- 
2.23.0



