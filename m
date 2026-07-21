Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1611C4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22E1B3D227C
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:42:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A7A33E210B
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8364E1400744
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B33D3E23;
 Tue, 21 Jul 2026 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYj7qgIs1PmR4aQ5jDc3r/UfTyuKpTZx8EvLaLMgUJo=;
 b=ie6d8giKyyL8FN7cC4G3DV7zE7b/zsNo0a8pcTdr+f9/ocks0re/Kawkxe9BKRJFAiryIi
 jA6+tijNCX3ursbhMsLMY5FSAFowRNk7beXK3HTJaUaMlom2pDSKgeJUJaOznWz+bRJcjG
 czim4QqcWPFR6RBMHlwzDoK+DAGOdf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYj7qgIs1PmR4aQ5jDc3r/UfTyuKpTZx8EvLaLMgUJo=;
 b=6rPlsfwk807pUMZ2X1V4NYkATRXpJZU5Ud/738hKVRCCBrQIuMjc7qz8h73xuS/HmbkoB0
 BhRp9uw5WhbcXtCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYj7qgIs1PmR4aQ5jDc3r/UfTyuKpTZx8EvLaLMgUJo=;
 b=ie6d8giKyyL8FN7cC4G3DV7zE7b/zsNo0a8pcTdr+f9/ocks0re/Kawkxe9BKRJFAiryIi
 jA6+tijNCX3ursbhMsLMY5FSAFowRNk7beXK3HTJaUaMlom2pDSKgeJUJaOznWz+bRJcjG
 czim4QqcWPFR6RBMHlwzDoK+DAGOdf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYj7qgIs1PmR4aQ5jDc3r/UfTyuKpTZx8EvLaLMgUJo=;
 b=6rPlsfwk807pUMZ2X1V4NYkATRXpJZU5Ud/738hKVRCCBrQIuMjc7qz8h73xuS/HmbkoB0
 BhRp9uw5WhbcXtCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C68779AB;
 Tue, 21 Jul 2026 12:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OfxNd9oX2plWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Jul 2026 12:41:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:41:05 +0200
MIME-Version: 1.0
Message-Id: <20260721-rewrite_mremap_testing_suite-v1-5-ec2c3cff6ea4@suse.com>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784637662; l=11895;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rMsJzwXpvtWrDu1B89sbKFCzr1LAMsf39lIKj/vmdog=;
 b=Ptc5A1CClt2wcqr8UX5p1H2zJhVA2JSm/0GwTRMV36y11mxWIjFBaZ3NmvKiXQzDLPMAZqwN+
 PySsiAc7TcMBdx7jMKIh6ZGwJUEIhQ+1JegcvBEnly1tyjtHx0hKDvw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] mremap05: Convert to new API
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

Convert the mremap05 test case from the legacy LTP API to the new
tst_test API.

Rewrite the test as a data-only struct tcase array with a single
run() handler, replacing the old function-pointer setup/cleanup
dispatch table. Use TST_EXP_FAIL_PTR_VOID() to verify that
mremap(MREMAP_FIXED) fails with EINVAL when MREMAP_MAYMOVE is not
set, when the target address is not page aligned, and when the old
and new ranges overlap. For the two successful-move cases, verify
both that mremap() returns the requested fixed address and that the
mapping's content is preserved across the move, including when the
target address was already mapped (proving the previous mapping
there is silently unmapped and replaced).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/mremap05.c | 315 +++++++++++-----------------
 1 file changed, 127 insertions(+), 188 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index 971cc8e5ee52c9a489782e3734178f59cd7e4a3c..3ccbda75a01ec1943ff92236767a85850e2f77df 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -1,239 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Linux Test Project, Inc.
- *
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
+ * Copyright (c) 2026 Linux Test Project
  */
