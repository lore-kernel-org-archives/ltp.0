Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EEF606A326
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=VXL3aGdg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=M5WmCJny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793790083; h=message-id :
 to : date : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3YxYAh3/ov+EDKihAlh2k79ctca51rjI72qjiXyB2hE=;
 b=VXL3aGdgDbYlHWlwRBqzk/Cmt9RFNPZOFIhmq4xk0CQxA6UWkSxiM/klhVDf6EE5TTKCc
 wcdajSW6oI7a/9GTx0IMmCJfWzvt/NwufeZ0RhsF9/5PZHb7bOL5bWifoQCMJFks605P3Jm
 QzFD2u+KYKcGaCAO4fzPACyS1BJbCOU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D519F3CB52E
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:01:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EDC83CB2CC
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:29 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BD241400BC2
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793790026; bh=L3GJ+mWXI52L8RpGtIbzqKYHqeioHMV8NNzJDd+FS9U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M5WmCJnyCipDdMRgUJBkJVkZSoa1EA/XHA9PZtq/xEWtCHunKV+NNTiXmldqhFIYp
 Nl/Ermk0oJc3rCfPN2pOwQTBtKwgHE7eO2xKxvhTPqD5lbv+odenUwaWf3kZzIiIyH
 dneaJmh9t5mECmRgL1Vgi3Gr4pa8tAJ684TbvfWE=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.87])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 15B4472; Wed, 04 Nov 2026 19:00:21 +0800
X-QQ-mid: xmsmtpt1793790024tregznakg
Message-ID: <tencent_E18802ABBC171ACFC1164A15ED457EDD2E08@qq.com>
X-QQ-XMAILINFO: ORcGkSaB+8SI29b+/WCe+s4+VIijrO+a9xgCY4Llz/dsaX+jsXxOarCAwK1hym
 +PN0RMztpQqAmSDtvC0uxoBpgHESr52ugFtYaqnIKnOSNnux5iwpX5c0JHj8cdrx3ir5z//hB7tm
 gC+AT8hYYYj8w1vuZc037QtlUuQ5Wk7NSn8RllDftBlnpuVKnqjtISJ0g06xD2ZcHvTLUaQJRgz0
 aDP/IybASosXRsEklAQQz0oBzqzAjG5aujGXdn69BHVL4lSwGOeJmaExiieknhO+TTAFmGqc+KwV
 Z8BWOuICyIUnsk84V5sIhT44p24JhI/v8RjlWRcGH707JOmXIO88RR6JR3B+pWOrmoqGHd3n2deD
 DmJN/uNZsshVU51oftFpZGzsKcQxwg130dpmxNK2hVCWQMGTF6mGF7Y+QoCUEAAw2OkgBf2PrQ8R
 4znJdDE1BAgeDi0edTt6xqhhDpwkLEDu9ZvbhUcuEVQFnFnDpUJlM+OFcFhFnH1Y7UVNgLDmaApV
 B6WBnxMuUFPGmhdVJ5u6MzaNdyEzd6SPPmev33iagzeSMFW5Jy1QyCjW+EMlZ3Djbr5j6GxAG305
 CP00qjERLqQG8vkaPhSGlZX9iPS3s9bY676op85FkxfrMM+wDZBVGbKuYmGIQJhhY9fYLbaC1IQZ
 MYoMrvse6WsOXzRop2gX4ConaWanlOC15u91y3wC8GUWZlGXkvAu7fhFod9W31f1I7B0KSORbJ3X
 I+SREsh906eTtW3ULUFTluEyZl8SNddQuhbpbYFNEZifweqUwh7iPFEw6Mwr/leZT1vInARExb1l
 L9eF8uReUx17sQc9QT2ve+KDzK01lr8K5MM9xLVvTnCPDVcg8DL/vTjgUSdvpIWEIiWiJeTC/Jvk
 UMYqaUVUqw+Qd3plc5E1DwIovQyIFNLFG7fiMNRUtdL2RixdQ8D8JDrI8JuOV7E0gjqszOyGRBcO
 oNVdIfLXiZAONzdRBlZtgxGFZzMrAnBrsTppgQ4GTukZtRpKO7V1A6W16P4LV3BImgeLZ9cR3HJf
 qtkalI0V8GDARP6X8cp6VfS1iOHIFqKDu0rSYQaMVvUP+oKUVR3Hjuof04FUPTCnq1/XcQY9fiAI
 Rs9HLK2NrxMhGvVRu43PVTJCwlR6lDEe15C74zdt1pT/XeQSPF6MI/xixSDxeM33dOemAJ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 19:00:21 +0800
X-OQ-MSGID: <20261104110021.7870-3-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110021.7870-1-2063309626@qq.com>
References: <20261104110021.7870-1-2063309626@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/madvise13: Check MADV_DONTNEED across
 an unmapped hole
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

madvise(2) documents that Linux applies the advice to the mapped parts of
a range containing unmapped pages, while returning ENOMEM for the
request. For a private anonymous mapping, MADV_DONTNEED should therefore
discard the contents of the mapped portions on both sides of a hole.

Existing tests do not cover that combination. madvise02 checks the ENOMEM
return for MADV_NORMAL and MADV_WILLNEED on a shared file mapping whose
final page has been unmapped; it does not check MADV_DONTNEED, and it does
not look at the contents of the mapped portions after the call. madvise03
checks zero-fill-on-demand for MADV_DONTNEED on a fully mapped range.

