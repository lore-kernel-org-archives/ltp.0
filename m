From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:28 +0200
Subject: [LTP] [PATCH 1/6] lapi: Add TEMP_FAILURE_RETRY definition
Message-ID: <20181018112433.9554-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

and use it in realtime to fix pi-tests.
This fixes build failure on libc missing it (e.g. musl, bionic):

test-skeleton.c:112:12: warning: implicit declaration of function ‘TEMP_FAILURE_RETRY’ [-Wimplicit-function-declaration]
  termpid = TEMP_FAILURE_RETRY(waitpid(pid, &status, 0));
            ^~~~~~~~~~~~~~~~~~
make[5]: *** [<builtin>: testpi-6] Error 1

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/unistd.h                          | 18 ++++++++++++++++++
 .../realtime/func/pi-tests/test-skeleton.c     |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 include/lapi/unistd.h

diff --git a/include/lapi/unistd.h b/include/lapi/unistd.h
new file mode 100644
index 000000000..7ddc60e9a
--- /dev/null
+++ b/include/lapi/unistd.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ */
+#ifndef LAPI_UNISTD_H__
+#define LAPI_UNISTD_H__
+
+/* glibc unistd.h */
+#ifndef TEMP_FAILURE_RETRY
+# define TEMP_FAILURE_RETRY(expression) \
+  (__extension__							      \
+    ({ long int __result;						      \
+       do __result = (long int) (expression);				      \
+       while (__result == -1L && errno == EINTR);			      \
+       __result; }))
+#endif
+
+#endif /* LAPI_UNISTD_H__ */
diff --git a/testcases/realtime/func/pi-tests/test-skeleton.c b/testcases/realtime/func/pi-tests/test-skeleton.c
index 326a8ab56..7ad4804c8 100644
--- a/testcases/realtime/func/pi-tests/test-skeleton.c
+++ b/testcases/realtime/func/pi-tests/test-skeleton.c
@@ -42,6 +42,7 @@
 #include <sys/wait.h>
 #include <time.h>
 #include <librttest.h>
+#include "lapi/unistd.h"
 
 void usage(void)
 {
-- 
2.19.1

