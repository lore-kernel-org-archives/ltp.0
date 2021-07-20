From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 20 Jul 2021 12:39:39 +0200
Subject: [LTP] [PATCH 1/3] Add skip_in_lockdown flag to struct tst_test
Message-ID: <20210720103941.9767-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the flag is set to 1, the LTP library will call tst_lockdown_enabled()
during initialization and exit with TCONF if kernel lockdown is detected.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_test.h | 1 +
 lib/tst_test.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 6ad355506..c7d77eb09 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -157,6 +157,7 @@ struct tst_test {
 	 * to the test function.
 	 */
 	int all_filesystems:1;
+	int skip_in_lockdown:1;
 
 	/*
 	 * The skip_filesystem is a NULL terminated list of filesystems the
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f4d9f8e3b..c7c77596c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -957,6 +957,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->min_kver)
 		check_kver();
 
+	if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skipping test");
+
 	if (tst_test->needs_cmds) {
 		const char *cmd;
 		char path[PATH_MAX];
-- 
2.32.0

