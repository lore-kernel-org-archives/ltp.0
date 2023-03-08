Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B6FC64EC4
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 13:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B2913CD958
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 14:25:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB853CB973
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 14:25:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DB42C10009DD
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 14:25:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 762681FE41;
 Wed,  8 Mar 2023 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678281944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvm1V5ZYWJaqqrRG91eeMuNF7VjN0TBq1cj4nIg8up0=;
 b=ECoS7ezQ0VbnQYgUd3Lirm88e1b960mP3SJ5KRaucQjD/dMVzJZfD0nALdwOC4SKZKp0iW
 arLPO0Iv8W7A0ZPx+fZrYA/dEnwDqPblkAbzepf1B+xE4Kd6y2tIY3m7FTVtNhrL4LwDM0
 JF6uMeswA+CpWYakC46d/Zsn17huhSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678281944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvm1V5ZYWJaqqrRG91eeMuNF7VjN0TBq1cj4nIg8up0=;
 b=8HMl2avbLc/b8i3LgCe/gF3vWZz0hu2PhK7yfuAXPQ8+56A/tc91jQuBy7pxtMVqwDCvbD
 ibQXvTVriychXgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52B511348D;
 Wed,  8 Mar 2023 13:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +EpfEtiMCGTGRwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 08 Mar 2023 13:25:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed,  8 Mar 2023 14:23:35 +0100
Message-Id: <20230308132335.29621-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230308132335.29621-1-andrea.cervesato@suse.de>
References: <20230308132335.29621-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] Rewrite eventfd2_03 test using new LTP API
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../kernel/syscalls/eventfd2/eventfd2_03.c    | 128 +++++-------------
 1 file changed, 35 insertions(+), 93 deletions(-)

diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
index 909004edb..e1949fd32 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_03.c
@@ -1,139 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  eventfd-sem by Davide Libenzi (Simple test for eventfd sempahore)
- *  Copyright (C) 2009  Davide Libenzi
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *  Davide Libenzi <davidel@xmailserver.org>
- *  Reference: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bcd0b235bf3808dec5115c381cd55568f63b85f0
- *  Reference: http://www.xmailserver.org/eventfd-sem.c
- *  eventfd: testing improved support for semaphore-like behavior in linux-2.6.30
+ * Copyright (c) Ulrich Drepper <drepper@redhat.com>
+ * Copyright (c) International Business Machines  Corp., 2009
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
+ * This test verifies that eventfd2 semaphore-like support is properly working.
  */
 
-#include <sys/types.h>
-#include <sys/syscall.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
 #include <fcntl.h>
 #include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <errno.h>
-#include <inttypes.h>
-
-#include "test.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "eventfd2_03";
-int TST_TOTAL = 1;
-
-#ifndef EFD_SEMLIKE
-#define EFD_SEMLIKE (1 << 0)
-#endif
-
-/* Dummy function as syscall from linux_syscall_numbers.h uses cleanup(). */
-void cleanup(void)
-{
-}
-
-static int eventfd2(int count, int flags)
-{
-	return tst_syscall(__NR_eventfd2, count, flags);
-}
+#include <sys/eventfd.h>
+#include "tst_test.h"
+#include "eventfd2.h"
 
 static void xsem_wait(int fd)
 {
 	u_int64_t cntr;
 
-	if (read(fd, &cntr, sizeof(cntr)) != sizeof(cntr)) {
-		perror("reading eventfd");
-		exit(1);
-	}
-	fprintf(stdout, "[%u] wait completed on %d: count=%" PRIu64 "\n",
-		getpid(), fd, cntr);
+	SAFE_READ(0, fd, &cntr, sizeof(cntr));
 }
 
 static void xsem_post(int fd, int count)
 {
 	u_int64_t cntr = count;
 
-	if (write(fd, &cntr, sizeof(cntr)) != sizeof(cntr)) {
-		perror("writing eventfd");
-		exit(1);
-	}
+	SAFE_WRITE(0, fd, &cntr, sizeof(cntr));
 }
 
 static void sem_player(int fd1, int fd2)
 {
-	fprintf(stdout, "[%u] posting 1 on %d\n", getpid(), fd1);
-	xsem_post(fd1, 1);
+	pid_t pid = getpid();
 
-	fprintf(stdout, "[%u] waiting on %d\n", getpid(), fd2);
-	xsem_wait(fd2);
-
-	fprintf(stdout, "[%u] posting 1 on %d\n", getpid(), fd1);
+	tst_res(TINFO, "[%u] posting 1 on fd=%d", pid, fd1);
 	xsem_post(fd1, 1);
 
-	fprintf(stdout, "[%u] waiting on %d\n", getpid(), fd2);
+	tst_res(TINFO, "[%u] waiting on fd=%d", pid, fd2);
 	xsem_wait(fd2);
 
-	fprintf(stdout, "[%u] posting 5 on %d\n", getpid(), fd1);
+	tst_res(TINFO, "[%u] posting 5 on fd=%d", pid, fd1);
 	xsem_post(fd1, 5);
 
-	fprintf(stdout, "[%u] waiting 5 times on %d\n", getpid(), fd2);
+	tst_res(TINFO, "[%u] waiting 5 times on fd=%d", pid, fd2);
 	xsem_wait(fd2);
 	xsem_wait(fd2);
 	xsem_wait(fd2);
 	xsem_wait(fd2);
 	xsem_wait(fd2);
-}
 
-static void usage(char const *prg)
-{
-	fprintf(stderr, "use: %s [-h]\n", prg);
+	tst_res(TPASS, "[%u] received all events", pid);
 }
 
-int main(int argc, char **argv)
+static void run(void)
 {
-	int c, fd1, fd2, status;
 	pid_t cpid_poster, cpid_waiter;
+	int fd1, fd2;
 
-	while ((c = getopt(argc, argv, "h")) != -1) {
-		switch (c) {
-		default:
-			usage(argv[0]);
-			return 1;
-		}
-	}
-	if ((fd1 = eventfd2(0, EFD_SEMLIKE)) == -1 ||
-	    (fd2 = eventfd2(0, EFD_SEMLIKE)) == -1) {
-		perror("eventfd2");
-		return 1;
-	}
-	if ((cpid_poster = fork()) == 0) {
+	fd1 = eventfd2(0, EFD_SEMAPHORE);
+	fd2 = eventfd2(0, EFD_SEMAPHORE);
+
+	cpid_poster = SAFE_FORK();
+	if (!cpid_poster) {
 		sem_player(fd1, fd2);
 		exit(0);
 	}
-	if ((cpid_waiter = fork()) == 0) {
+
+	cpid_waiter = SAFE_FORK();
+	if (!cpid_waiter) {
 		sem_player(fd2, fd1);
 		exit(0);
 	}
-	waitpid(cpid_poster, &status, 0);
-	waitpid(cpid_waiter, &status, 0);
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
