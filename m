From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 22 Aug 2019 16:17:13 +0200
Subject: [LTP] [PATCH v2 2/2] capability: library tests
In-Reply-To: <20190822141713.26825-1-rpalethorpe@suse.com>
References: <20190808153825.18363-2-rpalethorpe@suse.com>
 <20190822141713.26825-1-rpalethorpe@suse.com>
Message-ID: <20190822141713.26825-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/capability.h           |  8 +++++
 lib/newlib_tests/tst_capability01.c | 50 +++++++++++++++++++++++++++++
 lib/newlib_tests/tst_capability02.c | 35 ++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 lib/newlib_tests/tst_capability01.c
 create mode 100644 lib/newlib_tests/tst_capability02.c

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 02d7a9fda..dac233d84 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -12,10 +12,18 @@
 # include <sys/capability.h>
 #endif
 
+#ifndef CAP_NET_RAW
+# define CAP_NET_RAW          13
+#endif
+
 #ifndef CAP_SYS_ADMIN
 # define CAP_SYS_ADMIN        21
 #endif
 
+#ifndef CAP_AUDIT_READ
+# define CAP_AUDIT_READ       37
+#endif
+
 #ifndef CAP_TO_INDEX
 # define CAP_TO_INDEX(x)     ((x) >> 5)
 #endif
diff --git a/lib/newlib_tests/tst_capability01.c b/lib/newlib_tests/tst_capability01.c
new file mode 100644
index 000000000..1a9cb0568
--- /dev/null
+++ b/lib/newlib_tests/tst_capability01.c
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * The user or file requires CAP_NET_RAW for this test to work.
+ * e.g use "$ setcap cap_net_raw=pei tst_capability"
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "tst_safe_net.h"
+
+#include "lapi/socket.h"
+
+static void run(void)
+{
+	TEST(socket(AF_INET, SOCK_RAW, 1));
+	if (TST_RET > -1) {
+		tst_res(TFAIL, "Created raw socket");
+	} else if (TST_ERR != EPERM) {
+		tst_res(TBROK | TTERRNO,
+			"Failed to create socket for wrong reason");
+	} else {
+		tst_res(TPASS | TTERRNO, "Didn't create raw socket");
+	}
+}
+
+static void setup(void)
+{
+	if (geteuid() == 0)
+		tst_res(TWARN, "CAP_NET_RAW may be ignored when euid == 0");
+
+	TEST(socket(AF_INET, SOCK_RAW, 1));
+	if (TST_RET < 0)
+		tst_brk(TFAIL | TTERRNO, "Can't create raw socket in setup");
+
+	SAFE_CLOSE(TST_RET);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
+		{}
+	},
+};
diff --git a/lib/newlib_tests/tst_capability02.c b/lib/newlib_tests/tst_capability02.c
new file mode 100644
index 000000000..45e3f2d22
--- /dev/null
+++ b/lib/newlib_tests/tst_capability02.c
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "tst_safe_net.h"
+
+#include "lapi/socket.h"
+
+static void run(void)
+{
+	TEST(socket(AF_INET, SOCK_RAW, 1));
+	if (TST_RET > -1) {
+		tst_res(TPASS, "Created raw socket");
+		SAFE_CLOSE(TST_RET);
+	} else {
+		tst_res(TFAIL | TTERRNO, "Didn't create raw socket");
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_NET_RAW),
+		TST_CAP(TST_CAP_DROP, CAP_AUDIT_READ), /* 64bit capability */
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
+};
-- 
2.22.0

