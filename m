From: Christian Amann <camann@suse.com>
Date: Fri,  7 Jun 2019 16:16:22 +0200
Subject: [LTP] [PATCH v1] syscalls/acct02: Fix wrongfully failing sometimes
Message-ID: <20190607141622.20316-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some systems the process calling acct() has to end before
process accounting is started. This caused the original test
to fail on those systems.

This fix forks a child process to call acct() in order to
activate process accounting before running the test program.

Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 8a99bb94d..b609eec2b 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -108,13 +108,24 @@ static int verify_acct_v3(struct acct_v3 *acc)
 
 static void run(void)
 {
-	int read_bytes, ret, entry_count;
+	int read_bytes, ret, entry_count, pid;
 
 	fd = SAFE_OPEN(OUTPUT_FILE, O_RDWR | O_CREAT, 0644);
 
-	TEST(acct(OUTPUT_FILE));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "Could not set acct output file");
+	/* On some systems the process calling acct has to end
+	 * before it takes effect
+	 */
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		TEST(acct(OUTPUT_FILE));
+		if (TST_RET == -1) {
+			tst_brk(TBROK | TTERRNO,
+				"Could not set acct output file");
+		}
+		return;
+	}
+	tst_reap_children();
 
 	start_time = time(NULL);
 	run_command();
@@ -180,4 +191,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
+	.forks_child = 1,
 };
-- 
2.16.4

