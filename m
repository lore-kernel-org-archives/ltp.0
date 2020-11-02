From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon,  2 Nov 2020 10:49:45 +0800
Subject: [LTP] [PATCHv2] syscalls/statx05: add mkfs.ext4 package version
 check
Message-ID: <20201102024945.6605-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The encryption feature was added in e2fsprogs 1.43:
  e2fsprogs (1.43~WIP.2015.05.18-1) unstable; urgency=low
    * Add support for file encryption feature

The test should be skipped when running with older package, otherwise
it will fail with:
  Invalid filesystem option set: encrypt

Use popen and fscanf to get mkfs.ext4 -V output for version
comparison. This version checking by adding digits together does not
work with alphabets in the number like rc1, but in that case the test
will still be tested.

It will now be skipped with (Tested with Ubuntu Xenial + 4.15 kernel):
  statx05.c:102: TCONF: Test needs mkfs.ext4 >= 1.43 for encrypt option, test skipped

Fixes: #542
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/statx/statx05.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 77684e1ed..d7ac24418 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -17,6 +17,7 @@
  * Second directory has no flags set.
  *
  * Minimum kernel version required is 4.11.
+ * Minimum e2fsprogs version required is 1.43.
  */
 
 #define _GNU_SOURCE
@@ -24,6 +25,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "tst_safe_stdio.h"
 #include "tst_test.h"
 #include "lapi/fs.h"
 #include "lapi/stat.h"
@@ -86,9 +88,18 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
+	FILE *f;
 	char opt_bsize[32];
 	const char *const fs_opts[] = {"-O encrypt", opt_bsize, NULL};
-	int ret;
+	int ret, rc, major, minor, patch;
+
+	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
+	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
+	if (rc != 3)
+		tst_res(TWARN, "Unable parse version number");
+	else if (major * 10000 + minor * 100 + patch < 14300)
+		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for encrypt option, test skipped");
+	pclose(f);
 
 	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
 
-- 
2.17.1

