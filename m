Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD7EC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744787840; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Q6jmWywvloZBg9MT0eH2iy72k/OTFRdrjTJWlRhX3sw=;
 b=KqDjEhTqy/dSHGkK/IACH4PyO7QLNMkAJ1n9svcDUU+uM4FZeqM0tNQwUmgzzFfXhJdll
 3uKTFV1V/LTHT7JNzxKSZ9mWU7Z8e1mNfokEs9+bltMi6H29KsBEewdiMzWFBJuEstj9B0X
 qWZGgZZDdlBC6Viar1Ft7VpdHDBwIB8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0935C3CB950
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:17:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28323CB947
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:16:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3D59200755
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:16:50 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4701524f8f.3
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744787810; x=1745392610; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ot4D3IoyK8Dsq+TbQvIXGjH4A8kL0D5bJyFLZq1uF2U=;
 b=bJU1hexzPkDu+IVoh5Lh/6t4QQi66Bsf/GNh8jWiEhq5SpfnuEgwfI7hPVv8wrdmsy
 TkXj/KEclkDrNh2todtvl2+TOG1MFXAVM2VbaxgYTW+Tul/+7K72RkLvBXcBn4WF57c+
 TkDd0Dz4M2QD4bCCBRzXk7T8vUNektG/XxJkapSE5fvfNVnTuQVIc0/OirPIgqLICeT5
 R62LW0pGTzF312IJeN5gk1EssNk/zKRRzmF+Fpg+zifkRhGVTNwhAbYFg2FuCXUXJ10j
 /6IdlvitcVVDYrLY7wPaAGO9eXQTC4pb6finPrtR//fIuPxDRL0Isb/iU0T5o/Kma7Nb
 Dpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744787810; x=1745392610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot4D3IoyK8Dsq+TbQvIXGjH4A8kL0D5bJyFLZq1uF2U=;
 b=tjsOnfCpC8IgOcMJNj3icswEqiktKXdR9GsjcS/Y05h7h3WKbHLIS7aq9TvrZYx+Lq
 aBWxRctppu2qK6oiR1mk9YINND9406R6tlg6ShSMTUH7k9MVOp8ykxoPgOKiDOwWWavJ
 kfhU0gyf0ScEprCg8JwgEiIj2N/DKHRDpN9+lXX+TAI1S7qM1b8+Wo3DqTPWOBm9ycwP
 hJPcBjQ/oewesnlykOLwfC77NYJUD3w3k44vv78UZkRg4Xd3y9hzJj7sO3adK7AcCtzo
 lByORWC8qKuDEEk//ZdsPZWfAN9NwEMoxsN633l+Mit1o0DCONMkvikreZVoxuvx10t2
 JzUQ==
X-Gm-Message-State: AOJu0Yz+XCFDnsRejSBMuXTfL1BIFLzRHWFRSF0TI89fKf3pWJKtkE/L
 umZMlH0TBh6Dx6DqWpoLgriEDRjVAN9+OApAHDw80tkqtENpf4K550XhZ1eJZ8RO50Uu1knrtYw
 32A==
X-Gm-Gg: ASbGncu+bphoqVW1+S2XvGUu1nnX698GHHIsIYMPug5GA/ll769/PZ4HZY0RkZh9LIT
 Y1kIalwYdftX3cMLyRzyXyN9S9jFHsFBizTEwsK3qhK6GilqnVpsFOGWvN5gG5hwGCEFLWnFHsx
 IevHlRsVKT6j73RMo8JHScix8NLPXXm1D8ZyFDrDkvAgOv4iWdfTu7TwJIPngoiFJpPSbL6nwoa
 SwZseJfFETKitMFLvcyRzgvYZNceoCW5VVttBZ18cXZRE86rL6Jlwh18zu47sDrze3w57yb6PID
 +KbyH+9hvcIVMBC/ks4tuXu7wcHipg==
