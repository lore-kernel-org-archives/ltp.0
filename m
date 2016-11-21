From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Nov 2016 09:13:27 +0100
Subject: [LTP] [PATCH 1/1] testcases/mq_notify01: convert to use new test
	library API
Message-ID: <20161121081327.8444-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Debug switch was broken. It might be better just to remove the flag and
print it all the time.
I should have rewritten it more (goto is ugly).
---
 testcases/kernel/syscalls/mq_notify/mq_notify01.c | 277 +++++++---------------
 1 file changed, 92 insertions(+), 185 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_notify/mq_notify01.c b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
index 1f1d4f6..9dd073f 100644
--- a/testcases/kernel/syscalls/mq_notify/mq_notify01.c
+++ b/testcases/kernel/syscalls/mq_notify/mq_notify01.c
@@ -1,31 +1,20 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd		      */
-/*	  Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,	      */
-/*		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,          */
-/*		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>	      */
-/* Porting from Crackerjack to LTP is done by		                      */
-/*         Manas Kumar Nayak maknayak@in.ibm.com>			      */
-/*								              */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or	      */
-/* (at your option) any later version.					      */
-/*									      */
-/* This program is distributed in the hope that it will be useful,	      */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See		      */
-/* the GNU General Public License for more details.			      */
-/*									      */
-/* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/*									      */
-/******************************************************************************/
-/******************************************************************************/
-/*									      */
-/* Description: This tests the mq_notify() syscall			      */
-/*									      */
-/******************************************************************************/
+/*
+ * Copyright (c) Crackerjack Project., 2007-2008 ,Hitachi, Ltd
+ *          Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
+ *		       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
+ *		       Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
+ * Copyright (c) 2016 Linux Test Project
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ */
 #define _XOPEN_SOURCE 600
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -43,30 +32,12 @@
 #include <stdlib.h>
 #include <fcntl.h>
 
-#include "../utils/include_j_h.h"
-
-#include "test.h"
 #include "linux_syscall_numbers.h"
+#include "tst_test.h"
 
-char *TCID = "mq_notify01";
-int testno;
-int TST_TOTAL = 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-#define SYSCALL_NAME    "mq_notify"
-
+static char *str_debug;
 static int opt_debug;
-static char *progname;
+
 static int notified;
 static int cmp_ok;
 
