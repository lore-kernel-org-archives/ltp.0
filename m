Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47222C4345F
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 09:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E7143CC2DC
	for <ltp@archiver.kernel.org>; Fri,  3 May 2024 11:32:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABEFD3C8658
 for <ltp@lists.linux.it>; Fri,  3 May 2024 11:31:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7629A140BB62
 for <ltp@lists.linux.it>; Fri,  3 May 2024 11:31:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 173D820006;
 Fri,  3 May 2024 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714728712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AfwfONjhLcfOEKtV7CuwTBsM2HrM1MV5dnIq3uXJ6AU=;
 b=LPf+byeRiiXYmyPrv9U9UfmaVDOi4dj9zEt3nxKAl0OQyVhzK7WUAgGJ5NKyPt9DdKdg3k
 hTcAj7RMK7sYIjNSY8hdAX0gLSO694rc0IS3NhC23lSnuPYLnploPfVfXpfHw/CTY3mbym
 DrwKU5OjvkGRBXF7fspnSUmCWz1K14U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714728712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AfwfONjhLcfOEKtV7CuwTBsM2HrM1MV5dnIq3uXJ6AU=;
 b=GDZ69nCFogeVmwDWriSMFruevWPM/Oc4pqSN9VYQYn8ubKWJHyq0mu/6LcPPLcVTAoAq/e
 DQRXL5qOnzP3JdAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714728712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AfwfONjhLcfOEKtV7CuwTBsM2HrM1MV5dnIq3uXJ6AU=;
 b=LPf+byeRiiXYmyPrv9U9UfmaVDOi4dj9zEt3nxKAl0OQyVhzK7WUAgGJ5NKyPt9DdKdg3k
 hTcAj7RMK7sYIjNSY8hdAX0gLSO694rc0IS3NhC23lSnuPYLnploPfVfXpfHw/CTY3mbym
 DrwKU5OjvkGRBXF7fspnSUmCWz1K14U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714728712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AfwfONjhLcfOEKtV7CuwTBsM2HrM1MV5dnIq3uXJ6AU=;
 b=GDZ69nCFogeVmwDWriSMFruevWPM/Oc4pqSN9VYQYn8ubKWJHyq0mu/6LcPPLcVTAoAq/e
 DQRXL5qOnzP3JdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9121139CB;
 Fri,  3 May 2024 09:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RfiWNwevNGbRMgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 03 May 2024 09:31:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri,  3 May 2024 11:31:51 +0200
Message-Id: <20240503093151.29928-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Rewrite msgstress testing suite
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

msgstress testing suite has been rewritten, taking in consideration
that old code was not working most of the times. The new algorithm
simply generates new SysV IPC messages, spawning a sender and a
receiver which will validate data.

With the new algorithm we also reduce the amount of children which
we spawn, since we only have 2: sender and receiver. This permits to
increase the number of messages to send and to do not be depedent from
system overload.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Remove KEY_VAL0 and use IPC_PRIVATE
Rename *failure with *stop
Wait for all children to stop before checking *stop
reader() now uses pos variable
*stop as "volatile int"

 runtest/syscalls                              |   6 +-
 runtest/syscalls-ipc                          |   6 +-
 .../kernel/syscalls/ipc/msgstress/.gitignore  |   3 -
 .../kernel/syscalls/ipc/msgstress/Makefile    |   5 -
 .../syscalls/ipc/msgstress/msgstress01.c      | 450 ++++++++----------
 .../syscalls/ipc/msgstress/msgstress02.c      | 408 ----------------
 .../syscalls/ipc/msgstress/msgstress03.c      | 299 ------------
 .../syscalls/ipc/msgstress/msgstress04.c      | 444 -----------------
 8 files changed, 207 insertions(+), 1414 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b9dd9fec6..fabb196be 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -864,12 +864,10 @@ msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
-msgstress01 msgstress01
-msgstress02 msgstress02
-msgstress03 msgstress03
-msgstress04 msgstress04
 msgctl12 msgctl12
 
+msgstress01 msgstress01
+
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 9860394de..8960c487c 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -4,12 +4,10 @@ msgctl03 msgctl03
 msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
-msgstress01 msgstress01
-msgstress02 msgstress02
-msgstress03 msgstress03
-msgstress04 msgstress04
 msgctl12 msgctl12
 
+msgstress01 msgstress01
+
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
diff --git a/testcases/kernel/syscalls/ipc/msgstress/.gitignore b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
index a8f675399..fe9780693 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
@@ -1,4 +1 @@
 /msgstress01
-/msgstress02
-/msgstress03
-/msgstress04
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
index b821bda01..442eb87d5 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -3,10 +3,5 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
-
 include $(top_srcdir)/include/mk/testcases.mk
