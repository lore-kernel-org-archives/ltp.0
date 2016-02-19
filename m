From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 11:03:33 +0100
Subject: [LTP] [PATCH 1/5] open_posix: add SAFE_PFUNC macro
Message-ID: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Simple macro to exit test and print error if a pthread_* function
returned non-zero.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/open_posix_testsuite/include/safe_helpers.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/include/safe_helpers.h

diff --git a/testcases/open_posix_testsuite/include/safe_helpers.h b/testcases/open_posix_testsuite/include/safe_helpers.h
new file mode 100644
index 000000000000..655e158f65d0
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/safe_helpers.h
@@ -0,0 +1,17 @@
+#ifndef __SAFE_MACROS_H__
+#define __SAFE_MACROS_H__
+
+#include <string.h>
+
+#define SAFE_PFUNC(op) \
+do {\
+	int ret = (op); \
+	if (ret != 0) { \
+		printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
+			__FILE__, ret, strerror(ret), __LINE__, #op); \
+		fflush(stdout); \
+		exit(PTS_UNRESOLVED); \
+	} \
+} while (0)
+
+#endif
-- 
1.8.3.1

