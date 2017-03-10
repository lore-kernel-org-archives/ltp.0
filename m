From: the_hoang0709@yahoo.com <the_hoang0709@yahoo.com>
Date: Fri, 10 Mar 2017 07:54:44 +0700
Subject: [LTP]  [PATCH] prot_hsymlinks: Fix failure on read-only machine
Message-ID: <1489107284-4313-1-git-send-email-the_hoang0709@yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hoang Nguyen <the_hoang0709@yahoo.com>

Return 32 if /etc/passwd is read-only.
Also move tst_tmpdir before useradd in setup, to avoid "TESTDIR was
NULL" in tst_rmdir in cleanup.

Fixes #88

Signed-off-by: Hoang Nguyen <the_hoang0709@yahoo.com>
---
 testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index b23064a..31ddefa 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -206,6 +206,8 @@ static void setup(int argc, char *argv[])
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
+	tst_tmpdir();
+
 	test_user_cmd("useradd");
 	/*
 	 * enable hardlinks and symlinks restrictions,
@@ -220,8 +222,6 @@ static void setup(int argc, char *argv[])
 		disable_protected_slinks = 1;
 	}
 
-	tst_tmpdir();
-
 	init_base_dirs();
 
 	init_files_dirs();
@@ -273,7 +273,8 @@ static void cleanup(void)
 	if (skip_cleanup)
 		return;
 
-	test_user_cmd("userdel -r");
+	if (!eaccess("/etc/passwd", W_OK))
+		test_user_cmd("userdel -r");
 
 	if (disable_protected_hlinks) {
 		tst_resm(TINFO, "Disable protected hardlinks mode back");
@@ -316,8 +317,13 @@ static void test_user_cmd(const char *user_cmd)
 	char cmd[MAX_CMD_LEN];
 	snprintf(cmd, MAX_CMD_LEN, "%s %s", user_cmd, users[TEST_USER].name);
 	if (system(cmd) != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to run cmd: %s %s",
+		if (eaccess("/etc/passwd", W_OK)) {
+			tst_brkm(TCONF, cleanup,
+			"/etc/passwd is not accessible");
+		} else {
+			tst_brkm(TBROK, cleanup, "Failed to run cmd: %s %s",
 			user_cmd, users[TEST_USER].name);
+		}
 	}
 }
 
-- 
2.7.4