-
-LTPLDLIBS  += -lltpipc
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 84e338437..5851938dd 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -1,301 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
- * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
+ * Copyright (c) International Business Machines Corp., 2002
+ *   06/30/2001   Port to Linux   nsharoff@us.ibm.com
+ *   11/11/2002   Port to LTP     dbarrera@us.ibm.com
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
 /*
- * Get and manipulate a message queue.
+ * [Description]
+ *
+ * Stress test for SysV IPC. We send multiple messages at the same time,
+ * checking that we are not loosing any byte once we receive the messages
+ * from multiple children.
+ *
+ * The number of messages to send is determined by the free slots available
+ * in SysV IPC and the available number of children which can be spawned by
+ * the process. Each sender will spawn multiple messages at the same time and
+ * each receiver will read them one by one.
  */
 
-#define _XOPEN_SOURCE 500
-#include <signal.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
 #include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <values.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress01";
-int TST_TOTAL = 1;
-
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
-#define MAXNREPS	100000
-
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
-static int tid;
-static int MSGMNI, nprocs, nreps;
-static int procstat;
-static int mykid;
-
-void setup(void);
-void cleanup(void);
-
-static int dotest(key_t key, int child_process);
-static void sig_handler();
-
-static char *opt_nprocs;
-static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
+#include "tst_safe_sysv_ipc.h"
+#include "tst_safe_stdio.h"
+#include "tst_test.h"
+
+#define SYSVIPC_TOTAL "/proc/sys/kernel/msgmni"
+#define SYSVIPC_USED "/proc/sysvipc/msg"
+#define MSGTYPE 10
+#define MAXNREPS 100000
+
+struct sysv_msg {
+	long type;
+	struct {
+		char len;
+		char pbytes[99];
+	} data;
+};
+
+struct sysv_data {
+	int id;
+	struct sysv_msg msg;
 };
 
-static void usage(void)
+static struct sysv_data *ipc_data;
+static int ipc_data_len;
+
+static char *str_num_messages;
+static char *str_num_iterations;
+static int num_messages = 1000;
+static int num_iterations = MAXNREPS;
+static volatile int *stop;
+
+static int get_used_sysvipc(void)
 {
-	printf("  -n      Number of processes\n");
-	printf("  -l      Number of iterations\n");
+	FILE *fp;
+	int used = -1;
+	char buf[BUFSIZ];
+
+	fp = SAFE_FOPEN(SYSVIPC_USED, "r");
+
+	while (fgets(buf, BUFSIZ, fp) != NULL)
+		used++;
+
+	SAFE_FCLOSE(fp);
+
+	if (used < 0)
+		tst_brk(TBROK, "Can't read %s to get used sysvipc resource", SYSVIPC_USED);
+
+	return used;
 }
 
-int main(int argc, char **argv)
+static void reset_messages(void)
 {
-	int i, j, ok, pid;
-	int count, status;
-	struct sigaction act;
+	ipc_data_len = 0;
+	memset(ipc_data, 0, sizeof(struct sysv_data) * num_messages);
 
-	tst_parse_opts(argc, argv, options, usage);
+	for (int i = 0; i < num_messages; i++)
+		ipc_data[i].id = -1;
+}
 
-	setup();
+static int create_message(const int id)
+{
+	int pos = ipc_data_len;
+	struct sysv_data *buff = ipc_data + pos;
 
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
+	buff->id = id;
+	buff->msg.type = MSGTYPE;
+	buff->msg.data.len = (rand() % 99) + 1;
 
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
+	for (int i = 0; i < buff->msg.data.len; i++)
+		buff->msg.data.pbytes[i] = rand() % 255;
 
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
-		}
-	}
+	ipc_data_len++;
 
-	srand(getpid());
-	tid = -1;
+	return pos;
+}
 
