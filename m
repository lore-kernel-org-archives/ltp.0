Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A253C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743148852; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Ng0p6KjWxxjNZBGlY8GP7iN3amV7JCFWTjdWb1Wq/cc=;
 b=RKgW5PMefxUbHnYtjo08k2eCdbiCqz+6vaH7ThKzVOKf8N9fPiKFjZ4abbYhgRcq4a1A9
 8kBmv16JWea1TSClLBCIsBvLTm3J+sA6dFz82j1vRIR+nd8nlNvAhuvFK3++yBPPWiGBwUH
 04nVbgWdnW1HaLTFkyoQ87NDNEbY4vI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B74943CA2DD
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:00:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAC813CA20F
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:15 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3298D1400989
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:00:14 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso12796435e9.0
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743148813; x=1743753613; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewuVf2k6mgoX15CsBl5lNbRiqiwI6diEmmwNv+j95ao=;
 b=c5C1HFBXuo0VpMM3NwWb4vRTwOCLlidjr1oxXoGSDuRYmewCZRNLj8M08syskETFQi
 3mnTkM7uUzSYiV8kHxhVvhecyHTaxCQCN4/35mSgR3czokZfXha7sOpkI9ovdw4jVgS5
 3tTS1pNuPTqR2+06euF4wySQD5Y1lxZyUz75gQpDHRzI81duub+DLXn3R+bs4NWsdOV7
 uyKccYiFS6+zTuWyzjoIQpViGeFzYY7aQYFAw+gCH2XFwUMczJh6OcTrA+NoHBKgxk/G
 lOnL/ipUva/DCpjQzsSfDSbm9G5UXyDEz4O/Z4Mwdeu/a0Z51FBS+pWuQ0JlsPJEUMiG
 DYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148813; x=1743753613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewuVf2k6mgoX15CsBl5lNbRiqiwI6diEmmwNv+j95ao=;
 b=vav6BwI8GRIdRlOKqufNAtKUvnEFsj/qaf/tmzBsRqYYERTwr4y+T9/Qww9QRghV5G
 C0KrVWa80npcWPLRLXzc9UYeSBv2fD1+3WV/Kbl/lEk45wJo7f3IKNU2MTN5IDqQEDjq
 Tg24H2e4izOtSZvT+FiKAPlHPWbQU+y2RZZSjwRpLat5iCvxLeJmlQrJm6CUwTBOne48
 wUDBYB+LjXkwXdvmsS2NX06v+BkJbGSH0vwlvTPRnETGkAAOXzue7/qMqOftwTj/GeSA
 Koe+yrt2hM3rHIAHbDtXgO3uDdYhCxRlAjYZBBbvcY0nCM42W3qexbGUkskMHLNBcH3k
 3sPQ==
X-Gm-Message-State: AOJu0YzK7JgF+tgmrmvoIGt44cyPLnkUDPeVtp/fvDSi+FFIrNx0lEXb
 eW5NWm2/oP6nHhcEQ4xc1jikMydjYzLArgh3j3wceSwQLBSaOmNIdDYScPuAPm6CtWmzP+M6LbM
 fqDf4
X-Gm-Gg: ASbGnctXjVP/UtXdMK4ovaZbcBbFqSLU1bpG0EiSfxFcr80quEMj6CPjyA/BGBQw+++
 sRNnOVTdGwNFUxg7WI9h3MwxyHjvcQCQ8+2Q91f87mG8YNzMAtE55qoJKMWk/atlwGXH4qxqaQK
 fuyROe8H5p1FJRGjShKxq6RI987gX9Oq54hDyCB0aPauzPozrQCm8ZG74ZHHt0xgxslkqwgsdc8
 WxI70tb4Ciy/An8fAB63pvCaESIZrP5V96fJoJiilK+xJNhZxZOMqGvNIA+n19f2pOBa0w8s8Ub
 aljrPovJE5V4yBl/36jtTd4JItiV6TPM4w==
X-Google-Smtp-Source: AGHT+IEkcc7YKXITeU9tbUo6L2Cp+Qq2VXLi4zYsILmx0xW+tYtwrCXqRlqmHGsJ6LYXO6d8oBylpw==
X-Received: by 2002:a05:6000:4011:b0:391:2e97:5788 with SMTP id
 ffacd0b85a97d-39ad17889c5mr5291568f8f.55.1743148812761; 
 Fri, 28 Mar 2025 01:00:12 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a8d4sm1831179f8f.45.2025.03.28.01.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:00:12 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 03:59:57 -0400
