From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Wed, 25 Aug 2021 15:39:29 +0000
Subject: [LTP] [PATCH 1/4 v2] api: Add a IS_BIT_SET() macro in tst_bitmap.h
In-Reply-To: <20210825153932.138396-1-ziyaoxie@outlook.com>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
Message-ID: <OSZP286MB0871E8F61CE0773AF89CF35FCCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Xie Ziyao" <ziyaoxie@outlook.com>

Add a IS_BIT_SET() macro in tst_bitmap.h to check whether the n-th bit
of val is set.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
v1->v2:
1. Add a IS_BIT_SET() macro in tst_bitmap.h.

 include/tst_bitmap.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/tst_bitmap.h

diff --git a/include/tst_bitmap.h b/include/tst_bitmap.h
new file mode 100644
index 000000000..528a2bdaa
--- /dev/null
+++ b/include/tst_bitmap.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) Linux Test Project, 2021
+ * Author: Xie Ziyao <ziyaoxie@outlook.com>
+ */
+
+#ifndef TST_BITMAP_H__
+#define TST_BITMAP_H__
+
+/*
+ * Check whether the n-th bit of val is set
+ * @return 0: the n-th bit of val is 0, 1: the n-th bit of val is 1
+ */
+#define IS_BIT_SET(val, n) (((val) & (1<<(n))) >> (n))
+
+#endif /* TST_BITMAP_H__ */
--
2.25.1

