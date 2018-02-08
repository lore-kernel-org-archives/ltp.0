From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  8 Feb 2018 18:55:23 +0300
Subject: [LTP] [PATCH] openposix: mmap/21-1: adjust the test to work with
	MAP_SHARED_VALIDATE
Message-ID: <1518105323-12867-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Linux commit 50a8e840d050 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags")
introduced the MAP_SHARED_VALIDATE flag, which is similar to MAP_SHARED but
provides additional semantics. So on we need to make sure that the invalid
value of 'flags' in the test is generated taking into account this new flag.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/mmap/21-1.c             |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
index dc0cc13..81114b7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/21-1.c
@@ -27,6 +27,24 @@
 #include <errno.h>
 #include "posixtest.h"
 
+int is_valid(int flag)
+{
+	if (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
+		return 1;
+
+#ifdef __linux__
+
+#ifndef MAP_SHARED_VALIDATE
+#define MAP_SHARED_VALIDATE 0x03
+#endif
+
+	if (flag == MAP_SHARED_VALIDATE)
+		return 1;
+#endif
+
+	return 0;
+}
+
 int main(void)
 {
 	char tmpfname[256];
@@ -51,7 +69,7 @@ int main(void)
 	}
 
 	flag = MAP_SHARED;
-	while (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
+	while (is_valid(flag))
 		flag++;
 
 	pa = mmap(NULL, size, PROT_READ | PROT_WRITE, flag, fd, 0);
-- 
1.7.1

