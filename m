Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02851075269
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 01:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774401394; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=2E5u+84vhhuVpdZ98Wfy9WcUtrVVTyY6AtPUUFQUKxo=;
 b=n44L5X6SKRjBOT/sE/TwxvrpcwRCeR8Y2QksLMBNvPN+dQQ/uXHFqJdzd+Y/rijCvSIKa
 WtjRxFlZZ43tuu/VY7BsytAJavNdmP1zbScMKY97xTo+JQo97AQxGBKgbjIQY9SozcyJjhz
 NlBWyCgeNX2BUkK5yIRL1I7AVtYI6ac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 847C33E5F35
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 02:16:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F1303CC477
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 02:16:10 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CB5A1400B88
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 02:16:09 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-487035181a7so25696275e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774401368; x=1775006168; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snGyBniSzxVyZaBvhoDjJilvPiB7l1hVEw961Vc7OwU=;
 b=Yev80XKz+GmPjhRq+Yzi7OC0XxIvlkBwPw9+lKxyXMi19v1ptA4QvbyuQ7rQxJ1MDR
 hl4zZ3h4ZwGyYHrCGOWW10/Q1X9YwcLeku0ItRoWPKW+KNq+lhPGhPAgfv3SgLgjK0aX
 BBtGraqkJrPDIFsTx0hqVFUweQrqmAV2G9Bmm+KJn1pqb6yrCIjKPSAoVNMXCLLC2xfI
 EamhrtNCq0SjC17NKilNJprCaTBw4maYkApys5dC7pUqSoB5NZYfTXou/bEBxOcPJoCI
 gDAwTluDI7D5kw29CG1VVF/xv7HSiz3ErWqe9C2xJJc9lvPwqzr1AQZqfTFsIs4uVm3n
 2X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774401368; x=1775006168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snGyBniSzxVyZaBvhoDjJilvPiB7l1hVEw961Vc7OwU=;
 b=figusclrEV0Z4Sa3Ty7wEGcUktbQMfdpYCPSuHg4NSY+eHz/kCjgJRhFh8RNBkHKWb
 aVCjAedc+L837u6kqjh8784LcjWUI5hxCAHIsV0zuSKBRsBxcL8gS8t3CUMHeRYSw+Tk
 rk1wWc9vy9PgQ5WJBNmlWKRcNhK/VJMyRlWnNwnPlf2Xf/9lPMLA6CUlSSVxyRJGqR+p
 QAaM5gcLI2HQCxwBcyyhAcLCq8ZvgwVAyP3Fc0Jn0Ce98zOTBP9y8wN/+q+qpnX3g+Vp
 UvMSISce39Lepgl4cemNQAGd6eJeok37skxh2zUSq+65tGi4auCp1of0ORlVcRUUGGXg
 imMQ==
X-Gm-Message-State: AOJu0YyXPy88/Z/wh97Q+pnll3uFix5uT1wwvcwf+uZyki/FIHfFiuuM
 Ujgr/rTSDqlz3772oayWbMh+i4oiV/OO4faeZENi4nBdbtBS7plT6xL+xQJ9larwIN0ENeLmd4q
 1dPM=
X-Gm-Gg: ATEYQzwjsaN5TXWsgYP0nQZa5Za484Q3cCNPmH5w2ZNnppZKEN1BTd/nbXxCAmbSmpr
 WKXabBkonkMDCh/mbkYCAtK2UDfjv9Vv5bheFcHiH0f1OWJuqfsMZRsCk80rLnDeZrv7rM8RwTF
 iQ9Ez3zFvuhCBI6F+4L+ejASgEf6B2NesYIxVk3Nm8sg6oyK6v1fKJ4A45bCOeSxULhYoRvlTfu
 n4NckOjqu63JVr+KhHuZnCnDqXmLhxCG6sGnd4K3dY6mPbVn5cj8rDqL9CCHQzq9u9DOxhu7mPs
 jM5mg9eVaGwjyuWquk6Zc6xaCIw4dmt4+aERTKhTo+FOnlUYLQ1eKLq577rdy7REoQRUyR+LHdu
 MUayX/k7IAS1T65ZT+CQn/l8xDGJuOamalUpcESsvhM4I81/1NZrH14bVoDJVCOiaChS7Rp8A25
 GzIqAIqsD5jto=
X-Received: by 2002:a05:600c:1f12:b0:487:575:5e1 with SMTP id
 5b1f17b1804b1-487160511e0mr22248645e9.24.1774401368296; 
 Tue, 24 Mar 2026 18:16:08 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4871174f2cesm89314195e9.10.2026.03.24.18.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 18:16:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 25 Mar 2026 01:15:53 +0000
Message-ID: <20260325011605.5957-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225090525.19581-1-wegao@suse.com>
References: <20260225090525.19581-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This case test mremap() with MREMAP_DONTUNMAP and use userfaultfd
verifies fault which triggered by accessing old memory region.

Fixes: #1168
Signed-off-by: Wei Gao <wegao@suse.com>
---
v4->v5:
1)Added NULL as the 5th argument to mremap(), otherwise mremap will return
EINVAL, latest kernel will check new address is aligned or not.
2)Initialized uffd to -1
3)Updated fault_handler_thread to return void *
4)Enhanced the cleanup() function to verify that pointers are not
MAP_FAILED
5)Switched from TTERRNO to TERRNO in the mremap check
6)Removed .needs_root = 1

 configure.ac                                |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 160 ++++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/configure.ac b/configure.ac
