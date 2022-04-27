Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33DCC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 03:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B743CA4F4
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 05:38:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D8863CA4A1
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:38:30 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3FB21A00900
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 05:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1651030707; i=@fujitsu.com;
 bh=MX4+me1kdCqEaLNg+4L3WLR7+LzLq0lkDOof37HnBLI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=Pp9QfNpG3pXO350uQXq1N1HbTVTVp3NIE8P6JSRbInPxCOKsOi450UH0lyACaGfyw
 iW3jgauQ2oTVBNPJoRrDU4/+q81wLuH0TDBihtol9TFoGHEPG/T20J6YeUWnFv7ZU9
 Zu3QOzO4hpmdh9tLw17zKldRpOVd1VBUzHNzBLxH0t+qOEEtVeTS32d9rnV3l2a9QV
 G/mjFIsyslQxnqZ0E0TfjCeFpPQNUNkHw7dLA0QDG0HIqoyt6Pethx3A/y3fiY8TqM
 M5+HeFO5Vqewy3O1CxVVVLF6/p/tlpFUyoMRBKLueFRaaCtLbzChoqt8jjxicLUK36
 ranvQlI7SMaXQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRWlGSWpSXmKPExsViZ8ORqLt5V0a
 SwY2VIhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bec+tYCrY7VZzb28TSwLjetIuRi0NI4Cyj
 xKf7T5khnJ1MEkubljFCOHsYJU4/+wuU4eRgE9CUeNa5AMwWEZCQ6Gh4yw5iMwv4Sey7exUsL
 ixgLdH39wwLiM0ioCpxdcJOJhCbV8BT4vXKL2C2hICCxJSH75kh4oISJ2c+YYGYIyFx8MULZo
 gaRYlLHd8YIewKiVmz2qB61SSuntvEPIGRfxaS9llI2hcwMq1itE4qykzPKMlNzMzRNTQw0DU
 0NNU1NtU1tDDRS6zSTdRLLdUtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIDMyUYuUdOxjb
 Vv3UO8QoycGkJMqbPDUjSYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb8dOoJxgUWp6akVaZg4wS
 mDSEhw8SiK8k0HSvMUFibnFmekQqVOMilLivD/XACUEQBIZpXlwbbDIvMQoKyXMy8jAwCDEU5
 BalJtZgir/ilGcg1FJmHcTyHiezLwSuOmvgBYzAS3+VJsKsrgkESEl1cDktv3HqjOHGg/tSfk
 1V+5RxMdJEgZ34mdtOcnHzP3l8vuO3I+Xcv6FbVkUtfJJbcCtqXYfTnG75hlkOhzpcq42fHHu
 Ocu3NabSa1i25hzIMm4siL217JZ6trSS6+PAEC8HjoR81xal4iOlactvr7pzSOjWPNmkjy+y/
 7+R2zJb+PmyqfEzEq5ZyOra6c+WEr2mZMr29oerrJKN3oEnqmdSrCQXLSmdbDR3d9veTMZ3Fk
 /E0+d9O/u+edanV9uy69suzVq4ZtaXwHmrNv1pTyncsuBIucupk0XPFyrKy8v+eFW/1GGlWZb
 3OY4TUy/Z7rmXzLx+Kv9NsZdbC0rtVkwp322cvsbPT+Fy0I3VKouOLlJiKc5INNRiLipOBACO
 QZw0RwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1651030707!27584!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18945 invoked from network); 27 Apr 2022 03:38:27 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Apr 2022 03:38:27 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id DFCAF10018F
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 04:38:26 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id C17EB10018B
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 04:38:26 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 27 Apr 2022 04:38:03 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Apr 2022 12:39:21 +0800
Message-ID: <1651034362-18672-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/shmdt01: Convert into new api
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Liao Huangjie <liaohj.jy@fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmdt/Makefile  |   7 +-
 testcases/kernel/syscalls/ipc/shmdt/shmdt01.c | 241 ++++--------------
 2 files changed, 55 insertions(+), 193 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmdt/Makefile b/testcases/kernel/syscalls/ipc/shmdt/Makefile
index 26b9f264d..a48dbf48f 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -3,10 +3,13 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LTPLDLIBS  = -lltpipc
+shmdt01: LTPLDLIBS = -lltpnewipc
+shmdt02: LTPLDLIBS = -lltpipc
+
+LTPLDLIBS  = -lltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
index 697613a47..0b754da29 100644
--- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
+++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
@@ -1,223 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
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
+ * Copyright (c) International Business Machines Corp., 2001
  */
 
