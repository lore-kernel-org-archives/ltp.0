Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999FF94CBB
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 02:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776825106; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=QNYJeuZWjRZWOzr+6u1uUnt63DqJQwSTmG+hgdzLOHQ=;
 b=FyBBTOQVK1ekrwikzA2CrVNwezHep4GPG0HpuWyH/Tscxuy07zyI+7WzBwzD9QF9/uPld
 LT04ira/5RokqNumTOOBqtO/pwLXxA+H1SViheSveqDQsv0s7beOLihf6/2e00HNV4hLgfO
 WBxV1qPTju0xsOl3+6yQAFGa27jsME4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59FF03E2DB9
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 04:31:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65FD93E1DD1
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 04:31:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 941DF10000C8
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 04:31:19 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so30705625e9.1
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776825079; x=1777429879; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh9g/eFpyClu+URyxsQhLkM6pC165eUMQ//eqGZR2yo=;
 b=VCkGskWkdw/3HJcepSvnLEZJjeehTT6v7XfPm+Uuo7XnsMBztKTUuTsZ8Jqc+rorf8
 M3jqsTb0pJ3xaPxbwQT9MYtZHCwaCxPiojC0H6GQUBo+0qhWEBdEcUTOYdI/b6EMEqD8
 ZYHHbEN67NNl1+HiXFVIv2Bos5txCnha4Ym98d9rOlMr3ro/wQ1xAV3huT2xwp2tDKqu
 kBiN2nyrzSo1cVbuLslKclGUdEJtMjxbI69iDXV3uZyVfcd5YWls047sTN7MptsSLGEV
 rOKF7Fp2lvoHdv17kklCjKoqVdOExte+H0oJesPHX6bQSyVpm0BE/Q5pEg/cYhYY9bOL
 6POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776825079; x=1777429879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wh9g/eFpyClu+URyxsQhLkM6pC165eUMQ//eqGZR2yo=;
 b=RlhTJY6zwjbaCAP7A4KrbVgs+YAFTFTXBj38Vbx+eo/qnryMoM+77KH+91NlU5bW82
 dlL7NFd4rYd41sy7PD/Hui6wArVj8VEYKPZbtpeQcqvCm2sYrarmZ9eGlqw+AzB1SJMy
 SJRFtPlqOvSuJOIEoqHzr1+caSoYwLI5tGl8FIDEChdsmMi+yya13qGSr6vxFnl/Aw5t
 QAoH7+rwZUzmj5mRrm14waB5KgzOBP3p3VC8Re9kmHt/cjtgL/pLSXHcDsG+I452wjfb
 sXJcct8dgQA23Dzt2UXobQbxT9t0UE0xfY4SbXBd15U2X3BKB7hbsxat13lzXLkUq93s
 OgYQ==
X-Gm-Message-State: AOJu0YzoodB0EnKIBpJvHuIxHPGNO5wK4XQ3tvmWIGXaHDcXKh89k5UE
 kEaCgJf/6xvn4bf8uBtGRK0ifkCmQVkUR5kKEb1FlMShHCX8yJg5QL9CmyDzMh1DOuQv73aWc88
 GFi4=
X-Gm-Gg: AeBDiesomNLWKpIJR9kkwXCGLxK+8H9a/uwZMNV1MC4hsNHW8wLqvc3xouxyqQ1gW2N
 I5on+UCdzKDf0a5Ou/39ddVCFII4VOAolJF3D8nCKX4OujSjBVXf4d+zsEBJDVSc9Nywsixncgn
 9qMt6xqTxvJNz8srHT0OEEPFfu4xY//jnwauyCoTOhjzgjOgXLkJ0NV9FRzR/N3gnbve4Sfhk2q
 5pRH8FM4igikhX+qv/4P+DSv6hvI8Pa/Mu6wQkAG1GvBwX5+FxolMHN76pDcM1MOItnT5QPj+3/
 lqJiWdI76HOOHUpyYCQOEELG0WUGxvhW0xBY253lxVZjsMm2ftl4G3dPZTKOKgZVuzkVcqCvp5+
 Zcam1swMP4vDng8vMggO1LNIWKC2B3/YnNRobg0dVW5FsZ+bCGxNennGTZ3diuLCUilAh4xjcH1
 dorNANEoAFstqNBrjSfBX43w==
X-Received: by 2002:a05:600d:8451:b0:48a:599a:36fe with SMTP id
 5b1f17b1804b1-48a599a4413mr16113895e9.24.1776825078670; 
 Tue, 21 Apr 2026 19:31:18 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488fc1393f5sm385782145e9.9.2026.04.21.19.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 19:31:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 Apr 2026 02:30:59 +0000
