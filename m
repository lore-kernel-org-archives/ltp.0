From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  7 Apr 2016 11:10:50 +0300
Subject: [LTP] [PATCH v2 1/2] lib: add safe_pthread_create() &
	safe_pthread_join()
Message-ID: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/tst_safe_pthread.h |   32 ++++++++++++++++++++++++++
 include/tst_test.h         |    1 +
 lib/safe_pthread.c         |   54 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 include/tst_safe_pthread.h
 create mode 100644 lib/safe_pthread.c

diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
new file mode 100644
index 0000000..810ddcb
--- /dev/null
+++ b/include/tst_safe_pthread.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TST_SAFE_PTHREAD_H__
+#define TST_SAFE_PTHREAD_H__
+
+int safe_pthread_create(const char *file, const int lineno,
+			pthread_t *thread_id, const pthread_attr_t *attr,
+			void *(*thread_fn)(void *), void *arg);
+#define SAFE_PTHREAD_CREATE(thread_id, attr, thread_fn, arg) \
+	safe_pthread_create(__FILE__, __LINE__, thread_id, attr, thread_fn, arg)
+
+int safe_pthread_join(const char *file, const int lineno,
+		      pthread_t thread_id, void **retval);
+#define SAFE_PTHREAD_JOIN(thread_id, retval) \
+	safe_pthread_join(__FILE__, __LINE__, thread_id, retval)
+
+#endif /* TST_SAFE_PTHREAD_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2c35dbd..88b46d6 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -60,6 +60,7 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 #include "tst_safe_macros.h"
 #include "tst_safe_file_ops.h"
 #include "tst_safe_net.h"
+#include "tst_safe_pthread.h"
 
 struct tst_option {
 	char *optstr;
diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
new file mode 100644
index 0000000..415ef2b
--- /dev/null
+++ b/lib/safe_pthread.c
@@ -0,0 +1,54 @@
+/*
+ * Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <pthread.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+int safe_pthread_create(const char *file, const int lineno,
+			pthread_t *thread_id, const pthread_attr_t *attr,
+			void *(*thread_fn)(void *), void *arg)
+{
+	int rval;
+
+	rval = pthread_create(thread_id, attr, thread_fn, arg);
+
+	if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_create(%p,%p,%p,%p) failed: %s", thread_id,
+			 attr, thread_fn, arg, tst_strerrno(rval));
+	}
+
+	return rval;
+}
+
+int safe_pthread_join(const char *file, const int lineno,
+		      pthread_t thread_id, void **retval)
+{
+	int rval;
+
+	rval = pthread_join(thread_id, retval);
+
+	if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_join(%lu,%p) failed: %s", thread_id, retval,
+			 tst_strerrno(rval));
+	}
+
+	return rval;
+}
-- 
1.7.1

