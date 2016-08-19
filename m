From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 19 Aug 2016 17:19:33 +0800
Subject: [LTP] [PATCH 1/2] syscalls/access01: add testcases with files in
	subdirectory
In-Reply-To: <20160804165028.GD3367@rei.lan>
References: <20160804165028.GD3367@rei.lan>
Message-ID: <1471598374-26908-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/access01.c | 196 +++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index a445edd..25e13b7 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -32,9 +32,16 @@
 #include "tst_test.h"
 
 #define FNAME_RWX "accessfile_rwx"
-#define FNAME_R   "accesfile_r"
-#define FNAME_W   "accesfile_w"
-#define FNAME_X   "accesfile_x"
+#define FNAME_R   "accessfile_r"
+#define FNAME_W   "accessfile_w"
+#define FNAME_X   "accessfile_x"
+
+#define DNAME_R   "accessdir_r"
+#define DNAME_W   "accessdir_w"
+#define DNAME_X   "accessdir_x"
+#define DNAME_RW  "accessdir_rw"
+#define DNAME_RX  "accessdir_rx"
+#define DNAME_WX  "accessdir_wx"
 
 static uid_t uid;
 
@@ -90,7 +97,157 @@ static struct tcase {
 
 	{FNAME_X, R_OK, "R_OK", 0, 2},
 	{FNAME_X, W_OK, "W_OK", 0, 2},
-	{FNAME_X, R_OK|W_OK, "R_OK|W_OK", 0, 2}
+	{FNAME_X, R_OK|W_OK, "R_OK|W_OK", 0, 2},
+
+	{DNAME_R"/"FNAME_R, F_OK, "F_OK", 0, 2},
+	{DNAME_R"/"FNAME_R, R_OK, "R_OK", 0, 2},
+	{DNAME_R"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_R"/"FNAME_W, F_OK, "F_OK", 0, 2},
+	{DNAME_R"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_R"/"FNAME_W, W_OK, "W_OK", 0, 2},
+
+	{DNAME_R"/"FNAME_X, F_OK, "F_OK", 0, 2},
+	{DNAME_R"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_R"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_R"/"FNAME_X, X_OK, "X_OK", 0, 2},
+
+	{DNAME_W"/"FNAME_R, F_OK, "F_OK", 0, 2},
+	{DNAME_W"/"FNAME_R, R_OK, "R_OK", 0, 2},
+	{DNAME_W"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_W"/"FNAME_W, F_OK, "F_OK", 0, 2},
+	{DNAME_W"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_W"/"FNAME_W, W_OK, "W_OK", 0, 2},
+
+	{DNAME_W"/"FNAME_X, F_OK, "F_OK", 0, 2},
+	{DNAME_W"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_W"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_W"/"FNAME_X, X_OK, "X_OK", 0, 2},
+
+	{DNAME_X"/"FNAME_R, F_OK, "F_OK", 0, 3},
+	{DNAME_X"/"FNAME_R, R_OK, "R_OK", 0, 3},
+	{DNAME_X"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_X"/"FNAME_W, F_OK, "F_OK", 0, 3},
+	{DNAME_X"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_X"/"FNAME_W, W_OK, "W_OK", 0, 3},
+
+	{DNAME_X"/"FNAME_X, F_OK, "F_OK", 0, 3},
+	{DNAME_X"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_X"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_X"/"FNAME_X, X_OK, "X_OK", 0, 3},
+
+	{DNAME_RW"/"FNAME_R, F_OK, "F_OK", 0, 2},
+	{DNAME_RW"/"FNAME_R, R_OK, "R_OK", 0, 2},
+	{DNAME_RW"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_RW"/"FNAME_W, F_OK, "F_OK", 0, 2},
+	{DNAME_RW"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_RW"/"FNAME_W, W_OK, "W_OK", 0, 2},
+
+	{DNAME_RW"/"FNAME_X, F_OK, "F_OK", 0, 2},
+	{DNAME_RW"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_RW"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_RW"/"FNAME_X, X_OK, "X_OK", 0, 2},
+
+	{DNAME_RX"/"FNAME_R, F_OK, "F_OK", 0, 3},
+	{DNAME_RX"/"FNAME_R, R_OK, "R_OK", 0, 3},
+	{DNAME_RX"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_RX"/"FNAME_W, F_OK, "F_OK", 0, 3},
+	{DNAME_RX"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_RX"/"FNAME_W, W_OK, "W_OK", 0, 3},
+
+	{DNAME_RX"/"FNAME_X, F_OK, "F_OK", 0, 3},
+	{DNAME_RX"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_RX"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_RX"/"FNAME_X, X_OK, "X_OK", 0, 3},
+
+	{DNAME_WX"/"FNAME_R, F_OK, "F_OK", 0, 3},
+	{DNAME_WX"/"FNAME_R, R_OK, "R_OK", 0, 3},
+	{DNAME_WX"/"FNAME_R, W_OK, "W_OK", 0, 2},
+
+	{DNAME_WX"/"FNAME_W, F_OK, "F_OK", 0, 3},
+	{DNAME_WX"/"FNAME_W, R_OK, "R_OK", 0, 2},
+	{DNAME_WX"/"FNAME_W, W_OK, "W_OK", 0, 3},
+
+	{DNAME_WX"/"FNAME_X, F_OK, "F_OK", 0, 3},
+	{DNAME_WX"/"FNAME_X, R_OK, "R_OK", 0, 2},
+	{DNAME_WX"/"FNAME_X, W_OK, "W_OK", 0, 2},
+	{DNAME_WX"/"FNAME_X, X_OK, "X_OK", 0, 3},
+
+	{DNAME_R"/"FNAME_R, F_OK, "F_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_R, R_OK, "R_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_R"/"FNAME_W, F_OK, "F_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_W, W_OK, "W_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_R"/"FNAME_X, F_OK, "F_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_X, W_OK, "W_OK", EACCES, 1},
+	{DNAME_R"/"FNAME_X, X_OK, "X_OK", EACCES, 1},
+
+	{DNAME_W"/"FNAME_R, F_OK, "F_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_R, R_OK, "R_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_W"/"FNAME_W, F_OK, "F_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_W, W_OK, "W_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_W"/"FNAME_X, F_OK, "F_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_X, W_OK, "W_OK", EACCES, 1},
+	{DNAME_W"/"FNAME_X, X_OK, "X_OK", EACCES, 1},
+
+	{DNAME_X"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_X"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_X"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_X"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_X"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_X"/"FNAME_X, W_OK, "W_OK", EACCES, 1},
+
+	{DNAME_RW"/"FNAME_R, F_OK, "F_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_R, R_OK, "R_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_RW"/"FNAME_W, F_OK, "F_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_W, W_OK, "W_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_RW"/"FNAME_X, F_OK, "F_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_X, W_OK, "W_OK", EACCES, 1},
+	{DNAME_RW"/"FNAME_X, X_OK, "X_OK", EACCES, 1},
+
+	{DNAME_RX"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_RX"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_RX"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_RX"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_RX"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_RX"/"FNAME_X, W_OK, "W_OK", EACCES, 1},
+
+	{DNAME_WX"/"FNAME_R, W_OK, "W_OK", EACCES, 1},
+	{DNAME_WX"/"FNAME_R, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_WX"/"FNAME_W, R_OK, "R_OK", EACCES, 1},
+	{DNAME_WX"/"FNAME_W, X_OK, "X_OK", EACCES, 3},
+
+	{DNAME_WX"/"FNAME_X, R_OK, "R_OK", EACCES, 1},
+	{DNAME_WX"/"FNAME_X, W_OK, "W_OK", EACCES, 1}
 };
 
 static void verify_success(struct tcase *tc, const char *user)
@@ -166,6 +323,37 @@ static void setup(void)
 	SAFE_TOUCH(FNAME_R, 0444, NULL);
 	SAFE_TOUCH(FNAME_W, 0222, NULL);
 	SAFE_TOUCH(FNAME_X, 0111, NULL);
+
+	SAFE_MKDIR(DNAME_R, 0444);
+	SAFE_MKDIR(DNAME_W, 0222);
+	SAFE_MKDIR(DNAME_X, 0111);
+	SAFE_MKDIR(DNAME_RW, 0666);
+	SAFE_MKDIR(DNAME_RX, 0555);
+	SAFE_MKDIR(DNAME_WX, 0333);
+
+	SAFE_TOUCH(DNAME_R"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_R"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_R"/"FNAME_X, 0111, NULL);
+
+	SAFE_TOUCH(DNAME_W"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_W"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_W"/"FNAME_X, 0111, NULL);
+
+	SAFE_TOUCH(DNAME_X"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_X"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_X"/"FNAME_X, 0111, NULL);
+
+	SAFE_TOUCH(DNAME_RW"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_RW"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_RW"/"FNAME_X, 0111, NULL);
+
+	SAFE_TOUCH(DNAME_RX"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_RX"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_RX"/"FNAME_X, 0111, NULL);
+
+	SAFE_TOUCH(DNAME_WX"/"FNAME_R, 0444, NULL);
+	SAFE_TOUCH(DNAME_WX"/"FNAME_W, 0222, NULL);
+	SAFE_TOUCH(DNAME_WX"/"FNAME_X, 0111, NULL);
 }
 
 static struct tst_test test = {
-- 
1.8.4.2



