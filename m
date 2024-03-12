Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D2CC54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 15:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5289B3D0614
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 16:13:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6EEE3CB2C6
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:13:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 965031400F83
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:13:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 897953781C;
 Tue, 12 Mar 2024 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710256405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t44nZhCZXZfcotqV8sF3FjjsPHGZTJmdJEJWUEEh/m0=;
 b=b4dJL/d0zpwCiqw2LZnUgMuYDAge20WTFcyAm5xYLSlUUJRFpYQuXtG7LBRuFNtqCExlYS
 UpCpi1jmdfznxlI7eHx3swmTcdJNWudHGvnpgasbv+qzVeG4wZwQ/+dPpNk0gwb2jOHctz
 7mBS18vfvLGUa3SKXkix9siIfySgcEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710256405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t44nZhCZXZfcotqV8sF3FjjsPHGZTJmdJEJWUEEh/m0=;
 b=/vzT2uRDUXgCAWU+vuV5ozZ8rrYQsyxrOVEg5PN9+HFtOPuv4M8jnK3mz4UdPRdRJQGm0k
 cjOiIiEPe+5dnZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710256405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t44nZhCZXZfcotqV8sF3FjjsPHGZTJmdJEJWUEEh/m0=;
 b=b4dJL/d0zpwCiqw2LZnUgMuYDAge20WTFcyAm5xYLSlUUJRFpYQuXtG7LBRuFNtqCExlYS
 UpCpi1jmdfznxlI7eHx3swmTcdJNWudHGvnpgasbv+qzVeG4wZwQ/+dPpNk0gwb2jOHctz
 7mBS18vfvLGUa3SKXkix9siIfySgcEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710256405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t44nZhCZXZfcotqV8sF3FjjsPHGZTJmdJEJWUEEh/m0=;
 b=/vzT2uRDUXgCAWU+vuV5ozZ8rrYQsyxrOVEg5PN9+HFtOPuv4M8jnK3mz4UdPRdRJQGm0k
 cjOiIiEPe+5dnZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54B7F1364F;
 Tue, 12 Mar 2024 15:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e3XlERVx8GWKMgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 12 Mar 2024 15:13:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Mar 2024 16:13:24 +0100
Message-Id: <20240312151324.13236-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="b4dJL/d0";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/vzT2uRD"
X-Spamd-Result: default: False [-1.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 897953781C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Refactor fork05 using new LTP API
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
modify_ldt_ldt_s struct has been replaced by user_desc after kernel 2.4 that
is not supported by LTP

 testcases/kernel/syscalls/fork/fork05.c | 243 ++++++++----------------
 1 file changed, 82 insertions(+), 161 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
index 9a99cff1d..a52bb481c 100644
--- a/testcases/kernel/syscalls/fork/fork05.c
+++ b/testcases/kernel/syscalls/fork/fork05.c
@@ -1,150 +1,86 @@
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
- *
- *    Linux Test Project - Silicon Graphics, Inc.
- *    TEST IDENTIFIER	: fork05
- *    EXECUTED BY	: anyone
- *    TEST TITLE	: Make sure LDT is propagated correctly
- *    TEST CASE TOTAL	: 1
- *    CPU TYPES		: i386
- *    AUTHORS		: Ulrich Drepper
- *			  Nate Straz
- *
- *On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
- *>Robert Williamson wrote:
- *>
- *>>   I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
- *>> you wrote (attached below).  The test passes on my 2.5.68 machine running
- *>> SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
- *>> RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
- *>> the assembly code....could you take a look at it?
- *>
- *>There is no need to look at it, I know it cannot work anymore on recent
- *>systems.  Either change all uses of %gs to %fs or skip the entire patch
- *>if %gs has a nonzero value.
- *>
- *>- --
- *>- --------------.                        ,-.            444 Castro Street
- *>Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
- *>Red Hat         `--' drepper at redhat.com `---------------------------
- *
+ *     Author: Ulrich Drepper / Nate Straz , Red Hat
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
  *
+ * This test verifies that LDT is propagated correctly from parent process to
+ * the child process.
  *
- *On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:
- *> Ever since the %gs handling was fixed in the 2.3.99 series the
- *> appended test program worked.  Now with 2.4.0-test6 it's not working
- *> again.  Looking briefly over the patch from test5 to test6 I haven't
- *> seen an immediate candidate for the breakage.  It could be missing
- *> propagation of the LDT to the new process (and therefore an invalid
- *> segment descriptor) or simply clearing %gs.
- *>
- *> Anyway, this is what you should see and what you get with test5:
- *>
- *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *> a = 42
- *> %gs = 0x0007
- *> %gs = 0x0007
- *> a = 99
- *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *>
- *> This is what you get with test6:
- *>
- *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *> a = 42
- *> %gs = 0x0007
- *> %gs = 0x0000
- *> <SEGFAULT>
- *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *>
- *> If somebody is actually creating a test suite for the kernel, please
- *> add this program.  It's mostly self-contained.  The correct handling
- *> of %gs is really important since glibc 2.2 will make heavy use of it.
- *>
- *> - --
- *> - ---------------.                          ,-.   1325 Chesapeake Terrace
- *> Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
- *> Red Hat          `--' drepper at redhat.com   `------------------------
- *>
- *> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
+ * >Robert Williamson wrote:
+ * >
+ * >>   I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
+ * >> you wrote (attached below).  The test passes on my 2.5.68 machine running
+ * >> SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
+ * >> RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
+ * >> the assembly code....could you take a look at it?
+ * >
+ * >There is no need to look at it, I know it cannot work anymore on recent
+ * >systems.  Either change all uses of %gs to %fs or skip the entire patch
+ * >if %gs has a nonzero value.
+ * >
+ * >- --
+ * >- --------------.                        ,-.            444 Castro Street
+ * >Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
+ * >Red Hat         `--' drepper at redhat.com `---------------------------
  *
+ * On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:
+ * > Ever since the %gs handling was fixed in the 2.3.99 series the
+ * > appended test program worked.  Now with 2.4.0-test6 it's not working
+ * > again.  Looking briefly over the patch from test5 to test6 I haven't
+ * > seen an immediate candidate for the breakage.  It could be missing
+ * > propagation of the LDT to the new process (and therefore an invalid
+ * > segment descriptor) or simply clearing %gs.
+ * >
+ * > Anyway, this is what you should see and what you get with test5:
+ * >
+ * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * > a = 42
+ * > %gs = 0x0007
+ * > %gs = 0x0007
+ * > a = 99
+ * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * >
+ * > This is what you get with test6:
+ * >
+ * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * > a = 42
+ * > %gs = 0x0007
+ * > %gs = 0x0000
+ * > <SEGFAULT>
+ * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * >
+ * > If somebody is actually creating a test suite for the kernel, please
+ * > add this program.  It's mostly self-contained.  The correct handling
+ * > of %gs is really important since glibc 2.2 will make heavy use of it.
+ * >
+ * > - --
+ * > - ---------------.                          ,-.   1325 Chesapeake Terrace
+ * > Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
+ * > Red Hat          `--' drepper at redhat.com   `------------------------
+ * >
+ * > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+static void run(void)
 {
-	tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
-}
-
-int main(void)
-{
-	struct modify_ldt_ldt_s ldt0;
+	struct user_desc ldt0;
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
@@ -154,49 +90,34 @@ int main(void)
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