@@ -81,6 +52,7 @@ enum test_type {
 struct test_case {
 	int notify;
 	int ttype;
+	const char *desc;	   /* test description (name) */
 	int ret;
 	int err;
 };
@@ -88,63 +60,70 @@ struct test_case {
 #define MAX_MSGSIZE     8192
 #define MSG_SIZE	16
 #define USER_DATA       0x12345678
+#define QUEUE_NAME	"/test_mqueue"
+
+
+#define TYPE_NAME(x) .ttype = x, .desc = #x
 
 static struct test_case tcase[] = {
-	{			// case00
-	 .ttype = NORMAL,
+	{
+	 TYPE_NAME(NORMAL),
 	 .notify = SIGEV_NONE,
 	 .ret = 0,
 	 .err = 0,
 	 },
-	{			// case01
-	 .ttype = NORMAL,
+	{
+	 TYPE_NAME(NORMAL),
 	 .notify = SIGEV_SIGNAL,
 	 .ret = 0,
 	 .err = 0,
 	 },
-	{			// case02
-	 .ttype = NORMAL,
+	{
+	 TYPE_NAME(NORMAL),
 	 .notify = SIGEV_THREAD,
 	 .ret = 0,
 	 .err = 0,
 	 },
-	{			// case03
-	 .ttype = FD_NONE,
+	{
+	 TYPE_NAME(FD_NONE),
 	 .notify = SIGEV_NONE,
 	 .ret = -1,
 	 .err = EBADF,
 	 },
-	{			// case04
-	 .ttype = FD_NOT_EXIST,
+	{
+	 TYPE_NAME(FD_NOT_EXIST),
 	 .notify = SIGEV_NONE,
 	 .ret = -1,
 	 .err = EBADF,
 	 },
-	{			// case05
-	 .ttype = FD_FILE,
+	{
+	 TYPE_NAME(FD_FILE),
 	 .notify = SIGEV_NONE,
 	 .ret = -1,
 	 .err = EBADF,
 	 },
-	{			// case06
-	 .ttype = ALREADY_REGISTERED,
+	{
+	 TYPE_NAME(ALREADY_REGISTERED),
 	 .notify = SIGEV_NONE,
 	 .ret = -1,
 	 .err = EBUSY,
 	 },
 };
 
+static void setup(void)
+{
+	opt_debug = str_debug ? 1 : 0;
+}
+
 static void sigfunc(int signo, siginfo_t * info, void *data)
 {
 	if (opt_debug) {
-		tst_resm(TINFO, "si_code  E:%d,\tR:%d", info->si_code,
-			 SI_MESGQ);
-		tst_resm(TINFO, "si_signo E:%d,\tR:%d", info->si_signo,
-			 SIGUSR1);
-		tst_resm(TINFO, "si_value E:0x%x,\tR:0x%x",
+		tst_res(TINFO, "si_code  E:%d,\tR:%d", info->si_code, SI_MESGQ);
+		tst_res(TINFO, "si_signo E:%d,\tR:%d", info->si_signo, SIGUSR1);
+		tst_res(TINFO, "si_value E:0x%x,\tR:0x%x",
 			 info->si_value.sival_int, USER_DATA);
-		tst_resm(TINFO, "si_pid   E:%d,\tR:%d", info->si_pid, getpid());
-		tst_resm(TINFO, "si_uid   E:%d,\tR:%d", info->si_uid, getuid());
+		tst_res(TINFO, "si_pid   E:%d,\tR:%d", info->si_pid, getpid());
+		tst_res(TINFO, "si_uid   E:%d,\tR:%d", info->si_uid, getuid());
 	}
 	cmp_ok = info->si_code == SI_MESGQ &&
 	    info->si_signo == SIGUSR1 &&
@@ -159,16 +138,16 @@ static void tfunc(union sigval sv)
 	notified = 1;
 }
 
-static int do_test(struct test_case *tc)
+static void do_test(unsigned int i)
 {
 	int sys_ret;
 	int sys_errno;
-	int result = RESULT_OK;
-	int rc, i, fd = -1;
+	int rc, j, fd = -1;
 	struct sigevent ev;
 	struct sigaction sigact;
 	struct timespec abs_timeout;
 	char smsg[MAX_MSGSIZE];
+	struct test_case *tc = &tcase[i];
 
 	notified = cmp_ok = 1;
 
@@ -191,28 +170,20 @@ static int do_test(struct test_case *tc)
 	case FD_FILE:
 		TEST(fd = open("/", O_RDONLY));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL, "can't open \"/\".");
-			result = 1;
-			goto EXIT;
+			tst_res(TFAIL, "can't open \"/\".");
+			goto CLEANUP;
 		}
 		break;
 	default:
-		/*
-		 * Open message queue
-		 */
 		TEST(fd =
 		     mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU,
 			     NULL));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "mq_open failed");
-			result = 1;
-			goto EXIT;
+			tst_res(TFAIL | TTERRNO, "mq_open failed");
+			goto CLEANUP;
 		}
 	}
 
-	/*
-	 * Set up struct sigevent
-	 */
 	ev.sigev_notify = tc->notify;
 
 	switch (tc->notify) {
@@ -237,9 +208,8 @@ static int do_test(struct test_case *tc)
 	if (tc->ttype == ALREADY_REGISTERED) {
 		TEST(rc = mq_notify(fd, &ev));
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL | TTERRNO, "mq_notify failed");
-			result = 1;
-			goto EXIT;
+			tst_res(TFAIL | TTERRNO, "mq_notify failed");
+			goto CLEANUP;
 		}
 	}
 
@@ -249,111 +219,48 @@ static int do_test(struct test_case *tc)
 	errno = 0;
 	sys_ret = mq_notify(fd, &ev);
 	sys_errno = errno;
-	if (sys_ret < 0)
-		goto TEST_END;
+	if (sys_ret >= 0) {
+		/*
+		 * Prepare send message
+		 */
+		for (j = 0; j < MSG_SIZE; j++)
+			smsg[j] = j;
+		TEST(rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout));
+		if (rc < 0) {
+			tst_res(TFAIL | TTERRNO, "mq_timedsend failed");
+			goto CLEANUP;
+		}
 
-	/*
-	 * Prepare send message
-	 */
-	for (i = 0; i < MSG_SIZE; i++)
-		smsg[i] = i;
-	TEST(rc = mq_timedsend(fd, smsg, MSG_SIZE, 0, &abs_timeout));
-	if (rc < 0) {
-		tst_resm(TFAIL | TTERRNO, "mq_timedsend failed");
-		result = 1;
-		goto EXIT;
+		while (!notified)
+			usleep(10000);
 	}
 
-	while (!notified)
-		usleep(10000);
-
-TEST_END:
-	/*
-	 * Check results
-	 */
-	result |= (sys_ret != 0 && sys_errno != tc->err) || !cmp_ok;
-	PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
-			 cmp_ok);
+	if ((sys_ret != 0 && sys_errno != tc->err) || !cmp_ok) {
+		tst_res(TFAIL, "%s r/w check returned: %d, expected: %d,"
+			" returned errno: %s (%d), expected errno: %s (%d)",
+			tc->desc, sys_ret, tc->ret, tst_strerrno(sys_errno),
+			sys_errno, tst_strerrno(tc->err), tc->err);
+	} else {
+		tst_res(TPASS, "%s returned: %d", tc->desc, sys_ret);
+	}
 
-EXIT:
+CLEANUP:
 	if (fd >= 0) {
 		close(fd);
 		mq_unlink(QUEUE_NAME);
 	}
-
-	return result;
 }
 
-static void usage(const char *progname)
-{
-	tst_resm(TINFO, "usage: %s [options]", progname);
-	tst_resm(TINFO, "This is a regression test program of %s system call.",
-		 SYSCALL_NAME);
-	tst_resm(TINFO, "options:");
-	tst_resm(TINFO, "    -d --debug	   Show debug messages");
-	tst_resm(TINFO, "    -h --help	    Show this message");
-}
-
-int main(int ac, char **av)
-{
-	int result = RESULT_OK;
-	int c;
-	int i;
-	int lc;
-
-	struct option long_options[] = {
-		{"debug", no_argument, 0, 'd'},
-		{"help", no_argument, 0, 'h'},
-		{NULL, 0, NULL, 0}
-	};
-
-	progname = basename(av[0]);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(c = getopt_long(ac, av, "dh", long_options, NULL));
-			while (TEST_RETURN != -1) {
-				switch (c) {
-				case 'd':
-					opt_debug = 1;
-					break;
-				default:
-					usage(progname);
-				}
-			}
-
-			if (ac != optind) {
-				tst_resm(TINFO, "Options are not match.");
-				usage(progname);
-			}
-
-			for (i = 0; i < (int)(sizeof(tcase) / sizeof(tcase[0]));
-			     i++) {
-				int ret;
-				tst_resm(TINFO, "(case%02d) START", i);
-				ret = do_test(&tcase[i]);
-				tst_resm(TINFO, "(case%02d) END => %s",
-					 i, (ret == 0) ? "OK" : "NG");
-				result |= ret;
-			}
-
-			switch (result) {
-			case RESULT_OK:
-				tst_resm(TPASS, "mq_notify call succeeded");
-				break;
-
-			default:
-				tst_brkm(TFAIL, cleanup, "mq_notify failed");
-				break;
-			}
+static struct tst_option options[] = {
+	{"d", &str_debug, "Print debug messages"},
+	{NULL, NULL, NULL}
+};
 
-		}
-	}
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.tid = "mq_notify01",
+	.tcnt = ARRAY_SIZE(tcase),
+	.test = do_test,
+	.options = options,
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
-- 
2.10.2

