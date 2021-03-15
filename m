From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 15 Mar 2021 16:41:51 +0100
Subject: [LTP] [PATCH v2 1/3] syscalls/quotactl: Store addr string literals
 in buffer
Message-ID: <20210315154153.912-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The addr parameter of quotactl() is read-write so it's technically wrong
to pass string literals directly. Store them in a buffer and pass the buffer
instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 .../kernel/syscalls/quotactl/quotactl01.c     | 10 +++++---
 .../kernel/syscalls/quotactl/quotactl06.c     | 25 +++++++++++--------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 7b3649fa5..23233cf0d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -53,6 +53,8 @@
 
 static int32_t fmt_id = FMTID;
 static int test_id;
+static char usrpath[] = USRPATH;
+static char grppath[] = GRPPATH;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
@@ -79,7 +81,7 @@ static struct tcase {
 	char *des;
 	char *tname;
 } tcases[] = {
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH,
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath,
 	NULL, NULL, 0, "turn on quota for user",
 	"QCMD(Q_QUOTAON, USRQUOTA)"},
 
@@ -115,11 +117,11 @@ static struct tcase {
 	"get next disk quota limit for user",
 	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
 
-	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, USRPATH,
+	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, usrpath,
 	NULL, NULL, 0, "turn off quota for user",
 	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
 
-	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, GRPPATH,
+	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, grppath,
 	NULL, NULL, 0, "turn on quota for group",
 	"QCMD(Q_QUOTAON, GRPQUOTA)"},
 
@@ -154,7 +156,7 @@ static struct tcase {
 	"get next disk quota limit for group",
 	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
 
-	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, GRPPATH,
+	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, grppath,
 	NULL, NULL, 0, "turn off quota for group",
 	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 2818a4dc4..8621af05b 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -40,6 +40,9 @@
 #define TESTDIR1 MNTPOINT "/testdir1"
 #define TESTDIR2 MNTPOINT "/testdir2"
 
+static char usrpath[] = USRPATH;
+static char testdir1[] = TESTDIR1;
+static char testdir2[] = TESTDIR2;
 static int32_t fmt_id = FMTID;
 static int32_t fmt_invalid = 999;
 static int test_invalid;
@@ -76,17 +79,17 @@ static struct tcase {
 	int exp_err;
 	int on_flag;
 } tcases[] = {
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, TESTDIR1, EACCES, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, TESTDIR2, ENOENT, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH, EBUSY, 1},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir1, EACCES, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir2, ENOENT, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EBUSY, 1},
 	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1},
-	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, USRPATH, EINVAL, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH, ENOTBLK, 0},
+	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, usrpath, EINVAL, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, ENOTBLK, 0},
 	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, ESRCH, 0},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, USRPATH, ESRCH, 0},
-	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, USRPATH, ESRCH, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, usrpath, ESRCH, 0},
+	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, usrpath, ESRCH, 0},
 	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1},
-	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH, EPERM, 0},
+	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EPERM, 0},
 };
 
 static void verify_quotactl(unsigned int n)
@@ -101,7 +104,8 @@ static void verify_quotactl(unsigned int n)
 	}
 
 	if (tc->on_flag) {
-		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev, FMTID, USRPATH));
+		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
+			FMTID, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAON returned %ld", TST_RET);
@@ -130,7 +134,8 @@ static void verify_quotactl(unsigned int n)
 	}
 
 	if (quota_on) {
-		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev, FMTID, USRPATH));
+		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
+			FMTID, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
-- 
2.30.1

