From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:50 +0200
Subject: [LTP] [PATCH v2 03/10] lapi/shm.h: Add SHM_STAT_ANY
In-Reply-To: <20200907150157.23886-1-chrubis@suse.cz>
References: <20200907150157.23886-1-chrubis@suse.cz>
Message-ID: <20200907150157.23886-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/shm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/lapi/shm.h

diff --git a/include/lapi/shm.h b/include/lapi/shm.h
new file mode 100644
index 000000000..61c4e37bf
--- /dev/null
+++ b/include/lapi/shm.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef LAPI_SHM_H__
+#define LAPI_SHM_H__
+
+#ifndef SHM_STAT_ANY
+# define SHM_STAT_ANY 15
+#endif
+
+#endif /* LAPI_SHM_H__ */
-- 
2.26.2

