Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB63CCF9EA
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 05:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761802856; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=laTXx7m4o+X+8EhiLcItIJA5RKNU3RNOpBCtfaUM9iI=;
 b=JzA7GX0IpmRfRX3MTbNWH2f3wNRokP64GvxJdCWh5xHS5DTgGSeTB8X/UCQULWTCw2uHq
 rjoIDXkUBsxhmKiyvHx3Paat5CNVADWzth/ztBnNyRTYdOBcYIjGcL7tki1Cbg4tb9kM+uy
 FVqcrLSgp3DsJWMMX6//WdFYIUX2OQY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1FC03CBA00
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 06:40:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC8AF3C0F3B
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 06:40:36 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE8396018DF
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 06:40:35 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso4068525e9.0
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 22:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761802834; x=1762407634; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPBdaNEwx6TYFQTrC9T+7R1W/KtqyyLXUn/lHTl9Paw=;
 b=Nh5ZVv+9Abgt3/zfip6i/N+kOg/mpNUdiwZiOW6zXRQozwGdDZXWcSGfQvwaVGSFKa
 ZK4ue/ywEMlvBGLxW3+Diwn/dDjJLtSGmNGZyc77pH1P5cvqadpbZ/tUtkNDchnvcQ6/
 9Y0R4Jo0o4hInui4wDZ1HVI0/aoLnuJFNgMWxe0+C4XHyN+IzpTMHBXhN4KUku3TOPbe
 HYGQg/jG0EVHunj1lk9rHm3PUdoy5ldKGsqm/0Dsg3wXpa7mvj6qf21IgPB+GGInQDSt
 njP2005ExbWiHvGYZ/3typV/jQjaDsXnrWU9DU0tWPc5XUy2ms4hEDa1P+l6+Ep1COj9
 2S2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761802834; x=1762407634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPBdaNEwx6TYFQTrC9T+7R1W/KtqyyLXUn/lHTl9Paw=;
 b=CRrZFMtybwd52P1gQnPYIU8rJqWeloo3a9wBdL0pWJAW0ahS60cIM7pfh6ZhQ+YOCj
 nAjQt5v25mef0ndgGrSGl9/5UG2g3zuzVKBFHTOYQoHuxawsRBSr19kwtPly8IOdeIOV
 KEZJH5xHvAZTkZvowvC6nSHXsNb/A5r2mzxm0OI4ed565SSp8Zbs3uAdsq3jOFhFZ0Ym
 RHfVf/FqFfl+qavt78BOFD794vJ1ycixiwFITKZRIfXOzE+WAawVxH7W7Dsn5qSQGIzl
 0VY1lB7wqvuJ+HOILs0acYi0q+gILe/LfiQsBlsTie5BG5R8Yn9WCDPSxjAYjTSF/90O
 9ZdA==
X-Gm-Message-State: AOJu0Yzef69p1DO+eWwI7saOS6EVEeu3F8tlnTssUwPMdFfe2s4bz6eq
 mrmfUMVna38P+hVMQdgOIgApBiaNtwax+ty2ArXf/oNLX3O9ff3CsWyAws9YWFxD3C4aS6GJRdP
 OIFM=
X-Gm-Gg: ASbGncvg+Cd/A6m72rPy5RH44wEXf89gcqhTVj05UtWBqzlhbvO5oJKDsedziTuyIiO
 991CZluI8/9MfDTL4IVMRllLTGQLf5sTUbLo+GwHDlrRbDvTvzCOY459AmEcRchoAU6GjoDoUft
 Loz9AYpRc0j0xJw6gk1KJ8CnS+2m9LMa2OX5xalKMkO3KYijBSH9DMgv15uYMTziYJoNhdgU2WJ
 8Aa9i++C6uMIsbnS2DCAARKFSRbVXNlQFpoPWcYxzeN/w7lmCuFDbzlz92L/j3553GnVlbcZrNO
 Y0gVwR486OJr6z99or+pdtTq1/2qUhjYg0kx01SZci26KsQ4ybY59sUxz+OzQGlCyERe1cV/0D6
 9wZMwJ0afkpZOvpL2nPtaSxKowst7R0bin84pM5jwlm5VUWMOJdzw/ghi8DLNNdpU8nMI7v2Zbn
 tnr9YPnKhe4Q==
X-Google-Smtp-Source: AGHT+IGQjB8yvxO//r9WiqHM3qeim3uvAYGWUR67InSEIJ1uQpDJmSh2tirrrhi3p9h87hA2SAyuGw==
X-Received: by 2002:a05:600c:3b8c:b0:46e:2562:e7b8 with SMTP id
 5b1f17b1804b1-477267bc9e1mr14648825e9.21.1761802834470; 
 Wed, 29 Oct 2025 22:40:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4771904b26esm57054545e9.10.2025.10.29.22.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 22:40:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Oct 2025 05:40:15 +0000
Message-ID: <20251030054029.23511-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015031540.2120-1-wegao@suse.com>
References: <20251015031540.2120-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mremap07.c: New case check mremap with
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
 configure.ac                                |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 161 ++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/configure.ac b/configure.ac
index 0480f46ca..df842c9e4 100644
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
index 4b284f279..6d9a4f1d2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -920,6 +920,7 @@ mremap03 mremap03
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
index 000000000..7acfff461
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,161 @@
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
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
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
+static int sys_userfaultfd(int flags)
+{
+	return tst_syscall(__NR_userfaultfd, flags);
+}
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
+	if (nready <= 0)
+		tst_brk(TBROK | TERRNO, "Poll on uffd failed");
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
+	tst_res(TPASS, "Userfaultfd handler successfully handled the fault.");
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
+			tst_res(TCONF, "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
+			tst_brk(TCONF | TTERRNO, "userfaultfd() requires CAP_SYS_PTRACE on this system");
+		} else {
+			tst_brk(TBROK | TTERRNO, "Could not create userfault file descriptor");
+		}
+	}
+
+	uffd = TST_RET;
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	fault_addr = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
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
+	new_remap_addr = mremap(fault_addr, page_size, page_size, MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
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
+	tst_res(TINFO, "Main thread accessing old address %p to trigger fault. Access Content is \"%s\"",
+			(void *)fault_addr, fault_addr);
+
+	SAFE_PTHREAD_JOIN(handler_thread, NULL);
+
+	if (strcmp(fault_addr, test_string) != 0)
+		tst_res(TFAIL, "Verification failed: Content at old address is '%s', expected '%s'", fault_addr, test_string);
+	else
+		tst_res(TPASS, "Verification passed: Content at old address is correct after fault handling.");
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
