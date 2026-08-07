Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74DDC5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:19:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5728E3E7009
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:19:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04F883E7005
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F03BE600B99
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66A0D3E04;
 Fri,  7 Aug 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ME3lkt4wKWQgT9IQrL2ciaUQ7HfV3UCwDO+Vq4VQZIE=;
 b=eQls178mbG2b9oEXUOY+W5slPwT4CkPVc3KwldF60ZX0H/JZ9rEf2MSjnSp2nsHhgznE5n
 vq/73gRch3uwm39hyGZE/j/zhc1AD9XUnn63jf3YkLnUm9BDqWupUhz231PeE5MfU7TARR
 nvVgs5HcgON0XKJ0zhHM17LMtIy9CYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ME3lkt4wKWQgT9IQrL2ciaUQ7HfV3UCwDO+Vq4VQZIE=;
 b=XZfnWKCBdNAwF2X3x9+JT2+2HAXtPXSbOXddcsAy8E9IhpXfOzGLVDV9fFbF2qdq5hrHqM
 KP9tcHLXge7yxPCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ctUppHR1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TjglfWCg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ME3lkt4wKWQgT9IQrL2ciaUQ7HfV3UCwDO+Vq4VQZIE=;
 b=ctUppHR1rwxaJufLE0rLxWqukSdieq4/H/hF9RoirR5pwvBpNcJyusAzA7ckfCV09IfBgG
 a1AAMPbLncACXLpyXs3cKdiZFRO486EAXeIMT2SZLKxUhnU1CqwjmER4DM3l24hJbH58ZS
 +/iHtuva3o7cFczwwti4zpGfEU4YqqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ME3lkt4wKWQgT9IQrL2ciaUQ7HfV3UCwDO+Vq4VQZIE=;
 b=TjglfWCgtu8Pe1ksvxEEDEYXYht0A8RZB+h3AycAVu7I0ckhBXCWHdta/2kEHLoLxHIO+y
 6XTehPAthj1E+LDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A1C8779CD;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGTuFs7MdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:14 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-5-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=9668;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=whFmAln9cp/AQv2vNyMUhW4Lw0Sc4z6twdhoABVg92E=;
 b=HxAXmVu5W2eXNUU/VYDLSeP7ju9y7tGcZn8eZDkj4vM15HIKqgzcnb13HlEbhVmqqyX5/dD9n
 wlAdi+63CHQAPYabf63ANkimZpRx7+6W3Y1CMekat+F6BE1LaA/1aVj
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 66A0D3E04
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/7] mremap05: Convert to new API
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mremap/mremap05.c | 278 ++++++++--------------------
 1 file changed, 75 insertions(+), 203 deletions(-)

diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index 971cc8e5e..4e906a044 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -1,239 +1,111 @@
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
+ * Verify the behavior of the ``MREMAP_FIXED`` flag of :manpage:`mremap(2)`
+ * when invalid arguments are provided:
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
  */
 
 #define _GNU_SOURCE
-#include "config.h"
 #include <sys/mman.h>
-#include <errno.h>
-#include <unistd.h>
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
-	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED,
-	 .msg = "MREMAP_FIXED requires MREMAP_MAYMOVE",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup0,
-	 .cleanup = cleanup0},
-	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "new_addr has to be page aligned",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup1,
-	 .cleanup = cleanup0},
+	const char *msg;
+} tcases[] = {
 	{
-	 .old_size = 2,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "old/new area must not overlap",
-	 .exp_ret = MAP_FAILED,
-	 .exp_errno = EINVAL,
-	 .setup = setup2,
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
-	 .msg = "mremap #1",
-	 .setup = setup3,
-	 .cleanup = cleanup0},
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.align_offset = 1,
+		.exp_errno = EINVAL,
+		.msg = "new_addr has to be page aligned",
+	},
 	{
-	 .old_size = 1,
-	 .new_size = 1,
-	 .flags = MREMAP_FIXED | MREMAP_MAYMOVE,
-	 .msg = "mremap #2",
-	 .setup = setup4,
-	 .cleanup = cleanup1},
+		.old_pages = 2,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.overlap = 1,
+		.exp_errno = EINVAL,
+		.msg = "old/new area must not overlap",
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
-	if (free_area)
-		free_test_area(p, size);
-	return p;
-}
 
-static void test_mremap(struct test_case_t *t)
-{
-	t->ret = mremap(t->old_address, t->old_size, t->new_size, t->flags,
-			t->new_address);
+	p = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 
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
-}
-
-static void setup0(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 1);
-}
-
-static void setup1(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area((t->new_size + 1) * pagesize, 1) + 1;
-}
+	if (free_area)
+		SAFE_MUNMAP(p, size);
 
-static void setup2(struct test_case_t *t)
-{
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = t->old_address;
+	return p;
 }
 
-static void setup3(struct test_case_t *t)
+static void setup(void)
 {
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 1);
-	t->exp_ret = t->new_address;
-	*(t->old_address) = 0x1;
+	pagesize = getpagesize();
 }
 
-static void setup4(struct test_case_t *t)
+static void run(unsigned int n)
 {
-	t->old_address = get_test_area(t->old_size * pagesize, 0);
-	t->new_address = get_test_area(t->new_size * pagesize, 0);
-	t->exp_ret = t->new_address;
-	*(t->old_address) = 0x1;
-	*(t->new_address) = 0x2;
-}
+	struct tcase *tc = &tcases[n];
+	char *old_address;
+	char *new_address;
+	size_t old_size = tc->old_pages * pagesize;
+	size_t new_size = tc->new_pages * pagesize;
 
-static void cleanup0(struct test_case_t *t)
-{
-	if (t->ret == MAP_FAILED)
-		free_test_area(t->old_address, t->old_size * pagesize);
-	else
-		free_test_area(t->ret, t->new_size * pagesize);
-}
+	old_address = get_test_area(old_size, 0);
 
-static void cleanup1(struct test_case_t *t)
-{
-	if (t->ret == MAP_FAILED) {
-		free_test_area(t->old_address, t->old_size * pagesize);
-		free_test_area(t->new_address, t->new_size * pagesize);
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
-
-int main(int ac, char **av)
-{
-	int lc, testno;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; testno++) {
-			tdat[testno].setup(&tdat[testno]);
-			test_mremap(&tdat[testno]);
-			tdat[testno].cleanup(&tdat[testno]);
-		}
-	}
-	cleanup();
-	tst_exit();
-}
+	TST_EXP_FAIL_PTR_VOID(mremap(old_address, old_size, new_size,
+				     tc->flags, new_address),
+			      tc->exp_errno, "%s", tc->msg);
 
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
