Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793B6CA0FED
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756335812; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=XKra+cSFHx+FjI+3by6VEuKqtf6JUy56RKqolmh6NEY=;
 b=G47kIBCCPT2AqSgloGrXlHYxzQS8pLKriqMzFy6xxKqIBizR5Sv4zjxtThIK0XBs/sa78
 ZsFBcM8BHdddeDOr469gq3yV7wNRQ942oz0B/Tpv62zOQkq6KXOdXxo4+p2NagawQwHVXUX
 I9D5pocAMSyy/MfeEK3ucs0rJUyxeKo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102463CD057
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 01:03:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18A6C3CB909
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 01:03:11 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4515314001E3
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 01:03:11 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afec56519c8so51161666b.2
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756335790; x=1756940590; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XxSzUPVS5nXFtubyO3CjFzUmuEKvKf/1vYWjyRgG9Rc=;
 b=OaBzQN802RkLh8Jbm5CgVoOVpqhcwWX8fgVMWOSwxFnLm5BuQQewuBRxmR0Ob201ia
 wus2Ge3Jappmmbvtf1ZVwd18Xkji9QI1ErrKlHoXTw5C+fbCt0ujn2QZX5knsZuVICY9
 eIUsYS6+nTwAh9Ix9FaKSdz/I9mdhkPHnDDddOy7aC+8JCq7+AzPc+eomyqdI2TWjtFg
 /Xgag9aGwdJQuw1KaD2mJ2AG02yZ/wKxuVJe1IK17rRgtg6MgYg9TU7ETQ78O/FLWUM9
 yzehmOLby75Pmfp1SjhF4qnqa/JGZz8k00P8+zr0Jze4ISOgtoPIwc8Nu/gDP5udoWoN
 4hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756335790; x=1756940590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxSzUPVS5nXFtubyO3CjFzUmuEKvKf/1vYWjyRgG9Rc=;
 b=pqTpGBMmrzHU7rSihFDW/roUKUfpqQiZ/OgAhSF3ZzYjiAaR5JdlMx0uGDHkC/zlAj
 1h22qtGlcynBFvP8Z1x08AuZZu1HYs7xhncVNNTVUahm19tvCAhaD4fz7cu26ugfaZux
 KRdPzb2g4ALeVMYEHJ/s4aNsbatrQWWGSSZj+U/vve2vGeGUNnAuc1JN+w34fEC10Lwm
 Xni4cMHI9UfDY0bFV0AbVLRU4m4i7MNN7qHIsIumPeNoJ+J8lCz7baspy75cPKbfI7wl
 jGQbWW5prVqGyOJsH3wV2H/CPZdnZSGRqhTsUyckRT8W9nQhCTtvPcEuVJYUxFuu4U/V
 NPyw==
X-Gm-Message-State: AOJu0YzbDNlGfDsBQWVYYRHhHlMMuDHfl48p3fxLu2OghLu5i8pXU0qg
 gWwlChXWtYJ7jj91c8Rz8JK4oQhEmtVcM0foW1LqvsB6a3nx9uPIb3CGo42QK6nQsyrkKWp+8hP
 /AP0=
X-Gm-Gg: ASbGncvGStD1FZqc1FihqkBH3npXmNCXdogXEJg++xbE8JqbF9km1uhXwvHc3R4oG68
 M24odgTwpctnqFMZz4jX/v4UJUcMH7dAMbraZFhaCH7OYZ0/Tdr5TKroamFigI6+hB5cjcbmvJq
 PCdcm7OCdji6lY5E4ztxSIvLoWuQhaf5xDHNhSCaOB5ewifc/ldBeW2RdmyFpGinSHuRewPz25K
 mzGmW6jMNmah6EVeKJHiTtaFeOJI8ubF+NtK9+lRHx+5jD/Fyzl1/EqalrBQvrnu9LGliW0qyjg
 ev69RaAZnEy3KMjWV4Ffy949PpgOqnx2wxuytXw78KIXozw5EnGvbO86k+0zrWuO2vr2REf+86y
 n17n002T+CvrYXdkLdMLz2MLI3SHaoIlIp0VwuuAFID0Fyxpn8Uki2w==
X-Google-Smtp-Source: AGHT+IHoltx9DVe7+0ssbcVGEY2ZWlXtLKEthCwXF7B+JzNAiTCfUBx280KwboYYdzr39TQ/jyIMpA==
X-Received: by 2002:a17:907:80b:b0:afd:d994:7d1a with SMTP id
 a640c23a62f3a-afe2970a133mr2104598566b.63.1756335790322; 
 Wed, 27 Aug 2025 16:03:10 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afe6bb1337bsm883192066b.107.2025.08.27.16.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:03:10 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 Aug 2025 23:02:58 +0000
Message-ID: <20250827230301.32614-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mremap07.c: New case check mremap with
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
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/mremap07.c | 154 ++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mremap/mremap07.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f15331da3..14ceb7696 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -916,6 +916,7 @@ mremap03 mremap03
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
diff --git a/testcases/kernel/syscalls/mremap/mremap07.c b/testcases/kernel/syscalls/mremap/mremap07.c
new file mode 100644
index 000000000..084803775
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap07.c
@@ -0,0 +1,154 @@
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
+	new_remap_addr = mremap(fault_addr, page_size, page_size, MREMAP_DONTUNMAP | MREMAP_MAYMOVE);
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
