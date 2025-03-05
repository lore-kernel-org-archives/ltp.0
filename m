Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD19CC19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 05:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741151335; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hT6MhSUAlRPFWoM6N37IqtloyMSHzEHgE3ZlXmDO+Oo=;
 b=GU1BOWfauAj8p2sxepmh6lVId9fv6xzeHSwsPwjlIzer6gf5xcuWGsu8emVEIpLThgC3G
 CkmvpOUqr9bSTaPX7dPLVaaAmIwxGUHQYtOzbLrwqw6s0dL/aDXzT7l3vZcN2xpS8pQhWnw
 +0DTq5z/Ax4RS4NsI0rEunSrx/jdnQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC3253CA075
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 06:08:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C85433CA070
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:16 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C39B12131BF
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 06:08:15 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso26779715e9.3
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 21:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741151295; x=1741756095; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sFYAWJMeT1sZDxAvRYaR3xmNayDyosSHePH0fXGcS84=;
 b=GNAUHlQaCRBkuLiCwgZSMrK0SJVgvP7tHwTjhE3ButRdD6y0oPXt9aC3ml05cvsR8W
 hWlnDQPGnyoasQ86YjgZW7mrpibtPmQ4OzPkK7MJdmmtJCVXVLA9W/zEEoYXEYfoqFqp
 GGN7PHemtnf/pE0aLwzES9SQCNOicWNc5mkN8irqvkmpHEEJWV9qZBVzLfqF2h+icPyp
 jEajmXuu258JO6czhl9El1dVd4asS9j7lICiTcqX7mVqAg//lHIj+8IXLa5+IbstaEV+
 mfhR2K3HjSqgHADnXtaZubDuS/uPVddyvzc5qIqSHytjwAi4jlbz1kRQhlkxmRoaUmjR
 qppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741151295; x=1741756095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFYAWJMeT1sZDxAvRYaR3xmNayDyosSHePH0fXGcS84=;
 b=OIJKtGtZGvie4DQxliO47sjbnEbga9Azg+wFPSpQ0/5bqdIpnItjfKhJHZc/k/47+l
 Y4eDkTic4GlfoDUWfCvVBLbcBkKkqSxxpOLreuGQhxhMYhG/IUMdiG9aH1O6EC+yKRhH
 wfJRX1i63X709DyhIAIEOrfjW3YqDiEt++QMhGZmBv57MWhpOHp4QKdejxafjFRfNxHK
 kIlKGGYXtUxFSt+I10td4Gb4xCxpSwtPhdQeoj7m43jE3AZ7n9q3QLNNrx83pWd3NLXS
 7hXa7+75V8U3uKvVrciX0AbaYMnbUl3QxGUdxwdPgboPiXT+y5Sel8QkCEyYiJleaNuq
 8kAw==
X-Gm-Message-State: AOJu0Yw+fS5JTYtqU1vPpl2aS847O4Bui5Jxnj8Sq/pqdUKP7l+PW15y
 fE0/XHL9w4mTOVjevWUWa63AsS+VwdRq6s6eIOCJVDN8MBBQjMsDjlH8FbdLf73mjG/s1HskQGf
 UGQ==
X-Gm-Gg: ASbGncvcf2UXgSFLUO4OxUeHgqaewwf+XVDCnne8qo3IzO9OtCU41nkTic2X483O2SY
 G2Nd41P9wwTLapHPWlPBIN8IFcPulLMdYR634U8CnwRGYfdeoPCaLV5D0QvVm4AT2xpYouPiWRo
 zFtE8fouSUe/eXQa/gDkkzor1j4L3VfM3ioEaXPRc/XXwnTz2o45w8dOIYHI9Lx4wlBIZxPM6J6
 xSfLmivMk2FBC34XFXMt5stV83RRXhb5rAahpOVRHDzqganv/aahmogfqFxyKBTwRl92WN9fFrL
 nzxqAn2ApwmyMO0ASKqQKkCnXySvSHwVtaJy9fyc83ED
X-Google-Smtp-Source: AGHT+IGCuA0R/btNtS+JjYP2xz86xu9TWikhrFF47D0WvYGv+odbxbBmaqwhM7uYFEMOG5UGZ/TSXw==
X-Received: by 2002:a05:600c:458e:b0:43b:ca39:a9ca with SMTP id
 5b1f17b1804b1-43bd299e4c9mr10933955e9.16.1741151294984; 
 Tue, 04 Mar 2025 21:08:14 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c33asm6110675e9.3.2025.03.04.21.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 21:08:14 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  5 Mar 2025 00:08:03 -0500
Message-Id: <20250305050805.7905-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250305050805.7905-1-wegao@suse.com>
References: <20241209060117.16870-1-wegao@suse.com>
 <20250305050805.7905-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] cpuset02: Convert the test6 from
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
---
 lib/tst_cgroup.c                       |   1 +
 runtest/mm                             |   1 +
 testcases/kernel/mem/.gitignore        |   1 +
 testcases/kernel/mem/cpuset/Makefile   |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c | 139 +++++++++++++++++++++++++
 5 files changed, 147 insertions(+)
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
index 000000000..f43d8e98a
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * Test checks cpuset.mems works with hugepage file.
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
+#define PAGES_ALLOCATED 16u
+
+static long hpage_size;
+static struct tst_nodemap *node;
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
+	if (node == 0)
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
+	TST_CHECKPOINT_WAIT(0);
+
+	fd_hugepage = SAFE_OPEN(HUGE_PAGE_FILE, O_CREAT | O_RDWR, 0755);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_WRITE | PROT_READ,
+				MAP_SHARED, fd_hugepage, 0);
+
+	touch_memory_and_check_node(p, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd_hugepage);
+
+	TST_CHECKPOINT_WAKE(1);
+}
+
+static void run_test(void)
+{
+	int pid;
+
+	cg_cpuset_0 = tst_cg_group_mk(tst_cg, "0");
+
+	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.cpus", "0");
+	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.mems", "0");
+	SAFE_CG_PRINT(cg_cpuset_0, "cpuset.sched_load_balance", "0");
+
+	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 2 * node->cnt);
+
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		child();
+		return;
+	}
+
+	SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
+
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAIT(1);
+
+	SAFE_WAITPID(pid, NULL, 0);
+
+	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
+}
+
+static void setup(void)
+{
+	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
+	if (node->cnt <= 1)
+		tst_brk(TCONF, "test requires NUMA system");
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
