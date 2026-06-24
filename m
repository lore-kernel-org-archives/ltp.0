Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F07CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:22:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFEB43C01A4
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:22:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F07AF3E53C0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3289610009F7
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E9F87617C
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEtd+WyoiWA5de/wr89+zEKLrXimViJl/Xz4akvOuk4=;
 b=trQjLXnpqrfZGaoUXNWjouEEeDInV+Bn5pPeduUKGdxGJmL0I/FPlkKKg6y+D6O02lsucI
 B6GZlNKiMUDs+GYxKC3x+Rh1Xnq7bAuQgKa3RwK6mc4Jq1YZHCvBF0hmPhXXt4KT5FePqi
 WJeidCcA22PBZQuylzswSPHH0HMD3PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEtd+WyoiWA5de/wr89+zEKLrXimViJl/Xz4akvOuk4=;
 b=hnWSCR1rErOKllmCHwu1VBP025edEkQponx1b1I4jRfIvnldMPHkTxtu+QGEIAkZaGsFyN
 M6sZEw++n4Tl2iDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=trQjLXnp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hnWSCR1r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEtd+WyoiWA5de/wr89+zEKLrXimViJl/Xz4akvOuk4=;
 b=trQjLXnpqrfZGaoUXNWjouEEeDInV+Bn5pPeduUKGdxGJmL0I/FPlkKKg6y+D6O02lsucI
 B6GZlNKiMUDs+GYxKC3x+Rh1Xnq7bAuQgKa3RwK6mc4Jq1YZHCvBF0hmPhXXt4KT5FePqi
 WJeidCcA22PBZQuylzswSPHH0HMD3PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEtd+WyoiWA5de/wr89+zEKLrXimViJl/Xz4akvOuk4=;
 b=hnWSCR1rErOKllmCHwu1VBP025edEkQponx1b1I4jRfIvnldMPHkTxtu+QGEIAkZaGsFyN
 M6sZEw++n4Tl2iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F644779A8
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G6AoIg2hO2pmAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:59 +0200
Message-ID: <20260624091900.4107041-13-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E9F87617C
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/13] mem: vma03: Rewrite to the new test library
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

We also drop the __NR_mmap2 ifdef because the lapi/syscalls.h defines
the fallbacks to -1 when a syscall is not implemented on an achitecture,
so the macro is always defined.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/vma/vma03.c | 189 ++++++++++++-------------------
 1 file changed, 73 insertions(+), 116 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index da1f5be99..7694e7e9a 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -1,149 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Red Hat, Inc.
+ * Copyright (C) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * CVE-2011-2496 regression test.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
+ * Verify that :manpage:`mremap(2)` correctly rejects an expansion that
+ * would cause the page-offset (pgoff) inside the mapping to wrap around
+ * due to overflow.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * The normal :manpage:`mmap(2)` paths all prevent creating a mapping
+ * whose pgoff could wrap, but an expanding :manpage:`mremap(2)` was
+ * able to take a valid mapping and grow it past the wrap boundary.
  *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * The test uses :manpage:`mmap2(2)` to create a file-backed mapping at
+ * a pgoff near ``ULONG_MAX``, then attempts to double its size with
+ * :manpage:`mremap(2)`. The kernel must reject this with ``EINVAL``.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-/*
- * This is a reproducer for CVE-2011-2496.
- *
- * The normal mmap paths all avoid creating a mapping where the pgoff
- * inside the mapping could wrap around due to overflow.  However, an
- * expanding mremap() can take such a non-wrapping mapping and make it
- * bigger and cause a wrapping condition. There is also another case
- * where we expand mappings hiding in plain sight: the automatic stack
- * expansion.
- *
- * This program tries to remap a mapping with a new size that would
- * wrap pgoff. Notice that it only works on 32-bit arch for now.
+ * This test only runs on 32-bit systems with a 32-bit kernel because
+ * the overflow requires a 32-bit ``unsigned long`` address space.
  */
 
 #define _GNU_SOURCE
-#include "config.h"
-#include <sys/types.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/syscall.h>
-#include <errno.h>
-#include <fcntl.h>
 #include <limits.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
 
-#include "test.h"
-#include "tso_safe_macros.h"
-#include "tst_kernel.h"
+#include "tst_test.h"
 #include "lapi/abisize.h"
