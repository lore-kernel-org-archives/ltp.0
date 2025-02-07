Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B86BC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95EF43C93B5
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:51:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0780D3C9230
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5417420E590
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 400001F452
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq0JUkXNtgwPo9KmExPVxa7Rj+XgGjr9YnOeJD66sS4=;
 b=iqFqHV8aXt/VxxBeWOh0KgUFV4xcQBOQwdaZ5JX/p41qRdlfDDQ+NRo3eDZ5DQQoLqiR1e
 mm5yGRrYrBszu/j0S/5JEsHn2kzvqlcMci2DQ4v8YBt5nLmjYBtzrhWWWuOMsPi0tT4sXO
 QgvjNIZ85ANyNYQKOg0hnoy9fLI2XL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq0JUkXNtgwPo9KmExPVxa7Rj+XgGjr9YnOeJD66sS4=;
 b=57Gw0MspyHC3hYjWgaDkMCSrFtYiN5gSQekxDuY7Xg69Ndu1KIejfTDAmCQMLs5JR0R7Gp
 todSQM160sbZafDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq0JUkXNtgwPo9KmExPVxa7Rj+XgGjr9YnOeJD66sS4=;
 b=iqFqHV8aXt/VxxBeWOh0KgUFV4xcQBOQwdaZ5JX/p41qRdlfDDQ+NRo3eDZ5DQQoLqiR1e
 mm5yGRrYrBszu/j0S/5JEsHn2kzvqlcMci2DQ4v8YBt5nLmjYBtzrhWWWuOMsPi0tT4sXO
 QgvjNIZ85ANyNYQKOg0hnoy9fLI2XL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq0JUkXNtgwPo9KmExPVxa7Rj+XgGjr9YnOeJD66sS4=;
 b=57Gw0MspyHC3hYjWgaDkMCSrFtYiN5gSQekxDuY7Xg69Ndu1KIejfTDAmCQMLs5JR0R7Gp
 todSQM160sbZafDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27404139CB
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kAvfB7wdpmcdQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 14:50:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Feb 2025 15:50:31 +0100
MIME-Version: 1.0
Message-Id: <20250207-mmap_suite_refactoring-v1-2-d006d921e4d5@suse.com>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
In-Reply-To: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738939835; l=10526;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=SPCB1AZAS21gqTJzKYC0Vzs4Swlz+FP5Nb4MPjuF3/8=;
 b=/8UG+3Rg0OrU7GIwOOSH1+mnJ1Eyrda52XjNg1cbufjWI+YBQvvmXAZyDIayfueAVveuBARKB
 nxYnT2HuwV0DPRWfa20BveZuP0WIRUVroPQnoipYJjCQfgRqCZe9R+9
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] Refactor mmap10 test
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
 testcases/kernel/syscalls/mmap/mmap10.c | 261 +++++++++++---------------------
 1 file changed, 90 insertions(+), 171 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index b844af07fd78d69c5cf5afc3039a54685c982776..3d9f73abf1e8a453fe6137d588c0e7c1240d8ca7 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -1,206 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * mmap/munmap /dev/zero: a common way of malloc()/free() anonymous
