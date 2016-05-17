From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 May 2016 14:01:54 +0800
Subject: [LTP] [PATCH v2] syscalls/access01: Fix the test to run both under
	nobody and root
In-Reply-To: <20160516122326.GB6454@rei.lan>
References: <20160516122326.GB6454@rei.lan>
Message-ID: <1463464914-7679-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access01.c | 95 ++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 7d19d08..9f1f0c4 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -27,6 +27,7 @@
  */
 #include <errno.h>
 #include <unistd.h>
+#include <sys/types.h>
 #include "tst_test.h"
 
 #define FNAME_RWX "accessfile_rwx"
@@ -39,42 +40,54 @@ static struct tcase {
 	int mode;
 	char *name;
 	int exp_errno;
+	/*0: unspecified  1:nobody expected  2:root expected*/
+	int exp_user;
 } tcases[] = {
-	{FNAME_RWX, F_OK, "F_OK", 0},
-	{FNAME_RWX, X_OK, "X_OK", 0},
-	{FNAME_RWX, W_OK, "W_OK", 0},
-	{FNAME_RWX, R_OK, "R_OK", 0},
-
-	{FNAME_RWX, R_OK|W_OK, "R_OK|W_OK", 0},
-	{FNAME_RWX, R_OK|X_OK, "R_OK|X_OK", 0},
-	{FNAME_RWX, W_OK|X_OK, "W_OK|X_OK", 0},
-	{FNAME_RWX, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", 0},
-
-	{FNAME_X, X_OK, "X_OK", 0},
-	{FNAME_W, W_OK, "W_OK", 0},
-	{FNAME_R, R_OK, "R_OK", 0},
-
-	{FNAME_R, X_OK, "X_OK", EACCES},
-	{FNAME_R, W_OK, "W_OK", EACCES},
-	{FNAME_W, R_OK, "R_OK", EACCES},
-	{FNAME_W, X_OK, "X_OK", EACCES},
-	{FNAME_X, R_OK, "R_OK", EACCES},
-	{FNAME_X, W_OK, "W_OK", EACCES},
-
-	{FNAME_R, W_OK|X_OK, "W_OK|X_OK", EACCES},
-	{FNAME_R, R_OK|X_OK, "R_OK|X_OK", EACCES},
-	{FNAME_R, R_OK|W_OK, "R_OK|W_OK", EACCES},
-	{FNAME_R, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES},
-
-	{FNAME_W, W_OK|X_OK, "W_OK|X_OK", EACCES},
-	{FNAME_W, R_OK|X_OK, "R_OK|X_OK", EACCES},
-	{FNAME_W, R_OK|W_OK, "R_OK|W_OK", EACCES},
-	{FNAME_W, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES},
-
-	{FNAME_X, W_OK|X_OK, "W_OK|X_OK", EACCES},
-	{FNAME_X, R_OK|X_OK, "R_OK|X_OK", EACCES},
-	{FNAME_X, R_OK|W_OK, "R_OK|W_OK", EACCES},
-	{FNAME_X, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES},
+	{FNAME_RWX, F_OK, "F_OK", 0, 0},
+	{FNAME_RWX, X_OK, "X_OK", 0, 0},
+	{FNAME_RWX, W_OK, "W_OK", 0, 0},
+	{FNAME_RWX, R_OK, "R_OK", 0, 0},
+
+	{FNAME_RWX, R_OK|W_OK, "R_OK|W_OK", 0, 0},
+	{FNAME_RWX, R_OK|X_OK, "R_OK|X_OK", 0, 0},
+	{FNAME_RWX, W_OK|X_OK, "W_OK|X_OK", 0, 0},
+	{FNAME_RWX, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", 0, 0},
+
+	{FNAME_X, X_OK, "X_OK", 0, 0},
+	{FNAME_W, W_OK, "W_OK", 0, 0},
+	{FNAME_R, R_OK, "R_OK", 0, 0},
+
+	{FNAME_R, X_OK, "X_OK", EACCES, 0},
+	{FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{FNAME_W, X_OK, "X_OK", EACCES, 0},
+	{FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{FNAME_X, W_OK, "W_OK", EACCES, 1},
+
+	{FNAME_R, W_OK|X_OK, "W_OK|X_OK", EACCES, 0},
+	{FNAME_R, R_OK|X_OK, "R_OK|X_OK", EACCES, 0},
+	{FNAME_R, R_OK|W_OK, "R_OK|W_OK", EACCES, 1},
+	{FNAME_R, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES, 0},
+
+	{FNAME_W, W_OK|X_OK, "W_OK|X_OK", EACCES, 0},
+	{FNAME_W, R_OK|X_OK, "R_OK|X_OK", EACCES, 0},
+	{FNAME_W, R_OK|W_OK, "R_OK|W_OK", EACCES, 1},
+	{FNAME_W, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES, 0},
+
+	{FNAME_X, W_OK|X_OK, "W_OK|X_OK", EACCES, 1},
+	{FNAME_X, R_OK|X_OK, "R_OK|X_OK", EACCES, 1},
+	{FNAME_X, R_OK|W_OK, "R_OK|W_OK", EACCES, 1},
+	{FNAME_X, R_OK|W_OK|X_OK, "R_OK|W_OK|X_OK", EACCES, 1},
+
+	{FNAME_R, W_OK, "W_OK", 0, 2},
+	{FNAME_R, R_OK|W_OK, "R_OK|W_OK", 0, 2},
+
+	{FNAME_W, R_OK, "R_OK", 0, 2},
+	{FNAME_W, R_OK|W_OK, "R_OK|W_OK", 0, 2},
+
+	{FNAME_X, R_OK, "R_OK", 0, 2},
+	{FNAME_X, W_OK, "W_OK", 0, 2},
+	{FNAME_X, R_OK|W_OK, "R_OK|W_OK", 0, 2}
 };
 
 static void verify_success(struct tcase *tc)
@@ -109,6 +122,18 @@ static void verify_access(unsigned int n)
 {
 	struct tcase *tc = tcases + n;
 
+	if (tc->exp_user == 1 && geteuid() == 0) {
+		tst_res(TCONF, "access(%s, %s) is ignored for root",
+			tc->fname, tc->name);
+		return;
+	}
+
+	if (tc->exp_user == 2 && geteuid() != 0) {
+		tst_res(TCONF, "access(%s, %s) is ignored for nobody",
+			tc->fname, tc->name);
+		return;
+	}
+
 	TEST(access(tc->fname, tc->mode));
 
 	if (tc->exp_errno)
-- 
1.8.3.1



