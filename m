Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97BAC28B20
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 03:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743391238; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xmZPbROAPWc4+Ev8jlp8PAgomxZr06iv/B4Mzt8kaTk=;
 b=QQICw70lQscxxhIr4EBEEaBycHa4B/0fVf0ho6WxiTwmUswa0RioFzspWzOZ6xxJgyC91
 +1caxdKI75Qbk3WVB8OH9YZE841FryPA5rkEudf3ZsicECijOwJY9WV4af20Xf2b/V8OU7i
 cz42Sm1s/6l2vQIsVeXiljVqRc5pH34=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4D243CA846
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 05:20:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C7953CAAF4
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 05:20:00 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6B21C1A01976
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 05:19:59 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so33445835e9.1
 for <ltp@lists.linux.it>; Sun, 30 Mar 2025 20:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743391198; x=1743995998; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef8i6rfZZ6shZ0DME3qcJbjBFD6V4qOJGbDNE4B1yV0=;
 b=HkQs59Y+rrAY8WLbpf2CBRFrdRCWuRxF/J20QVsJzQxP52phV7Xpd2yHtVGtiAe6w8
 ddWdFR6CRYXM/fph54u4763D4H8mAi2fCh/gavmm8DWffIR2xGcafpmm5JnPGxPQaq0G
 XGz3isSwrd1E54EpM4He9npyatJ3mDGUfCvF9ybdMIKtLAT/gTdGxDFdp3LZmwEzURe9
 57y602lHPK09aFZAeNePL3SYPjzo9GkixhFYQQivM+tpmaE0vJyYFn1wMgSDlXqk00cM
 hfiDM0WW5fc/UuVubeN1+vYCB9q65c6ej2rUTM0gtXupL+YbG3AVZOHkVgVIxNDoQze5
 QoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743391198; x=1743995998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef8i6rfZZ6shZ0DME3qcJbjBFD6V4qOJGbDNE4B1yV0=;
 b=cZ1cDKncZRQH4QxMkMkJvAh9oKjXpoTHMx/vOQCmSJ3R7oAu/qqBJiEMSfth4N2xS+
 3uLNuH1c2wXw9ySANganVTUD7WjC1CGUrkeSoy09mSzgr9bf38MEo8e0xFObBSIcpYDJ
 yge1mAXoi1ZSf68wQ3/ujY5AmO63CmKhpw+X5fif+tsMFuUcQquYSIp0d1Y13Z7r74Lm
 /Uk9c1FIV8gofdEMppddxlU7sA57A+wBL0tLZDDTUIxHj4MUpGAH0hw4gGfP/3orGCxe
 u/Om4jIH7FHpOLkwnhiDrzzmlZG9cTqOTbUH5TgHgNOo6kAResTXgYypzIVFPHWQ5efd
 Z+oA==
X-Gm-Message-State: AOJu0YxrYmj0x14+11wCQc6E2TDweIi79fgOJNJe74qCC81w3hd/uMI4
 WWwRF79Uo4VgZSCJyBRT4p/83QHFh0ScCK2fAFfMU9az7aqIdTZWNuxJwg2gmj8WTZVxnkBg4HP
 1kc19
X-Gm-Gg: ASbGncv47RguFqjtWqRG50XVNLXaG0BdPJHKzwc8PDhTkaTDBWnZ2FoDBFKk1Orw6EL
 c+JESOTHLk6m3KwSZY4qHpusS7d4sus1W74IHYk8VEYojgycBbWyEKtHuEk0a0pdaJOC+Og1EOm
 X3PICYgMu7eg9iI5BfQqmGPxIwm1VKtplnxXeCPVNGgnqeWDiA7Mlmiv+D4OKV5WHBSSXJ4G8og
 3WE4sCfYepIlJ3U+B9tHiN+MKQLkGSssyMp4EB3n1nrNYdn/sTdv5QLdCThyHCqioTn7UzyIzof
 nJ/cmUUJANL0nFMjW8hLwDt9BlAvHRnOZw==
X-Google-Smtp-Source: AGHT+IGOHwRRzIUZn4rtMaRoq6N7AxPwrOZD9YjhZpwy0fe28hJiuugqAqSvSrefHMb3kAgUoPyAUw==
X-Received: by 2002:a5d:47c6:0:b0:39c:e0e:b7ea with SMTP id
 ffacd0b85a97d-39c11b9b858mr6243546f8f.20.1743391197975; 
 Sun, 30 Mar 2025 20:19:57 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e141sm10085563f8f.77.2025.03.30.20.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 20:19:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 30 Mar 2025 23:19:44 -0400
Message-Id: <20250331031945.5948-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250331031945.5948-1-wegao@suse.com>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
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

Improvements compare with test6 shell test:
* Remove /bin/echo $load_balance > $path/cpuset.sched_load_balance
since test focus on verify huge page is really allocated in the correct
node, task no need bind to specific cpuset.
* Directly keep 1 hpage reserved in each node otherwise test case has
chance to fail, since `echo 1 > /proc/sys/vm/nr_hugepages` will try to
reserve 1 pages from a NUMA node randomly.

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                             |   1 +
 testcases/kernel/mem/.gitignore        |   1 +
 testcases/kernel/mem/cpuset/Makefile   |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c | 140 +++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

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
index 000000000..1e239afa3
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,140 @@
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
+		tst_res(TPASS, "1 huge page allocated on node-%d as expected", node);
+	else
+		tst_res(TFAIL, "1 huge page allocated on node-%d unexpected", node);
+}
+
+static void child(void)
+{
+	char *p;
+	int fd_hugepage;
+
+	fd_hugepage = SAFE_OPEN(HUGE_PAGE_FILE, O_CREAT | O_RDWR, 0755);
+TST_EXP_PASS_SILENT(system("cat /proc/meminfo"));
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
+	unsigned int nr_hugepages;
+
+	for (i = 0; i < node->cnt; i++) {
+		unsigned int current_node_id = node->map[i];
+
+		sprintf(path,
+			"/sys/devices/system/node/node%d/hugepages/hugepages-%ldkB/nr_hugepages",
+			current_node_id, hpage_size / 1024);
+		FILE_PRINTF(path, "%d", 1);
+		SAFE_FILE_SCANF(path, "%d", &nr_hugepages);
+		if (nr_hugepages != 1)
+			tst_brk(TCONF, "reserve 1 huge page on node%d failed", current_node_id);
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
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.test_all = run_test,
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
