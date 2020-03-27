From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:24 +0100
Subject: [LTP] [PATCH 6/6] Use SAFE_RUN_CMD()
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <20200327213924.18816-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Renamed: s/SAFE_RUNCMD()/SAFE_RUN_CMD()/

 testcases/kernel/syscalls/add_key/add_key05.c   | 15 ++++-----------
 testcases/kernel/syscalls/quotactl/quotactl01.c | 11 ++---------
 testcases/kernel/syscalls/quotactl/quotactl06.c |  9 +--------
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 3da3be9ee..fd0fb0a50 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -36,17 +36,10 @@ static void add_user(void)
 		return;
 
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
-	int rc;
-
-	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL,
-				  TST_RUN_CMD_PASS_EXIT_VAL))) {
-	case 0:
-		user_added = 1;
-		ltpuser = SAFE_GETPWNAM(username);
-		break;
-	default:
-		tst_brk(TBROK, "useradd failed (%d)", rc);
-	}
+
+	SAFE_RUN_CMD(cmd_useradd, NULL, NULL);
+	user_added = 1;
+	ltpuser = SAFE_GETPWNAM(username);
 	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
 }
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index e4c2a8939..a40852f34 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -162,15 +162,8 @@ static struct tcase {
 static void setup(void)
 {
 	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
-	int ret;
-
-	ret = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
-	switch (ret) {
-	case 0:
-		break;
-	default:
-		tst_brk(TBROK, "quotacheck exited with %i", ret);
-	}
+
+	SAFE_RUN_CMD(cmd, NULL, NULL);
 
 	test_id = geteuid();
 	if (access(USRPATH, F_OK) == -1)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 5d70f340f..e990d6976 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -146,16 +146,9 @@ static void verify_quotactl(unsigned int n)
 static void setup(void)
 {
 	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
-	int ret;
 	unsigned int i;
 
-	ret = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
-	switch (ret) {
-	case 0:
-		break;
-	default:
-		tst_brk(TBROK, "quotacheck exited with %i", ret);
-	}
+	SAFE_RUN_CMD(cmd, NULL, NULL);
 
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
-- 
2.25.1

