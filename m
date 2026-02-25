Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CACEFD210
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772010351; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UlnyqMY9t22i0mdd7sczM7s38IzCZoS0ZTSJIE8+f9c=;
 b=SONdgjo0Lw62zkcjqGSVCi+9bmpmhbOekkhi7sijRfzQxLgP4dcazmQg7eLphXcDauptM
 M5IkjpbPSpXwZ1YoGt16EZbZYSEFnK2cvILdkK6TFDtJbsWp/lyKXvRCZSPFF9x1bYFA/dx
 8pJrSmy9RnpnIbr4SZ2fRnGtF6+60c8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F9933C634F
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 10:05:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7642F3C5398
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:05:30 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EA6DA1000DC3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:05:28 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso55634145e9.3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772010328; x=1772615128; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X9TOisawhH54Km9MVd5QN1lQ7tMvr4six8zg+5kWS4=;
 b=XfkARws36VF9Aq3+UvNI8H0shXBr12XqFF8rS/Q8smdFSF+9TlMKXbqHBgm/hSndUu
 9rxeCuEkWKHbZgZ/XaWftp/rDTi50z6us+vTeWVL4CYY1eAWURu/1TBAZxi3tFQRTihe
 wMlV34bqzQ/QnkoOKUlwbfUV/FAP9N3hUtiWVfXsMCvAqt1zZuwyvcFqqX2bf7pH91Ng
 +u1Nkt2wwi7lfJhcpeK8Tvtd390NnCC1otChwSZZK2MnvbtROgoXrCYL0LL6tMIqN6/d
 KvYOcFeuubx0QzCqEW1zq8hVqG0O6Ei9g0wG2PGJzZOGjvz6zgAX99HGQsYI3NbJdH4S
 JevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772010328; x=1772615128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4X9TOisawhH54Km9MVd5QN1lQ7tMvr4six8zg+5kWS4=;
 b=bgPXqrQGvcot4g69s5sDyoG2dzQIaYc99N86uaDfSNbXIaW7trhfdxb+R0aC6s8KDF
 eOQdgD8s3CapkbzymY6Bxx8ixX+SRQcpmgDI9HfayMBdMaweUVgbzqK0bFmFkMnTBysU
 JwbOq+injXLbsPlBuW0fkVye3eYa1Dw5cwudAnF9s3P/ldekMHSbU8lzWNYDs+qXwvB/
 UgwcfY43iw3bxmeOMWgofLLUkianAcQZf/DjrhAr3C6LycqkezyDW4ysYOTVUIK0uK1m
 Ndl6395gBlnCFdPA3uZSQM7faMZyndGGwReR85ftft6jwnKNdIxK0JUw3OTyhUoqSGfG
 I6cw==
X-Gm-Message-State: AOJu0Yx3pdN9eKV3VAb4qMgB7ZSZo8EuuryHcwtTbnfarKg/mQPQyjL2
 OEbSvzCVeKvwM15DlibWlxR53OQ/RG5FH65j3reBERLd4uEyZ6/hT32swyJhF/22ZRk0d+1WagQ
 1LIk=
X-Gm-Gg: ATEYQzxf1d7hlQlTnPBuNrkw2fGNoz76foVPQdqW4WJUrxhxC82S4f9lEy/ka59giwL
 2x16NSDL8JVfdZ9lh/iLHjPUfkAUjquJ5AV6FxXkDR0OYDX9mPv/QacdW7bX2JqwZJcx+plv5AM
 a5mIbpnjE3L1PUVRQ6mju6yk9DLOkV5B9jZ/eFB7xi47nIFfctm9Pakmdq1jy9ni0Fi/lnWJ30m
 pT6BL81/GQc50jTekAGlsduKOswLj7PuJMCoSEILJRQbz1TqJpGlY3zdM4UmfWDCF3nae0MhC5D
 9oOSpcT4Xdc4/+EAczFXdcmpKtVHNt5sjw5U4P+pkfJ4j88quFd6KxCBOg0XblHCOu/Vv4W0KRU
 y3t5c+YbpBmdFj/0q7Ls1yG2nq9ZmJHTq64XbJjL3SMyO1666s7DayV3bO8oz1UWgUATtbAruBk
 62MA+miOnAw58=
X-Received: by 2002:a05:600c:1386:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-483a96087d8mr283984435e9.14.1772010327931; 
 Wed, 25 Feb 2026 01:05:27 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-483bd726a35sm49183045e9.9.2026.02.25.01.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:05:27 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 25 Feb 2026 09:05:13 +0000
Message-ID: <20260225090525.19581-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030054029.23511-1-wegao@suse.com>
References: <20251030054029.23511-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mremap07.c: New case check mremap with
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

changelog v4->v3:
1) Add explicit volatile memory access to trigger page fault.
2) Use SAFE_USERFAULTFD and add config.h/linux/mman.h.
3) Logic: Distinguish poll() timeout from failure.
4) Style: Fix long lines.

Fixes: #1168
Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 158 ++++++++++++++++++++
 5 files changed, 162 insertions(+)
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
index 000000000..92dee4636
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,158 @@
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
+static int uffd;
+static char *fault_addr;
+static char *new_remap_addr;
+
+static const char *test_string = "Hello, world! This is a test string that fills up a page.";
+
+static void fault_handler_thread(void)
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
+	if (new_remap_addr != NULL)
+		SAFE_MUNMAP(new_remap_addr, page_size);
+
+	if (fault_addr != NULL)
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
+		(void * (*)(void *))fault_handler_thread, NULL);
+
+	new_remap_addr = mremap(fault_addr, page_size, page_size,
+		MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
+
+	if (new_remap_addr == MAP_FAILED)
+		tst_brk(TBROK | TTERRNO, "mremap failed");
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
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_checkpoints = 1,
+	.cleanup = cleanup,
+	.needs_root = 1,
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
