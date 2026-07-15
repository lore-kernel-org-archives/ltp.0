Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4A1C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63BC83E5691
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:40:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C36E43E76D3
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35355600157
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 550C23DFE;
 Wed, 15 Jul 2026 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUrHH9A6JFr6wk3MRpJei/ayoaULGmx6AlH2IkJRXas=;
 b=P0mXEsCrktGZTMjnHmX0Cyrk4u4HK9GxyHsQSGEXZ+VsbC8MkMIpkCe5IgB2qDvzFjgfGW
 ooGrLQCC1qjO+saM3acaCl+hts+2GAe6OkVQJBg17v8Gm0ZFnTWYrNDRwnLnxsKRlb3XNu
 H9J5EXoOKw9Es0PdLuDwNTh4feW5jZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUrHH9A6JFr6wk3MRpJei/ayoaULGmx6AlH2IkJRXas=;
 b=BZg5Lr9vlpzkyGt0Q63/5XaEn/4qkOcs7F5R1VHe+B8MTFkim+3vWBhEUG3osDCd7cKYgd
 LztUVGCFVLYJ1BAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P0mXEsCr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BZg5Lr9v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUrHH9A6JFr6wk3MRpJei/ayoaULGmx6AlH2IkJRXas=;
 b=P0mXEsCrktGZTMjnHmX0Cyrk4u4HK9GxyHsQSGEXZ+VsbC8MkMIpkCe5IgB2qDvzFjgfGW
 ooGrLQCC1qjO+saM3acaCl+hts+2GAe6OkVQJBg17v8Gm0ZFnTWYrNDRwnLnxsKRlb3XNu
 H9J5EXoOKw9Es0PdLuDwNTh4feW5jZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUrHH9A6JFr6wk3MRpJei/ayoaULGmx6AlH2IkJRXas=;
 b=BZg5Lr9vlpzkyGt0Q63/5XaEn/4qkOcs7F5R1VHe+B8MTFkim+3vWBhEUG3osDCd7cKYgd
 LztUVGCFVLYJ1BAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AA0D779AD;
 Wed, 15 Jul 2026 11:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mEebDHNxV2qHIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 Jul 2026 11:39:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 15 Jul 2026 13:39:27 +0200
MIME-Version: 1.0
Message-Id: <20260715-hugemmap35-v1-2-1d5911d1f2cf@suse.com>
References: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
In-Reply-To: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115570; l=4345;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=y7yFquqaY85XbAyNgo1BhOUoM7EqlUo+uJJwbymZX6M=;
 b=lLxDCsj9oJGOEia7Cwt4oSBjQuvHgrDAQSFlwK2r+OPk6iFcellafmkSDcPvFSnah8wTWOHYV
 zVbDlnXdOB3AnyXGZj1M87McPaaGz5wuh1bMi6N9gdpzG12Ukwrdzqd
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 550C23DFE
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] hugemmap35: add regression test for 49ccf2c3cafb
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

Add a regression test verifying that a hugetlbfs file can be mapped
with PROT_MTE even when MAP_HUGETLB is not set in the mmap() flags.

Before the referenced commit, VM_MTE_ALLOWED was not set early enough
for hugetlbfs file mappings, so such an mmap() was wrongly rejected.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/hugetlb                                    |   1 +
 testcases/kernel/mem/.gitignore                    |   1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c | 105 +++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c941f068628f53c31197b293906c4ecba6..8ee0e6f828cb1954e03d67d40fe691d6521361bf 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap35 hugemmap35
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51d6d6a9cc3d8b7ff392fc3ea9e95890a..0e59035dfdcf759aa16c069575bb1f4eb58f321c 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap35
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
new file mode 100644
index 0000000000000000000000000000000000000000..1c11013e0de6b6dd870e3ffc48562912a44cf7f7
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test that :manpage:`mmap(2)` accepts ``PROT_MTE`` for hugetlbfs file
+ * mappings that do not specify ``MAP_HUGETLB``.
+ *
+ * On arm64, hugetlbfs file mappings must get ``VM_MTE_ALLOWED`` before mmap
+ * flag validation. This is needed because mapping a hugetlbfs file does not
+ * have to use ``MAP_HUGETLB``. The test needs root to reserve huge pages and
+ * mount hugetlbfs.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "hugetlb.h"
+#include "lapi/mman.h"
+#include "lapi/mmap.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static int fd = -1;
+static long hpage_size;
+
+#define TC(x) {x, #x}
+
+static struct tcase {
+	int flags;
+	const char *desc;
+} tcases[] = {
+	TC(MAP_SHARED),
+	TC(MAP_PRIVATE),
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	volatile char *ptr;
+
+	TESTPTR(mmap(NULL, hpage_size, PROT_READ | PROT_WRITE | PROT_MTE,
+		     tc->flags, fd, 0));
+
+	if (TST_RET_PTR == MAP_FAILED) {
+		if (TST_ERR == ENOMEM)
+			tst_brk(TCONF, "Not enough huge pages");
+
+		tst_res(TFAIL | TTERRNO, "mmap(PROT_MTE, %s) without MAP_HUGETLB failed",
+			tc->desc);
+		return;
+	}
+
+	ptr = TST_RET_PTR;
+	*ptr = 1;
+
+	SAFE_MUNMAP(TST_RET_PTR, hpage_size);
+
+	tst_res(TPASS, "mmap(PROT_MTE, %s) without MAP_HUGETLB passed", tc->desc);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	if (!hpage_size)
+		tst_brk(TCONF, "Huge pages are not supported");
+
+	TESTPTR(mmap(NULL, hpage_size, PROT_READ | PROT_MTE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0));
+
+	if (TST_RET_PTR == MAP_FAILED)
+		tst_brk(TCONF | TTERRNO, "PROT_MTE is not supported with MAP_HUGETLB");
+
+	SAFE_MUNMAP(TST_RET_PTR, hpage_size);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	SAFE_FTRUNCATE(fd, hpage_size);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.hugepages = { 2, TST_NEEDS },
+	.supported_archs = (const char *const []) {
+		"aarch64",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "49ccf2c3cafb"},
+		{}
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