index 7fa614dcb..c836ef7f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
 AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
+AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     aio.h \
diff --git a/runtest/syscalls b/runtest/syscalls
index 2f629e4e4..9d7c6c32e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -925,6 +925,7 @@ mremap03 mremap03
 mremap04 mremap04
 mremap05 mremap05
 mremap06 mremap06
+mremap07 mremap07
 
 mseal01 mseal01
 mseal02 mseal02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index ec15a19cd..292899e03 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -4,3 +4,4 @@
 /mremap04
 /mremap05
 /mremap06
+/mremap07
diff --git a/testcases/kernel/syscalls/mremap/Makefile b/testcases/kernel/syscalls/mremap/Makefile
index 9f5aca9ec..8811b887e 100644
--- a/testcases/kernel/syscalls/mremap/Makefile
+++ b/testcases/kernel/syscalls/mremap/Makefile
@@ -8,5 +8,6 @@ LTPLIBS = ipc
 include $(top_srcdir)/include/mk/testcases.mk
 
 mremap04: LTPLDLIBS  = -lltpipc
+mremap07: LDLIBS  += -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mremap/mremap07.c b/testcases/kernel/syscalls/mremap/mremap07.c
new file mode 100644
index 000000000..51c24b6fc
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * LTP test case for mremap() with MREMAP_DONTUNMAP and userfaultfd.
+ *
+ * This test verifies a fault is triggered on the old memory region
+ * and is then correctly handled by a userfaultfd handler.
+ */
+
+#define _GNU_SOURCE
+#include <poll.h>
+#include <pthread.h>
+#include <linux/mman.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
+#include "config.h"
+
+#if HAVE_DECL_MREMAP_DONTUNMAP
+
+static int page_size;
+static int uffd = -1;
+static char *fault_addr;
+static char *new_remap_addr;
+
+static const char *test_string = "Hello, world! This is a test string that fills up a page.";
+
+static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct uffd_msg msg;
+	struct uffdio_copy uffdio_copy;
+
+	TST_CHECKPOINT_WAIT(0);
+
+	struct pollfd pollfd;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+
+	int nready = poll(&pollfd, 1, -1);
+
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "poll() failed");
+
+	if (nready == 0)
+		tst_brk(TBROK, "poll() timed out unexpectedly");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TBROK, "Received unexpected UFFD_EVENT: %d", msg.event);
+
+	if ((char *)msg.arg.pagefault.address != fault_addr)
+		tst_brk(TBROK, "Page fault on unexpected address: %p", (void *)msg.arg.pagefault.address);
+
+	tst_res(TINFO, "Userfaultfd handler caught a page fault at %p", (void *)msg.arg.pagefault.address);
+
+	uffdio_copy.src = (unsigned long)new_remap_addr;
+	uffdio_copy.dst = (unsigned long)fault_addr;
+	uffdio_copy.len = page_size;
+	uffdio_copy.mode = 0;
+	uffdio_copy.copy = 0;
+
+	SAFE_IOCTL(uffd, UFFDIO_COPY, &uffdio_copy);
+	tst_res(TPASS, "Userfaultfd handler successfully handled the fault");
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	fault_addr = SAFE_MMAP(NULL, page_size,
+		PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	tst_res(TINFO, "Original mapping created at %p", (void *)fault_addr);
+
+	strcpy(fault_addr, "ABCD");
+
+	uffdio_register.range.start = (unsigned long)fault_addr;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+}
+
+static void cleanup(void)
+{
+	if (new_remap_addr && new_remap_addr != MAP_FAILED)
+		SAFE_MUNMAP(new_remap_addr, page_size);
+
+	if (fault_addr && fault_addr != MAP_FAILED)
+		SAFE_MUNMAP(fault_addr, page_size);
+
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void run(void)
+{
+	pthread_t handler_thread;
+
+	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
+		fault_handler_thread, NULL);
+
+	new_remap_addr = mremap(fault_addr, page_size, page_size,
+		MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+
+	if (new_remap_addr == MAP_FAILED)
+		tst_brk(TBROK | TERRNO, "mremap failed");
+
+	tst_res(TINFO, "New mapping created at %p", (void *)new_remap_addr);
+
+	strcpy(new_remap_addr, test_string);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_res(TINFO, "Main thread accessing old address %p to trigger fault",
+			(void *)fault_addr);
+
+	(void)*(volatile char *)fault_addr;
+
+	SAFE_PTHREAD_JOIN(handler_thread, NULL);
+
+	if (strcmp(fault_addr, test_string) != 0)
+		tst_res(TFAIL, "Verification failed: Content of the old "
+			"address is '%s', expected '%s'", fault_addr, test_string);
+	else
+		tst_res(TPASS, "Verification passed: Content of the old "
+			"address is correct after fault handling");
+
+	SAFE_MUNMAP(new_remap_addr, page_size);
+	new_remap_addr = NULL;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USERFAULTFD=y",
+		NULL,
+	},
+	.min_kver = "5.7",
+};
+
+#else
+TST_TEST_TCONF("Missing MREMAP_DONTUNMAP in <linux/mman.h>");
+#endif
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