X-Google-Smtp-Source: AGHT+IF3qPisHYzfK6CjKD4koZalwe9Ad6YgBP7Vj9PdtR1gNMQMQfTelfXHOv86cvpDGteGL37p8w==
X-Received: by 2002:a5d:5f82:0:b0:390:f6aa:4e72 with SMTP id
 ffacd0b85a97d-39ee5b16e7bmr690784f8f.18.1744787809720; 
 Wed, 16 Apr 2025 00:16:49 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22c33ef0e83sm7131215ad.35.2025.04.16.00.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 00:16:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 16 Apr 2025 15:16:44 -0400
Message-ID: <20250416191645.355088-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250103135626.28672-1-wegao@suse.com>
References: <20250103135626.28672-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mmap22.c: Test for new MAP_DROPPABLE flag for mmap
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/lapi/mmap.h                       |  4 +
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/mmap/.gitignore |  1 +
 testcases/kernel/syscalls/mmap/mmap22.c   | 95 +++++++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap22.c

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index ea9730586..248b64564 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -87,6 +87,10 @@
 # define MADV_PAGEOUT	21
 #endif
 
+#ifndef MAP_DROPPABLE
+# define MAP_DROPPABLE 0x08
+#endif
+
 #ifndef MAP_FIXED_NOREPLACE
 
 #ifdef __alpha__
diff --git a/runtest/syscalls b/runtest/syscalls
index 932b7030c..e369536ea 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -844,6 +844,7 @@ mmap19 mmap19
 mmap20 mmap20
 mmap21_01 mmap21 -m 1
 mmap21_02 mmap21
+mmap22 mmap22
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 850284d86..075be933d 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -18,3 +18,4 @@
 /mmap19
 /mmap20
 /mmap21
+/mmap22
diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
new file mode 100644
index 000000000..31414896c
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test mmap(2) with MAP_DROPPABLE flag.
+ *
+ * Test base on kernel selftests/mm/droppable.c
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define MEM_LIMIT (256 * TST_MB)
+#define ALLOC_SIZE (128 * TST_MB)
+
+static struct tst_cg_group *cg_child;
+
+static void test_mmap(void)
+{
+	size_t alloc_size = ALLOC_SIZE;
+	size_t page_size = getpagesize();
+	void *alloc;
+	pid_t child;
+
+	cg_child = tst_cg_group_mk(tst_cg, "child");
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
+	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
+
+	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
+
+	memset(alloc, 'A', alloc_size);
+	for (size_t i = 0; i < alloc_size; i += page_size) {
+		if (*(char *)(alloc + i) != 'A')
+			tst_res(TFAIL, "memset failed");
+	}
+
+	child = SAFE_FORK();
+	if (!child) {
+		for (;;)
+			*(char *)malloc(page_size) = 'B';
+	}
+
+	while (1) {
+		for (size_t i = 0; i < alloc_size; i += page_size) {
+			if (!tst_remaining_runtime())
+				tst_brk(TBROK, "MAP_DROPPABLE did not drop memory within the timeout period.");
+			if (!*(uint8_t *)(alloc + i)) {
+				tst_res(TPASS, "MAP_DROPPABLE test pass.");
+				goto kill_child;
+			}
+		}
+	}
+
+kill_child:
+	SAFE_KILL(child, SIGKILL);
+	SAFE_WAITPID(child, NULL, 0);
+	SAFE_MUNMAP(alloc, alloc_size);
+}
+
+static void setup(void)
+{
+	void *addr = mmap(0, 1, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
+	if (addr == MAP_FAILED && errno == EINVAL)
+		tst_brk(TCONF, "MAP_DROPPABLE not support");
+}
+
+static void cleanup(void)
+{
+	if (cg_child) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child = tst_cg_group_rm(cg_child);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = test_mmap,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
+	.needs_root = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+	.runtime = 30,
+	.min_mem_avail = 300,
+};
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