-/*
- * NAME
- *	shmdt01.c
- *
- * DESCRIPTION
- *	shmdt01 - check that shared memory is detached correctly
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	create a shared memory resource of size sizeof(int)
- *	attach it to the current process and give it a value
- *	call shmdt() using the TEST macro
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		attempt to write a value to the shared memory address
- *		this should generate a SIGSEGV which will be caught in
- *		    the signal handler
- *	  	if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmdt01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- *      06/03/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix wrong return value check on shmat system call (leading to
- *        segfault in case of error with this syscall).
- *
- * RESTRICTIONS
- *	none
+ * This case check whether we get SIGSEGV when write a value to a detached
+ * shared memory resource.
  */
 
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
 #include <setjmp.h>
-#include "ipcshm.h"
-
-char *TCID = "shmdt01";
-int TST_TOTAL = 1;
-
-void sighandler(int);
-struct shmid_ds buf;
+#include "tst_test.h"
+#include "libnewipc.h"
+#include "tst_safe_sysv_ipc.h"
 
-int shm_id_1 = -1;
-int *shared;			/* variable to use for shared memory attach */
-int new;
-int pass = 0;
+static int shm_id = -1, shm_key, pass;
+static int *shared;
 sigjmp_buf env;
 
-int main(int ac, char **av)
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	int lc;
-	void check_functionality(void);
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * Use TEST macro to make the shmdt() call
-		 */
-
-		TEST(shmdt((const void *)shared));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			check_functionality();
-		}
-
-		/* reattach the shared memory segment in case we are looping */
-		shared = shmat(shm_id_1, 0, 0);
-
-		if (shared == (void *)-1) {
-			tst_brkm(TBROK, cleanup, "memory reattach failed");
-		}
-
-		/* also reset pass */
-		pass = 0;
-	}
-
-	cleanup();
-
-	tst_exit();
+	pass = 1;
+	siglongjmp(env, 1);
 }
 
-/*
- * check_functionality() - make sure the memory is detached correctly
- */
-void check_functionality(void)
+static void check_functionality(void)
 {
-	/* stat the shared memory segment */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "could not stat in signal handler");
+	struct shmid_ds buf;
 
+	SAFE_SHMCTL(shm_id, IPC_STAT, &buf);
 	if (buf.shm_nattch != 0) {
-		tst_resm(TFAIL, "# of attaches is incorrect");
+		tst_res(TFAIL, "Number of attaches(%ld) is non-zero", buf.shm_nattch);
 		return;
 	}
 
-	/*
-	 * Try writing to the shared memory.  This should generate a
-	 * SIGSEGV which will be caught below.
-	 *
-	 * This is wrapped by the sigsetjmp() call that will take care of
-	 * restoring the program's context in an elegant way in conjunction
-	 * with the call to siglongjmp() in the signal handler.
-	 *
-	 * An attempt to do the assignment without using the sigsetjmp()
-	 * and siglongjmp() calls will result in an infinite loop.  Program
-	 * control is returned to the assignment statement after the execution
-	 * of the signal handler and another SIGSEGV will be generated.
-	 */
-
-	if (sigsetjmp(env, 1) == 0) {
+	if (sigsetjmp(env, 1) == 0)
 		*shared = 2;
-	}
-
-	if (pass) {
-		tst_resm(TPASS, "shared memory detached correctly");
-	} else {
-		tst_resm(TFAIL, "shared memory was not detached correctly");
-	}
-}
 
-void sighandler(int sig)
-{
-	/* if we have received a SIGSEGV, we are almost done */
-	if (sig == SIGSEGV) {
-		/* set the global variable and jump back */
-		pass = 1;
-		siglongjmp(env, 1);
-	} else
-		tst_brkm(TBROK, cleanup,
-			 "received an unexpected signal: %d", sig);
+	if (pass)
+		tst_res(TPASS, "shared memory detached correctly");
+	else
+		tst_res(TFAIL, "shared memory was not detached correctly");
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
+static void verify_shmdt(void)
 {
-
-	tst_sig(NOFORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See libs/libltpipc/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	shmkey = getipckey();
-
-	/* create a shared memory resource with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, INT_SIZE, SHM_RW | IPC_CREAT |
-			       IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource in setup()");
-	}
-
-	/* attach the shared memory segment */
-	shared = shmat(shm_id_1, 0, 0);
-
-	if (shared == (void *)-1) {
-		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
+	TST_EXP_PASS_SILENT(shmdt(shared));
+	if (TST_PASS) {
+		check_functionality();
+		shared = SAFE_SHMAT(shm_id, 0, 0);
 	}
 
-	/* give a value to the shared memory integer */
-	*shared = 4;
+	pass = 0;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void cleanup(void)
+static void setup(void)
 {
-	/* if it exists, delete the shared memory resource */
-	rm_shm(shm_id_1);
+	shm_key = GETIPCKEY();
+	shm_id = SAFE_SHMGET(shm_key, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
 
-	tst_rmdir();
+	SAFE_SIGNAL(SIGSEGV, sighandler);
+	shared = SAFE_SHMAT(shm_id, 0, 0);
+}
 
+static void cleanup(void)
+{
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_shmdt,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
