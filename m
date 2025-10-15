Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15365CCD184
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 03:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760498167; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nvpE3+bf9Xz9a59iIwfJU3pwvjxFBqlVgYiqC6dj9g4=;
 b=cVWi0p6MQZUugdwG0vUasuQjIIrLIjV++dQUHxtKegLpCnXj5sYGJrKvvPl/I9iUCxFW2
 TCocHHRvm/MDFtiWC+mtwhSMTGXKKBxEgoIT3oXYmyMjTTBfYnmtp2HWm+mURil//yMsWQF
 oc//nm0a62GarWwrm9tuhQz6kTaqF4E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A713CEC61
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 05:16:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89443CCDF1
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 05:15:45 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCB341400267
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 05:15:44 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4256866958bso3400936f8f.1
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760498144; x=1761102944; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/MydFltt6nx+0z5GcNng8Or6S839apVFBeyvqmvYlw=;
 b=bJTKRjUYzCKTic5tMYDFi8VJkSiMgHgxD+Gyz0FvjLBi7xYs2zh3hsGsd47rlV5KJT
 AOBiCSFicUqVd3n9N21bEYTkE52LUcGhV2hC48oNED31yg9JgDscEz9iYJur/Xt/wHXC
 RTUBaUXg3o8sE4sKjKO8AjULjad19wLKQuRbtiqWBGdx9KPgjgX8IjRkBnqYymO2bOvZ
 cNsGML9onkbnqvRBe7kNjazddC2t0WS+T/bmwo74vUU5qDxUl5vcuhqRcazoUj969gBg
 Vf9CCrWlgm8otzLOT2i46H7TgCoJ/PBAOiHmSzVFMPAG500RajMKZeu5D1CrXnPQ1Qi3
 QgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760498144; x=1761102944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/MydFltt6nx+0z5GcNng8Or6S839apVFBeyvqmvYlw=;
 b=sKOcykHsz3PNdFiKNFGT9hQe+V5HBi8IDb9sKEYD1UTtJIExnKvACveSLx+BQGfEC1
 PznA3p/3i4fLozRdLlDE6W+deLF1WRnQqjbVNZ+sWsJ68g99TPgtnZlKIHuyJNI+fR9e
 rCMb2/qK2AAA7g6LPcqGIDqirEMWP37krltfvKhX1XOx2Fg9imGktT1gt4empO/wVHG2
 vbeqi5aWSXRZzoANKQiNW+IOPB/c+hObGFnKVydWgDE73R1YDTY39fJ4om20TMyfjKxk
 8I2qaBWYrINA8DtZ0ZItqM5OzuYSvUE79/V62hMwA9WLe/9w7umDWG5+bykXav+82LKZ
 ZC2g==
X-Gm-Message-State: AOJu0YwQzUOWMPnoWncUnQPiX5nUITXNiknEPG+63J6ia27rYdkqulvm
 lBw+jaD9jHkNPDtjY0r5sGUh2Z1ZEuCpA9ICtm5y77D/gfLsitiyQOsQXpOkD8nWn3hfRBv0ETq
 PKK8=
X-Gm-Gg: ASbGncs1asOEBCbKWEpi6QpdExBzhaZ6WIQaA9luPLy8nvXl3hRZcZPSz2uR89WBFQt
 tNABj4MO5J3xfnvlkJWvzto0RxUJSojvF2XNX6lmiX5KzPgFBMV/1S3birqbgnUvKj+1Gp6TxN/
 7LpqJIXoA2pxm1vawnOx3dc6OSpmrB+kTdMTQSZ4wt5+XDmAHA1X/2rse0G4bWGmuDyX6d3Eo7j
 3BXiMQ2Aq/NYHECJ/xf47pUiN/3Qf1RDbwp+dfUHIt3XqdPlrUmuDhFqVuTpw5vjzUa0wWpJ0to
 3ijCbfiU08vkj42U7ILo0V0lIV5kt08/9v3bxX8qZfoP6NefA98n7TOvZEREr/0tyiMe6Q5011Z
 75lqKh3q+6Stl/r6eXulIlGqG2x4t9226SsCny0BD
X-Google-Smtp-Source: AGHT+IEVIHISFHTpO4hD9YJ4Pd9qgUU5wu7Hy0e5uJV4WUiBluLv7U6iWUOeJUMC5b8GUaPURJ4FPQ==
X-Received: by 2002:a05:6000:2c11:b0:3f4:c39d:d392 with SMTP id
 ffacd0b85a97d-4266e7df8f5mr18154620f8f.40.1760498143613; 
 Tue, 14 Oct 2025 20:15:43 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-426ce5cf71dsm25584239f8f.29.2025.10.14.20.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 20:15:43 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Oct 2025 03:15:34 +0000
Message-ID: <20251015031540.2120-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827230301.32614-1-wegao@suse.com>
References: <20250827230301.32614-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mremap07.c: New case check mremap with
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
 testcases/kernel/syscalls/mremap/mremap07.c | 159 ++++++++++++++++++++
 5 files changed, 163 insertions(+)
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
index 000000000..db5e1dfd4
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,159 @@
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
+#if HAVE_DECL_MREMAP_DONTUNMAP
+	new_remap_addr = mremap(fault_addr, page_size, page_size, MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
+#else
+	tst_brk(TCONF, "System not supported MREMAP_DONTUNMAP");
+#endif
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
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
