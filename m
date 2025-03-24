Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F70C36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742817700; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yReCmNJbT4m6yOxSzDFEP01/ycQU3BlucPrK7U61L/g=;
 b=NAB0oOKvWwWUx5/9ruLJFMYut1SxZa4ltitq3WO8VDP6I8BfPfL0hWVYV4TTZiwEp9arj
 sP0Ex+NHac1oCaaUawBo/dTp8KtInTI6ZxzCrPXjJsUIrtbglERoP74QQNO6DFWgC5PwELb
 DQYDMMKTo4/GPTMzbgxK72VLEIjc+3E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 861903C7AE1
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 13:01:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28A373C8E61
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:01:00 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23CA5601335
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 13:00:59 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso4052496f8f.2
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742817658; x=1743422458; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8N2FoLGoklTVPe35lwA1axE9OPIplsQm+T+B7jwqxoM=;
 b=by20svZT5wH16z/Q/G1Sk/atrxIAje9JnnuEBOANYF4Z6FkJIlcO73aH+UligWptP/
 VEn0ho0B4fR0kZPd1dG4uYfr5/bDPb8wjFHfkl6+YZfoTrenrYV8Sr5SwOJx64wGxsNz
 piRhdZBUxzdtv4fNRBdl8CgCjv0Jpj8z6e/5Jwjx6nEZjsL2BRXc/OnyeeSDQQQiak5N
 FR8LojOztsqsECHTjs4CUU1WwC1Dnl6c6BsL+vvYTMApoobJ2DZC7tJL93o1oVke6uvz
 r+mMfSFotpOuyJEa7gATTiM9nWTatxtI4BJ/MFgQYMm96tTQTDEZ0ifP3+NosNTPRlzi
 ViiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817658; x=1743422458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8N2FoLGoklTVPe35lwA1axE9OPIplsQm+T+B7jwqxoM=;
 b=YjHI8x+wXnDh7i/7y8uj7owV6RbpylqULV8FQdVbPjqpSPYMdYF7nf+1+r0IUh5CSa
 pRT5MR10w3p0OXX6Y3dDGRQXjH10toY84xAw3k+ZPHP+5dsu4aFFj595kQKFZjt9TnP7
 azSeqgrOyMsyG+dicC80Lftfd5sJvWlkINHBF0SFX7kRMeHsgDsINjTgkTTkkB6pIue6
 E8+guX0h0HEgwNO7YXdzRbejEyeSXBqgayo3Wy1QqqLlJuhiqTmmu8EkCiwhREfUQxIz
 ZBO0vsxqrkZmExysNH9qpoXbmLbsmIh49AQ9HuL1a2DYAeEpRYGqFZ9ppSUDufUqN1H8
 I8eg==
X-Gm-Message-State: AOJu0YzAENNXLvVeRIrpaFfshbwcZW6N2rH3cJTWBHR/aeirPKWHDwrT
 lKqFLoDzF9U46Y9HnT0vPtBQgGeasNniwVBY28lkNEam+n+5GqOxrpu1eRpK7bq0pjHcmBHLdPX
 +wouvqtQ=
X-Gm-Gg: ASbGnctLTGpdYTeuZHIcANLogfw39zkvJEs292Jkv1oN/ccBhwzO5762fp3pJaWCF6/
 YXLpg3/NPkVY9WrTrG2RVK/yxXvgtm0M+z/Kn6sq3htIepnNTe/x1GclycV53DOboQIkK1arZfI
 syHUleniqUtysLXRMP3bjaBJU5/2Swg5VOBtXxjkpF25Pj0Lc42Tun0p8C7MqqCnVfCk7CwbjEj
 pkkOJo1r2AW2TRKSXOH7BSvJm0RVD/Gyf+e4licVapu6dlEusakGRXfY8h/Z7Zsb1RHfU0oSMOW
 UxzfJL2BH4tcLC0tOyo/FrizbjHPU/Q+gZ8WZ3k8spUK
X-Google-Smtp-Source: AGHT+IE5u3wgvoTRODlNa1I0yh/HHQwLIy9exjb/+z0pWd5yUKFEyH00NdvpSiPtLKPak0SUCV5V9w==
X-Received: by 2002:a05:6000:1543:b0:391:3cf6:95fd with SMTP id
 ffacd0b85a97d-3997f9144c4mr10743202f8f.30.1742817658053; 
 Mon, 24 Mar 2025 05:00:58 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227bf257682sm21233685ad.195.2025.03.24.05.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 05:00:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 24 Mar 2025 08:00:48 -0400
Message-Id: <20250324120049.29270-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250324120049.29270-1-wegao@suse.com>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
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
---
 lib/tst_cgroup.c                       |   1 +
 runtest/mm                             |   1 +
 testcases/kernel/mem/.gitignore        |   1 +
 testcases/kernel/mem/cpuset/Makefile   |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c | 132 +++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
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
index 000000000..0d8ef055a
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2025 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * Test checks cpuset.mems works with hugepage file.
+ * Based on test6 from cpuset_memory_testset.sh.
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
+#include <numa.h>
+#include <numaif.h>
+#include <errno.h>
+#include "tst_numa.h"
+#include "tst_safe_stdio.h"
+#include "numa_helper.h"
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
+	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 1);
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
+		tst_brk(TCONF, "test requires NUMA system");
+
+	check_node_id = node->map[0];
+
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
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
+	.hugepages = {3, TST_NEEDS},
+	.needs_checkpoints = 1,
+	.needs_cgroup_ver = TST_CG_V1,
+	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
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
