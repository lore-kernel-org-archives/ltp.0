From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Jun 2017 22:05:49 +0200
Subject: [LTP] [PATCH 3/3] syscalls/mq_notify: Cleanup + use mq.h
In-Reply-To: <20170605200549.3832-1-pvorel@suse.cz>
References: <20170605200549.3832-1-pvorel@suse.cz>
Message-ID: <20170605200549.3832-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mq_notify/Makefile      |   2 +-
 testcases/kernel/syscalls/mq_notify/mq_notify01.c | 204 +++++++++++-----------
 2 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/Makefile b/testcases/kernel/syscalls/mq_notify/Makefile
index 2e1628e9f..7b9304212 100644
--- a/testcases/kernel/syscalls/mq_notify/Makefile
+++ b/testcases/kernel/syscalls/mq_notify/Makefile
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-CPPFLAGS		?= -D_POSIX_C_SOURCE=$(shell getconf _POSIX_MESSAGE_PASSING)L
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
 LDLIBS			+= -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 2406dee85..29a2ba92a 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -1,102 +1,102 @@
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
+ * Author(s):
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
 #include <string.h>
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
 
 static char *str_debug;
-static char smsg[MAX_MSGSIZE];
+static struct sigevent ev;
 
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
+	void (*setup)(void);
+	void (*cleanup)(void);
+	int fd;
 	int notify;
 	int ttype;
-	const char *desc;
 	int ret;
 	int err;
 };
 
-#define TYPE_NAME(x) .ttype = x, .desc = #x
+static void create_queue_notify_queue(void)
+{
+	create_queue();
+	if (mq_notify(fd, &ev) == -1)
+		tst_brk(TBROK | TERRNO, "mq_notify(%d, %p) failed", fd, &ev);
+}
+
 static struct test_case tcase[] = {
 	{
-		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.notify = SIGEV_NONE,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.notify = SIGEV_SIGNAL,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(NORMAL),
+		.setup = create_queue,
+		.cleanup = unlink_queue,
 		.notify = SIGEV_THREAD,
 		.ret = 0,
 		.err = 0,
 	},
 	{
-		TYPE_NAME(FD_NONE),
+		.fd = -1,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(FD_NOT_EXIST),
+		.fd = INT_MAX - 1,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(FD_FILE),
+		.setup = open_fd,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
-		TYPE_NAME(ALREADY_REGISTERED),
+		.setup = create_queue_notify_queue,
+		.cleanup = unlink_queue,
 		.notify = SIGEV_NONE,
 		.ret = -1,
 		.err = EBUSY,
@@ -107,7 +107,7 @@ static void setup(void)
 {
 	int i;
 
-	for (i = 0; i < MSG_SIZE; i++)
+	for (i = 0; i < MSG_LENGTH; i++)
 		smsg[i] = i;
 }
 static void sigfunc(int signo LTP_ATTRIBUTE_UNUSED, siginfo_t *si,
@@ -131,8 +131,6 @@ static void tfunc(union sigval sv)
 
 static void do_test(unsigned int i)
 {
-	int rc, fd = -1;
-	struct sigevent ev;
 	struct sigaction sigact;
 	struct timespec abs_timeout;
 	struct test_case *tc = &tcase[i];
@@ -149,22 +147,11 @@ static void do_test(unsigned int i)
 	 */
 	mq_unlink(QUEUE_NAME);
 
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
+	if (tc->fd)
+		fd = tc->fd;
+
+	if (tc->setup)
+		tc->setup();
 
 	ev.sigev_notify = tc->notify;
 
@@ -177,7 +164,10 @@ static void do_test(unsigned int i)
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
@@ -187,54 +177,64 @@ static void do_test(unsigned int i)
 		break;
 	}
 
-	if (tc->ttype == ALREADY_REGISTERED) {
-		rc = mq_notify(fd, &ev);
-		if (rc < 0) {
-			tst_res(TBROK | TERRNO, "mq_notify failed");
-			goto CLEANUP;
-		}
+	TEST(mq_notify(fd, &ev));
+
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO) {
+			tst_res(TFAIL | TTERRNO,
+				"mq_notify failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		} else
+			tst_res(TPASS | TTERRNO, "mq_notify failed expectedly");
+
+		if (tc->cleanup)
+			tc->cleanup();
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
+	TEST(mq_timedsend(fd, smsg, MSG_LENGTH, 0, &abs_timeout));
 
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
+	if (tc->cleanup)
+		tc->cleanup();
+
+	if (TEST_RETURN < 0) {
+		tst_res(TFAIL | TTERRNO, "mq_timedsend failed");
+		return;
 	}
 
-	if ((TEST_RETURN != 0 && TEST_ERRNO != tc->err) || !cmp_ok) {
-		tst_res(TFAIL | TTERRNO, "%s r/w check returned: %ld, "
-			"expected: %d, expected errno: %s (%d)", tc->desc,
-			TEST_RETURN, tc->ret, tst_strerrno(tc->err), tc->err);
-	} else {
-		tst_res(TPASS | TTERRNO, "%s returned: %ld",
-			tc->desc, TEST_RETURN);
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
 
-CLEANUP:
-	if (fd >= 0) {
-		close(fd);
-		mq_unlink(QUEUE_NAME);
+	if (TEST_RETURN < 0) {
+		if (tc->err != TEST_ERRNO)
+			tst_res(TFAIL | TTERRNO,
+				"mq_timedsend failed unexpectedly, expected %s",
+				tst_strerrno(tc->err));
+		else
+			tst_res(TPASS | TTERRNO, "mq_timedsend failed expectedly");
+		return;
 	}
+
+	if (tc->ret != TEST_RETURN) {
+		tst_res(TFAIL | TTERRNO, "mq_timedreceive returned %ld, expected %d",
+			TEST_RETURN, tc->ret);
+		return;
+	}
+
+	tst_res(TPASS, "mq_notify and mq_timedsend exited expectedly");
 }
 
 static struct tst_option options[] = {
-- 
2.12.2

