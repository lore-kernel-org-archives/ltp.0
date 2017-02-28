From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:40 +0100
Subject: [LTP] [COMMITTED] [PATCH 18/23] syscalls/ptrace04,
	ptrace05: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-18-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Move tst_parse_opts() before tst_brkm() in ptrace04

* Get rid of hacked up option parsion in ptrace05

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ptrace/ptrace04.c |  4 ++--
 testcases/kernel/syscalls/ptrace/ptrace05.c | 27 +--------------------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace04.c b/testcases/kernel/syscalls/ptrace/ptrace04.c
index b2707c0..af35fb3 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace04.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace04.c
@@ -99,11 +99,11 @@ void compare_registers(unsigned char poison)
 
 int main(int argc, char *argv[])
 {
+	tst_parse_opts(argc, argv, NULL, NULL);
+
 	if (ARRAY_SIZE(regs) == 0)
 		tst_brkm(TCONF, NULL, "test not supported for your arch (yet)");
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
 	make_a_baby(argc, argv);
 
 	/* first compare register states when execl() syscall starts */
diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index f81d3d3..22261f3 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -60,32 +60,7 @@ int main(int argc, char **argv)
 
 	pid_t child;
 
-	/* Parse the CLI args appropriately. */
-	switch (argc) {
-	case 3:
-		end_signum = (int)strtol((const char *)*(argv + 2), NULL, 10);
-		/* Parse the signal value. */
-		if (end_signum == 0 && errno != 0) {
-			tst_brkm(TBROK, NULL,
-				 "argument (%s) isn't a valid number.\n",
-				 *(argv + 2));
-		}
-		/* FALLTHROUGH */
-	case 2:
-		start_signum = (int)strtol((const char *)*(argv + 1), NULL, 10);
-		/* Parse the signal value. */
-		if (end_signum == 0 && errno != 0) {
-			tst_brkm(TBROK, NULL,
-				 "argument (%s) isn't a valid number.\n",
-				 *(argv + 1));
-		}
-		break;
-	case 1:
-		/* Do nothing. */
-		break;
-	default:
-		return usage(basename(*argv));
-	}
+	tst_parse_opts(argc, argv, NULL, NULL);
 
 	if (start_signum == -1) {
 		start_signum = 0;
-- 
2.10.2