- * memory on Solaris.
+/*\
+ * [Description]
+ *
+ * This test examines the functionality of mapping and unmapping /dev/zero,
+ * which is a common method for allocating anonymous memory in Solaris.
  *
- * The basic purpose of this is a to test if it is possible to map and
- * unmap /dev/zero, and to read and write the mapping. Being inspired
- * by two bugs in the past, the design of the test was added some
- * variations based on the reproducers for them. It also accept an
- * option to mmap/munmap anonymous pages.
+ * The primary objective is to determine whether it is possible to successfully
+ * map and unmap /dev/zero, as well as to read from and write to the mapped
+ * memory. The design of this test is inspired by two previous bugs,
+ * incorporating variations based on their reproducers. Additionally, the test
+ * accepts an option to mmap/munmap anonymous pages.
  *
- * One is to trigger panic with transparent hugepage feature that
- * split_huge_page is very strict in checking the rmap walk was
- * perfect. Keep it strict because if page_mapcount isn't stable and
- * just right, the __split_huge_page_refcount that follows the rmap
- * walk could lead to erratic page_count()s for the subpages. The bug
- * in fork lead to the rmap walk finding the parent huge-pmd twice
- * instead of just one, because the anon_vma_chain objects of the
- * child vma still point to the vma->vm_mm of the parent. That trips
- * on the split_huge_page mapcount vs page_mapcount check leading to a
- * BUG_ON.
+ * One of the bugs aims to trigger a panic related to the transparent hugepage
+ * feature. The split_huge_page function is particularly strict in verifying
+ * that the reverse mapping (rmap) walk is accurate. This strictness is crucial
+ * because if the page_mapcount is not stable or correct, the subsequent
+ * __split_huge_page_refcount operation could lead to inconsistent page_count()
+ * values for the subpages. A bug related to fork caused the rmap walk to find
+ * the parent huge-pmd twice instead of once, due to the anon_vma_chain objects
+ * of the child VMA still pointing to the parent's vma->vm_mm. This
+ * inconsistency triggers a failure in the split_huge_page mapcount versus
+ * page_mapcount check, resulting in a BUG_ON.
  *
- * The other bug is mmap() of /dev/zero results in calling map_zero()
- * which on RHEL5 maps the ZERO_PAGE in every PTE within that virtual
- * address range. Since the application which maps a region from 5M to
- * 16M in size is also multi-threaded the subsequent munmap() of
- * /dev/zero results is TLB shootdowns to all other CPUs. When this
- * happens thousands or millions of times the application performance
- * is terrible. The mapping ZERO_PAGE in every pte within that virtual
- * address range was an optimization to make the subsequent pagefault
- * times faster on RHEL5 that has been removed/changed upstream.
+ * The second bug involves the mmap() operation on /dev/zero, which invokes
+ * map_zero(). On RHEL5, this function maps the ZERO_PAGE into every page table
+ * entry (PTE) within the specified virtual address range. When an application
+ * maps a region from 5M to 16M and operates in a multi-threaded environment,
+ * the subsequent munmap() of /dev/zero leads to TLB shootdowns across all CPUs.
+ * When this occurs thousands or millions of times, it severely degrades
+ * application performance. The optimization of mapping the ZERO_PAGE in every
+ * PTE within that virtual address range was intended to enhance page fault
+ * handling times on RHEL5 but has since been modified or removed in upstream
+ * versions.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include "test.h"
-#include "config.h"
-
-#define SIZE (5*1024*1024)
-#define PATH_KSM "/sys/kernel/mm/ksm/"
-
-char *TCID = "mmap10";
-int TST_TOTAL = 1;
-
-static int fd, opt_anon, opt_ksm;
-static long ps;
-static char *x;
-
-void setup(void);
-void cleanup(void);
-void mmapzero(void);
-void help(void);
-
-static option_t options[] = {
-	{"a", &opt_anon, NULL},
-	{"s", &opt_ksm, NULL},
-	{NULL, NULL, NULL}
-};
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, options, help);
-
-	if (opt_ksm) {
-		if (access(PATH_KSM, F_OK) == -1)
-			tst_brkm(TCONF, NULL,
-				 "KSM configuration is not enabled");
-#ifdef HAVE_DECL_MADV_MERGEABLE
-		tst_resm(TINFO, "add to KSM regions.");
-#else
-		tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
-#endif
-	}
-	if (opt_anon)
-		tst_resm(TINFO, "use anonymous pages.");
-	else
-		tst_resm(TINFO, "use /dev/zero.");
 
-	setup();
+#include "tst_test.h"
 
-	tst_resm(TINFO, "start tests.");
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		mmapzero();
-	}
+#define SIZE (5 * TST_MB)
+#define PATH_KSM "/sys/kernel/mm/ksm/"
 
-	cleanup();
-	tst_exit();
-}
+static char *opt_ksm;
+static char *opt_anon;
+static size_t page_sz;
+static char *memory;
 
-void mmapzero(void)
+static void run(void)
 {
-	int n;
+	int fd = -1;
 
 	if (opt_anon) {
-		x = mmap(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		memory = SAFE_MMAP(NULL, SIZE + SIZE - page_sz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	} else {
-		if ((fd = open("/dev/zero", O_RDWR, 0666)) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "open");
-		x = mmap(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE, fd, 0);
+		fd = SAFE_OPEN("/dev/zero", O_RDWR, 0666);
+
+		memory = SAFE_MMAP(NULL, SIZE + SIZE - page_sz,
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE, fd, 0);
 	}
-	if (x == MAP_FAILED)
-		tst_brkm(TFAIL | TERRNO, cleanup, "mmap");
+
 #ifdef HAVE_DECL_MADV_MERGEABLE
 	if (opt_ksm) {
-		if (madvise(x, SIZE + SIZE - ps, MADV_MERGEABLE) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "madvise");
+		if (madvise(memory, SIZE + SIZE - page_sz, MADV_MERGEABLE) == -1)
+			tst_brk(TBROK | TERRNO, "madvise error");
 	}
 #endif
-	x[SIZE] = 0;
-
-	switch (n = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup, "munmap");
-		exit(0);
-	default:
-		break;
-	}
 
-	switch (n = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "subsequent munmap #1");
-		exit(0);
-	default:
-		switch (n = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		case 0:
-			if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "subsequent munmap #2");
+	memory[SIZE] = 0;
+
+	for (int i = 0; i < 3; i++) {
+		if (!SAFE_FORK()) {
+			SAFE_MUNMAP(memory + SIZE + page_sz, SIZE - page_sz * 2);
 			exit(0);
-		default:
-			break;
 		}
-		break;
 	}
 
-	if (munmap(x, SIZE + SIZE - ps) == -1)
-		tst_resm(TFAIL | TERRNO, "munmap all");
+	SAFE_MUNMAP(memory, SIZE + SIZE - page_sz);
 
-	while (waitpid(-1, &n, WUNTRACED | WCONTINUED) > 0)
-		if (WEXITSTATUS(n) != 0)
-			tst_resm(TFAIL, "child exit status is %d",
-				 WEXITSTATUS(n));
-}
+	tst_reap_children();
 
-void cleanup(void)
-{
+	tst_res(TPASS, "All memory has been released");
+
+	if (fd != -1)
+		SAFE_CLOSE(fd);
 }
 
-void setup(void)
+static void setup(void)
 {
-	tst_require_root();
+	if (opt_ksm) {
+		if (access(PATH_KSM, F_OK) == -1)
+			tst_brk(TCONF, "KSM configuration is not enabled");
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+#ifdef HAVE_DECL_MADV_MERGEABLE
+		tst_res(TINFO, "Add to KSM regions");
+#else
+		tst_brk(TCONF, "MADV_MERGEABLE missing in sys/mman.h");
+#endif
+	}
 
-	if ((ps = sysconf(_SC_PAGESIZE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "sysconf(_SC_PAGESIZE)");
-}
+	if (opt_anon)
+		tst_res(TINFO, "Use anonymous pages");
+	else
+		tst_res(TINFO, "Use /dev/zero device");
 
-void help(void)
-{
-	printf("  -a      Test anonymous pages\n");
-	printf("  -s      Add to KSM regions\n");
+	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"a", &opt_anon, "Test anonymous pages"},
+		{"s", &opt_ksm, "Add to KSM regions"},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
