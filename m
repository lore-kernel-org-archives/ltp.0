From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Tue, 4 Dec 2018 20:53:12 +0800
Subject: [LTP] [PATCH] packet/fanout01.c: Fix compiler errors and warning
Message-ID: <1543927992-29054-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)Compilations fail on some older distros:
  a.CLONE_NEWUSER and CLONE_NEWNET are undefined on RHEL5, so include
    lapi/namespaces_constants.h to fix it.
  b.PACKET_FANOUT and PACKET_FANOUT_ROLLOVER are undefined on RHEL5/6,
    so create and include lapi/if_packet.h to fix it.
2)A warning occurs when initializing ifreq structure on RHEL5/6/7, so
  use memset() to fix it.

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/if_packet.h            | 18 ++++++++++++++++++
 testcases/network/packet/fanout01.c |  7 ++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/if_packet.h

diff --git a/include/lapi/if_packet.h b/include/lapi/if_packet.h
new file mode 100644
index 0000000..c077b56
--- /dev/null
+++ b/include/lapi/if_packet.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Jinhui huang <huangjh.jy@cn.fujitsu.com>
+ */
+
+#ifndef __LAPI_IF_PACKET_H__
+#define __LAPI_IF_PACKET_H__
+
+#ifndef PACKET_FANOUT
+#define PACKET_FANOUT	18
+#endif
+
+#ifndef PACKET_FANOUT_ROLLOVER
+#define PACKET_FANOUT_ROLLOVER	3
+#endif
+
+#endif /* __LAPI_IF_PACKET_H__ */
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 9f2d9bb..f5ce19a 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -17,9 +17,12 @@
 #include <sys/types.h>
 #include <net/if.h>
 #include <linux/if_packet.h>
+#include <string.h>
 
 #include "tst_test.h"
 #include "tst_fuzzy_sync.h"
+#include "lapi/if_packet.h"
+#include "lapi/namespaces_constants.h"
 
 static struct tst_fzsync_pair pair;
 static int fd;
@@ -64,7 +67,9 @@ void *binder(void *unused)
 void run(void)
 {
 	int fanout_val = PACKET_FANOUT_ROLLOVER, index;
-	struct ifreq ifr = { 0 };
+	struct ifreq ifr;
+
+	memset(&ifr, 0, sizeof(struct ifreq));
 
 	tst_fzsync_pair_reset(&pair, binder);
 	while (tst_fzsync_run_a(&pair)) {
-- 
1.8.3.1