-/*
- * Test Name: mremap05
+
+/*\
+ * Verify the behavior of the ``MREMAP_FIXED`` flag of :manpage:`mremap(2)`:
  *
- * Test Description:
- *  Verify that MREMAP_FIXED fails without MREMAP_MAYMOVE.
- *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if target address
- *    is not page aligned.
- *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if old range
- *    overlaps with new range.
- *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE can move mapping to new address.
- *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE unmaps previous mapping
- *    at the address range specified by new_address and new_size.
+ * - ``MREMAP_FIXED`` fails with ``EINVAL`` without ``MREMAP_MAYMOVE``.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` fails with ``EINVAL`` if the target
+ *   address is not page aligned.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` fails with ``EINVAL`` if the old range
+ *   overlaps with the new range.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` can move a mapping to a new, free
+ *   address, preserving its content.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` unmaps a previously existing mapping at
+ *   the target address range and replaces it with the moved mapping.
  */
 
 #define _GNU_SOURCE
-#include "config.h"
 #include <sys/mman.h>
 #include <errno.h>
 #include <unistd.h>
-#include "test.h"
-#include "tso_safe_macros.h"
+#include "tst_test.h"
 
-char *TCID = "mremap05";
+static int pagesize;
 
-struct test_case_t {
-	char *old_address;
-	char *new_address;
-	size_t old_size;	/* in pages */
-	size_t new_size;	/* in pages */
+static struct tcase {
+	size_t old_pages;
+	size_t new_pages;
 	int flags;
-	const char *msg;
-	void *exp_ret;
+	int align_offset;
+	int overlap;
+	int free_dst;
+	int expect_move;
 	int exp_errno;
-	char *ret;
-	void (*setup) (struct test_case_t *);
-	void (*cleanup) (struct test_case_t *);
-};
-
-static void setup(void);
-static void cleanup(void);
-static void setup0(struct test_case_t *);
-static void setup1(struct test_case_t *);
-static void setup2(struct test_case_t *);
-static void setup3(struct test_case_t *);
-static void setup4(struct test_case_t *);
-static void cleanup0(struct test_case_t *);
-static void cleanup1(struct test_case_t *);
-
-struct test_case_t tdat[] = {
+	const char *msg;
+} tcases[] = {
 	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED,
-	 .msg = "MREMAP_FIXED requires MREMAP_MAYMOVE",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup0,
-	 .cleanup = cleanup0},
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED,
+		.free_dst = 1,
+		.exp_errno = EINVAL,
+		.msg = "MREMAP_FIXED requires MREMAP_MAYMOVE",
+	},
 	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "new_addr has to be page aligned",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup1,
-	 .cleanup = cleanup0},
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.align_offset = 1,
+		.exp_errno = EINVAL,
+		.msg = "new_addr has to be page aligned",
+	},
 	{
-	 .old_size = 2,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "old/new area must not overlap",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup2,
-	 .cleanup = cleanup0},
+		.old_pages = 2,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.overlap = 1,
+		.exp_errno = EINVAL,
+		.msg = "old/new area must not overlap",
+	},
 	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "mremap #1",
-	 .setup = setup3,
-	 .cleanup = cleanup0},
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 1,
+		.expect_move = 1,
+		.msg = "move mapping to free address",
+	},
 	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "mremap #2",
-	 .setup = setup4,
-	 .cleanup = cleanup1},
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 0,
+		.expect_move = 1,
+		.msg = "move mapping onto an occupied address",
+	},
 };
 
-static int pagesize;
-static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-static void free_test_area(void *p, int size)
-{
-	SAFE_MUNMAP(cleanup, p, size);
-}
-
-static void *get_test_area(int size, int free_area)
+static void *get_test_area(size_t size, int free_area)
 {
 	void *p;
-	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
-		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (p == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "get_test_area mmap");
+
+	p = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
 	if (free_area)
-		free_test_area(p, size);
+		SAFE_MUNMAP(p, size);
+
 	return p;
 }
 
-static void test_mremap(struct test_case_t *t)
+static void setup(void)
 {
-	t->ret = mremap(t->old_address, t->old_size, t->new_size, t->flags,
-			t->new_address);
-
-	if (t->ret == t->exp_ret) {
-		if (t->ret != MAP_FAILED) {
-			tst_resm(TPASS, "%s", t->msg);
-			if (*(t->ret) == 0x1)
-				tst_resm(TPASS, "%s value OK", t->msg);
-			else
-				tst_resm(TPASS, "%s value failed", t->msg);
-		} else {
-			if (errno == t->exp_errno)
-				tst_resm(TPASS, "%s", t->msg);
-			else
-				tst_resm(TFAIL | TERRNO, "%s", t->msg);
-		}
-	} else {
-		tst_resm(TFAIL, "%s ret: %p, expected: %p", t->msg,
-			 t->ret, t->exp_ret);
-	}
+	pagesize = getpagesize();
 }
 
