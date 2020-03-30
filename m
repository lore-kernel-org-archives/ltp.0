From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:43:38 +0200
Subject: [LTP] [PATCH v2 5/5] Use SAFE_CMD()
In-Reply-To: <20200330124338.6764-1-pvorel@suse.cz>
References: <20200330124338.6764-1-pvorel@suse.cz>
Message-ID: <20200330124338.6764-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt                 |  4 ++--
 include/tst_safe_macros.h                       |  5 ++---
 testcases/kernel/syscalls/add_key/add_key05.c   | 14 ++++----------
 testcases/kernel/syscalls/quotactl/quotactl01.c | 11 ++---------
 testcases/kernel/syscalls/quotactl/quotactl06.c |  9 +--------
 5 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6f1eee490..75c2e517a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1283,8 +1283,8 @@ return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
 'stdout_path' and 'stderr_path' determine where to redirect the program
 stdout and stderr I/O streams.
 
-The 'SAFE_CMD()' macro can be used automatic handling non zero exits (exits
-with 'TBROK') or 'ENOENT' (exits with 'TCONF').
+The 'SAFE_CMD()' macro can be used automatic handling non-zero exits (exits
+with 'TBROK') and 'ENOENT' (exits with 'TCONF').
 
 .Example
 [source,c]
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 38eb67d1d..bcd4b9c9e 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -540,9 +540,8 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
 {
 	int rval;
 
-	switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path,
-				    TST_RUN_CMD_PASS_EXIT_VAL |
-				    TST_RUN_CMD_CHECK_CMD))) {
+	switch ((rval = tst_cmd(argv, stdout_path, stderr_path, TST_CMD_PASS_RETVAL
+							| TST_CMD_CHECK_CMD))) {
 	case 0:
 		break;
 	default:
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index aa2b9cb2f..f64c359bb 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -36,16 +36,10 @@ static void add_user(void)
 		return;
 
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
-	int rc;
-
-	switch ((rc = tst_cmd(cmd_useradd, NULL, NULL, TST_CMD_PASS_RETVAL))) {
-	case 0:
-		user_added = 1;
-		ltpuser = SAFE_GETPWNAM(username);
-		break;
-	default:
-		tst_brk(TBROK, "useradd failed (%d)", rc);
-	}
+
+	SAFE_CMD(cmd_useradd, NULL, NULL);
+	user_added = 1;
+	ltpuser = SAFE_GETPWNAM(username);
 	sprintf(fmt, "%5u: %%*5d %%*d/%%*d %%d/%%d %%d/%%d", ltpuser->pw_uid);
 }
 
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 6f0b60ffc..e1ec22529 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -162,15 +162,8 @@ static struct tcase {
 static void setup(void)
 {
 	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
-	int ret;
-
-	ret = tst_cmd(cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
-	switch (ret) {
-	case 0:
-		break;
-	default:
-		tst_brk(TBROK, "quotacheck exited with %i", ret);
-	}
+
+	SAFE_CMD(cmd, NULL, NULL);
 
 	test_id = geteuid();
 	if (access(USRPATH, F_OK) == -1)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 773114dfd..0a36c97a4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -146,16 +146,9 @@ static void verify_quotactl(unsigned int n)
 static void setup(void)
 {
 	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
-	int ret;
 	unsigned int i;
 
-	ret = tst_cmd(cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
-	switch (ret) {
-	case 0:
-		break;
-	default:
-		tst_brk(TBROK, "quotacheck exited with %i", ret);
-	}
+	SAFE_CMD(cmd, NULL, NULL);
 
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
-- 
2.26.0

