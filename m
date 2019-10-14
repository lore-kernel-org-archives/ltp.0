From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 14 Oct 2019 14:42:37 +0200
Subject: [LTP] [PATCH] mlock_8-1,
 munlock_10-1: don't use LONG_MAX as invalid pointer
Message-ID: <2e51e5453562001b5b6992ccc897d9177e6673ca.1571053661.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

arm64 kernel with commit 057d3389108e ("mm: untag user pointers passed to
memory syscalls") will assume this is tagged user pointer and will
attempt to clear first byte. This leads to test hitting different error
(EINVAL instead of ENOMEM).

Add a helper function which provides invalid/unused pointer from user
address space.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/mlock/8-1.c             | 11 ++--------
 .../conformance/interfaces/munlock/10-1.c          | 11 ++--------
 .../open_posix_testsuite/include/invalid_helpers.h | 25 ++++++++++++++++++++++
 3 files changed, 29 insertions(+), 18 deletions(-)
 create mode 100644 testcases/open_posix_testsuite/include/invalid_helpers.h

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
index d9569008b82b..5883ff8ec162 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/8-1.c
@@ -20,22 +20,15 @@
 #include <errno.h>
 #include <limits.h>
 #include "posixtest.h"
+#include "invalid_helpers.h"
 
 #define BUFSIZE 8
 
 int main(void)
 {
 	int result;
-	long page_size;
-	void *page_ptr;
+	void *page_ptr = get_invalid_ptr();
 
-	page_size = sysconf(_SC_PAGESIZE);
-	if (errno) {
-		perror("An error occurs when calling sysconf()");
-		return PTS_UNRESOLVED;
-	}
-
-	page_ptr = (void *)(LONG_MAX - (LONG_MAX % page_size));
 	result = mlock(page_ptr, BUFSIZE);
 
 	if (result == -1 && errno == ENOMEM) {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
index cf870289b512..1bc3d8015808 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/munlock/10-1.c
@@ -20,22 +20,15 @@
 #include <errno.h>
 #include <limits.h>
 #include "posixtest.h"
+#include "invalid_helpers.h"
 
 #define BUFSIZE 8
 
 int main(void)
 {
 	int result;
-	long page_size;
-	void *page_ptr;
+	void *page_ptr = get_invalid_ptr();
 
-	page_size = sysconf(_SC_PAGESIZE);
-	if (errno) {
-		perror("An error occurs when calling sysconf()");
-		return PTS_UNRESOLVED;
-	}
-
-	page_ptr = (void *)(LONG_MAX - (LONG_MAX % page_size));
 	result = munlock(page_ptr, BUFSIZE);
 
 	if (result == -1 && errno == ENOMEM) {
diff --git a/testcases/open_posix_testsuite/include/invalid_helpers.h b/testcases/open_posix_testsuite/include/invalid_helpers.h
new file mode 100644
index 000000000000..7882c783abf6
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/invalid_helpers.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2019 Linux Test Project
+ */
+
+#ifndef __INVALID_HELPERS_H__
+#define __INVALID_HELPERS_H__
+
+#include <stdlib.h>
+#include "safe_helpers.h"
+
+#define DISTANT_AREA_SIZE (128*1024*1024)
+
+static void *get_invalid_ptr(void)
+{
+	int page_size;
+	void *ptr;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	SAFE_PFUNC(posix_memalign(&ptr, page_size, DISTANT_AREA_SIZE));
+	free(ptr);
+
+	return (char *)ptr + (DISTANT_AREA_SIZE / 2);
+}
+
+#endif
-- 
1.8.3.1

