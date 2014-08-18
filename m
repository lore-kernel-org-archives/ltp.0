Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XJK6E-0007BF-H8
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 10:23:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XJK6C-00028s-LN
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 10:23:38 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7IANTrq013987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Aug 2014 06:23:29 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7IANRJW003195
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Aug 2014 06:23:28 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Aug 2014 12:23:41 +0200
Message-Id: <92b6bfe6278a2b2e15bd47a572d909f3828f6a7b.1408357299.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] profil01: rewrite testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The original testcase failed on ppc64le, because instead of using
_start address it reads value stored there, which caused that
calculated size of watched range (lotext, etext) was negative.

profil() syscall is deprecated for at least decade, so this really
excersises only glibc function. Since this test is in LTP for long
time and is quite simple, I chose to rewrite it, so we keep coverage.

Main changes are:
 1. no arch ifdefs, test assumes that 16k buffer will cover all code
    in test function
 2. only single sanity test to check that profil records some data

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---

Changes in v2:
 1. remove PROFIL_BUFSZ
 2. make data[] volatile, remove any assumptions about compiler
 3. remove UCLIBC ifdef, profil is in FILTER_OUT_DIRS in ../Makefile

 testcases/kernel/syscalls/profil/profil01.c |  425 +++++++--------------------
 1 files changed, 114 insertions(+), 311 deletions(-)
 rewrite testcases/kernel/syscalls/profil/profil01.c (82%)

diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
dissimilarity index 82%
index 6d4627b..5511f68 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -1,311 +1,114 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2002
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/* 01/02/2003	Port to LTP avenkat@us.ibm.com */
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-/*
- * NAME
- *	profil1.c  -- test profil procedure
- *
- * CALLS
- *	profil(2), alarm(2), signal(2)
- *
- * ALGORITHM
- *	Set up a profiling buffer, turn profiling on, set a timer for
- *	cpu time, spin the pc and wait for timer to go off.
- *	The profiling buffer should contain some info, highly concentrated.
- *	We just do a "looks reasonable" check.
- *
- * RESTRICTIONS
- */
-
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE 1
-#endif
-
-#include <features.h>
-#include <stdio.h>
-#include <signal.h>
-#include <limits.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "usctest.h"
-
-char *TCID = "profil01";
-
-#ifndef __UCLIBC__
-
-#ifdef __arm__
-#define ADDRESS_OFFSET 0x8000
-#else
-#define ADDRESS_OFFSET 0
-#endif
-
-#define FAILED 0
-#define PASSED 1
-
-#define P_TIME		10	/* profile for this many  seconds */
-
-extern int etext;
-
-volatile int t_flag;
-
-//char progname[]= "profil1()";
-
-/*****	LTP Port	*****/
-int local_flag = PASSED;
-int block_number;
-FILE *temp;
-int TST_TOTAL = 1;
-struct sigaction sigptr;
-
-int anyfail();
-int blenter();
-int blexit();
-void setup();
-void terror();
-void fail_exit();
-/*****	**	**	*****/
-
-u_short *pbuf;
-int stuff[11];
-int loops_completed;
-int ucount, scount;
-
-/*--------------------------------------------------------------*/
-int main(int argc, char *argv[])
-{
-	register int i;
-	int count, loc;
-	long int bsize;
-	void alrm();
-#ifdef __mips__
-#if _MIPS_SIM == _MIPS_SIM_ABI64
-	extern long int __start;
-	long int lotext = (long int)&__start;
-#else
-	extern int __start;
-	int lotext = (int)&__start;
-#endif
-#elif defined(__powerpc64__)
-	extern long int _start;
-	long int *lotextptr = (long *)&_start;
-	long int lotext = *lotextptr;
-#elif __WORDSIZE == 64
-	extern long int _start;
-	long int lotext = (long)&_start;
-#else
-	extern int _start;
-	int lotext = (int)&_start;
-#endif
-
-	bsize = (long int)&etext;
-	bsize -= lotext & ~4096;
-
-	count = loc = 0;
-
-	setup();		/* temp file is now open        */
-	/*
-	   if ((sigset(SIGALRM, alrm)) == SIG_ERR) {
-	   fprintf(temp,"signal failed. errno = %d\n",errno);
-	   fail_exit();
-	   } */
-	sigptr.sa_handler = (void (*)(int signal))alrm;
-	sigfillset(&sigptr.sa_mask);
-	sigptr.sa_flags = 0;
-	sigaddset(&sigptr.sa_mask, SIGALRM);
-	if (sigaction(SIGALRM, &sigptr, NULL) == -1) {
-		fprintf(temp, "Signal SIGALRM failed, errno = %d \n", errno);
-		fail_exit();
-	}
-
-/*--------------------------------------------------------------*/
-	blenter();
-
-	if ((pbuf =
-	     (u_short *) malloc(bsize * (sizeof(u_short)))) == (u_short *) 0) {
-		fprintf(temp, "\tcannot malloc buffer.\n");
-		fail_exit();
-	}
-
-	for (i = 0; i < bsize; i++)
-		pbuf[i] = 0;
-
-	if (profil(pbuf, bsize, ADDRESS_OFFSET, 0x10000)) {
-		fprintf(temp, "\tprofile (on) failed, errno = %d\n", errno);
-		fail_exit();
-	}
-
-	/*
-	 * Set timer.
-	 * Code will just loop in small area of text.
-	 */
-
-	alarm(P_TIME);
-
-	while (!t_flag) {
-		stuff[0] = 1;
-		stuff[1] = 1;
-		stuff[2] = 1;
-		stuff[3] = 1;
-		stuff[4] = 1;
-		stuff[5] = 1;
-		stuff[6] = 1;
-		stuff[7] = 1;
-		stuff[8] = 1;
-		stuff[9] = 1;
-		stuff[10] = 1;
-		loops_completed++;
-	}
-
-	if (profil(pbuf, bsize, ADDRESS_OFFSET, 0)) {
-		fprintf(temp, "\tprofile (off) failed, errno = %d\n", errno);
-		fail_exit();
-	}
-
-	blexit();
-/*--------------------------------------------------------------*/
-	blenter();
-
-	for (i = 0; i < bsize; i++) {
-		count += pbuf[i];
-		if (pbuf[i])
-			loc++;
-	}
-	ucount = count;
-
-	blexit();
-/*--------------------------------------------------------------*/
-	blenter();
-
-	if ((sigset(SIGCLD, SIG_IGN)) == SIG_ERR) {
-		fprintf(temp, "signal failed. errno = %d\n", errno);
-		fail_exit();
-	}
-	t_flag = 0;
-	setpgrp();
-	for (i = 0; i < bsize; i++)
-		pbuf[i] = 0;
-
-	if (profil(pbuf, bsize, ADDRESS_OFFSET, 0x10000)) {
-		fprintf(temp, "\tprofile (on) failed, errno = %d\n", errno);
-		fail_exit();
-	}
-
-	/*
-	 * Set timer. This loop will spend a lot of time in system code
-	 * (searching though proc table) that won't add to our buffer
-	 * since the pc isn't in our code.
-	 */
-
-	alarm(P_TIME);
-
-	while (!t_flag) {
-		kill(getpid(), SIGCLD);
-	}
-
-	if (profil(pbuf, bsize, ADDRESS_OFFSET, 0)) {
-		fprintf(temp, "\tprofile (off) failed, errno = %d\n", errno);
-		fail_exit();
-	}
-
-	count = 0;
-	for (i = 0; i < bsize; i++) {
-		count += pbuf[i];
-		if (pbuf[i])
-			loc++;
-	}
-	scount = count;
-
-	if (scount > ucount) {
-		fprintf(temp, "\tUnexpected profiling results.\n");
-		fprintf(temp, "\tExpected second value to be less.\n");
-		local_flag = FAILED;
-	}
-
-	blexit();
-/*--------------------------------------------------------------*/
-	anyfail();		/* THIS CALL DOES NOT RETURN - EXITS!!  */
-	tst_exit();
-}
-
-/*--------------------------------------------------------------*/
-
-void alrm(void)
-{
-	t_flag++;
-}
-
-/*****	LTP Port	*****/
-int anyfail(void)
-{
-	(local_flag == FAILED) ? tst_resm(TFAIL,
-					  "Test failed") : tst_resm(TPASS,
-								    "Test passed");
-	tst_exit();
-	return 0;
-}
-
-void setup(void)
-{
-	temp = stderr;
-}
-
-int blenter(void)
-{
-	//tst_resm(TINFO, "Enter block %d", block_number);
-	local_flag = PASSED;
-	return 0;
-}
-
-int blexit(void)
-{
-	//tst_resm(TINFO, "Exitng test");
-	(local_flag == FAILED) ? tst_resm(TFAIL,
-					  "Test failed") : tst_resm(TPASS,
-								    "Test passed");
-	return 0;
-}
-
-void terror(char *message)
-{
-	tst_resm(TBROK, "Reason: %s:%s", message, strerror(errno));
-}
-
-void fail_exit(void)
-{
-	local_flag = FAILED;
-	anyfail();
-
-}
-
-/*****	**	**	*****/
-
-#else
-int main(void)
-{
-	/* uClibc does not have profiling support */
-	tst_exit();
-}
-#endif
+/*
+ *   Copyright (c) International Business Machines  Corp., 2002
+ *   Copyright (C) 2014 Linux Test Project, Inc.
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ */
+/*
+ * ALGORITHM
+ *	Set up a profiling buffer, turn profiling on, set a timer for
+ *	cpu time, spin the pc and wait for timer to go off.
+ *	The profiling buffer should contain some info, highly concentrated.
+ *	We just do a "looks reasonable" check.
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/types.h>
+#include "test.h"
+#include "safe_macros.h"
+#include "usctest.h"
+
+#define PROFIL_TIME 5
+
+/* should be large enough to hold data for test_profil() .text
+ * on x86_64 this is ~600 bytes, so 16k should enough for all arches */
+#define PROFIL_BUFLEN (16*1024)
+
+char *TCID = "profil01";
+int TST_TOTAL = 1;
+
+static volatile sig_atomic_t profil_done;
+
+static void alrm_handler(int sig)
+{
+	(void) sig;
+	profil_done = 1;
+}
+
+static void test_profil(void)
+{
+	unsigned short buf[PROFIL_BUFLEN] = { 0 };
+	volatile int data[8] = { 0 };
+	size_t offset = (size_t) &test_profil, count = 0;
+	int ret, i;
+
+	/* reset for test looping */
+	profil_done = 0;
+
+	/* profil_count in glibc calculates offset as
+	 *   i = (pc - pc_offset - (void *) 0) / 2
+	 *   i = i * pc_scale / 65536
+	 * set scale to 2*65536 to have 1:1 mapping for $pc */
+	ret = profil(buf, sizeof(buf), offset, 2*65536);
+	if (ret)
+		tst_brkm(TBROK, NULL, "profil returned: %d\n", ret);
+
+	signal(SIGALRM, alrm_handler);
+	alarm(PROFIL_TIME);
+
+	while (!profil_done) {
+		if (data[0])
+			data[0] = -data[7];
+		else
+			data[1] = data[0] / 2;
+		if (data[2])
+			data[2] = data[1] * 2;
+		else
+			data[3] = data[2] + data[0];
+		if (data[4])
+			data[4] = data[3] - data[1];
+		else
+			data[5] = data[4] * data[2];
+		if (data[6])
+			data[6] = data[5] + data[3];
+		else
+			data[7] = data[6] - data[4];
+	}
+
+	for (i = 0; i < PROFIL_BUFLEN; i++)
+		if (buf[i]) {
+			tst_resm(TINFO, "buf[0x%04x]=%d", i, buf[i]);
+			count += buf[i];
+		}
+
+	if (count > 0)
+		tst_resm(TPASS, "profil recorded some data");
+	else
+		tst_resm(TFAIL, "profil failed to record anything");
+}
+
+int main(int ac, char *av[])
+{
+	int lc;
+	const char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	for (lc = 0; TEST_LOOPING(lc); lc++)
+		test_profil();
+
+	tst_exit();
+}
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