Message-Id: <20250328075958.7616-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250328075958.7616-1-wegao@suse.com>
References: <20250324120049.29270-1-wegao@suse.com>
 <20250328075958.7616-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Li Wang <liwang@redhat.com>
---
 lib/tst_cgroup.c                       |   1 +
 runtest/mm                             |   1 +
 testcases/kernel/mem/.gitignore        |   1 +
 testcases/kernel/mem/cpuset/Makefile   |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c | 138 +++++++++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 73b696c58..545c779e7 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -204,6 +204,7 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
 	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
 	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
+	{ "cpuset.sched_load_balance", "cpuset.sched_load_balance", CTRL_CPUSET },
 	{ }
 };
 
diff --git a/runtest/mm b/runtest/mm
index d8e62af81..5af29b0ea 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -75,6 +75,7 @@ ksm06_2 ksm06 -n 8000
 ksm07 ksm07
 
 cpuset01 cpuset01
+cpuset02 cpuset02
 
 oom01 oom01
 oom02 oom02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 699e022fb..e24e96001 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,4 +1,5 @@
 /cpuset/cpuset01
+/cpuset/cpuset02
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugefork/hugefork01
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index bac13e02b..7010c7be4 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -19,6 +19,11 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = numa
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/include/lib.mk
+
+cpuset02: LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
new file mode 100644
index 000000000..26b77f8be
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * Test checks cpuset.mems works with hugepage file.
+ * Based on test6 from cpuset_memory_testset.sh written by Miao Xie.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include "tst_test.h"
+
+#ifdef HAVE_NUMA_V2
+#include <numaif.h>
+#include "tst_numa.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define HUGE_PAGE_FILE MNTPOINT "hugepagefile"
+
+static long hpage_size;
+static struct tst_nodemap *node;
+static int check_node_id;
+static struct tst_cg_group *cg_cpuset_0;
+
+static void touch_memory_and_check_node(char *p, int size)
+{
+	int i;
+	int node = -1;
+	long ret;
+	int pagesize = sysconf(_SC_PAGESIZE);
+
+	for (i = 0; i < size; i += pagesize)
+		p[i] = 0xef;
+
+	ret = get_mempolicy(&node, NULL, 0, p, MPOL_F_NODE | MPOL_F_ADDR);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
+
+	if (node == check_node_id)
+		tst_res(TPASS, "check node pass");
+	else
+		tst_res(TFAIL, "check node failed");
+}
+
+static void child(void)
+{
+	char *p;
+	int fd_hugepage;
+
+	fd_hugepage = SAFE_OPEN(HUGE_PAGE_FILE, O_CREAT | O_RDWR, 0755);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_WRITE | PROT_READ,
+				MAP_SHARED, fd_hugepage, 0);
+
+	touch_memory_and_check_node(p, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd_hugepage);
+}
+
+static void run_test(void)
+{
+	int pid;
+	char node_id_str[256];
+
+	cg_cpuset_0 = tst_cg_group_mk(tst_cg, "0");
+
+	sprintf(node_id_str, "%u", check_node_id);
+	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.mems", node_id_str);
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
+		child();
+		return;
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
+}
+
+static void setup(void)
+{
+	node = tst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
+	if (node->cnt <= 1)
+		tst_brk(TCONF, "test requires at least 2 NUMA memory nodes");
+
+	check_node_id = node->map[node->cnt - 1];
+
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+
+	char path[256];
+	unsigned int i;
+
+	for (i = 0; i < node->cnt; i++) {
+		unsigned int current_node_id = node->map[i];
+
+		sprintf(path,
+			"/sys/devices/system/node/node%d/hugepages/hugepages-%ldkB/nr_hugepages",
+			current_node_id, hpage_size / 1024);
+		SAFE_FILE_PRINTF(path, "%d", 1);
+	}
+}
+
+static void cleanup(void)
+{
+	if (cg_cpuset_0)
+		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.runs_script = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.needs_checkpoints = 1,
+	.needs_cgroup_ver = TST_CG_V1,
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TCONF},
+		{}
+	},
+};
+
+#else
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+#endif
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
