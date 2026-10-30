Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A66606A31C
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=c4sXVGn+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=h3/fCIOu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793364295; h=message-id :
 to : date : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1302kBqKz1EzAH1IB1y/tNTLbVQ+sOoR5UX1zY9Hm4Q=;
 b=c4sXVGn+zzgOX2GLzo4sa74CSnerXP7l4RcA9I2QROrlXS3tgTK6UPcfQlVasMw7YdwOE
 qTwQj+BCT6HkP9mbWgYaV1eU3/M09CQAJRPz0im9u6pZzzRGpnE7UGtpqVtcShbLbE8hgQk
 0UDNUG3RN64H3ZWVMxjAb91xSIE13eY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C78F03E60E4
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 13:44:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 800A63D23FD
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 13:44:35 +0100 (CET)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A07CC1400F24
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 13:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793364268; bh=4sigXJ8+6sayyQ6hFDl2dZbr2OkqsSiDEXFrbH5J9x8=;
 h=From:To:Cc:Subject:Date;
 b=h3/fCIOuKntfG/cN7i9w1MJ479fXcu5UbmeGRqp27cqDrXGk1jM8M/ULT9WV1Mc00
 tCk3OxoV95TiA9NSRUIppWF2h3dwWXfppmMhhglO0udKYB5PPHbsBNMTP1q+xk+hGu
 Qj+eccd/WpP6UkC4p9TE+Kcnb+A+fWX3vyPd/f1c=
Received: from 6PLUS.localdomain ([120.244.108.109])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id B1A394EE; Fri, 30 Oct 2026 20:44:26 +0800
X-QQ-mid: xmsmtpt1793364266tiq07m6w4
Message-ID: <tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+eOlvoDUpxrzaoDm3kIpJOGY9TipTCoCQvEJf6GM3Pz3kiC1Pfe
 T7FomJ0XHaw7iGnHygA/FpsNai/Y+CSsjCWazp4zQQflXFF1giqXyNUhTcvsGm7Ih5CQIX4NQUm3
 29pI6E/dD4vmbtsb8rnXqoUyLh6gVwVoZjBqABSwtU9+NgINS1E11QBI6hRuqszfQk/PZIRcwZdL
 TGdJNlbbmzguBxR8UIHqmOcXmz/KH+xynDBEkV+VXndD1E+eyD+OrLR2k52R+TSYVe2kAsbSuCem
 GKsRsLkQBfD400fAfcY/Cwh0ios+712yZxEMfXPzMVyCuj8qchwC7PXuHVnAArqoPoOYCteGQgoE
 XWmXE9qaqRA7oK+Fqk2+W9E1ioDijSUPnQxUWPQDTngk1y2Y1hhuycCIPVoZ8AiKVEibULok6wwS
 xVbjkeG5c2qJRyU/Uf+fJqj3UenxB33S2v2Z2Gc2nPxyv11lbEh9jkaRy9ElzTMx3RuTpPqub6Bh
 UJd8779ai5dnNuo2XBXazuIqr3CKDnz8y8vt0eByttvWi8UaxdVET1OzNSeMHbGpnY0vXGdBJpQQ
 riQS45CYyr7vDOj5VNY7b0GKmbVR4G6SYRl1GwsfBXWg+QiddKiQD4yOThgbNoU9RcV9zkK9GdBw
 GSjsc4QHPLaz0C9ypicsX/V8Tk35MMtLNzQm/zPrZFYnI/KxTMFRi1QamM8eyUR4CT6lLZaUqOxo
 02I51NPSRTtk2F1u04Ak1CQeFwMEOQXCQMKRRzT3lNSdwJU43e7q3u8/E1QZ2TAVVvvxV6wN1AZS
 MNnhnUfU6Z83Mfyk1V9vbLsM3mjE0DHKbqxXW6xxicn4Qz1K1dgceM1f5SRzzuLnrP2xvG+/sM0Z
 tpqz8bMHZJl1QhdhTruv8qgHl/5S172EHDJi9RAFB4UGSR6YbQrWjJjvYUk4X1p3UrO20HDUa3Ql
 2iI6rgUb+FzCVjpMadJkw+jrSnNBJBLTiDJHhbPIWBtyPacPVj+ESZaIegBJ3VmMubaXpYYDoRYk
 7NcdgD7gXuNphcriBUouGzbRnfspgC0c23CXzEOftCgsnbGk6wmd4Mg7zlcbeMHkYOWuBzaITtjn
 kCNFAE
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
To: ltp@lists.linux.it
Date: Fri, 30 Oct 2026 20:41:55 +0800
X-OQ-MSGID: <20261030124426.596-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
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
Subject: [LTP] [RFC PATCH] syscalls/madvise: Check DONTNEED across an
 unmapped hole
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
a range containing unmapped pages, while returning ENOMEM for the request.
For a private anonymous mapping, MADV_DONTNEED should therefore discard
the contents of the mapped portions on both sides of a hole.

These tests do not cover that combination. madvise02 checks the ENOMEM
return for MADV_NORMAL and MADV_WILLNEED on a shared file mapping whose
final page has been unmapped; it does not check MADV_DONTNEED, and it does
not look at the contents of the mapped portions after the call. madvise03
checks zero-fill-on-demand for MADV_DONTNEED on a fully mapped range.
Neither checks the contents of private anonymous pages on both sides of
an unmapped hole after MADV_DONTNEED returns ENOMEM.

