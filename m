From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Mar 2016 12:25:55 +0800
Subject: [LTP] [PATCH V2 1/3] mm/ksm: taking use of SAFE_FILE_ macro for
	ksm05.c
Message-ID: <1458707157-31233-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm05.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index abf888e..2baca3b 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -75,7 +75,6 @@ int TST_TOTAL = 1;
 static int ksm_run_orig;
 
 static void sighandler(int sig);
-static void write_ksm_run(int val);
 
 int main(int argc, char *argv[])
 {
@@ -123,25 +122,8 @@ static void sighandler(int sig)
 	_exit((sig == SIGSEGV) ? 0 : sig);
 }
 
-static void write_ksm_run(int val)
-{
-	int fd;
-	char buf[BUFSIZ];
-
-	sprintf(buf, "%d", val);
-	fd = open(PATH_KSM "run", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
-	if (write(fd, buf, 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write");
-	close(fd);
-}
-
 void setup(void)
 {
-	int fd;
-	char buf[BUFSIZ];
-
 	tst_require_root();
 
 	if (tst_kvercmp(2, 6, 32) < 0)
@@ -155,24 +137,16 @@ void setup(void)
 	TEST_PAUSE;
 
 	/* save original /sys/kernel/mm/ksm/run value */
-	fd = open(PATH_KSM "run", O_RDONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
-	if (read(fd, buf, 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "read");
-	close(fd);
-	ksm_run_orig = atoi(buf);
+	SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &ksm_run_orig);
 
 	/* echo 1 > /sys/kernel/mm/ksm/run */
-	if (ksm_run_orig != 1)
-		write_ksm_run(1);
+	SAFE_FILE_PRINTF(NULL, PATH_KSM "run", "1");
 }
 
 void cleanup(void)
 {
 	/* restore /sys/kernel/mm/ksm/run value */
-	if (ksm_run_orig != 1)
-		write_ksm_run(ksm_run_orig);
+	FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
 }
 #else
 int main(void)
-- 
1.8.3.1

