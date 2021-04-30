From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 30 Apr 2021 12:26:44 +0100
Subject: [LTP] [PATCH v5 2/7] API: Make tst_count_scanf_conversions public
In-Reply-To: <20210430112649.16302-1-rpalethorpe@suse.com>
References: <20210430112649.16302-1-rpalethorpe@suse.com>
Message-ID: <20210430112649.16302-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Useful in other parts of the library like tst_cgroup.c

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/safe_file_ops_fn.h | 10 ++++++++++
 lib/safe_file_ops.c        | 16 ++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index ed7d978dd..6d680967b 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -23,6 +23,16 @@
 
 #include "lapi/utime.h"
 
+/*
+ * Count number of expected assigned conversions. Any conversion starts with '%'.
+ * The '%%' matches % and no assignment is done. The %*x matches as x would do but
+ * the assignment is suppressed.
+ *
+ * NOTE: This is not 100% correct for complex scanf strings, but will do for
+ *       all of our intended usage.
+ */
+int tst_count_scanf_conversions(const char *fmt);
+
 /*
  * All-in-one function to scanf value(s) from a file.
  */
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 0ec2ff8fe..249a512a1 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -34,15 +34,7 @@
 #include "test.h"
 #include "safe_file_ops_fn.h"
 
-/*
- * Count number of expected assigned conversions. Any conversion starts with '%'.
- * The '%%' matches % and no assignment is done. The %*x matches as x would do but
- * the assignment is suppressed.
- *
- * NOTE: This is not 100% correct for complex scanf strings, but will do for
- *       all of our intended usage.
- */
-static int count_scanf_conversions(const char *fmt)
+int tst_count_scanf_conversions(const char *fmt)
 {
 	unsigned int cnt = 0;
 	int flag = 0;
@@ -89,7 +81,7 @@ int file_scanf(const char *file, const int lineno,
 		return 1;
 	}
 
-	exp_convs = count_scanf_conversions(fmt);
+	exp_convs = tst_count_scanf_conversions(fmt);
 
 	va_start(va, fmt);
 	ret = vfscanf(f, fmt, va);
@@ -141,7 +133,7 @@ void safe_file_scanf(const char *file, const int lineno,
 		return;
 	}
 
-	exp_convs = count_scanf_conversions(fmt);
+	exp_convs = tst_count_scanf_conversions(fmt);
 
 	va_start(va, fmt);
 	ret = vfscanf(f, fmt, va);
@@ -195,7 +187,7 @@ int file_lines_scanf(const char *file, const int lineno,
 		return 1;
 	}
 
-	arg_count = count_scanf_conversions(fmt);
+	arg_count = tst_count_scanf_conversions(fmt);
 
 	while (fgets(line, BUFSIZ, fp) != NULL) {
 		va_start(ap, fmt);
-- 
2.31.1