Use eight pages with distinct nonzero byte patterns and advise pages 2
through 4. Run once with all pages mapped and once with page 3 unmapped.
Check the return value, zero-filled target pages, unchanged data outside
the range, and preservation of the hole. Use mincore() to check the hole
without dereferencing it, not to infer physical-page reclamation.

Allocate a fresh mapping for each case, use the runtime page size, and
release the complete region in cleanup, including the case with a hole.
The test does not require root privileges.

Tested on x86_64, page size 4096, gcc 13.3.0, kernel 6.8.0: madvise13
18 TPASS (three consecutive runs), 36 TPASS with -i2, 1800 TPASS with
-i100; madvise03 1 TPASS on the same kernel.

Link: https://man7.org/linux/man-pages/man2/madvise.2.html
Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise13.c | 145 ++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4d3f53e..7e255c3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1094,6 +1094,7 @@ madvise09 madvise09
 madvise10 madvise10
 madvise11 madvise11
 madvise12 madvise12
+madvise13 madvise13
 
 newuname01 newuname01
 
diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
index 758e601..3e7dbe6 100644
--- a/testcases/kernel/syscalls/madvise/.gitignore
+++ b/testcases/kernel/syscalls/madvise/.gitignore
@@ -9,3 +9,4 @@
 /madvise10
 /madvise11
 /madvise12
+/madvise13
diff --git a/testcases/kernel/syscalls/madvise/madvise13.c b/testcases/kernel/syscalls/madvise/madvise13.c
new file mode 100644
index 0000000..eed99dc
--- /dev/null
+++ b/testcases/kernel/syscalls/madvise/madvise13.c
@@ -0,0 +1,145 @@
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
+#define FIRST_PAGE 2
+#define LAST_PAGE 4
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
+static void check_page(unsigned int page, unsigned char expected, int prepare)
+{
+	unsigned char vec;
+	unsigned char *ptr = addr + page * page_size;
+	size_t i;
+
+	TEST(mincore(ptr, page_size, &vec));
+	if (TST_RET == -1) {
+		if (prepare || TST_ERR != ENOMEM)
+			tst_brk(TBROK | TTERRNO, "mincore() on page %u", page);
+
+		tst_res(TFAIL, "Page %u is no longer mapped", page);
+		return;
+	}
+
+	for (i = 0; i < page_size; i++) {
+		if (ptr[i] == expected)
+			continue;
+
+		if (prepare)
+			tst_brk(TBROK, "Page %u was not initialized", page);
+
+		tst_res(TFAIL, "Page %u byte %zu: expected %#x, got %#x",
+			page, i, expected, ptr[i]);
+		return;
+	}
+
+	if (!prepare)
+		tst_res(TPASS, "Page %u contains only %#x", page, expected);
+}
+
+static void check_hole(int prepare)
+{
+	unsigned char vec;
+
+	TEST(mincore(addr + HOLE_PAGE * page_size, page_size, &vec));
+	if (TST_RET == -1 && TST_ERR == ENOMEM) {
+		if (!prepare)
+			tst_res(TPASS, "The hole remains unmapped");
+		return;
+	}
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "mincore() on the hole");
+
+	if (prepare)
+		tst_brk(TBROK, "The hole was not created");
+
+	tst_res(TFAIL, "The hole is mapped after MADV_DONTNEED");
+}
+
+static void run(unsigned int hole)
+{
+	unsigned int page;
+	unsigned char expected;
+
+	tst_res(TINFO, "MADV_DONTNEED %s a hole", hole ? "across" : "without");
+	addr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	/* EINVAL is also returned when THP support is not configured. */
+	if (madvise(addr, PAGES * page_size, MADV_NOHUGEPAGE) &&
+	    errno != EINVAL)
+		tst_brk(TBROK | TERRNO, "madvise(MADV_NOHUGEPAGE)");
+
+	for (page = 0; page < PAGES; page++) {
+		memset(addr + page * page_size, 0x40 + page, page_size);
+		check_page(page, 0x40 + page, 1);
+	}
+
+	if (hole) {
+		SAFE_MUNMAP(addr + HOLE_PAGE * page_size, page_size);
+		check_hole(1);
+		TST_EXP_FAIL(madvise(addr + FIRST_PAGE * page_size,
+			3 * page_size, MADV_DONTNEED), ENOMEM);
+	} else {
+		TST_EXP_PASS(madvise(addr + FIRST_PAGE * page_size,
+			3 * page_size, MADV_DONTNEED));
+	}
+
+	for (page = 0; page < PAGES; page++) {
+		if (hole && page == HOLE_PAGE)
+			continue;
+
+		expected = 0x40 + page;
+		if (page >= FIRST_PAGE && page <= LAST_PAGE)
+			expected = 0;
+		check_page(page, expected, 0);
+	}
+
+	if (hole)
+		check_hole(0);
+
+	cleanup();
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	if (!page_size)
+		tst_brk(TBROK, "Invalid page size");
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

base-commit: 46688815513714a28fd2ae300adae6b6e68b838b


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