Message-ID: <20260422023115.27534-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417122804.23890-1-wegao@suse.com>
References: <20260417122804.23890-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9] mremap07.c: New test for mremap() with
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

This test verifies the mremap() syscall with the MREMAP_DONTUNMAP flag.
It uses userfaultfd to verify that accessing the old memory region
correctly triggers a page fault after the mapping has been moved.

MREMAP_DONTUNMAP behavior with userfaultfd was not covered by existing
mremap tests. This test provides coverage for the feature requested in
the linked issue.

Closes: https://github.com/linux-test-project/ltp/issues/1168
Signed-off-by: Wei Gao <wegao@suse.com>
---
v8->v9:
- Removed `MREMAP_DONTUNMAP` check from `configure.ac` and moved fallback to `include/lapi/mmap.h`.
- Renamed address variables to `old_addr` and `new_addr` for clarity.
- Replaced hardcoded strings with `TEST_STRING_A` and `TEST_STRING_B` macros.
- Improved code formatting and indentation.
- Removed `.min_kver = "5.7"` in favor of dynamic feature detection.
- Added runtime `EINVAL` check to trigger `TCONF` on unsupported kernels.
- Added verification logic for data content at `new_addr`.
- Fixed stability issues for multiple test iterations (`-i` option).

 include/lapi/mmap.h                         |   4 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/Makefile   |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 164 ++++++++++++++++++++
 5 files changed, 171 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 248b64564..3908310f4 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -91,6 +91,10 @@
 # define MAP_DROPPABLE 0x08
 #endif
 
+#ifndef MREMAP_DONTUNMAP
+# define MREMAP_DONTUNMAP 4
+#endif
+
 #ifndef MAP_FIXED_NOREPLACE
 
 #ifdef __alpha__
diff --git a/runtest/syscalls b/runtest/syscalls
index 5025b259f..df5dc02b5 100644
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
index 000000000..ecd8319f9
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Wei Gao <wegao@suse.com>
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
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
+#include "lapi/mmap.h"
+#include "config.h"
+
+static int page_size;
+static int uffd = -1;
+static char *old_addr;
+static char *new_addr;
+
+#define TEST_STRING_A "ABCD"
+#define TEST_STRING_B "EFGH"
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
+	if ((char *)msg.arg.pagefault.address != old_addr)
+		tst_brk(TBROK, "Page fault on unexpected address: %p",
+			(void *)msg.arg.pagefault.address);
+
+	tst_res(TINFO, "Userfaultfd handler caught a page fault at %p",
+		(void *)msg.arg.pagefault.address);
+
+	uffdio_copy.src = (unsigned long)new_addr;
+	uffdio_copy.dst = (unsigned long)old_addr;
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
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	page_size = getpagesize();
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	old_addr = SAFE_MMAP(NULL, page_size,
+			     PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS,
+			     -1, 0);
+
+	tst_res(TINFO, "Original mapping created at %p", (void *)old_addr);
+
+	strcpy(old_addr, TEST_STRING_A);
+
+	uffdio_register.range.start = (unsigned long)old_addr;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+}
+
+static void cleanup(void)
+{
+	if (new_addr && new_addr != MAP_FAILED)
+		SAFE_MUNMAP(new_addr, page_size);
+
+	if (old_addr && old_addr != MAP_FAILED)
+		SAFE_MUNMAP(old_addr, page_size);
+
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void run(void)
+{
+	new_addr = NULL;
+	pthread_t handler_thread;
+
+	SAFE_PTHREAD_CREATE(&handler_thread, NULL,
+			    fault_handler_thread, NULL);
+
+	new_addr = mremap(old_addr, page_size, page_size,
+			  MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+
+	if (new_addr == MAP_FAILED) {
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"mremap with MREMAP_DONTUNMAP not supported?");
+		}
+		tst_brk(TBROK | TERRNO, "mremap failed");
+	}
+
+	tst_res(TINFO, "New mapping created at %p", (void *)new_addr);
+
+	TST_EXP_EQ_STR(new_addr, TEST_STRING_A);
+	strcpy(new_addr, TEST_STRING_B);
+
+	TST_CHECKPOINT_WAKE(0);
+
+	tst_res(TINFO, "Main thread accessing old address %p to trigger fault",
+		(void *)old_addr);
+
+	(void)*(volatile char *)old_addr;
+
+	SAFE_PTHREAD_JOIN(handler_thread, NULL);
+
+	TST_EXP_EQ_STR(old_addr, TEST_STRING_B);
+
+	SAFE_MUNMAP(new_addr, page_size);
+	new_addr = NULL;
+	strcpy(old_addr, TEST_STRING_A);
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
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
