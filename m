From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  3 Aug 2021 13:52:51 +0100
Subject: [LTP] [PATCH v3 2/3] API: Add lapi/ip_tables.h and use it in
 setsockopt03
In-Reply-To: <20210803125252.16214-1-rpalethorpe@suse.com>
References: <87czquna4l.fsf@suse.de>
 <20210803125252.16214-1-rpalethorpe@suse.com>
Message-ID: <20210803125252.16214-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/ip_tables.h                      | 46 +++++++++++++++++++
 .../kernel/syscalls/setsockopt/setsockopt03.c | 39 +---------------
 2 files changed, 48 insertions(+), 37 deletions(-)
 create mode 100644 include/lapi/ip_tables.h

diff --git a/include/lapi/ip_tables.h b/include/lapi/ip_tables.h
new file mode 100644
index 000000000..e91238ffd
--- /dev/null
+++ b/include/lapi/ip_tables.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef LAPI_IP_TABLES__
+#define LAPI_IP_TABLES__
+
+#include "config.h"
+
+#include <linux/netfilter_ipv4/ip_tables.h>
+
+#ifndef HAVE_STRUCT_XT_ENTRY_MATCH
+struct xt_entry_match {
+	union {
+		struct {
+			uint16_t match_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t match_size;
+			void *match;
+		} kernel;
+		uint16_t match_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
+#ifndef HAVE_STRUCT_XT_ENTRY_TARGET
+struct xt_entry_target {
+	union {
+		struct {
+			uint16_t target_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t target_size;
+			void *target;
+		} kernel;
+		uint16_t target_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
+#endif
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 3d49628d6..1434475db 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -21,12 +21,13 @@
 #include <netinet/in.h>
 #include <net/if.h>
 #include <limits.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
 
 #include "tst_test.h"
 #include "tst_safe_net.h"
 #include "tst_kernel.h"
 
+#include "lapi/ip_tables.h"
+
 #define TOO_SMALL_OFFSET 74
 #define OFFSET_OVERWRITE 0xFFFF
 #define NEXT_OFFSET (sizeof(struct ipt_entry)		\
@@ -34,42 +35,6 @@
 		     + sizeof(struct xt_entry_target))
 #define PADDING (OFFSET_OVERWRITE - NEXT_OFFSET)
 
-#ifndef HAVE_STRUCT_XT_ENTRY_MATCH
-struct xt_entry_match {
-	union {
-		struct {
-			uint16_t match_size;
-			char name[29];
-			uint8_t revision;
-		} user;
-		struct {
-			uint16_t match_size;
-			void *match;
-		} kernel;
-		uint16_t match_size;
-	} u;
-	unsigned char data[0];
-};
-#endif
-
-#ifndef HAVE_STRUCT_XT_ENTRY_TARGET
-struct xt_entry_target {
-	union {
-		struct {
-			uint16_t target_size;
-			char name[29];
-			uint8_t revision;
-		} user;
-		struct {
-			uint16_t target_size;
-			void *target;
-		} kernel;
-		uint16_t target_size;
-	} u;
-	unsigned char data[0];
-};
-#endif
-
 struct payload {
 	struct ipt_replace repl;
 	struct ipt_entry ent;
-- 
2.31.1

