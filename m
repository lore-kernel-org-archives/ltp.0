Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724ABC3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 04:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57DA13D217E
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 06:17:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E54173CDE64
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:17:25 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 1931A10006D8
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 06:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7RAGt
 pbn4Nfp13H7BOhMmYrZzzRoo/fKACnFXztqViI=; b=I3oSnzbddeTCpu0qaJ7G0
 iQMKdqXtFQGGtfDM7iJqQtQBagCCqyDazx/h24MjHr8y51ZtAiK91X40uY7sBOt1
 3TDQ8fQpRHDZgj75VbOZy6yHgvtFgcdtF8YmJl24bVJLrEImVei8I03imSRDHNH1
 l2hWkEsYkER7btKdtT5pBg=
Received: from fedora-40.. (unknown [106.146.87.91])
 by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wAnD_3J0r5mHgIUCQ--.48845S2;
 Fri, 16 Aug 2024 12:17:15 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: ltp@lists.linux.it
Date: Fri, 16 Aug 2024 13:17:11 +0900
Message-ID: <20240816041711.153530-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CM-TRANSID: _____wAnD_3J0r5mHgIUCQ--.48845S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw13GFyrWw1UCr4kZry3XFb_yoW5Kr43pF
 y7JFW7Aw4fJa4xXr43Xr1jkFW7Cw1rJF17GrWjywn09r93ZFy7tF4qqFy3G348JrZ7CayD
 CanYvrs3Ka1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUga9xUUUUU=
X-Originating-IP: [106.146.87.91]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0ho9XmWXzvVL7gACsF
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mseal02.c: Add new testcase
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

New testcase is added to check various errnos for mseal(2).

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/mseal/.gitignore |  1 +
 testcases/kernel/syscalls/mseal/mseal02.c  | 75 ++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mseal/mseal02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fea0c9828..1591158de 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -886,6 +886,7 @@ mremap05 mremap05
 mremap06 mremap06
 
 mseal01 mseal01
+mseal02 mseal02
 
 msgctl01 msgctl01
 msgctl02 msgctl02
diff --git a/testcases/kernel/syscalls/mseal/.gitignore b/testcases/kernel/syscalls/mseal/.gitignore
index e13090994..2348efe30 100644
--- a/testcases/kernel/syscalls/mseal/.gitignore
+++ b/testcases/kernel/syscalls/mseal/.gitignore
@@ -1 +1,2 @@
 mseal01
+mseal02
diff --git a/testcases/kernel/syscalls/mseal/mseal02.c b/testcases/kernel/syscalls/mseal/mseal02.c
new file mode 100644
index 000000000..62eeb25b2
--- /dev/null
+++ b/testcases/kernel/syscalls/mseal/mseal02.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Xiao Yang <ice_yangxiao@163.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Check various errnos for mseal(2).
+ *
+ * - mseal() fails with EINVAL if flags is invalid.
+ * - mseal() fails with EINVAL if the start address is not page aligned.
+ * - mseal() fails with EINVAL if address range overflows.
+ * - mseal() fails with ENOMEM if the start address is not allocated.
+ * - mseal() fails with ENOMEM if the end address is not allocated.
+ * - mseal() fails with ENOMEM if there is a gap (unallocated memory) between start and end address.
+ *
+ * TODO: support both raw syscall and libc wrapper via .test_variants.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static void *start_addr, *unaligned_start_addr, *unallocated_start_addr, *unallocated_end_addr;
+static size_t page_size, twopages_size, fourpages_size, overflow_size;
+
+static struct tcase {
+	void **addr;
+	size_t *len;
+	unsigned long flags;
+	int exp_err;
+} tcases[] = {
+	{&start_addr, &page_size, ULONG_MAX, EINVAL},
+	{&unaligned_start_addr, &page_size, 0, EINVAL},
+	{&start_addr, &overflow_size, 0, EINVAL},
+	{&unallocated_start_addr, &twopages_size, 0, ENOMEM},
+	{&unallocated_end_addr, &twopages_size, 0, ENOMEM},
+	{&start_addr, &fourpages_size, 0, ENOMEM},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(tst_syscall(__NR_mseal, *tc->addr, *tc->len, tc->flags), tc->exp_err,
+		"mseal(%p, %lu, %lu)", *tc->addr, *tc->len, tc->flags);
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	twopages_size = page_size * 2;
+	fourpages_size = page_size * 4;
+	overflow_size = ULONG_MAX - page_size + 2;
+	start_addr = SAFE_MMAP(NULL, fourpages_size, PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	unaligned_start_addr = start_addr + 1;
+	SAFE_MUNMAP(start_addr + twopages_size, page_size);
+	unallocated_start_addr = start_addr + twopages_size;
+	unallocated_end_addr = start_addr + page_size;
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(start_addr, fourpages_size);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
