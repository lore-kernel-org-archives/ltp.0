Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B59C88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 056EA3E9211
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:30:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D7B3E920E
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53987200AD3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A087C1FF02;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DT68rvTHdqjGzlPAoHoSOSCKWWOkPZzPLMYtQupTlA=;
 b=kwWWAvId+pzlmjJDYFV5PK+jD0Q6FXTCZ01iQyIqyCNhn//GmdkU8xOIqcGJbBInq+mGpr
 etTMw8rW/bM9NALrap/7ayx7un/kAd09zAR+L/e1m56FYqgbaVHEk+gO9ImnluQYX2j+J6
 K8nzTMILcb+KjSLVw21y/9i6tZQRz5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DT68rvTHdqjGzlPAoHoSOSCKWWOkPZzPLMYtQupTlA=;
 b=4cft+w4r3f+nTDfGNzhUSpAHrn7yzh56QT2azlSPbYHf+dg4FUQAqkLYr66ndPDrWrj4As
 UTHDZp64PkS190DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DT68rvTHdqjGzlPAoHoSOSCKWWOkPZzPLMYtQupTlA=;
 b=v+GDb760VUu1hXCsPG/pw0YPNl7pU8ZiRCAF2gR+aubqGmqaH0FFCWZqjDZNc6wNbMX8qH
 63dA1Mmmxombcum+qfKcs+I1jyGIvqSH0X364g8BIUtvlLKp5yVkd5pBpSlDDNVUh0QjU3
 qFPxfDqLNfBu0mBpET52Ke1vN80r+c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DT68rvTHdqjGzlPAoHoSOSCKWWOkPZzPLMYtQupTlA=;
 b=pnEU+LnZSGafB2gKtXk32M7mLbScg4i+Py4PUXteXzc66KzFbj3eBrSBeeGWm8Ul6pNNt/
 5GNnn1bMVT9CQDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DBB713794;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPglFXQepGoNOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 15:29:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:29:55 +0200
MIME-Version: 1.0
Message-Id: <20260911-mmap_32bit_coverage-v3-3-b0608349556d@suse.com>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
In-Reply-To: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789140595; l=4408;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pMxTokLqETS+TkZwxlQ2kL0oGOpAEpcuHBl3RvuTKJo=;
 b=gnPpuv5WEK80gfP7hw4V6ZCDDQUh6zXlZnakLDRV9xIO9XP3J2qrlTLg52GrHDsUFjtopDqKu
 EdXQQN3x+fiAaI+wPEQyb27dNHwuI65u1J7kC1/hN0At2nluycD28kE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] mmap24: add test for MAP_32BIT address limit
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

Add a test verifying that mmap() with the MAP_32BIT flag restricts
mappings to the first 2GB of address space and fails with ENOMEM
when the 32-bit address space is exhausted without falling back to
higher addresses.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/mmap/.gitignore |   1 +
 testcases/kernel/syscalls/mmap/mmap24.c   | 112 ++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 56f88c0b6..418e8f64d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -891,6 +891,7 @@ mmap21_01 mmap21 -m 1
 mmap21_02 mmap21
 mmap22 mmap22
 mmap23 mmap23
+mmap24 mmap24
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index dd332e9a1..f072e7f64 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -20,3 +20,4 @@
 /mmap21
 /mmap22
 /mmap23
+/mmap24
diff --git a/testcases/kernel/syscalls/mmap/mmap24.c b/testcases/kernel/syscalls/mmap/mmap24.c
new file mode 100644
index 000000000..2152036a4
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap24.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that :manpage:`mmap(2)` with the MAP_32BIT flag restricts all mappings
+ * to the first 2GB of the process address space (< 0x80000000).
+ *
+ * MAP_32BIT is supported only on x86-64 for 64-bit programs.
+ *
+ * Use PROT_NONE to test address placement without allocating data pages
+ * or charging private writable memory against the commit limit.
+ *
+ * [Algorithm]
+ *
+ * - Repeatedly reserve 32MB chunks with MAP_32BIT and PROT_NONE until ENOMEM
+ * - Verify that every returned address satisfies (addr + size) <= 0x80000000
+ * - Verify that at least one chunk was mapped and failure errno is ENOMEM
+ * - Before releasing any chunks, try the same mapping without MAP_32BIT
+ * - Report TCONF if the unrestricted mapping also fails with ENOMEM,
+ *   otherwise verify that it succeeds
+ * - Unmap all allocated chunks in cleanup
+ */
+
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define ADDR_LIMIT 0x80000000UL
+#define CHUNK_SZ (32UL * TST_MB)
+#define MAX_CHUNKS 64
+
+static void *addrs[MAX_CHUNKS];
+static size_t num_chunks;
+
+static void cleanup(void)
+{
+	size_t i;
+
+	for (i = 0; i < num_chunks; i++) {
+		if (addrs[i]) {
+			SAFE_MUNMAP(addrs[i], CHUNK_SZ);
+			addrs[i] = NULL;
+		}
+	}
+	num_chunks = 0;
+}
+
+static void run(void)
+{
+	size_t i;
+	void *addr;
+
+	for (i = 0; i < MAX_CHUNKS; i++) {
+		TESTPTR(mmap(NULL, CHUNK_SZ, PROT_NONE,
+			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0));
+		addr = TST_RET_PTR;
+
+		if (addr == MAP_FAILED) {
+			if (TST_ERR != ENOMEM) {
+				tst_res(TFAIL | TTERRNO,
+					"mmap() failed with unexpected errno");
+				goto out;
+			}
+			break;
+		}
+
+		addrs[num_chunks++] = addr;
+
+		if ((unsigned long)addr + CHUNK_SZ > ADDR_LIMIT) {
+			tst_res(TFAIL, "mapping at %p + %lu exceeds 2GB limit",
+				addr, CHUNK_SZ);
+			goto out;
+		}
+	}
+
+	if (i == MAX_CHUNKS) {
+		tst_res(TFAIL, "MAP_32BIT did not fail with ENOMEM");
+		goto out;
+	}
+
+	/* Keep the chunks mapped so the control sees the same resource usage. */
+	TESTPTR(mmap(NULL, CHUNK_SZ, PROT_NONE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
+	if (TST_RET_PTR == MAP_FAILED) {
+		if (TST_ERR == ENOMEM)
+			tst_brk(TCONF | TTERRNO,
+				"Unrestricted mmap() also failed; result inconclusive");
+		tst_brk(TBROK | TTERRNO,
+			"Unrestricted mmap() failed unexpectedly");
+	}
+	SAFE_MUNMAP(TST_RET_PTR, CHUNK_SZ);
+
+	if (!num_chunks)
+		tst_res(TFAIL, "failed to map any chunk with MAP_32BIT");
+	else
+		tst_res(TPASS,
+			"Mapped %lu MB across %zu chunks within 2GB before ENOMEM",
+			(num_chunks * CHUNK_SZ) / TST_MB, num_chunks);
+
+out:
+	cleanup();
+}
+
+static struct tst_test test = {
+	.cleanup = cleanup,
+	.test_all = run,
+	.supported_archs = (const char *const []){
+		"x86_64",
+		NULL
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
