From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 19 Aug 2020 13:04:06 +0200
Subject: [LTP] [PATCH] Taint check: Use TFAIL instead of TBROK in
 fork_testrun()
Message-ID: <20200819110406.25099-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/test-writing-guidelines.txt | 6 +++---
 lib/tst_test.c                  | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index b2265a778..252e91ffc 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1567,9 +1567,9 @@ the test.
 
 LTP library will then automatically check kernel taint at the end of testing.
 If '.all_filesystems' is set in struct tst_test, taint check will be performed
-after each file system and testing may be aborted early by 'TBROK'. You can
-optionally also call 'tst_taint_check()' during 'run()', which returns 0 or
-the tainted flags set in '/proc/sys/kernel/tainted' as specified earlier.
+after each file system and taint will abort testing early with 'TFAIL'. You
+can optionally also call 'tst_taint_check()' during 'run()', which returns 0
+or the tainted flags set in '/proc/sys/kernel/tainted' as specified earlier.
 
 Depending on your kernel version, not all tainted-flags will be supported.
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3a37f61ca..28f8843cf 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1282,8 +1282,10 @@ static int fork_testrun(void)
 	alarm(0);
 	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
-	if (tst_test->taint_check && tst_taint_check())
-		tst_brk(TBROK, "Kernel is now tainted.");
+	if (tst_test->taint_check && tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is now tainted.");
+		return TFAIL;
+	}
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
 		return WEXITSTATUS(status);
-- 
2.28.0

