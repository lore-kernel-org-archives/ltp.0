Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B97EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:00:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77323CCCE0
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:00:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C1DE3CB589
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:00:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F29706013D4
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:00:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 048DA1F8AA;
 Thu,  7 Sep 2023 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694080842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zAp9XATHc16H0cdePZ6gmf4f72zKNi8BpQhUF1PFhkQ=;
 b=iNHJOo+6sgCYP9cb6Ne3/yYmGSI7b4r47a1rmLmADg/LJGzw6UcSnxszCPyeFtPzwfoafL
 7ofkuJeu9fazXrz2T8Q+ZDAgh27HHVg6Ca9Ndt2AG1kPRwozWuv0zjF+5TqpbOg5UYWSmd
 u5SS7RuDy7L9izaCPbK7qFBfq8TmMPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694080842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zAp9XATHc16H0cdePZ6gmf4f72zKNi8BpQhUF1PFhkQ=;
 b=kR3ExJULKHEsjsW/ZcuLPh8Qq+qIrpsowanqXmpO2w+B5ybpDGf6qtAKCwAbK49zQP5v5P
 2m/xW3jOSCGuGUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F2D138F9;
 Thu,  7 Sep 2023 10:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +KWJM0mf+WTLSgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Sep 2023 10:00:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 12:00:41 +0200
Message-Id: <20230907100041.22406-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor fork05 using new LTP API
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
 testcases/kernel/syscalls/fork/fork05.c | 133 +++++-------------------
 1 file changed, 28 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
index 9a99cff1d..bf146d32a 100644
--- a/testcases/kernel/syscalls/fork/fork05.c
+++ b/testcases/kernel/syscalls/fork/fork05.c
@@ -1,44 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * Portions Copyright (c) 2000 Ulrich Drepper
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com$
- *
- * For further information regarding this notice, see:$
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * Author: Ulrich Drepper / Nate Straz , Red Hat
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
- *    Linux Test Project - Silicon Graphics, Inc.
- *    TEST IDENTIFIER	: fork05
- *    EXECUTED BY	: anyone
- *    TEST TITLE	: Make sure LDT is propagated correctly
- *    TEST CASE TOTAL	: 1
- *    CPU TYPES		: i386
- *    AUTHORS		: Ulrich Drepper
- *			  Nate Straz
+ * This test verifies that LDT is propagated correctly from parent process to
+ * the child process.
  *
  *On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
  *>Robert Williamson wrote:
@@ -96,55 +67,22 @@
  *> Red Hat          `--' drepper at redhat.com   `------------------------
  *>
  *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
  */
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <sys/wait.h>
+#include <asm/ldt.h>
 #include "lapi/syscalls.h"
-#include "test.h"
-
-char *TCID = "fork05";
-
-static char *environ_list[] = { "TERM", "NoTSetzWq", "TESTPROG" };
-
-#define NUMBER_OF_ENVIRON (sizeof(environ_list)/sizeof(char *))
-int TST_TOTAL = NUMBER_OF_ENVIRON;
+#include "tst_test.h"
 
 #if defined(linux) && defined(__i386__)
 
-struct modify_ldt_ldt_s {
-	unsigned int entry_number;
-	unsigned long int base_addr;
-	unsigned int limit;
-	unsigned int seg_32bit:1;
-	unsigned int contents:2;
-	unsigned int read_exec_only:1;
-	unsigned int limit_in_pages:1;
-	unsigned int seg_not_present:1;
-	unsigned int useable:1;
-	unsigned int empty:25;
-};
-
-static int a = 42;
-
-static void modify_ldt(int func, struct modify_ldt_ldt_s *ptr, int bytecount)
-{
-	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
-}
-
-int main(void)
+static void run(void)
 {
 	struct modify_ldt_ldt_s ldt0;
+	int base_addr = 42;
 	int lo;
-	pid_t pid;
-	int res;
 
 	ldt0.entry_number = 0;
-	ldt0.base_addr = (long)&a;
+	ldt0.base_addr = (long)&base_addr;
 	ldt0.limit = 4;
 	ldt0.seg_32bit = 1;
 	ldt0.contents = 0;
@@ -154,49 +92,34 @@ int main(void)
 	ldt0.useable = 1;
 	ldt0.empty = 0;
 
-	modify_ldt(1, &ldt0, sizeof(ldt0));
+	tst_syscall(__NR_modify_ldt, 1, &ldt0, sizeof(ldt0));
 
 	asm volatile ("movw %w0, %%fs"::"q" (7));
-
 	asm volatile ("movl %%fs:0, %0":"=r" (lo));
-	tst_resm(TINFO, "a = %d", lo);
+	tst_res(TINFO, "a = %d", lo);
 
 	asm volatile ("pushl %%fs; popl %0":"=q" (lo));
-	tst_resm(TINFO, "%%fs = %#06hx", lo);
+	tst_res(TINFO, "%%fs = %#06hx", lo);
 
 	asm volatile ("movl %0, %%fs:0"::"r" (99));
 
-	pid = fork();
-
-	if (pid == 0) {
+	if (!SAFE_FORK()) {
 		asm volatile ("pushl %%fs; popl %0":"=q" (lo));
-		tst_resm(TINFO, "%%fs = %#06hx", lo);
+		tst_res(TINFO, "%%fs = %#06hx", lo);
 
 		asm volatile ("movl %%fs:0, %0":"=r" (lo));
-		tst_resm(TINFO, "a = %d", lo);
+		tst_res(TINFO, "a = %d", lo);
+
+		TST_EXP_EQ_LI(lo, 99);
 
-		if (lo != 99)
-			tst_resm(TFAIL, "Test failed");
-		else
-			tst_resm(TPASS, "Test passed");
 		exit(lo != 99);
-	} else {
-		waitpid(pid, &res, 0);
 	}
-
-	return WIFSIGNALED(res);
 }
 
-#else /* if defined(linux) && defined(__i386__) */
-
-int main(void)
-{
-	tst_resm(TINFO, "%%fs test only for ix86");
-
-	/*
-	 * should be successful on all non-ix86 platforms.
-	 */
-	tst_exit();
-}
+static struct tst_test test = {
+	.run_all = run
+};
 
-#endif /* if defined(linux) && defined(__i386__) */
+#else /* defined(linux) && defined(__i386__) */
+	TST_TEST_TCONF("Test only supports linux 32 bits");
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
