Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5B0C61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 751E73E9A6A
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 17:36:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EA083E5E02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4BF96600075
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87D5F1FCC0;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a6II7ovAD7TcQFacP+7IVoR7SHeatOUY0CdHKqQXps=;
 b=Qc/NRlovT+HW+HEp++/MLQT+nIGWOzdSpjleUscxcJNtUVyygqy8gMBapHd/YqEzcAIq5t
 m6TcO8StQ8D8twfTPqGkGP42ZS18cSIQPH0E8wHEXlR8vu+YxHkAlNOGjUTuSeo2O5YJQP
 eE0ilTT7HwEMwQPtpGRRrL1GE9uVGUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a6II7ovAD7TcQFacP+7IVoR7SHeatOUY0CdHKqQXps=;
 b=jSX3g0j3b3PiCRrVzYB2iVbR4RZICckEPynzfA16YojLcR5GYCGLPRxCrSlv8Wt0j7Tcp+
 hYEbKUXPOnREXDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a6II7ovAD7TcQFacP+7IVoR7SHeatOUY0CdHKqQXps=;
 b=K6ki82APzOW5RoyDina5p8zkzFyZOLE/N7caYzF4NnnJT0vYbhEQM8SKvWnn1/28OEoIAY
 IExU4P64QOZP1q2cVESiTCLH4vbL794patU1nkNy5arV5aP3qMTC1KKN/sjx2SES4sg6J2
 qSn6dn25iviwNdgaBLZbSAw4029GeEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a6II7ovAD7TcQFacP+7IVoR7SHeatOUY0CdHKqQXps=;
 b=Cqw7R8gXDlCWQqusb0UtvFvi8dx6IUXv0PQBSGjOm2LtSYhbgBDyerjV4C+yCDR2IseFmm
 koKdh0rQedruVhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56C1A13686;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8JumE/OqkWrebQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 15:36:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 17:36:05 +0200
MIME-Version: 1.0
Message-Id: <20260828-mmap_32bit_coverage-v1-3-7f0b8b589773@suse.com>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
In-Reply-To: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931378; l=3777;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=kI5Ar5fiR5egy/rqh2/2FOPc/Ia8U21fNcHLQfKYe2U=;
 b=/pdWpVnEC7rHC0wO0jvAobLc2UWMaw+pLaxwEHXqs/TJzs5d4YKlasiAUqWiYJY8FeXvtNSNX
 OoDHOY7r3tqBXMZsfcwJ8CJ70Ff8hKIpk8DUwiJBiumem2Sxr8zxhHb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] mmap24: add test for MAP_32BIT address limit
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/mmap/.gitignore |  1 +
 testcases/kernel/syscalls/mmap/mmap24.c   | 96 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a264f42c8..ef235668e 100644
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
index 000000000..50de620f4
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap24.c
@@ -0,0 +1,96 @@
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
+ * [Algorithm]
+ *
+ * - Repeatedly call mmap() allocating 32MB chunks with MAP_32BIT until ENOMEM
+ * - Verify that every returned address satisfies (addr + size) <= 0x80000000
+ * - Verify that memory in each chunk is readable and writable
+ * - Verify that at least one chunk was mapped and failure errno is ENOMEM
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
+	int failed_with_enomem = 0;
+
+	for (i = 0; i < MAX_CHUNKS; i++) {
+		void *addr = mmap(NULL, CHUNK_SZ, PROT_READ | PROT_WRITE,
+				  MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
+
+		if (addr == MAP_FAILED) {
+			if (errno == ENOMEM)
+				failed_with_enomem = 1;
+			else
+				tst_res(TFAIL | TERRNO,
+					"mmap() failed with unexpected errno");
+			break;
+		}
+
+		if ((unsigned long)addr + CHUNK_SZ > ADDR_LIMIT) {
+			tst_res(TFAIL, "mapping at %p + %zu exceeds 2GB limit",
+				addr, CHUNK_SZ);
+			addrs[num_chunks++] = addr;
+			cleanup();
+			return;
+		}
+
+		((char *)addr)[0] = 'a';
+		((char *)addr)[CHUNK_SZ - 1] = 'z';
+
+		addrs[num_chunks++] = addr;
+	}
+
+	if (!failed_with_enomem) {
+		tst_res(TFAIL, "32-bit address space was not exhausted");
+	} else if (!num_chunks) {
+		tst_res(TFAIL, "failed to map any chunk with MAP_32BIT");
+	} else {
+		tst_res(TPASS,
+			"Mapped %zu MB across %zu chunks within 2GB before ENOMEM",
+			(num_chunks * CHUNK_SZ) / TST_MB, num_chunks);
+	}
+
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
