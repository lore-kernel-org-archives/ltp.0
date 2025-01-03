Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C71E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735912615; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=edljqNfN79puUH2m90irK5fpj5l+5jP4tostGMB+zOE=;
 b=CW6myWxYT2IqUekYUCr1Rm0jx4u52GsjCHiQQTdBl3Y7A+BEbGvIbKKZkMYZZbqAZa8VP
 azAEMMZovwxz+3dFeXGdRxZ8ko4llrdDOORRPuH9kRf9/uLH/0bgDy+GhaZxkENprvXGHNN
 zsQ7b8iTFkSHRv3/wbDpJegeB4qhcqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7291C3C070D
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 14:56:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CB4D3C05F8
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 14:56:33 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5AF74142EA15
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 14:56:33 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso89224505e9.2
 for <ltp@lists.linux.it>; Fri, 03 Jan 2025 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735912592; x=1736517392; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vYM49MSzUlNcP8ooUuLdEq/81m81BzpYjH8DPkE9Ow=;
 b=Ku/iljDZ2C+tu29nOxF+7Nai7pddVDZmU8W1y6nA8JQvTC4mmALoXYNp1k3INHpz7t
 pPfRfNC4OO1Kf/puAUDVBkZJfIEcz9nMg5gjLBVz9rRs6K310UsFu4ef0uYjuqBJCGxr
 GmT1I/ZBJNW1P9FvTgD7YYJQRDGDl5cwXHm7keSwoJGPmFCNDMzNcglVRTAfXABLxbpR
 43a+If5XD/taetdsYBZgEDoC/3rsDLLd+l6Py5PFPJ98qwq4uz/0i/JGFcJbxnwZWiLY
 N2Js5Qpz0UrICjBdvEDRxQptMiOdYsqELOJ9dl+MCOXPe6DLhMkynCE2cmNYVz+uK8rs
 4lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735912592; x=1736517392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vYM49MSzUlNcP8ooUuLdEq/81m81BzpYjH8DPkE9Ow=;
 b=heR1SqQgxDlAnAYogRiNSLaAp1hgTsjMR9QoTXi0BlZ1fY10ujOm6MDPeennad4azt
 uCSFw/Dm/CzawtTAioLJ7J4QAg0uOI9Ivp8OaeSbrJAClUcTLKUqd5fXf3ypiXyMUl/s
 mPZZ2MT6DXHWW/dQ+WIY/KYrxtZLV8Q+AwtVCEqghiWFR+s4QUB0kFkuKq3EPhXBMMaf
 XnAxcI1k56DcEQCLbNQlPramEiOqCIG1x9VCt+dv+ZZfavfDepg/kULYgHl3RJL0Ol1G
 5PkfpZ8nW/MJBkO6rPIPBwCLrsHI5XUMV9Hb5VwIozNGIsRETAYRtDjf0iXk0o/v3QU5
 of9g==
X-Gm-Message-State: AOJu0YyMbWVxA4wX9ebEKzt0UxiGXVDyanqDwpJICUWOcwOkIBWwutYG
 ZgXSBAPq9mHyGslJFPkwU3drFFZSDVWm7lEObPDFSBIX5NhrzDVgQsbmjN/G1QEY7sWqK1eSj05
 76Q==
X-Gm-Gg: ASbGncvZFotKyBrYPgJXwvOCCrV3QLL4U7kU28+QlVzEZ3Q2y1h5yFcMLBTG/MywprZ
 3FomE5fv88P5+cLpCi7thPe7dq1Mgi/coyslrrpnJ9Tx+7lNMEmuyXhri6A8CGN82+MVY/xeDXE
 XjNfWf/RWfJAPX/H+1LB8N2W7pn3wdnI1g77qd544j2whpktrVmRt65BGblnjpXFsLwB44lqKPS
 FAmgEYF2RH94q95op33yn4H5MGPn0LzuaGUqLZ1Jidm1g==
X-Google-Smtp-Source: AGHT+IGTeH9ggVnGBlsxtCfpUupGhde5pVhmWvou0rtJiXGBov2yLSw+jAK2bj0nOWFJDy/jZKL0ow==
X-Received: by 2002:a05:600c:3b8b:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-43668b7a1f6mr332032925e9.33.1735912592190; 
 Fri, 03 Jan 2025 05:56:32 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4d7sm483197855e9.34.2025.01.03.05.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 05:56:31 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  3 Jan 2025 08:56:26 -0500
Message-Id: <20250103135626.28672-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241228133217.28945-1-wegao@suse.com>
References: <20241228133217.28945-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap21.c: Test for new MAP_DROPPABLE flag for mmap
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
 include/lapi/mmap.h                       |   4 +
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/mmap/.gitignore |   1 +
 testcases/kernel/syscalls/mmap/mmap21.c   | 102 ++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mmap/mmap21.c

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
index ded035ee8..7166e39a4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -840,6 +840,7 @@ mmap17 mmap17
 mmap18 mmap18
 mmap19 mmap19
 mmap20 mmap20
+mmap21 mmap21
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 4591fdbb9..87b23aaee 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -18,3 +18,4 @@
 /mmap18
 /mmap19
 /mmap20
+/mmap21
diff --git a/testcases/kernel/syscalls/mmap/mmap21.c b/testcases/kernel/syscalls/mmap/mmap21.c
new file mode 100644
index 000000000..46f3ac7c5
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap21.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
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
+	int *shared_var = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	*shared_var = 0;
+
+	child = SAFE_FORK();
+	if (!child) {
+		for (;;) {
+			*(char *)malloc(page_size) = 'B';
+			if ((*shared_var) == 1)
+				exit(0);
+		}
+	}
+
+	while (!(*shared_var)) {
+		for (size_t i = 0; i < alloc_size; i += page_size) {
+			if (!*(uint8_t *)(alloc + i)) {
+				*shared_var = 1;
+				break;
+			}
+		}
+	}
+
+	TST_EXP_EQ_LI((*shared_var), 1);
+
+	SAFE_WAITPID(child, NULL, 0);
+
+	SAFE_MUNMAP(alloc, alloc_size);
+	SAFE_MUNMAP(shared_var, sizeof(int));
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
+	.min_mem_avail = 300,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