-	/* Setup signal handling routine */
-	memset(&act, 0, sizeof(act));
-	act.sa_handler = sig_handler;
-	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGTERM);
-	if (sigaction(SIGTERM, &act, NULL) < 0) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
-	}
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < nprocs; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) rand();
-			/* Make sure key is unique and not private */
-			if (keyarray[i] == IPC_PRIVATE) {
-				ok = 0;
-				continue;
-			}
-			for (j = 0; j < i; j++) {
-				if (keyarray[j] == keyarray[i]) {
-					ok = 0;
-					break;
-				}
-				ok = 1;
-			}
-		} while (ok == 0);
-	}
+static void writer(const int id, const int pos)
+{
+	struct sysv_data *buff = &ipc_data[pos];
+	int iter = num_iterations;
 
-	/* Fork a number of processes, each of which will
-	 * create a message queue with one reader/writer
-	 * pair which will read and write a number (iterations)
-	 * of random length messages with specific values.
-	 */
+	while (--iter >= 0 && !(*stop))
+		SAFE_MSGSND(id, &buff->msg, 100, 0);
+}
+
+static void reader(const int id, const int pos)
+{
+	int size;
+	int iter = num_iterations;
+	struct sysv_msg msg_recv;
+	struct sysv_data *buff = &ipc_data[pos];
+
+	while (--iter >= 0 && !(*stop)) {
+		memset(&msg_recv, 0, sizeof(struct sysv_msg));
+
+		size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
+
+		if (msg_recv.type != buff->msg.type) {
+			tst_res(TFAIL, "Received the wrong message type");
 
-	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
+			*stop = 1;
+			return;
 		}
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(keyarray[i], i));
+
+		if (msg_recv.data.len != buff->msg.data.len) {
+			tst_res(TFAIL, "Received the wrong message data length");
+
+			*stop = 1;
+			return;
 		}
-		pidarray[i] = pid;
-	}
 
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != 0) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
+		for (int i = 0; i < size; i++) {
+			if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
+				tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
+					msg_recv.data.pbytes[i],
+					buff->msg.data.pbytes[i]);
+
+				*stop = 1;
+				return;
 			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
 		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-	}
 
-	tst_resm(TPASS, "Test ran successfully!");
+		tst_res(TDEBUG, "Received correct data");
+		tst_res(TDEBUG, "msg_recv.type = %ld", msg_recv.type);
+		tst_res(TDEBUG, "msg_recv.data.len = %d", msg_recv.data.len);
+	}
 
-	cleanup();
-	tst_exit();
+	buff->id = -1;
 }
 
-static int dotest(key_t key, int child_process)
+static void run(void)
 {
-	int id, pid;
-	int ret, status;
+	int id, pos;
 
-	sighold(SIGTERM);
-	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
-	if (TEST_RETURN < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(TEST_ERRNO));
+	reset_messages();
 
-		return FAIL;
-	}
-	tid = id = TEST_RETURN;
-	sigrelse(SIGTERM);
-
-	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
-		printf("\tFork failed (may be OK if under stress)\n");
-		TEST(msgctl(tid, IPC_RMID, 0));
-		if (TEST_RETURN < 0) {
-			printf("mscgtl() error in cleanup: %s\n",
-				strerror(TEST_ERRNO));
+	for (int i = 0; i < num_messages; i++) {
+		id = SAFE_MSGGET(IPC_PRIVATE, IPC_CREAT | 0600);
+		pos = create_message(id);
+
+		if (!SAFE_FORK()) {
+			writer(id, pos);
+			return;
 		}
-		return FAIL;
-	}
-	/* Child does this */
-	if (pid == 0)
-		exit(doreader(key, id, 1, child_process, nreps));
-	/* Parent does this */
-	mykid = pid;
-	procstat = 2;
-	ret = dowriter(key, id, 1, child_process, nreps);
-	wait(&status);
-
-	if (ret != PASS)
-		exit(FAIL);
-
-	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
-		exit(FAIL);
-
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		printf("msgctl() errno %d: %s\n",
-			TEST_ERRNO, strerror(TEST_ERRNO));
-
-		return FAIL;
+
+		if (!SAFE_FORK()) {
+			reader(id, pos);
+			return;
+		}
+
+		if (*stop)
+			break;
 	}
-	return PASS;
-}
 
-static void sig_handler(void)
-{
+	tst_reap_children();
+
+	if (!(*stop))
+		tst_res(TPASS, "Test passed. All messages have been received");
 }
 
