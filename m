From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:51 +0300
Subject: [LTP] [PATCH V2 03/11] Add TST_TRACE
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-4-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
This is a new patch in the series.

 doc/test-writing-guidelines.txt |   38 ++++++++++++++++++++++++++++++++++++++
 include/tst_test.h              |    4 ++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 740e90c..3a3e644 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1226,6 +1226,44 @@ the rest of the LTP test binaries.
 WARNING: All identifiers starting with TST_ or tst_ are reserved for the
          'test.sh' library.
 
+2.2.22 Code path tracing
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+'tst_res' is a macro, so on when you define a function in one file:
+
+[source,c]
+-------------------------------------------------------------------------------
+int do_action(void)
+{
+	...
+
+	if (ok) {
+		tst_res(TPASS, "...");
+		return 0;
+	} else {
+		tst_res(TFAIL, "...");
+		return -1;
+	}
+}
+-------------------------------------------------------------------------------
+
+and call it from another file, the file and line reported by 'tst_res' in this
+function will be from the former file.
+
+'TST_TRACE' can make the analysis of such situations easier. It's a macro which
+inserts a call to 'tst_res(TINFO, ...)' in case its argument is not zero.
+In this call to 'tst_res(TINFO, ...)' the file and line will be expanded using
+the actual location of 'TST_TRACE'.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+if (TST_TRACE(do_action())) {
+	...
+}
+-------------------------------------------------------------------------------
+
 2.3.1 Basic shell test structure
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/tst_test.h b/include/tst_test.h
index 3e2ff5b..eb3f751 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -59,6 +59,10 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 #define SAFE_FORK() \
 	safe_fork(__FILE__, __LINE__)
 
+#define TST_TRACE(expr)							\
+	({int ret = expr;						\
+		ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; })
+
 #include "tst_safe_macros.h"
 #include "tst_safe_file_ops.h"
 #include "tst_safe_net.h"
-- 
1.7.1

