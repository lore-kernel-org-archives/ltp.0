From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  5 May 2020 17:23:13 +0200
Subject: [LTP] [PATCH v2 1/3] Move if_packet.h compat macros to LAPI headers
Message-ID: <20200505152315.29216-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch.

 include/lapi/if_ether.h                       | 19 ++++++++++
 include/lapi/if_packet.h                      | 32 ++++++++++++++++
 .../kernel/syscalls/setsockopt/setsockopt02.c | 37 +------------------
 3 files changed, 53 insertions(+), 35 deletions(-)
 create mode 100644 include/lapi/if_ether.h

diff --git a/include/lapi/if_ether.h b/include/lapi/if_ether.h
new file mode 100644
index 000000000..0e9a4fcc1
--- /dev/null
+++ b/include/lapi/if_ether.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
+ */
+
+#ifndef __LAPI_IF_ETHER_H__
+#define __LAPI_IF_ETHER_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_IF_ETHER_H
+# include <linux/if_ether.h>
+#endif
+
+#ifndef ETH_P_ALL
+# define ETH_P_ALL 0x0003
+#endif
+
+#endif /* __LAPI_IF_ETHER_H__ */
diff --git a/include/lapi/if_packet.h b/include/lapi/if_packet.h
index c077b564d..81110217d 100644
--- a/include/lapi/if_packet.h
+++ b/include/lapi/if_packet.h
@@ -7,6 +7,24 @@
 #ifndef __LAPI_IF_PACKET_H__
 #define __LAPI_IF_PACKET_H__
 
+#include "config.h"
+
+#ifdef HAVE_LINUX_IF_PACKET_H
+# include <linux/if_packet.h>
+#endif
+
+#ifndef PACKET_RX_RING
+# define PACKET_RX_RING 5
+#endif
+
+#ifndef PACKET_VERSION
+# define PACKET_VERSION 10
+#endif
+
+#ifndef PACKET_RESERVE
+# define PACKET_RESERVE 12
+#endif
+
 #ifndef PACKET_FANOUT
 #define PACKET_FANOUT	18
 #endif
@@ -15,4 +33,18 @@
 #define PACKET_FANOUT_ROLLOVER	3
 #endif
 
+#ifndef HAVE_STRUCT_TPACKET_REQ3
+# define TPACKET_V3 2
+
+struct tpacket_req3 {
+	unsigned int	tp_block_size;
+	unsigned int	tp_block_nr;
+	unsigned int	tp_frame_size;
+	unsigned int	tp_frame_nr;
+	unsigned int	tp_retire_blk_tov;
+	unsigned int	tp_sizeof_priv;
+	unsigned int	tp_feature_req_word;
+};
+#endif
+
 #endif /* __LAPI_IF_PACKET_H__ */
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
index dc9db2d43..f0a2a5ecd 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt02.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -20,41 +20,8 @@
 #include <errno.h>
 #include "tst_test.h"
 #include "tst_safe_net.h"
-#include "config.h"
-
-#ifdef HAVE_LINUX_IF_PACKET_H
-# include <linux/if_packet.h>
-#endif
-
-#ifdef HAVE_LINUX_IF_ETHER_H
-# include <linux/if_ether.h>
-#endif
-
-#ifndef ETH_P_ALL
-# define ETH_P_ALL 0x0003
-#endif
-
-#ifndef PACKET_RX_RING
-# define PACKET_RX_RING 5
-#endif
-
-#ifndef PACKET_VERSION
-# define PACKET_VERSION 10
-#endif
-
-#ifndef HAVE_STRUCT_TPACKET_REQ3
-# define TPACKET_V3 2
-
-struct tpacket_req3 {
-	unsigned int	tp_block_size;
-	unsigned int	tp_block_nr;
-	unsigned int	tp_frame_size;
-	unsigned int	tp_frame_nr;
-	unsigned int	tp_retire_blk_tov;
-	unsigned int	tp_sizeof_priv;
-	unsigned int	tp_feature_req_word;
-};
-#endif
+#include "lapi/if_packet.h"
+#include "lapi/if_ether.h"
 
 static int sk;
 static long pgsz;
-- 
2.26.2