Use eight pages with distinct nonzero byte patterns and advise pages 2
through 4. Run once with all pages mapped and once with page 3 unmapped.
Check the return value, zero-filled target pages, unchanged data outside
the range, and preservation of the hole. Use mincore() to check the hole
without dereferencing it, not to infer physical-page reclamation.

Allocate a fresh mapping for each case, use the runtime page size, and
release the complete region in cleanup, including the case with a hole.
The test does not require root privileges.

Tested on x86-64, 4096-byte pages, kernel 6.18.54.1: 18 TPASS, 36 TPASS
with -i 2.

Link: https://man7.org/linux/man-pages/man2/madvise.2.html
Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise13.c | 154 ++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ff3de1b15..48cbdab39 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1095,6 +1095,7 @@ madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
 madvise12 madvise12
+madvise13 madvise13
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 758e601a9..3e7dbe653 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -9,3 +9,4 @@
 /madvise10
 /madvise11
 /madvise12
+/madvise13
diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
new file mode 100644
index 000000000..cb4323e5b
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise13.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wenyuan Li <2063309626@qq.com>
+ */
+
+/*\
+ * Verify MADV_DONTNEED on a private anonymous range containing an unmapped
+ * page. The call must return ENOMEM but still discard the mapped pages on
+ * both sides of the hole, without changing data outside the requested range.
+ * Also test the same request with the middle page mapped.
+ *
+ * madvise(2), VERSIONS/Linux, specifies that Linux applies the advice to
+ * the mapped parts of a range containing holes, even though it returns
+ * ENOMEM.
+ */
+
+#include <sys/mman.h>
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define PAGES 8
+#define HOLE_PAGE 3
+/* Test-local range, not a madvise(2) advice. */
+#define RANGE_FIRST 2
+#define RANGE_LAST 4
+#define RANGE_PAGES (RANGE_LAST - RANGE_FIRST + 1)
+
+static unsigned char *addr;
+static size_t page_size;
+
+static void cleanup(void)
+{
+	if (addr) {
+		SAFE_MUNMAP(addr, PAGES * page_size);
+		addr = NULL;
+	}
+}
+
+/*
+ * Return 1 if the page is mapped, 0 if mincore() reports ENOMEM (a hole).
+ * Any other mincore() failure is a test library error.
+ */
+static int page_mapped(unsigned int page)
+{
+	unsigned char vec;
+
+	TEST(mincore(addr + page * page_size, page_size, &vec));
+
+	if (TST_RET == -1) {
+		if (TST_ERR == ENOMEM)
+			return 0;
+
+		tst_brk(TBROK | TTERRNO, "mincore() on page %u", page);
+	}
+
+	return 1;
+}
+
+/*
+ * Return the offset of the first byte that differs from expected, or
+ * page_size when the whole page matches.
+ */
+static size_t page_first_mismatch(unsigned int page, unsigned char expected)
+{
+	unsigned char *ptr = addr + page * page_size;
+	size_t i;
+
+	for (i = 0; i < page_size; i++) {
+		if (ptr[i] != expected)
+			return i;
+	}
+
+	return page_size;
+}
+
+static void run(unsigned int hole)
+{
+	unsigned int page;
+	unsigned char expected;
+	size_t off;
+
+	tst_res(TINFO, "MADV_DONTNEED %s a hole", hole ? "across" : "without");
+
+	addr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	for (page = 0; page < PAGES; page++) {
+		if (!page_mapped(page))
+			tst_brk(TBROK, "Page %u is not mapped after mmap()", page);
+
+		memset(addr + page * page_size, 0x40 + page, page_size);
+
+		off = page_first_mismatch(page, 0x40 + page);
+		if (off != page_size)
+			tst_brk(TBROK, "Page %u byte %zu was not initialized", page, off);
+	}
+
+	if (hole) {
+		SAFE_MUNMAP(addr + HOLE_PAGE * page_size, page_size);
+
+		if (page_mapped(HOLE_PAGE))
+			tst_brk(TBROK, "The hole was not created");
+
+		TST_EXP_FAIL(madvise(addr + RANGE_FIRST * page_size,
+				     RANGE_PAGES * page_size, MADV_DONTNEED), ENOMEM);
+	} else {
+		TST_EXP_PASS(madvise(addr + RANGE_FIRST * page_size,
+				     RANGE_PAGES * page_size, MADV_DONTNEED));
+	}
+
+	for (page = 0; page < PAGES; page++) {
+		if (hole && page == HOLE_PAGE)
+			continue;
+
+		expected = 0x40 + page;
+		if (page >= RANGE_FIRST && page <= RANGE_LAST)
+			expected = 0;
+
+		if (!page_mapped(page)) {
+			tst_res(TFAIL, "Page %u is no longer mapped", page);
+			continue;
+		}
+
+		off = page_first_mismatch(page, expected);
+		if (off == page_size) {
+			tst_res(TPASS, "Page %u contains only %#x", page, expected);
+		} else {
+			tst_res(TFAIL, "Page %u byte %zu: expected %#x, got %#x",
+				page, off, expected,
+				addr[page * page_size + off]);
+		}
+	}
+
+	if (hole) {
+		if (page_mapped(HOLE_PAGE))
+			tst_res(TFAIL, "The hole is mapped after MADV_DONTNEED");
+		else
+			tst_res(TPASS, "The hole remains unmapped");
+	}
+
+	cleanup();
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
