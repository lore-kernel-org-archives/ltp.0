From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 20 Aug 2018 08:42:55 +0200
Subject: [LTP] [PATCH 3/5] Convert fcntl33 to newlib
In-Reply-To: <20180820064257.17974-1-rpalethorpe@suse.com>
References: <20180820064257.17974-1-rpalethorpe@suse.com>
Message-ID: <20180820064257.17974-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add extra checks that fcntl does not return success after trying to
downgrade a lease on a file where it can only be removed and that it can
downgrade a lease on a file opened as read only.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/fcntl/fcntl33.c | 168 +++++++++-------------
 1 file changed, 71 insertions(+), 97 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 13616c65f..1dfc8ec7f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -28,8 +28,9 @@
 
 #include <errno.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_macros.h"
 
 /*
  * MIN_TIME_LIMIT is defined to 5 senconds as a minimal acceptable
@@ -50,10 +51,8 @@
 #define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
 #define PATH_LS_BRK_T	"/proc/sys/fs/lease-break-time"
 
-static void setup(void);
-static void do_test(int);
-static int do_child(int);
-static void cleanup(void);
+static void do_test(unsigned int);
+static void do_child(unsigned int);
 
 static int fd;
 static int ls_brk_t;
@@ -84,113 +83,86 @@ static struct test_case_t {
 		"truncate() conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
 };
 
-char *TCID = "fcntl33";
-int TST_TOTAL = ARRAY_SIZE(test_cases);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int tc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (tc = 0; tc < TST_TOTAL; tc++)
-			do_test(tc);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
 	tst_timer_check(CLOCK_MONOTONIC);
 
 	/* Backup and set the lease-break-time. */
-	SAFE_FILE_SCANF(NULL, PATH_LS_BRK_T, "%d", &ls_brk_t);
-	SAFE_FILE_PRINTF(NULL, PATH_LS_BRK_T, "%d", 45);
+	SAFE_FILE_SCANF(PATH_LS_BRK_T, "%d", &ls_brk_t);
+	SAFE_FILE_PRINTF(PATH_LS_BRK_T, "%d", 45);
 
-	tst_tmpdir();
-
-	switch ((type = tst_fs_type(cleanup, "."))) {
+	switch ((type = tst_fs_type("."))) {
 	case TST_NFS_MAGIC:
 	case TST_RAMFS_MAGIC:
 	case TST_TMPFS_MAGIC:
-		tst_brkm(TCONF, cleanup,
-			 "Cannot do fcntl(F_SETLEASE, F_WRLCK) "
-			 "on %s filesystem",
-			 tst_fs_type_name(type));
+		tst_brk(TCONF,
+			"Cannot do fcntl(F_SETLEASE, F_WRLCK) on %s filesystem",
+			tst_fs_type_name(type));
 	default:
 		break;
 	}
 
-	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
+	SAFE_TOUCH("file", FILE_MODE, NULL);
 
 	sigemptyset(&newset);
 	sigaddset(&newset, SIGIO);
 
 	if (sigprocmask(SIG_SETMASK, &newset, &oldset) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "sigprocmask() failed");
-
-	TEST_PAUSE;
+		tst_brk(TBROK | TERRNO, "sigprocmask() failed");
 }
 
-static void do_test(int i)
+static void do_test(unsigned int i)
 {
-	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
-
-	pid_t cpid = tst_fork();
-
-	if (cpid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+	pid_t cpid;
 
+	cpid = SAFE_FORK();
 	if (cpid == 0) {
-		SAFE_CLOSE(NULL, fd);
 		do_child(i);
+		return;
 	}
 
+	fd = SAFE_OPEN("file", O_RDONLY);
+
 	TEST(fcntl(fd, F_SETLEASE, test_cases[i].lease_type));
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "fcntl() failed to set lease");
-		SAFE_WAITPID(cleanup, cpid, NULL, 0);
-		SAFE_CLOSE(cleanup, fd);
-		fd = 0;
-		return;
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fcntl() failed to set lease");
+		goto exit;
 	}
 
 	/* Wait for SIGIO caused by lease breaker. */
 	TEST(sigtimedwait(&newset, NULL, &timeout));
