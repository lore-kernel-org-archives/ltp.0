From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  9 Jun 2017 21:12:51 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/mq_notify: Cleanup + use mq.h header
In-Reply-To: <20170609191252.9870-1-pvorel@suse.cz>
References: <20170609191252.9870-1-pvorel@suse.cz>
Message-ID: <20170609191252.9870-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mq_notify/Makefile      |   1 +
 testcases/kernel/syscalls/mq_notify/mq_notify01.c | 222 ++++++++++------------
 2 files changed, 98 insertions(+), 125 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/Makefile b/testcases/kernel/syscalls/mq_notify/Makefile
index 2e1628e9f..1b4a564e0 100644
--- a/testcases/kernel/syscalls/mq_notify/Makefile
+++ b/testcases/kernel/syscalls/mq_notify/Makefile
@@ -21,6 +21,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 2406dee85..9eaa736de 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -1,115 +1,95 @@
 /*
- * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
- *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
- *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
- *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- * Copyright (c) 2016 Linux Test Project
+ * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * Authors:
+ * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
-#define _XOPEN_SOURCE 600
-#include <sys/types.h>
-#include <sys/stat.h>
+
 #include <limits.h>
 #include <errno.h>
-#include <unistd.h>
-#include <string.h>
-#include <mqueue.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <fcntl.h>
 
+#include "mq.h"
 #include "tst_test.h"
 #include "tst_safe_posix_ipc.h"
 
-#define MAX_MSGSIZE     8192
-#define MSG_SIZE	16
 #define USER_DATA       0x12345678
-#define QUEUE_NAME	"/test_mqueue"
 
+int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 static char *str_debug;
-static char smsg[MAX_MSGSIZE];
 
 static volatile sig_atomic_t notified, cmp_ok;
 static siginfo_t info;
 
-enum test_type {
-	NORMAL,
-	FD_NONE,
-	FD_NOT_EXIST,
-	FD_FILE,
-	ALREADY_REGISTERED,
-};
-
 struct test_case {
+	int *fd;
+	int already_registered;
 	int notify;
-	int ttype;
-	const char *desc;
 	int ret;
 	int err;
 };
 
-#define TYPE_NAME(x) .ttype = x, .desc = #x
 static struct test_case tcase[] = {
 	{
-		TYPE_NAME(NORMAL),
+		.fd = &fd,
 		.notify = SIGEV_NONE,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(NORMAL),
+		.fd = &fd,
 		.notify = SIGEV_SIGNAL,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(NORMAL),
+		.fd = &fd,
 		.notify = SIGEV_THREAD,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(FD_NONE),
+		.fd = &fd_invalid,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(FD_NOT_EXIST),
+		.fd = &fd_maxint,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(FD_FILE),
+		.fd = &fd_root,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(ALREADY_REGISTERED),
+		.fd = &fd,
 		.notify = SIGEV_NONE,
+		.already_registered = 1,
 		.ret = -1,
 		.err = EBUSY,
 	},
 };
 
-static void setup(void)
-{
-	int i;
-
-	for (i = 0; i < MSG_SIZE; i++)
-		smsg[i] = i;
-}
 static void sigfunc(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *si,
 	void *data LTP_ATTRIBUTE_UNUSED)
 {
@@ -131,42 +111,12 @@ static void tfunc(union sigval sv)
 
 static void do_test(unsigned int i)
 {
-	int rc, fd = -1;
-	struct sigevent ev;
 	struct sigaction sigact;
-	struct timespec abs_timeout;
 	struct test_case *tc = &tcase[i];
-
-	notified = cmp_ok = 1;
-
-	/* Don't timeout. */
-	abs_timeout.tv_sec = 0;
-	abs_timeout.tv_nsec = 0;
-
-	/*
-	 * When test ended with SIGTERM etc, mq descriptor is left remains.
-	 * So we delete it first.
-	 */
-	mq_unlink(QUEUE_NAME);
-
-	switch (tc->ttype) {
-	case FD_NONE:
-		break;
-	case FD_NOT_EXIST:
-		fd = INT_MAX - 1;
-		break;
-	case FD_FILE:
-		fd = open("/", O_RDONLY);
-		if (fd < 0) {
-			tst_res(TBROK | TERRNO, "can't open \"/\".");
-			goto CLEANUP;
-		}
-		break;
-	default:
-		fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
-	}
+	struct sigevent ev;
 
 	ev.sigev_notify = tc->notify;
