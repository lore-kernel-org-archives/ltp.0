From: Sandeep Patil <sspatil@google.com>
Date: Fri, 25 Aug 2017 14:33:03 -0700
Subject: [LTP] [PATCH] android: getcwd0[12]: use temp dir from $TMPDIR if
	present
Message-ID: <20170825213303.38909-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

getcwd01/getcwd02 tests are broken on an Android system as the device
doesn't have "/tmp". Instead of hardcoding the temporary directory
to be "/tmp", look for it in 'TMPDIR' environment variable and fallback
to "/tmp" if its not defined.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c      |  4 ++-
 testcases/kernel/syscalls/getcwd/getcwd02.c      |  8 +++--
 testcases/kernel/syscalls/getcwd/getcwd_helper.h | 39 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getcwd/getcwd_helper.h

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index fdf306103..cde4b1641 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -34,9 +34,11 @@
  */
 
 #include <errno.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
 #include "tst_test.h"
+#include "getcwd_helper.h"
 
 static char buffer[5];
 
@@ -76,7 +78,7 @@ static void verify_getcwd(unsigned int n)
 
 static void setup(void)
 {
-	SAFE_CHDIR("/tmp");
+	SAFE_CHDIR(get_tmpdir_path());
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/getcwd/getcwd02.c b/testcases/kernel/syscalls/getcwd/getcwd02.c
index 384157d42..11480f14f 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd02.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd02.c
@@ -28,8 +28,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include "tst_test.h"
+#include "getcwd_helper.h"
 
-#define TMPDIR "/tmp"
 
 static char exp_buf[PATH_MAX];
 static char buffer[PATH_MAX];
@@ -71,9 +71,11 @@ end:
 
 static void setup(void)
 {
-	SAFE_CHDIR(TMPDIR);
+	const char *tmpdir = get_tmpdir_path();
 
-	if (!realpath(TMPDIR, exp_buf))
+	SAFE_CHDIR(tmpdir);
+
+	if (!realpath(tmpdir, exp_buf))
 		tst_brk(TBROK | TERRNO, "realpath() failed");
 
 	tst_res(TINFO, "Expected path '%s'", exp_buf);
diff --git a/testcases/kernel/syscalls/getcwd/getcwd_helper.h b/testcases/kernel/syscalls/getcwd/getcwd_helper.h
new file mode 100644
index 000000000..6a78ddbf5
--- /dev/null
+++ b/testcases/kernel/syscalls/getcwd/getcwd_helper.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2017 Google Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+#ifndef GETCWD_HELPER_H
+#define GETCWD_HELPER_H
+
+#include <stdlib.h>
+
+#define GETCWD_TMPDIR_PATH	"/tmp"
+
+static const char *get_tmpdir_path(void)
+{
+	const char *tmpdir;
+
+	tmpdir = getenv("TMPDIR");
+	if (!tmpdir)
+		return GETCWD_TMPDIR_PATH;
+
+	/* $TMPDIR must be absolute path.. */
+	if (tmpdir[0] != '/')
+		return GETCWD_TMPDIR_PATH;
+
+	return tmpdir;
+}
+
+#endif /* GETCWD_HELPER_H */
-- 
2.14.1.342.g6490525c54-goog

