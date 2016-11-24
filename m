From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Nov 2016 15:53:59 +0100
Subject: [LTP] [PATCH v3 1/1] syscalls/mq_notify01: prevent deadlock,
 cleanup
In-Reply-To: <20161124113205.26581-1-pvorel@suse.cz>
References: <20161124113205.26581-1-pvorel@suse.cz>
Message-ID: <20161124145358.GE14986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few minor changes, thanks.

Commented diff follows:

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index a0aee1b..68fabff 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -16,15 +16,10 @@
  * the GNU General Public License for more details.
  */
 #define _XOPEN_SOURCE 600
-#include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/uio.h>
-#include <getopt.h>
-#include <libgen.h>
 #include <limits.h>
 #include <errno.h>
-#include <stdio.h>
 #include <unistd.h>
 #include <string.h>
 #include <mqueue.h>
@@ -32,7 +27,6 @@
 #include <stdlib.h>
 #include <fcntl.h>
 
-#include "linux_syscall_numbers.h"
 #include "tst_test.h"
 
  *** Remove a few more useless includes
 
 #define MAX_MSGSIZE     8192
@@ -111,6 +105,7 @@ static struct test_case tcase[] = {
 static void setup(void)
 {
 	int i;
+
 	for (i = 0; i < MSG_SIZE; i++)
 		smsg[i] = i;
 }
@@ -160,16 +155,16 @@ static void do_test(unsigned int i)
 		fd = INT_MAX - 1;
 		break;
 	case FD_FILE:
-		TEST(fd = open("/", O_RDONLY));
-		if (TEST_RETURN < 0) {
-			tst_res(TFAIL, "can't open \"/\".");
+		fd = open("/", O_RDONLY);
+		if (fd < 0) {
+			tst_res(TBROK | TERRNO, "can't open \"/\".");
 			goto CLEANUP;
 		}
 		break;
 	default:
-		TEST(fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL));
-		if (TEST_RETURN < 0) {
-			tst_res(TFAIL | TTERRNO, "mq_open failed");
+		fd = mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+		if (fd < 0) {
+			tst_res(TBROK | TERRNO, "mq_open failed");
 			goto CLEANUP;
 		}
 	}
@@ -185,7 +180,7 @@ static void do_test(unsigned int i)
 		memset(&sigact, 0, sizeof(sigact));
 		sigact.sa_sigaction = sigfunc;
 		sigact.sa_flags = SA_SIGINFO;
-		TEST(rc = sigaction(SIGUSR1, &sigact, NULL));
+		rc = sigaction(SIGUSR1, &sigact, NULL);
 		break;
 	case SIGEV_THREAD:
 		notified = cmp_ok = 0;
@@ -196,9 +191,9 @@ static void do_test(unsigned int i)
 	}
 
 	if (tc->ttype == ALREADY_REGISTERED) {
-		TEST(rc = mq_notify(fd, &ev));
-		if (TEST_RETURN < 0) {
-			tst_res(TFAIL | TTERRNO, "mq_notify failed");
+		rc = mq_notify(fd, &ev);
+		if (rc < 0) {
+			tst_res(TBROK | TERRNO, "mq_notify failed");
 			goto CLEANUP;
 		}
 	}

 *** Got rid of a few more useless TEST() uses

@@ -216,23 +211,26 @@ static void do_test(unsigned int i)
 			usleep(10000);
 
 		if (str_debug && tc->notify == SIGEV_SIGNAL) {
-			tst_res(TINFO, "si_code  E:%d,\tR:%d", info.si_code, SI_MESGQ);
-			tst_res(TINFO, "si_signo E:%d,\tR:%d", info.si_signo, SIGUSR1);
+			tst_res(TINFO, "si_code  E:%d,\tR:%d",
+				info.si_code, SI_MESGQ);
+			tst_res(TINFO, "si_signo E:%d,\tR:%d",
+				info.si_signo, SIGUSR1);
 			tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
-					info.si_value.sival_int, USER_DATA);
-			tst_res(TINFO, "si_pid   E:%d,\tR:%d", info.si_pid, getpid());
-			tst_res(TINFO, "si_uid   E:%d,\tR:%d", info.si_uid, getuid());
+				info.si_value.sival_int, USER_DATA);
+			tst_res(TINFO, "si_pid   E:%d,\tR:%d",
+				info.si_pid, getpid());
+			tst_res(TINFO, "si_uid   E:%d,\tR:%d",
+				info.si_uid, getuid());
 		}
 	}
 
-	/* result check */
 	if ((TEST_RETURN != 0 && TEST_ERRNO != tc->err) || !cmp_ok) {
-		tst_res(TFAIL, "%s r/w check returned: %ld, expected: %d,"
-			" returned errno: %s (%d), expected errno: %s (%d)",
-			tc->desc, TEST_RETURN, tc->ret, tst_strerrno(TEST_ERRNO),
-			TEST_ERRNO, tst_strerrno(tc->err), tc->err);
+		tst_res(TFAIL | TTERRNO, "%s r/w check returned: %ld, "
+			"expected: %d, expected errno: %s (%d)", tc->desc,
+			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
 	} else {
-		tst_res(TPASS, "%s returned: %ld", tc->desc, TEST_RETURN);
+		tst_res(TPASS | TTERRNO, "%s returned: %ld",
+			tc->desc, TEST_RETURN);
 	}
 
 CLEANUP:

 *** Fixed a few over 80 chars lines and made use of TTERRNO flag
     instead of printing TEST_ERRNO via %d

-- 
Cyril Hrubis
chrubis@suse.cz