+	notified = cmp_ok = 1;
 
 	switch (tc->notify) {
 	case SIGEV_SIGNAL:
@@ -177,7 +127,10 @@ static void do_test(unsigned int i)
 		memset(&sigact, 0, sizeof(sigact));
 		sigact.sa_sigaction = sigfunc;
 		sigact.sa_flags = SA_SIGINFO;
-		rc = sigaction(SIGUSR1, &sigact, NULL);
+		if (sigaction(SIGUSR1, &sigact, NULL) == -1) {
+			tst_res(TFAIL | TTERRNO, "sigaction failed");
+			return;
+		}
 		break;
 	case SIGEV_THREAD:
 		notified = cmp_ok = 0;
@@ -187,54 +140,72 @@ static void do_test(unsigned int i)
 		break;
 	}
 
-	if (tc->ttype == ALREADY_REGISTERED) {
-		rc = mq_notify(fd, &ev);
-		if (rc < 0) {
-			tst_res(TBROK | TERRNO, "mq_notify failed");
-			goto CLEANUP;
-		}
+	if (tc->already_registered && mq_notify(*tc->fd, &ev) == -1) {
+		tst_res(TFAIL | TERRNO, "mq_notify(%d, %p) failed", fd, &ev);
+		return;
 	}
 
-	/* test */
-	TEST(mq_notify(fd, &ev));
-	if (TEST_RETURN >= 0) {
-		rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout);
-		if (rc < 0) {
-			tst_res(TFAIL | TTERRNO, "mq_timedsend failed");
-			goto CLEANUP;
-		}
+	TEST(mq_notify(*tc->fd, &ev));
 
-		while (!notified)
-			usleep(10000);
-
-		if (str_debug && tc->notify == SIGEV_SIGNAL) {
-			tst_res(TINFO, "si_code  E:%d,\tR:%d",
-				info.si_code, SI_MESGQ);
-			tst_res(TINFO, "si_signo E:%d,\tR:%d",
-				info.si_signo, SIGUSR1);
-			tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
-				info.si_value.sival_int, USER_DATA);
-			tst_res(TINFO, "si_pid   E:%d,\tR:%d",
-				info.si_pid, getpid());
-			tst_res(TINFO, "si_uid   E:%d,\tR:%d",
-				info.si_uid, getuid());
-		}
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO)
+			tst_res(TFAIL | TTERRNO,
+				"mq_notify failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		else
+			tst_res(TPASS | TTERRNO, "mq_notify failed expectedly");
+
+		/* unregister notification */
+		if (*tc->fd == fd)
+			mq_notify(*tc->fd, NULL);
+
+		return;
+	}
+
+	TEST(mq_timedsend(*tc->fd, smsg, MSG_LENGTH, 0,
+		&((struct timespec){0})));
+
+	if (*tc->fd == fd)
+		cleanup_queue(fd);
+
+	if (TEST_RETURN < 0) {
+		tst_res(TFAIL | TTERRNO, "mq_timedsend failed");
+		return;
+	}
+
+	while (!notified)
+		usleep(10000);
+
+	if (str_debug && tc->notify == SIGEV_SIGNAL) {
+		tst_res(TINFO, "si_code  E:%d,\tR:%d",
+			info.si_code, SI_MESGQ);
+		tst_res(TINFO, "si_signo E:%d,\tR:%d",
+			info.si_signo, SIGUSR1);
+		tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
+			info.si_value.sival_int, USER_DATA);
+		tst_res(TINFO, "si_pid   E:%d,\tR:%d",
+			info.si_pid, getpid());
+		tst_res(TINFO, "si_uid   E:%d,\tR:%d",
+			info.si_uid, getuid());
 	}
 
-	if ((TEST_RETURN != 0 && TEST_ERRNO != tc->err) || !cmp_ok) {
-		tst_res(TFAIL | TTERRNO, "%s r/w check returned: %ld, "
-			"expected: %d, expected errno: %s (%d)", tc->desc,
-			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
-	} else {
-		tst_res(TPASS | TTERRNO, "%s returned: %ld",
-			tc->desc, TEST_RETURN);
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO)
+			tst_res(TFAIL | TTERRNO,
+				"mq_timedsend failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		else
+			tst_res(TPASS | TTERRNO, "mq_timedsend failed expectedly");
+		return;
 	}
 
-CLEANUP:
-	if (fd >= 0) {
-		close(fd);
-		mq_unlink(QUEUE_NAME);
+	if (tc->ret != TEST_RETURN) {
+		tst_res(TFAIL, "mq_timedsend returned %ld, expected %d",
+			TEST_RETURN, tc->ret);
+		return;
 	}
+
+	tst_res(TPASS, "mq_notify and mq_timedsend exited expectedly");
 }
 
 static struct tst_option options[] = {
@@ -246,5 +217,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.options = options,
-	.setup = setup,
+	.setup = setup_common,
+	.cleanup = cleanup_common,
 };
-- 
2.12.2

