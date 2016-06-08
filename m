From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  8 Jun 2016 17:03:58 +0200
Subject: [LTP] [PATCH 1/2] lib/tst_test.c: propagate TBROK retcode in
	library process
Message-ID: <fa495176ab2cdec819046bb813af0066435ca88c.1465398038.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <chrubis@suse.cz>

Previous patch caused, that 0 would be returned as ret code
if library process hit a TBROK. It also missed that there are
other places where library can exit by calling exit().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index f7485bd33082..6e6d41738ebb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,7 +64,7 @@ char *const tst_ipc_envp[] = {ipc_path, NULL};
 
 static char shm_path[1024];
 
-static void do_exit(void) __attribute__ ((noreturn));
+static void do_exit(int ret) __attribute__ ((noreturn));
 
 static void setup_ipc(void)
 {
@@ -237,7 +237,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 		do_test_cleanup();
 
 	if (getpid() == lib_pid)
-		do_exit();
+		do_exit(TTYPE_RESULT(ttype));
 
 	exit(TTYPE_RESULT(ttype));
 }
@@ -443,10 +443,8 @@ static void parse_opts(int argc, char *argv[])
 }
 
 
-static void do_exit(void)
+static void do_exit(int ret)
 {
-	int ret = 0;
-
 	printf("\nSummary:\n");
 	printf("passed   %d\n", results->passed);
 	printf("failed   %d\n", results->failed);
@@ -719,7 +717,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	do_cleanup();
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
-		exit(WEXITSTATUS(status));
+		do_exit(WEXITSTATUS(status));
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "
@@ -730,5 +728,5 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	if (WIFSIGNALED(status))
 		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
 
-	do_exit();
+	do_exit(0);
 }
-- 
1.8.3.1

