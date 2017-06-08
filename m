From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 8 Jun 2017 14:41:13 +0800
Subject: [LTP] [PATCH 1/2] syscalls/splice04,05: fix max limit for pipe
Message-ID: <1496904074-25394-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These cases fail on some older kernel(e.g, 2.6.32 and
2.6.35-rc1) because the pipe-max-size file does not exist.

The pipe-max-pages is introduced in kernel:
'b492e95be0ae(pipe: set lower and upper limit on max pages
in the pipe page array)'

The pipe-max-pages is renamed to pipe-max-size in kernel:
'ff9da691c049(pipe: change /proc/sys/fs/pipe-max-pages to
byte sized interface)'

We add get_max_limit function to check whether pipe-max-pages
or pipe-max-size exists.  If both pipe-max-pages and pipe-max-size
don't exist, the max limit is set to default PIPE_MAX.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/splice/splice.h   | 45 +++++++++++++++++++++++++++++
 testcases/kernel/syscalls/splice/splice04.c |  6 ++--
 testcases/kernel/syscalls/splice/splice05.c |  6 ++--
 3 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/splice/splice.h

diff --git a/testcases/kernel/syscalls/splice/splice.h b/testcases/kernel/syscalls/splice/splice.h
new file mode 100644
index 0000000..681f657
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+#ifndef SPLICE_H__
+#define SPLICE_H__
+
+#include <unistd.h>
+#include "tst_safe_file_ops.h"
+#include "tst_minmax.h"
+
+static inline int get_max_limit(int default_len_data)
+{
+	int pipe_max_unpriv;
+	int pipe_max_limit;
+
+	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
+		pipe_max_limit = MIN(pipe_max_unpriv, default_len_data);
+		return pipe_max_limit;
+	}
+
+	if (!access("/proc/sys/fs/pipe-max-pages", F_OK)) {
+		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-pages", "%d", &pipe_max_unpriv);
+		pipe_max_limit = MIN(pipe_max_unpriv * getpagesize(), default_len_data);
+		return pipe_max_limit;
+	}
+
+	return default_len_data;
+}
+
+#endif  /* SPLICE_H__ */
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index da0d3e1..2c94a29 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -27,6 +27,7 @@
 #include <fcntl.h>
 #include <stdlib.h>
 #include "tst_test.h"
+#include "splice.h"
 
 #define PIPE_MAX (64*1024)
 
@@ -41,10 +42,9 @@ static struct tst_option options[] = {
 
 static void setup(void)
 {
-	int i, pipe_max_unpriv, pipe_limit;
+	int i, pipe_limit;
 
-	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
-	pipe_limit = MIN(pipe_max_unpriv, num_len_data);
+	pipe_limit = get_max_limit(num_len_data);
 	num_len_data = pipe_limit;
 
 	if (tst_parse_int(str_len_data, &num_len_data, 1, pipe_limit)) {
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 7f312e7..d7edf8d 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -32,6 +32,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "tst_test.h"
+#include "splice.h"
 
 #define PIPE_MAX (64*1024)
 
@@ -46,10 +47,9 @@ static struct tst_option options[] = {
 
 static void setup(void)
 {
-	int i, pipe_max_unpriv, pipe_limit;
+	int i, pipe_limit;
 
-	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
-	pipe_limit = MIN(pipe_max_unpriv, num_len_data);
+	pipe_limit = get_max_limit(num_len_data);
 	num_len_data = pipe_limit;
 
 	if (tst_parse_int(str_len_data, &num_len_data, 1, pipe_limit)) {
-- 
1.8.3.1