-static void setup0(struct test_case_t *t)
+static void fill_pattern(char *addr, size_t pages)
 {
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 1);
-}
+	size_t i;
 
-static void setup1(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area((t->new_size + 1) * pagesize, 1) + 1;
+	for (i = 0; i < pages; i++)
+		addr[i * pagesize] = (char)(0x1 + i);
 }
 
-static void setup2(struct test_case_t *t)
+static int check_pattern(const char *msg, char *addr, size_t pages)
 {
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = t->old_address;
-}
+	size_t i;
 
-static void setup3(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 1);
-	t->exp_ret = t->new_address;
-	*(t->old_address) = 0x1;
-}
+	for (i = 0; i < pages; i++) {
+		char got = addr[i * pagesize];
+		char exp = (char)(0x1 + i);
 
-static void setup4(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 0);
-	t->exp_ret = t->new_address;
-	*(t->old_address) = 0x1;
-	*(t->new_address) = 0x2;
-}
+		if (got != exp) {
+			tst_res(TFAIL, "%s: page %zu content 0x%x, expected 0x%x",
+				msg, i, (unsigned char)got, (unsigned char)exp);
+			return 1;
+		}
+	}
 
-static void cleanup0(struct test_case_t *t)
-{
-	if (t->ret == MAP_FAILED)
-		free_test_area(t->old_address, t->old_size * pagesize);
-	else
-		free_test_area(t->ret, t->new_size * pagesize);
+	return 0;
 }
 
-static void cleanup1(struct test_case_t *t)
+static void run(unsigned int n)
 {
-	if (t->ret == MAP_FAILED) {
-		free_test_area(t->old_address, t->old_size * pagesize);
-		free_test_area(t->new_address, t->new_size * pagesize);
+	struct tcase *tc = &tcases[n];
+	char *old_address;
+	char *new_address;
+	char *ret;
+	size_t old_size = tc->old_pages * pagesize;
+	size_t new_size = tc->new_pages * pagesize;
+
+	old_address = get_test_area(old_size, 0);
+
+	if (tc->overlap) {
+		new_address = old_address;
+	} else if (tc->align_offset) {
+		new_address = get_test_area(new_size + pagesize, 1) +
+			tc->align_offset;
 	} else {
-		free_test_area(t->ret, t->new_size * pagesize);
+		new_address = get_test_area(new_size, tc->free_dst);
 	}
-}
 
-int main(int ac, char **av)
-{
-	int lc, testno;
+	if (tc->expect_move) {
+		fill_pattern(old_address, tc->old_pages);
+
+		if (!tc->free_dst)
+			*new_address = 0x7f;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+		TESTPTR(mremap(old_address, old_size, new_size, tc->flags,
+			       new_address));
+		ret = TST_RET_PTR;
 
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; testno++) {
-			tdat[testno].setup(&tdat[testno]);
-			test_mremap(&tdat[testno]);
-			tdat[testno].cleanup(&tdat[testno]);
+		if (ret != new_address) {
+			tst_res(TFAIL, "%s: ret %p, expected %p",
+				tc->msg, ret, new_address);
+		} else if (check_pattern(tc->msg, ret, tc->new_pages) == 0) {
+			tst_res(TPASS, "%s", tc->msg);
 		}
+	} else {
+		TST_EXP_FAIL_PTR_VOID(mremap(old_address, old_size, new_size,
+					     tc->flags, new_address),
+				      tc->exp_errno, "%s", tc->msg);
 	}
-	cleanup();
-	tst_exit();
-}
 
-static void setup(void)
-{
-	pagesize = getpagesize();
+	if (TST_RET_PTR == MAP_FAILED)
+		SAFE_MUNMAP(old_address, old_size);
+	else
+		SAFE_MUNMAP(TST_RET_PTR, new_size);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
