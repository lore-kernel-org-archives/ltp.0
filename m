Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B33C36005
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 04:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745813096; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=t7f0gvX6DCjsFo8RhK3eKo3HVBdrCiTEqKEZ97uezeE=;
 b=eOdOby5004vstCNQUwY87XYJznwW/K+/FkWaEXN3gyZBvm6WqbdDK0g4PSCLrfuvaLlCP
 N/HqPPX/s1APJX5blzog6jiH0TWHmDldOhBV4xTl+he/P1f8cOf9NzXjA+VTWEgwmdHbUwh
 zk1JsCfkuGZMtYDzxspoefqm7ReN7KI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4DC3CBA3F
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 06:04:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A5A63C0626
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 06:04:34 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C37811A0090D
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 06:04:33 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-acb615228a4so935865366b.0
 for <ltp@lists.linux.it>; Sun, 27 Apr 2025 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745813073; x=1746417873; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRU1SR0JBDGbROLSxubSTnrPjyW8Dvfu1Syq9rCC9DA=;
 b=XngUNgkJgju/UzA6aX1OiFufS4tp7ABUBhL3ZOan8/oR5nX1gIF+W6nncbsXjNj465
 jIiLybOeTrpYvu6cVgN1w4Br9r6aQEV2Jp3Bv5+8gkj15PtScD3ooPJtn/1cNzF7pCSw
 wq/VJJQDnTBoxjIs5A0TDDD99U5Z0o73FZShTIvKjNWJWCkFgxWf3m/jjRrhEx8O5dCH
 H4hakOJ7zKqkBd+D0gHMGzdOvOdravzym0g/V4fwJyZa30zdXzynLafY668yQgn8rp4w
 UkDDrG6emKvrNeGlVqqg1a0hHjfWOey1WFTz7lo6eAQIJRMixX34a16/RPRuBiodo5gu
 eQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745813073; x=1746417873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRU1SR0JBDGbROLSxubSTnrPjyW8Dvfu1Syq9rCC9DA=;
 b=Ko5bwF8edkBUUULhm8aMTlovthqBQmIVaWlGufxyNn1Dl2t4nCcCPKRqKsirW7fI7E
 hIQiLCJEztjtSD7M6BLXZwfvdAY2VB5B+3FFG3HovkBCmB1uiaVyFBYxl6bwugaUZgpe
 EwNeVwqHKuR7YWq9JlFV85buE1tso1AHTaKnv7yCx+g2DWp4NdzpIk8v03f942nBULGn
 RNNe+SFGyLfrDCwttM32LH/j4QZVigu5bgLjwCQbedHl1GHGQxNQrZ4E2S2W9PIFlLy8
 rV1V/2oC5BLCB8AxSesLlDJ1QfgiELamnvyTHCEoxakTndf0HEerYiMWKKOqzVxZOm83
 mzfQ==
X-Gm-Message-State: AOJu0YxrwJGHZt03FTH/Pp5+CDuv25WnaW+PRHStFkilqqLDaFsmQiQC
 w9plghy1zZkT8agxqZ8pB4wG/lcU4JfOhYU+4Vi2IHBzBXi/2jdVKZ+HLFMC2EPrs1ec937N7mx
 hXQ==
X-Gm-Gg: ASbGnct8Jn+0QKSqHr6g8xExwDPWxCq8B/EhMRjwoLa5DoiDRyIdpJmAgf2nJKgqzF4
 OEXOeAgqn+4cKRQXamMMV3W7U3Yjh2Gwn0MMoKUDgv8/PU7kRY06dm9jCpkwzDP885csxPLHqSR
 LhOtIZajRly+8whkVXyEPoEr5us34eR1blLyp+fUiD4u5KP98AQiOTFuXPgUzMmeG/rCQIzG4sM
 5Em28Gd/20CKUmrBeYehApqH6OeaqmCTb6X54PVkvEf5UOC8ap4k5nXHKiRZh4STyE9jIyulYaY
 RkKQ2XtgAXp6xz/1pEnVN1yandH/eA==
X-Google-Smtp-Source: AGHT+IEApS9kOe7nWyr0xde2QT9/bl3XmMZlPGcNXCVr8bmty4bhGXu0teuRrQsLrv8C+0cKbi2tzA==
X-Received: by 2002:a17:907:3d4c:b0:ac7:334d:3217 with SMTP id
 a640c23a62f3a-ace5a27b8b0mr1211880566b.12.1745813072849; 
 Sun, 27 Apr 2025 21:04:32 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50e7bd0sm72014305ad.127.2025.04.27.21.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 21:04:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 28 Apr 2025 12:04:19 -0400
Message-ID: <20250428160421.3457215-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416191645.355088-1-wegao@suse.com>
References: <20250416191645.355088-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for mmap
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
 testcases/kernel/syscalls/mmap/mmap22.c   | 98 +++++++++++++++++++++++
 4 files changed, 104 insertions(+)
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
index 000000000..bfef559e4
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -0,0 +1,98 @@
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
+	char *alloc;
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
+		if (alloc[i]  != 'A')
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
+			if (!tst_remaining_runtime()) {
+				tst_res(TFAIL, "MAP_DROPPABLE did not drop memory within the timeout period.");
+				goto kill_child;
+			}
+			if (!alloc[i]) {
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
+	SAFE_MUNMAP(addr, 1);
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
