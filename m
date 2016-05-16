From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 16 May 2016 11:19:49 +0800
Subject: [LTP] [PATCH] syscalls/access01: Fix the test to run both under
	nobody and root
Message-ID: <1463368789-1403-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access01.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 7d19d08..a447607 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -27,6 +27,8 @@
  */
 #include <errno.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <string.h>
 #include "tst_test.h"
 
 #define FNAME_RWX "accessfile_rwx"
@@ -117,8 +119,26 @@ static void verify_access(unsigned int n)
 		verify_success(tc);
 }
 
+static void verify_root(struct tcase *tc)
+{
+	if (!strcmp(tc->fname, FNAME_X))
+		tc->exp_errno = 0;
+
+	if (!strcmp(tc->fname, FNAME_R) || !strcmp(tc->fname, FNAME_W)) {
+		if (strstr(tc->name, "X_OK") == NULL)
+			tc->exp_errno = 0;
+	}
+}
+
 static void setup(void)
 {
+	unsigned int i;
+
+	if (geteuid() == 0) {
+		for (i = 0; i < ARRAY_SIZE(tcases); i++)
+			verify_root(&tcases[i]);
+	}
+
 	SAFE_TOUCH(FNAME_RWX, 0777, NULL);
 	SAFE_TOUCH(FNAME_R, 0444, NULL);
 	SAFE_TOUCH(FNAME_W, 0222, NULL);
-- 
1.8.3.1