+#include "lapi/syscalls.h"
 
-char *TCID = "vma03";
-int TST_TOTAL = 1;
-
-#ifdef __NR_mmap2
 #define TESTFILE "testfile"
 
+static int fd = -1;
 static size_t pgsz;
-static int fd;
+static void *map = MAP_FAILED;
 
-static void *mmap2(void *addr, size_t length, int prot,
-		   int flags, int fd, off_t pgoffset);
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-	void *map, *remap;
-	off_t pgoff;
-
-	if (TST_ABI != 32 || tst_kernel_bits() != 32) {
-		tst_brkm(TCONF, NULL,
-			 "test is designed for 32-bit system only.");
-	}
+	if (TST_ABI != 32 || tst_kernel_bits() != 32)
+		tst_brk(TCONF, "test is designed for 32-bit systems only");
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	pgsz = sysconf(_SC_PAGE_SIZE);
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = SAFE_OPEN(NULL, TESTFILE, O_RDWR);
-
-		/*
-		 * The pgoff is counted in 4K units and must be page-aligned,
-		 * hence we must align it down to page_size/4096 in a case that
-		 * the system has page_size > 4K.
-		 */
-		pgoff = (ULONG_MAX - 1)&(~((pgsz-1)>>12));
-		map = mmap2(NULL, pgsz, PROT_READ | PROT_WRITE, MAP_PRIVATE,
-			    fd, pgoff);
-		if (map == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap2");
-
-		remap = mremap(map, pgsz, 2 * pgsz, 0);
-		if (remap == MAP_FAILED) {
-			if (errno == EINVAL)
-				tst_resm(TPASS, "mremap failed as expected.");
-			else
-				tst_resm(TFAIL | TERRNO, "mremap");
-			munmap(map, pgsz);
-		} else {
-			tst_resm(TFAIL, "mremap succeeded unexpectedly.");
-			munmap(remap, 2 * pgsz);
-		}
-
-		close(fd);
-	}
+	pgsz = getpagesize();
 
-	cleanup();
-	tst_exit();
+	SAFE_CREAT(TESTFILE, 0644);
 }
 
-static void *mmap2(void *addr, size_t length, int prot,
-		   int flags, int fd, off_t pgoffset)
+static void run(void)
 {
-	return (void *)syscall(SYS_mmap2, addr, length, prot,
-			       flags, fd, pgoffset);
-}
+	/*
+	 * pgoff is counted in 4K units, must be page-aligned, so
+	 * align down to page_size/4096 for systems with page_size > 4K.
+	 */
+	off_t pgoff = (ULONG_MAX - 1) & (~((pgsz - 1) >> 12));
 
-static void setup(void)
-{
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR);
+
+	map = (void *)tst_syscall(__NR_mmap2, NULL, pgsz,
+				  PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE, fd, pgoff);
+
+	if (map == MAP_FAILED) {
+		tst_brk(TBROK | TERRNO, "mmap2(%s, pgoff=%ld)",
+			TESTFILE, (long)pgoff);
+	}
+
+	void *remap = mremap(map, pgsz, 2 * pgsz, 0);
 
-	tst_tmpdir();
+	if (remap == MAP_FAILED) {
+		if (errno == EINVAL)
+			tst_res(TPASS, "mremap() failed with EINVAL as expected");
+		else
+			tst_res(TFAIL | TERRNO, "mremap() failed unexpectedly");
 
-	fd = SAFE_CREAT(NULL, TESTFILE, 0644);
-	close(fd);
+		SAFE_MUNMAP(map, pgsz);
+	} else {
+		tst_res(TFAIL, "mremap() succeeded unexpectedly");
+		SAFE_MUNMAP(remap, 2 * pgsz);
+	}
 
-	TEST_PAUSE;
+	map = MAP_FAILED;
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
-}
-#else /* __NR_mmap2 */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "__NR_mmap2 is not defined on your system");
+	if (map != MAP_FAILED)
+		SAFE_MUNMAP(map, pgsz);
+
+	if (fd != -1)
+		SAFE_CLOSE(fd);
 }
-#endif
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "982134ba6261"},
+		{"CVE", "2011-2496"},
+		{}
+	}
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