-void setup(void)
+static void setup(void)
 {
-	int nr_msgqs;
+	int total_msg;
+	int avail_msg;
+	int free_msgs;
+	int free_pids;
 
-	tst_tmpdir();
+	srand(time(0));
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_FILE_SCANF(SYSVIPC_TOTAL, "%i", &total_msg);
 
-	TEST_PAUSE;
+	free_msgs = total_msg - get_used_sysvipc();
 
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
+	/* We remove 10% of free pids, just to be sure
+	 * we won't saturate the sysyem with processes.
+	 */
+	free_pids = tst_get_free_pids() / 2.1;
 
-	nr_msgqs -= get_used_msgqueues();
-	if (nr_msgqs <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
-	}
+	avail_msg = MIN(free_msgs, free_pids);
+	if (!avail_msg)
+		tst_brk(TCONF, "Unavailable messages slots");
 
-	/*
-	 * Since msgmni scales to the memory size, it may reach huge values
-	 * that are not necessary for this test.
-	 * That's why we define NR_MSGQUEUES as a high boundary for it.
-	 */
-	MSGMNI = MIN(nr_msgqs, NR_MSGQUEUES);
+	tst_res(TINFO, "Available messages slots: %d", avail_msg);
+
+	if (tst_parse_int(str_num_messages, &num_messages, 1, avail_msg))
+		tst_brk(TBROK, "Invalid number of messages '%s'", str_num_messages);
+
+	if (tst_parse_int(str_num_iterations, &num_iterations, 1, MAXNREPS))
+		tst_brk(TBROK, "Invalid number of messages iterations '%s'", str_num_iterations);
+
+	ipc_data = SAFE_MMAP(
+		NULL,
+		sizeof(struct sysv_data) * num_messages,
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+
+	stop = SAFE_MMAP(
+		NULL,
+		sizeof(int),
+		PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS,
+		-1, 0);
+
+	reset_messages();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	int status;
+	if (!ipc_data)
+		return;
 
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
+	for (int pos = 0; pos < num_messages; pos++) {
+		struct sysv_data *buff = &ipc_data[pos];
 
+		if (buff->id != -1)
+			SAFE_MSGCTL(buff->id, IPC_RMID, NULL);
 	}
 
-	tst_rmdir();
+	SAFE_MUNMAP(ipc_data, sizeof(struct sysv_data) * num_messages);
+	SAFE_MUNMAP((void *)stop, sizeof(int));
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.max_runtime = 180,
+	.options = (struct tst_option[]) {
+		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
+		{"l:", &str_num_iterations, "Number iterations per message (default: 10000)"},
+		{},
+	},
+};
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
deleted file mode 100644
index a0f894b05..000000000
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ /dev/null
@@ -1,408 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
- * 11/11/2002   Port to LTP     dbarrera@us.ibm.com
- */
-
-/*
- * Get and manipulate a message queue.
- */
-
-#define _XOPEN_SOURCE 500
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <errno.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress02";
-int TST_TOTAL = 1;
-
-#define MAXNREPS	1000
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
-#define MAXNKIDS	10
-
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
-static int rkidarray[MAXNKIDS];
-static int wkidarray[MAXNKIDS];
-static int tid;
-static int nprocs, nreps, nkids, MSGMNI;
-static int procstat;
-
-void setup(void);
-void cleanup(void);
-
-static void term(int);
-static int dotest(key_t, int);
-static void cleanup_msgqueue(int i, int tid);
-
-static char *opt_nprocs;
-static char *opt_nkids;
-static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"c:", NULL, &opt_nkids},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
-};
-
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -c      Number of read/write child pairs\n");
-	printf("  -l      Number of iterations\n");
-}
-
-int main(int argc, char **argv)
-{
-	int i, j, ok, pid;
-	int count, status;
-
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
-	nkids = MAXNKIDS;
-
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
-
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
-		}
-	}
-
-	if (opt_nkids) {
-		nkids = atoi(opt_nkids);
-		if (nkids > MAXNKIDS) {
-			tst_resm(TINFO,
-				 "Requested number of read/write pairs too "
-				 "large, setting to Max. of %d", MAXNKIDS);
-			nkids = MAXNKIDS;
-		}
-	}
-
-	procstat = 0;
-	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
-	tid = -1;
-
-	/* Setup signal handleing routine */
-	if (sigset(SIGTERM, term) == SIG_ERR) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
-	}
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < nprocs; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) lrand48();
-			/* Make sure key is unique and not private */
-			if (keyarray[i] == IPC_PRIVATE) {
-				ok = 0;
-				continue;
-			}
-			for (j = 0; j < i; j++) {
-				if (keyarray[j] == keyarray[i]) {
-					ok = 0;
-					break;
-				}
-				ok = 1;
-			}
-		} while (ok == 0);
-	}
-	/* Fork a number of processes (nprocs), each of which will
-	 * create a message queue with several (nkids) reader/writer
-	 * pairs which will read and write a number (iterations)
-	 * of random length messages with specific values (keys).
-	 */
-
-	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
-		}
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(keyarray[i], i));
-		}
-		pidarray[i] = pid;
-	}
-
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-	}
-
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-static void cleanup_msgqueue(int i, int tid)
-{
-	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
-	 */
-
-	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
-	for (; i >= 0; i--) {
-		(void)kill(rkidarray[i], SIGKILL);
-		(void)kill(wkidarray[i], SIGKILL);
-	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		tst_brkm(TFAIL | TERRNO, NULL, "Msgctl error in cleanup");
-	}
-}
-
-static int dotest(key_t key, int child_process)
-{
-	int id, pid;
-	int i, count, status, exit_status;
-
-	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	tid = id;
-	sigrelse(SIGTERM);
-
-	exit_status = PASS;
-
-	for (i = 0; i < nkids; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the first child of child group %d\n",
-				child_process);
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* First child does this */
-		if (pid == 0) {
-			procstat = 2;
-			exit(doreader(key, tid, getpid(),
-					child_process, nreps));
-		}
-		rkidarray[i] = pid;
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the second child of child group %d\n",
-				child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* Second child does this */
-		if (pid == 0) {
-			procstat = 2;
-			exit(dowriter(key, tid, rkidarray[i],
-					child_process, nreps));
-		}
-		wkidarray[i] = pid;
-	}
-	/* Parent does this */
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				printf("Child exit status = %d from child group %d\n",
-					status >> 8, child_process);
-				for (i = 0; i < nkids; i++) {
-					kill(rkidarray[i], SIGTERM);
-					kill(wkidarray[i], SIGTERM);
-				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					printf("msgctl() error: %s\n",
-						strerror(errno));
-				}
-				return FAIL;
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != (nkids * 2)) {
-		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
-			child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			printf("msgctl() error: %s\n", strerror(errno));
-		}
-		return FAIL;
-	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		printf("msgctl() failure in child group %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	return exit_status;
-}
-
-static void term(int sig LTP_ATTRIBUTE_UNUSED)
-{
-	int i;
-
-	if (procstat == 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
-#endif
-		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					printf("Kill failed to kill child %d",
-						i);
-					exit(FAIL);
-				}
-			}
-		}
-		return;
-	}
-
-	if (procstat == 2) {
-		fflush(stdout);
-		exit(PASS);
-	}
-
-	if (tid == -1) {
-		exit(FAIL);
-	}
-	for (i = 0; i < nkids; i++) {
-		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
-		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
-	}
-}
-
-void setup(void)
-{
-	int nr_msgqs;
-
-	tst_tmpdir();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
-
-	nr_msgqs -= get_used_msgqueues();
-	if (nr_msgqs <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
-	}
-
-	/*
-	 * Since msgmni scales to the memory size, it may reach huge values
-	 * that are not necessary for this test.
-	 * That's why we define NR_MSGQUEUES as a high boundary for it.
-	 */
-	MSGMNI = MIN(nr_msgqs, NR_MSGQUEUES);
-}
-
-void cleanup(void)
-{
-	int status;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	fflush(stdout);
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	fflush(stdout);
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
deleted file mode 100644
index aa37d9058..000000000
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ /dev/null
@@ -1,299 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
- * 11/06/2002   Port to LTP     dbarrera@us.ibm.com
- */
-
-/*
- * Get and manipulate a message queue.
- * Same as msgstress01 but gets the actual msgmni value under procfs.
- */
-
-#define _XOPEN_SOURCE 500
-#include <signal.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <values.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <sys/stat.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress03";
-int TST_TOTAL = 1;
-
-#define MAXNPROCS	10000	/*These should be sufficient */
-#define MAXNREPS	10000	/*Else they srewup the system un-necessarily */
-
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
-static int tid;
-static int MSGMNI, nprocs, nreps;
-static int procstat;
-static int mykid;
-
-void setup(void);
-void cleanup(void);
-
-static int dotest(key_t key, int child_process);
-static void sig_handler(int signo);
-
-static char *opt_nprocs;
-static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_nprocs},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
-};
-
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -l      Number of iterations\n");
-}
-
-int main(int argc, char **argv)
-{
-	int i, j, ok, pid, free_pids;
-	int count, status;
-	struct sigaction act;
-
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nprocs = MSGMNI;
-
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
-
-	if (opt_nprocs) {
-		nprocs = atoi(opt_nprocs);
-		if (nprocs > MSGMNI) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-			nprocs = MSGMNI;
-		}
-	}
-
-	free_pids = tst_get_free_pids(cleanup);
-	/* Each forked child forks once, take it into account here. */
-	if (nprocs * 2 >= free_pids) {
-		tst_resm(TINFO,
-			 "Requested number of processes higher than limit (%d > %d), "
-			 "setting to %d", nprocs * 2, free_pids, free_pids);
-		nprocs = free_pids / 2;
-	}
-
-	srand(getpid());
-	tid = -1;
-
-	/* Setup signal handling routine */
-	memset(&act, 0, sizeof(act));
-	act.sa_handler = sig_handler;
-	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGTERM);
-	if (sigaction(SIGTERM, &act, NULL) < 0) {
-		tst_brkm(TFAIL, NULL, "Sigset SIGTERM failed");
-	}
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < nprocs; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) rand();
-			/* Make sure key is unique and not private */
-			if (keyarray[i] == IPC_PRIVATE) {
-				ok = 0;
-				continue;
-			}
-			for (j = 0; j < i; j++) {
-				if (keyarray[j] == keyarray[i]) {
-					ok = 0;
-					break;
-				}
-				ok = 1;
-			}
-		} while (ok == 0);
-	}
-
-	/* Fork a number of processes, each of which will
-	 * create a message queue with one reader/writer
-	 * pair which will read and write a number (iterations)
-	 * of random length messages with specific values.
-	 */
-
-	for (i = 0; i < nprocs; i++) {
-		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			tst_brkm(TFAIL,
-				 NULL,
-				 "\tFork failed (may be OK if under stress)");
-		}
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(keyarray[i], i));
-		}
-		pidarray[i] = pid;
-	}
-
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != 0) {
-				tst_brkm(TFAIL, NULL,
-					 "Child exit status = %d",
-					 status >> 8);
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != nprocs) {
-		tst_brkm(TFAIL,
-			 NULL,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-	}
-
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-static int dotest(key_t key, int child_process)
-{
-	int id, pid;
-	int ret, status;
-
-	sighold(SIGTERM);
-	TEST(msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR));
-	if (TEST_RETURN < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(TEST_ERRNO));
-		return FAIL;
-	}
-	tid = id = TEST_RETURN;
-	sigrelse(SIGTERM);
-
-	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
-		printf("Fork failed (may be OK if under stress)\n");
-		TEST(msgctl(tid, IPC_RMID, 0));
-		if (TEST_RETURN < 0) {
-			printf("msgctl() error in cleanup: %s\n",
-				strerror(TEST_ERRNO));
-		}
-		return FAIL;
-	}
-	if (pid == 0)
-		exit(doreader(key, id, 1, child_process, nreps));
-
-	mykid = pid;
-	procstat = 2;
-	ret = dowriter(key, id, 1, child_process, nreps);
-	wait(&status);
-
-	if (ret != PASS)
-		exit(FAIL);
-
-	if ((!WIFEXITED(status) || (WEXITSTATUS(status) != PASS)))
-		exit(FAIL);
-
-	TEST(msgctl(id, IPC_RMID, 0));
-	if (TEST_RETURN < 0) {
-		printf("msgctl() failed: %s\n",
-			strerror(TEST_ERRNO));
-		return FAIL;
-	}
-	return PASS;
-}
-
-static void sig_handler(int signo LTP_ATTRIBUTE_UNUSED)
-{
-}
-
-void setup(void)
-{
-	int nr_msgqs;
-
-	tst_tmpdir();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		cleanup();
-
-	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI > MAXNPROCS)
-		MSGMNI = MAXNPROCS;
-	if (MSGMNI <= 0) {
-		tst_resm(TBROK,
-			 "Max number of message queues already used, cannot create more.");
-		cleanup();
-	}
-}
-
-void cleanup(void)
-{
-	int status;
-
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
deleted file mode 100644
index b9ebf9035..000000000
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ /dev/null
@@ -1,444 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2002
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * 06/30/2001   Port to Linux   nsharoff@us.ibm.com
- * 11/11/2002   Port to LTP     dbarrera@us.ibm.com
- */
-
-/*
- * Get and manipulate a message queue.
- * Same as msgstress02 but gets the actual msgmni value under procfs.
- */
-
-#define _XOPEN_SOURCE 500
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/msg.h>
-#include <sys/wait.h>
-#include <signal.h>
-#include <errno.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
-#include "ipcmsg.h"
-#include "libmsgctl.h"
-
-char *TCID = "msgstress04";
-int TST_TOTAL = 1;
-
-#define MAXNREPS	1000
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	 1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
-#define MAXNKIDS	10
-#define DEFNKIDS	2
-
-static int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
-static key_t keyarray[MAXNPROCS];
-static int pidarray[MAXNPROCS];
-static int rkidarray[MAXNKIDS];
-static int wkidarray[MAXNKIDS];
-static int tid;
-static int nprocs, nreps, nkids, MSGMNI;
-static int maxnprocs;
-static int procstat;
-
-void setup(void);
-void cleanup(void);
-
-static void term(int);
-static int dotest(key_t, int);
-static void dotest_iteration(int off);
-static void cleanup_msgqueue(int i, int tid);
-
-static char *opt_maxnprocs;
-static char *opt_nkids;
-static char *opt_nreps;
-
-static option_t options[] = {
-	{"n:", NULL, &opt_maxnprocs},
-	{"c:", NULL, &opt_nkids},
-	{"l:", NULL, &opt_nreps},
-	{NULL, NULL, NULL},
-};
-
-static void usage(void)
-{
-	printf("  -n      Number of processes\n");
-	printf("  -c      Number of read/write child pairs\n");
-	printf("  -l      Number of iterations\n");
-}
-
-
-int main(int argc, char **argv)
-{
-	int i, j, ok;
-
-	tst_parse_opts(argc, argv, options, usage);
-
-	setup();
-
-	nreps = MAXNREPS;
-	nkids = MAXNKIDS;
-
-	if (opt_nreps) {
-		nreps = atoi(opt_nreps);
-		if (nreps > MAXNREPS) {
-			tst_resm(TINFO,
-				 "Requested number of iterations too large, "
-				 "setting to Max. of %d", MAXNREPS);
-			nreps = MAXNREPS;
-		}
-	}
-
-	if (opt_nkids) {
-		nkids = atoi(opt_nkids);
-		if (nkids > MAXNKIDS) {
-			tst_resm(TINFO,
-				 "Requested number of read/write pairs too "
-				 "large, setting to Max. of %d", MAXNKIDS);
-			nkids = MAXNKIDS;
-		}
-	}
-
-
-	if (opt_maxnprocs) {
-		if (atoi(opt_maxnprocs) > maxnprocs) {
-			tst_resm(TINFO,
-				 "Requested number of processes too large, "
-				 "setting to Max. of %d", MSGMNI);
-		} else {
-			maxnprocs = atoi(opt_maxnprocs);
-		}
-	}
-
-	procstat = 0;
-	srand48((unsigned)getpid() + (unsigned)(getppid() << 16));
-	tid = -1;
-
-	/* Setup signal handling routine */
-	if (sigset(SIGTERM, term) == SIG_ERR)
-		tst_brkm(TFAIL, cleanup, "Sigset SIGTERM failed");
-
-	/* Set up array of unique keys for use in allocating message
-	 * queues
-	 */
-	for (i = 0; i < MSGMNI; i++) {
-		ok = 1;
-		do {
-			/* Get random key */
-			keyarray[i] = (key_t) lrand48();
-			/* Make sure key is unique and not private */
-			if (keyarray[i] == IPC_PRIVATE) {
-				ok = 0;
-				continue;
-			}
-			for (j = 0; j < i; j++) {
-				if (keyarray[j] == keyarray[i]) {
-					ok = 0;
-					break;
-				}
-				ok = 1;
-			}
-		} while (ok == 0);
-	}
-	/* Fork a number of processes, each of which will
-	 * create a message queue with several (nkids) reader/writer
-	 * pairs which will read and write a number (iterations)
-	 * of random length messages with specific values (keys).
-	 *
-	 * We do not fork more than maxnprocs at a time and
-	 * we fork until all the message queues get used.
-	 */
-
-	if (MSGMNI <= maxnprocs) {
-		nprocs = MSGMNI;
-		dotest_iteration(0);
-	} else {
-		for (i = 0; i < (MSGMNI / maxnprocs); i++) {
-			nprocs = maxnprocs;
-			dotest_iteration(i * maxnprocs);
-		}
-
-		nprocs = MSGMNI % maxnprocs;
-		dotest_iteration(i * maxnprocs);
-	}
-
-	tst_resm(TPASS, "Test ran successfully!");
-
-	cleanup();
-	tst_exit();
-}
-
-static void dotest_iteration(int off)
-{
-	key_t key;
-	int i, count, status;
-	pid_t pid;
-
-	memset(pidarray, 0, sizeof(pidarray));
-
-	for (i = 0; i < nprocs; i++) {
-		key = keyarray[off + i];
-
-		if ((pid = FORK_OR_VFORK()) < 0)
-			tst_brkm(TFAIL, cleanup,
-				 "Fork failed (may be OK if under stress)");
-
-		/* Child does this */
-		if (pid == 0) {
-			procstat = 1;
-			exit(dotest(key, i));
-		}
-		pidarray[i] = pid;
-	}
-
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS)
-				tst_brkm(TFAIL, cleanup,
-					"Child exit status = %d", status >> 8);
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-#ifdef DEBUG
-			tst_resm(TINFO, "Signal detected during wait");
-#endif
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != nprocs)
-		tst_brkm(TFAIL, cleanup,
-			 "Wrong number of children exited, Saw %d, Expected %d",
-			 count, nprocs);
-}
-
-static void cleanup_msgqueue(int i, int tid)
-{
-	/*
-	 * Decrease the value of i by 1 because it
-	 * is getting incremented even if the fork
-	 * is failing.
-	 */
-
-	i--;
-	/*
-	 * Kill all children & free message queue.
-	 */
-	for (; i >= 0; i--) {
-		(void)kill(rkidarray[i], SIGKILL);
-		(void)kill(wkidarray[i], SIGKILL);
-	}
-
-	if (msgctl(tid, IPC_RMID, 0) < 0) {
-		printf("Msgctl error in cleanup_msgqueue %d\n", errno);
-		exit(FAIL);
-	}
-}
-
-static int dotest(key_t key, int child_process)
-{
-	int id, pid;
-	int i, count, status, exit_status;
-
-	sighold(SIGTERM);
-	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
-		printf("msgget() error in child %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	tid = id;
-	sigrelse(SIGTERM);
-
-	exit_status = PASS;
-
-	for (i = 0; i < nkids; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the first child of child group %d\n",
-				child_process);
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* First child does this */
-		if (pid == 0) {
-			procstat = 2;
-			exit(doreader(key, tid, getpid(),
-					child_process, nreps));
-		}
-		rkidarray[i] = pid;
-		if ((pid = FORK_OR_VFORK()) < 0) {
-			printf("Fork failure in the second child of child group %d\n",
-				child_process);
-			/*
-			 * Kill the reader child process
-			 */
-			(void)kill(rkidarray[i], SIGKILL);
-
-			cleanup_msgqueue(i, tid);
-			return FAIL;
-		}
-		/* Second child does this */
-		if (pid == 0) {
-			procstat = 2;
-			exit(dowriter(key, tid, rkidarray[i],
-					child_process, nreps));
-		}
-		wkidarray[i] = pid;
-	}
-	/* Parent does this */
-	count = 0;
-	while (1) {
-		if ((wait(&status)) > 0) {
-			if (status >> 8 != PASS) {
-				printf("Child exit status = %d from child group %d\n",
-					status >> 8, child_process);
-				for (i = 0; i < nkids; i++) {
-					kill(rkidarray[i], SIGTERM);
-					kill(wkidarray[i], SIGTERM);
-				}
-				if (msgctl(tid, IPC_RMID, 0) < 0) {
-					printf("msgctl() error: %s\n",
-						strerror(errno));
-				}
-				return FAIL;
-			}
-			count++;
-		} else {
-			if (errno != EINTR) {
-				break;
-			}
-		}
-	}
-	/* Make sure proper number of children exited */
-	if (count != (nkids * 2)) {
-		printf("Wrong number of children exited in child group %d, saw %d, expected %d\n",
-			child_process, count, (nkids * 2));
-		if (msgctl(tid, IPC_RMID, 0) < 0) {
-			printf("msgctl() error: %s\n", strerror(errno));
-		}
-		return FAIL;
-	}
-	if (msgctl(id, IPC_RMID, 0) < 0) {
-		printf("msgctl() failure in child group %d: %s\n",
-			child_process, strerror(errno));
-		return FAIL;
-	}
-	return exit_status;
-}
-
-/* ARGSUSED */
-static void term(int sig LTP_ATTRIBUTE_UNUSED)
-{
-	int i;
-
-	if (procstat == 0) {
-#ifdef DEBUG
-		tst_resm(TINFO, "SIGTERM signal received, test killing kids");
-#endif
-		for (i = 0; i < nprocs; i++) {
-			if (pidarray[i] > 0) {
-				if (kill(pidarray[i], SIGTERM) < 0) {
-					tst_resm(TBROK,
-						 "Kill failed to kill child %d",
-						 i);
-					exit(FAIL);
-				}
-			}
-		}
-		return;
-	}
-
-	if (procstat == 2) {
-		exit(PASS);
-	}
-
-	if (tid == -1) {
-		exit(FAIL);
-	}
-	for (i = 0; i < nkids; i++) {
-		if (rkidarray[i] > 0)
-			kill(rkidarray[i], SIGTERM);
-		if (wkidarray[i] > 0)
-			kill(wkidarray[i], SIGTERM);
-	}
-}
-
-void setup(void)
-{
-	int nr_msgqs, free_pids;
-
-	tst_tmpdir();
-	/* You will want to enable some signal handling so you can capture
-	 * unexpected signals like SIGSEGV.
-	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* One cavet that hasn't been fixed yet.  TEST_PAUSE contains the code to
-	 * fork the test with the -c option.  You want to make sure you do this
-	 * before you create your temporary directory.
-	 */
-	TEST_PAUSE;
-
-	nr_msgqs = get_max_msgqueues();
-	if (nr_msgqs < 0)
-		tst_brkm(TBROK, cleanup, "get_max_msgqueues() failed");
-
-	MSGMNI = nr_msgqs - get_used_msgqueues();
-	if (MSGMNI <= 0)
-		tst_brkm(TBROK, cleanup,
-			 "Max number of message queues already used, cannot create more.");
-
-	tst_resm(TINFO, "Found %d available message queues", MSGMNI);
-
-	free_pids = tst_get_free_pids(cleanup);
-	/* We don't use more than a half of available pids.
-	 * For each child we fork up to 2*maxnkids grandchildren. */
-	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
-
-	if (!maxnprocs)
-		tst_brkm(TBROK, cleanup, "Not enough free pids");
-
-	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
-}
-
-void cleanup(void)
-{
-	int status;
-
-	/*
-	 * Remove the message queue from the system
-	 */
-#ifdef DEBUG
-	tst_resm(TINFO, "Removing the message queue");
-#endif
-	(void)msgctl(tid, IPC_RMID, NULL);
-	if ((status = msgctl(tid, IPC_STAT, NULL)) != -1) {
-		(void)msgctl(tid, IPC_RMID, NULL);
-		tst_resm(TFAIL, "msgctl(tid, IPC_RMID) failed");
-
-	}
-
-	tst_rmdir();
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
