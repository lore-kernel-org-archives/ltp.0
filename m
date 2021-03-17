From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 15:26:52 +0800
Subject: [LTP] [PATCH] syscalls/chdir01: Add umask before mkdir
Message-ID: <20210317072652.26974-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When uid is nobody, umask is not 022, the test process might
has not permmission to access the file which created by SAFE_MKDIR
with mode 0755.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 60165a6cb..a378b260c 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <pwd.h>

@@ -55,6 +56,14 @@ static void setup(void)
 	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
 	free(cwd);
 	SAFE_CHDIR(workdir);
+
+	/*
+	 * When uid is nobody, umask is not 022, the test process might
+	 * has not permmission to access the file which created by SAFE_MKDIR
+	 * with mode 0755.
+	 */
+	umask(022);
+
 	SAFE_MKDIR(DIR_NAME, 0755);
 	SAFE_MKDIR(BLOCKED_NAME, 0644);

--
2.17.1

