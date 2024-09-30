Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA8CE8347
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727704720; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DCRxY2UvnsjAMQmLo5uVbJ5Pdgs/KedqZR+C9zvS5Pc=;
 b=HmZmoGGfNEGCbLUmQyD2213Hf6SSQr8hQhkfDC157ZBqH+teAruPgSAfbt14PmEUd7gtn
 e4r0bajvs9MaQljnpB5PZlO85W1ed0vWMS/rAV2xomJPGBm1XXChXKIExrHRC+DpwCBCEse
 J7osbf8yNxBR3Lyer5QsLCYwtsnPlek=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90523C5687
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 15:58:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78D3D3C5687
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 15:58:20 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE5471A003FF
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 15:58:19 +0200 (CEST)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539908f238fso1555508e87.2
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727704698; x=1728309498; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rh76bKx6Z4mAxL/IXG7RZ+7Sb/Dhv14GrRSRdpgU6Tg=;
 b=eEdTVXU6r0YrirppXFTKfU4tyRHlaMwnORtU2GI/kpdEF3/pBYvR15PYudBYFEJ7zj
 9aZmUTXEXicA2K9WLyBQUkOypwxcUlSmobVk8t3iI+CVyNT5YQFn3PH0oXKW3ve2BVCd
 XrmWr8J2OAH8yyJkA/oR3Vlg0SABM+6kU4/vV7gSak+S+zsHmRYCbkEwd9Jw05HgxI2s
 dRgqjv/GmK7AXSXMLcZqo2Eg4d/IzVq+CDSpRnRKH3CSt6VP8YoxaeDh+FAlx9Po5FtH
 1OqUCxhKaKaNvn5MC9n/H3nHOvfko1zvsLRTXiaehLTx9YfbMoAU5QBiH5+q/Refzt++
 npGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727704698; x=1728309498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rh76bKx6Z4mAxL/IXG7RZ+7Sb/Dhv14GrRSRdpgU6Tg=;
 b=ZxCv8QC2VYl+jeRja4PfK2/WJYpm21lrhSz2WPNsMDbP+h5PO6bbCl/oars7gzzfED
 zUzyY5emG/d353cqWlRjJBgnFHlENLZPGjNH8zrAtbsIF1+Ixxku8/NBFUOggS2biIJh
 KX7wCrkJUjnj2DXphEsXBHohBP/5TxAcDuC9p+T0DiVr7QDGvfDn7/lsPPw3/YcIm/LC
 wKpdyGwd13zhucWf/RjSd7wrYhpAC3njSrK2PhhlWdP1VSd2oSUV7W2lX28Y8uz5MaSY
 uCCSVEBkopoymbPltgBXROLEFJYUyNeZee3sHYwlYwImq3zv0iCtt087kFCiiEiiDK+P
 i1Bg==
X-Gm-Message-State: AOJu0Yzv2bJKeK67d1vUEJpTP4e1P8sRxUPplShegZrhJd3gn+c96w4B
 FQWiDqmAGZN7tU82W45pLGk/G2Ewbodv2OrsGsPtOYQ1Di4Z0l1PbsVOi+yYOTHto4RTBFngx0W
 q+A==
X-Google-Smtp-Source: AGHT+IHcEcUh6BLe4X5Rro3WSEBAqf4yLOFvm0k6a8prlel4Xc8PKRALyv2SXwFFIC4fy8YoyEuwLw==
X-Received: by 2002:a05:6512:3b0e:b0:533:4477:28a2 with SMTP id
 2adb3069b0e04-5389fc3bd4cmr7406087e87.16.1727704698256; 
 Mon, 30 Sep 2024 06:58:18 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88640fe9asm3518677a12.82.2024.09.30.06.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 06:58:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 30 Sep 2024 09:58:09 -0400
Message-Id: <20240930135809.9300-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240926061936.21499-1-wegao@suse.com>
References: <20240926061936.21499-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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
 testcases/kernel/mem/cpuset/Makefile   |   7 ++
 testcases/kernel/mem/cpuset/cpuset02.c | 140 +++++++++++++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 6055015eb..1404116a5 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -203,6 +203,7 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ "cpuset.cpus", "cpuset.cpus", CTRL_CPUSET },
 	{ "cpuset.mems", "cpuset.mems", CTRL_CPUSET },
 	{ "cpuset.memory_migrate", "cpuset.memory_migrate", CTRL_CPUSET },
+	{ "cpuset.sched_load_balance", "cpuset.sched_load_balance", CTRL_CPUSET },
 	{ }
 };
 
diff --git a/runtest/mm b/runtest/mm
index 6a8cd0b9d..845874c41 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -75,6 +75,7 @@ ksm06_2 ksm06 -n 8000
 ksm07 ksm07
 
 cpuset01 cpuset01
+cpuset02 cpuset02
 
 oom01 oom01
 oom02 oom02
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index d88484fa1..0845297cb 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,4 +1,5 @@
 /cpuset/cpuset01
+/cpuset/cpuset02
 /hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugefallocate/hugefallocate02
 /hugetlb/hugefork/hugefork01
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
index 8e41c0223..366d67ce9 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -19,6 +19,13 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = numa
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+
+LDLIBS  += $(NUMA_LIBS)
+LDLIBS  += $(top_srcdir)/testcases/kernel/controllers/cpuset/cpuset_lib/libcpu_set.a
+LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
new file mode 100644
index 000000000..a62c98b3f
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test check cpuset's mems work with hugepage file.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include "tst_test.h"
+#include "../../controllers/cpuset/cpuset_lib/cpuset.h"
+
+#ifdef HAVE_NUMA_V2
+#include <numa.h>
+#include <numaif.h>
+#include <errno.h>
+#include "tst_numa.h"
+#include "tst_safe_stdio.h"
+#include "mem.h"
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
+static void count_cpus_mems(void)
+{
+	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
+	if (node->cnt <= 1)
+		tst_brk(TCONF, "test requires NUMA system");
+}
+
+static void touch_memory_and_check_node(char *p, int size)
+{
+	int i;
+	int pagesize = sysconf(_SC_PAGESIZE);
+
+	for (i = 0; i < size; i += pagesize)
+		p[i] = 0xef;
+
+	if (cpuset_addr2node(p) == 0)
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
+	if (!pid) {
+		child();
+	} else {
+		SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
+
+		TST_CHECKPOINT_WAKE(0);
+		TST_CHECKPOINT_WAIT(1);
+
+		SAFE_WAITPID(pid, NULL, 0);
+
+		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
+	}
+}
+
+static void setup(void)
+{
+	count_cpus_mems();
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
