From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 9 Jun 2021 17:49:23 +0800
Subject: [LTP] [PATCH 1/2] syscalls/chown: format output and add testcases
 for chown05
In-Reply-To: <20210609094924.145262-1-xieziyao@huawei.com>
References: <20210609094924.145262-1-xieziyao@huawei.com>
Message-ID: <20210609094924.145262-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Print values not variable names in TST_EXP_PASS().
2. Add testcases that -1 does not change the value after the chown
call.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/chown/chown05.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown05.c b/testcases/kernel/syscalls/chown/chown05.c
index ebb9e9b7c..44abdc750 100644
--- a/testcases/kernel/syscalls/chown/chown05.c
+++ b/testcases/kernel/syscalls/chown/chown05.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * 07/2001 Ported by Wayne Boyer
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

 /*\
@@ -20,24 +21,31 @@
 #define TESTFILE "testfile"

 struct test_case_t {
+	char *desc;
 	uid_t uid;
 	gid_t gid;
 } tc[] = {
-	{700, 701},
-	{702, 701},
-	{702, 703},
-	{704, 705}
+	{"change owner/group ids", 700, 701},
+	{"change owner id only", 702, -1},
+	{"change owner id only", 703, 701},
+	{"change group id only", -1, 704},
+	{"change group id only", 703, 705},
+	{"no change", -1, -1}
 };

 static void run(unsigned int i)
 {
 	struct stat stat_buf;
-	TST_EXP_PASS(CHOWN(TESTFILE, tc[i].uid, tc[i].gid));
+	uid_t expect_uid = tc[i].uid == (uid_t)-1 ? tc[i - 1].uid : tc[i].uid;
+	gid_t expect_gid = tc[i].gid == (uid_t)-1 ? tc[i - 1].gid : tc[i].gid;
+
+	TST_EXP_PASS(CHOWN(TESTFILE, tc[i].uid, tc[i].gid), "chown(%s, %d, %d), %s",
+		     TESTFILE, tc[i].uid, tc[i].gid, tc[i].desc);

 	SAFE_STAT(TESTFILE, &stat_buf);
-	if (stat_buf.st_uid != tc[i].uid || stat_buf.st_gid != tc[i].gid) {
+	if (stat_buf.st_uid != expect_uid || stat_buf.st_gid != expect_gid) {
 		tst_res(TFAIL, "%s: incorrect ownership set, expected %d %d",
-			TESTFILE, tc[i].uid, tc[i].gid);
+			TESTFILE, expect_uid, expect_gid);
 	}
 }

--
2.17.1

