Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4158DF36B9A
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775788365; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=i4COvm1n959OT9k9D1yktuluTcuIcFmDCvWIfDksqrA=;
 b=Oi9wEtzwBsbImqV9F9/8RYY8MbednclEO5dOrr29GTPrGyLoFu3+m4J6YBldP9D8DnC1q
 Td6Pcc8PhrjG9YmQUOtoImxjNXaklu13X4/nT935EuRXeC+DClu0XsF5QSwoJSSujW6IYZK
 /GnHsHvd7XwiPrxmbuQBfz75V2EJfmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE3643E60AC
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 04:32:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FF423E602F
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 04:32:22 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AE90600054
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 04:32:21 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso8381935e9.0
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 19:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775788341; x=1776393141; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KQvUyY4hFx23OLHpClhb/xFevHa4DCnMOgwsQfBrYI=;
 b=J50UxYaBdi+ucPvcl4fnxLF9CjWRbiZz43E857GSxkqW6acwlWKXxiiZ0RuMr1dUj6
 hsOZLYMQMfs5ofii3Un6V7amXG74ZwKgYr9twfh9BEcsuj148XZxvXgN+1CaoqAPK3dG
 wuO57WciCh4nmKJmsw7f2o+z81UMzhPlUhdJKdNBVeeRLsjkDQz4v0Ncwd//HG/wF9AV
 cC26HEhjFj2NdnDm+Hak1/7HrWOs+E22FjdU+/olCcWk+WUxehRWCIvpKD9pMIYmcJI0
 8MBwUaGxvYvtEofQhxoZtLK0agbobMI3Otx4J2AewmCi13zESOs/HvhCB5dTWP3/eRUK
 JaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775788341; x=1776393141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/KQvUyY4hFx23OLHpClhb/xFevHa4DCnMOgwsQfBrYI=;
 b=IfqgpWvdSkh8pp4uTjmQXQFn22uhBSvDNCkp6ixFWn1JGoOgHBl3SsEy+yLP3gvb7o
 48RqftM8pJC4Xie3RBqQ7v5zukiREsxQfuE+AT2w+O3HYZs0RC0X4PVfqUhOId38e3cl
 NPTzr0ZLDG0ukCKs3ERzTgWTUnww5gXkKUqbnHWK3QipfGgy5+3Egv+Ha61p/JwAGX/I
 FjSFNe93baQcpUvd0e5c5fMUgFuywBslQMneHcCEUe8qfnItagXaSiiphDXpwm27H6C2
 uH6zCrVZbmkpSQq4HOXqaRLqzuAs/pQjfJVyOxwSGVdQjyb7LqHTJ/djrE7ZHAbcrRgM
 nKGw==
X-Gm-Message-State: AOJu0YzUlIH9Tt0MGSTUPGOuyhWQdMR9xDX5T41k3DaJ8nkAytF+qXbf
 JihKspO2x7ltRWinDY9Gh6b3vwmxVqm5P5M7CuhRhbDCj5EZSGaOqawMHYNvdIviafkApIKj4Fa
 w1+Q=
X-Gm-Gg: AeBDieslQEFUMgYbuO9TBqGYDjBKaXHWT6zsgpkp9BXlJRTj4Ez0JqJLTN3EL7A4Gbl
 7qAakVSSJfObfXn5rPTemlJxwSrumE2j3Nfy87gR8yMwMaXfmQaYxAKWM9I4m7Y2FFLQ5WZljlO
 8OTh7+xfCyFgbdVg9kObwKtw2Z0tt/up9h6UJ0I8S7jqzsx4J+KI/FhWPKOxoG3iUXaZdgXPvxs
 5qddxOwb8To3VvjuTmc0PZnUqPwYtpjyDYdcGmxxUVaUOdthey8SHSGg+4VA0BivwIkCZoJUq+T
 AXBa4qmbqcQigF1nqZGUiZ6ktK6ihYMiAT66w9lQxcyPpgyx76nSv43vULC/TRIhte7FNtFJrBW
 bq4hdfpzTCOLx0PQamMulQ16l6SoqM3PNSBe/MyWbKmqengZHs/62NFvkZ/oIfAept+938Uun+E
 Mn+Lu06yY/w+g=
X-Received: by 2002:a05:600c:1987:b0:488:b187:d8ed with SMTP id
 5b1f17b1804b1-488d67bf765mr13166965e9.2.1775788340739; 
 Thu, 09 Apr 2026 19:32:20 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488d532ed4dsm36146795e9.4.2026.04.09.19.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 19:32:20 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Apr 2026 02:31:52 +0000
Message-ID: <20260410023201.18119-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325011605.5957-1-wegao@suse.com>
References: <20260325011605.5957-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] mremap07.c: New case check mremap with
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

Fixes: https://github.com/linux-test-project/ltp/issues/1168
Signed-off-by: Wei Gao <wegao@suse.com>
---
v5->v6:
- Refined the test description header
- Added a missing return NULL to the fault_handler_thread
- Replaced a manual strcmp and tst_res conditional block with the TST_EXP_EQ_STR macro
 configure.ac                                |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 158 ++++++++++++++++++++
 5 files changed, 162 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/configure.ac b/configure.ac
index 812f17d8b..211aaa8ad 100644
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
index d72fceb5e..b9a9ce5fe 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -927,6 +927,7 @@ mremap03 mremap03
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
index 000000000..0510fdfe1
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
+ * Test mremap() with MREMAP_DONTUNMAP and verify that accessing the
+ * old memory region triggers a page fault, which is then correctly
+ * handled by a userfaultfd handler.
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
+
+	return NULL;
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
+	TST_EXP_EQ_STR(fault_addr, test_string);
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
