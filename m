From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 15 Dec 2020 07:49:02 +0100
Subject: [LTP] [PATCH] shm_open/37-1: Remove non-portable output
Message-ID: <20201215064902.518801-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This test could mess up some tools, because it wrote characters
outside of the ansi character set. Since most systems expect utf-8 now,
this could lead to messed up or even output.

This replaces the verbatim output of the shm ames used in the test with
a short description.

It also replaces the no-protable characters with escape sequences and
adds the missing close, if the shm was opend successfully.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/shm_open/37-1.c    | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/37-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/37-1.c
index 69dabd951..09b4d6657 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/37-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/37-1.c
@@ -1,65 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
  * Test that the shm_open() function sets errno = EINVAL if the shm_open()
  * operation is not supported for the given name.
  *
  * The supported names are implementation-defined, so the test is done for
- * several differents names. The test pass for a given name if shm_open make no
+ * several different names. The test pass for a given name if shm_open make no
  * error or set errno to EINVAL.
  */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
 #include "posixtest.h"
 
-static char *shm_name[] = {
-	/* char which are in portable character set but not in portable
-	   filename character set */
-	"$#\n@\t\a,~}",
-	/* char which are not in portable character set (accentuated char and c
-	   cedilla) */
-	"??????",
-	/* some file or directory which should exist */
-	"..",
-	"/",
-	"//",
-	"/abc",
-	NULL
+struct test_data {
+	const char *desc;
+	const char *name;
+};
+
+struct test_data testdata[] = {
+	{
+		"char which are in portable character set, "
+		"but not in portable filename character set",
+		"$#\n@\t\a,~}"
+	},
+	{
+		"chars which are not in portable character set "
+		 "(accentuated char and c cedilla)",
+		"\xe9\xea\xee\xf4\xe7\xe0"
+	},
+	{ "parent directory", ".." },
+	{ "root directory", "/" },
+	{ "double slash", "//" },
+	{ "non-existent directory", "/abc" }
 };
 
 int main(void)
 {
-	int fd, i = 0, result = PTS_PASS;
+	unsigned int i;
+	int fd, result = PTS_PASS;
 
-	while (shm_name[i]) {
+	for (i = 0; i < ARRAY_SIZE(testdata); i++) {
 		fflush(stderr);
-		printf("Name: '%s'\n", shm_name[i]);
+		printf("Test: %s\n", testdata[i].desc);
 		fflush(stdout);
 
-		fd = shm_open(shm_name[i], O_RDWR | O_CREAT, 0);
-
+		fd = shm_open(testdata[i].name, O_RDWR | O_CREAT, 0);
 		if (fd == -1 && errno == EINVAL) {
 			printf("   OK: errno == EINVAL\n");
 		} else if (fd != -1) {
-			printf("   OK: open  with success.\n");
+			printf("   OK: open with success.\n");
+			close(fd);
 		} else {
 			perror("   Unexpected error");
 			result = PTS_FAIL;
 		}
 
-		shm_unlink(shm_name[i]);
-
-		i++;
+		shm_unlink(testdata[i].name);
 	}
 
 	if (result == PTS_PASS)
-- 
2.25.1

