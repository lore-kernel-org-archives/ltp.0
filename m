From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Tue, 22 Dec 2020 03:48:27 -0500
Subject: [LTP] [PATCH 2/3] lapi/sem.h: Add SEM_STAT_ANY
In-Reply-To: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <1608626908-8117-2-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 include/lapi/sem.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/lapi/sem.h

diff --git a/include/lapi/sem.h b/include/lapi/sem.h
new file mode 100644
index 0000000..5d86a2f
--- /dev/null
+++ b/include/lapi/sem.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
+ */
+
+#ifndef LAPI_SEM_H
+#define LAPI_SEM_H
+
+#ifndef SEM_STAT_ANY
+# define SEM_STAT_ANY 20
+#endif
+
+#endif /* LAPI_SEM_H */
+
-- 
1.8.3.1