-	if (TEST_RETURN == -1) {
-		if (TEST_ERRNO == EAGAIN) {
-			tst_resm(TFAIL | TTERRNO, "failed to receive SIGIO "
-				 "within %lis", timeout.tv_sec);
-			SAFE_WAITPID(cleanup, cpid, NULL, 0);
-			SAFE_CLOSE(cleanup, fd);
-			fd = 0;
-			return;
+	if (TST_RET == -1) {
+		if (TST_ERR == EAGAIN) {
+			tst_res(TFAIL | TTERRNO,
+				"failed to receive SIGIO within %lis",
+				timeout.tv_sec);
+			goto exit;
 		}
-		tst_brkm(TBROK | TTERRNO, cleanup, "sigtimedwait() failed");
+		tst_brk(TBROK | TTERRNO, "sigtimedwait() failed");
 	}
 
 	/* Try to downgrade or remove the lease. */
 	switch (test_cases[i].lease_type) {
 	case F_WRLCK:
 		TEST(fcntl(fd, F_SETLEASE, F_RDLCK));
-		if (TEST_RETURN == 0)
-			break;
+		if (TST_RET == 0) {
+			if (test_cases[i].op_type == OP_OPEN_RDONLY)
+				break;
+
+			tst_res(TFAIL,
+				"fcntl() downgraded lease when not read-only");
+		}
+
+		if (test_cases[i].op_type == OP_OPEN_RDONLY) {
+			tst_res(TFAIL | TTERRNO,
+				"fcntl() failed to downgrade lease");
+		}
+
+		LTP_ATTRIBUTE_FALLTHROUGH;
 	case F_RDLCK:
 		TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
+		if (TST_RET == -1) {
+			tst_res(TFAIL | TTERRNO,
 				 "fcntl() failed to remove the lease");
 		}
 		break;
@@ -198,35 +170,31 @@ static void do_test(int i)
 		break;
 	}
 
-	tst_record_childstatus(cleanup, cpid);
-
-	SAFE_CLOSE(cleanup, fd);
-	fd = 0;
+exit:
+	tst_reap_children();
+	SAFE_CLOSE(fd);
 }
 
-static int do_child(int i)
+static void do_child(unsigned int i)
 {
 	long long elapsed_ms;
 
-	if (tst_process_state_wait2(getppid(), 'S') != 0) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "failed to wait for parent process's state");
-	}
+	TST_PROCESS_STATE_WAIT(getppid(), 'S');
 
 	tst_timer_start(CLOCK_MONOTONIC);
 
 	switch (test_cases[i].op_type) {
 	case OP_OPEN_RDONLY:
-		SAFE_OPEN(NULL, "file", O_RDONLY);
+		SAFE_OPEN("file", O_RDONLY);
 		break;
 	case OP_OPEN_WRONLY:
-		SAFE_OPEN(NULL, "file", O_WRONLY);
+		SAFE_OPEN("file", O_WRONLY);
 		break;
 	case OP_OPEN_RDWR:
-		SAFE_OPEN(NULL, "file", O_RDWR);
+		SAFE_OPEN("file", O_RDWR);
 		break;
 	case OP_TRUNCATE:
-		SAFE_TRUNCATE(NULL, "file", 0);
+		SAFE_TRUNCATE("file", 0);
 		break;
 	default:
 		break;
@@ -237,27 +205,33 @@ static int do_child(int i)
 	elapsed_ms = tst_timer_elapsed_ms();
 
 	if (elapsed_ms < MIN_TIME_LIMIT * 1000) {
-		tst_resm(TPASS, "%s, unblocked within %ds",
+		tst_res(TPASS, "%s, unblocked within %ds",
 			 test_cases[i].desc, MIN_TIME_LIMIT);
 	} else {
-		tst_resm(TFAIL, "%s, blocked too long %llims, "
-			 "expected within %ds",
-			 test_cases[i].desc, elapsed_ms, MIN_TIME_LIMIT);
+		tst_res(TFAIL,
+			"%s, blocked too long %llims, expected within %ds",
+			test_cases[i].desc, elapsed_ms, MIN_TIME_LIMIT);
 	}
-
-	tst_exit();
 }
 
 static void cleanup(void)
 {
 	if (sigprocmask(SIG_SETMASK, &oldset, NULL) < 0)
-		tst_resm(TWARN | TERRNO, "sigprocmask restore oldset failed");
+		tst_res(TWARN | TERRNO, "sigprocmask restore oldset failed");
 
-	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "failed to close file");
-
-	tst_rmdir();
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 
 	/* Restore the lease-break-time. */
 	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.setup = setup,
+	.test = do_test,
+	.cleanup = cleanup
+};
-- 
2.18.0

