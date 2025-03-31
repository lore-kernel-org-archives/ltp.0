Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE1C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743427595; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=V4FWctaTFEOEqbOrw/EZ2e+w9mRzuSdTbFaHejNMYj0=;
 b=mQBXot8fuThI88Zugv8JDqhYr7BBE8XiDxjkJ8UZE3w+0T7wsuRitQar4R343QtmKEtuf
 YN+uvHK/Lz3TDsAo48VVPo7Wkg+CTPcScYAC7tWOAMcaRr8mJufx56Mo8m3LycVEpZfMZun
 W7NWcnjzpHv0Hx7QzdYm+oG+uhHR4TU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A70943CAC56
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 15:26:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 721423CABDD
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:55 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 634B11A00152
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 15:25:53 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2350753f8f.0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743427552; x=1744032352; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXr+oUJ7gKqkdvQNSS0X7yWCiTutEkRB/iV8+glojS8=;
 b=JTrLN35QwZkbJaBNAUBDEO8ASplUcuvfF2B8oX0qYIKxu+OWKglASQHG8eszkIGUZ/
 UFXTUf+WO2F65lbMsAEP2UtGxYXizlfrmnNvqURa7NWa3foquqb1SBpqI4uoV02axVBE
 O9faowHFVs+RLu2qIOzdOrqAb90ZqIke0L2V/7U1Ctq9G1Weqx9pamXgBPjAPdPkl5UN
 uavS80JAS/H5Qaen980Km+yJJxYqK2U+9C5xN/fNev9GsLPknEGZK44x0UYceiFu8BMt
 xC6zzrIPNrQSTtggWW/SAdkmG5RRDFotk+uugCdzO2MTN3FTtz8R70exEPgiEufK63y5
 Hj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427552; x=1744032352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXr+oUJ7gKqkdvQNSS0X7yWCiTutEkRB/iV8+glojS8=;
 b=FlU4T5K0meCNkPt+OK5IQUQmjEXyvC0MYph+RRsVAw7Mnqg/rUThYr/hJGSnePdgbm
 cmkaiuA97tx05DuRtBvVzxzH3EpEud7A6CnhBYYIPM7VaNBcUJq8gFS/QWyM8JLFAwuZ
 lVg0dT7JDTks6z89/phJsfPIj500qo4vhgK88txzrmDbpHPMGbMo1XWYL4HhFjshzKhw
 orLM4NsLDY0eD+7TWoPQ8JjjeNC0piEapX6W9E4jgApJ8t+DFzNkOSLDj5ctPOtFw2u+
 JFCVPDM/LLNUIPXD8tWKMDWyd2O4V2HksEY5h4MC9zNm79heOHN5bL+KOkYG5k1puctt
 j+cQ==
X-Gm-Message-State: AOJu0YxdQg3fmQCYsgf6YdLj8Uc1YAQ2khwl2Nzj4u5gW3uZ/krJ6NQ9
 PEp8RGFizTBBdVsqlwE+m425uVg+Z6UXGoq8LIlavv8NZW12+613BPYBNpNW/9yREMj0+47oJ6I
 mXnjjPpM=
X-Gm-Gg: ASbGncuk+s31Mnr8+kweL9GU4jEbmTkdv7cqlRC0LhPLc9byogN7F+s9gtl+W1ynOw4
 9NmdkwU4IbRrmZWUqU37qtQwBqIMYPT0/qqw45QMDxZ99SFllE1ESRKK9DX0GoIhuZbW4bJvAeR
 htXUuJFcxTPvGTaho0t3/ZVbLinbvHqGzoaJoc4KkdVC+9Vk/wHx/wkicnYcYv0XgwXe6xmot2K
 8H4lBQzMWroJuH60edTUGdi6P+59QyJiKFc8BtenGS1o8oTpaBTVjqZamkEaUiJ4u+ovkYDgDdb
 /7jXM2FK8YJ+LUev+nFW4iKEXzucMmEw6A==
X-Google-Smtp-Source: AGHT+IH1Z1JKyiJc0Dbtvwnk+YQRA3aSgIwcufbWOZGvlHLrKk92gABAKygXFezGGuVI3r7zcNEtTQ==
X-Received: by 2002:a05:6000:1a89:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39c121139a1mr6208730f8f.34.1743427552018; 
 Mon, 31 Mar 2025 06:25:52 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a8d4sm11201653f8f.45.2025.03.31.06.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:25:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Mar 2025 09:25:36 -0400
Message-Id: <20250331132537.26417-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250331132537.26417-1-wegao@suse.com>
References: <20250331031945.5948-1-wegao@suse.com>
 <20250331132537.26417-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/2] cpuset02: Convert the test6 from
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
Reviewed-by: Li Wang <liwang@redhat.com>
---
 runtest/mm                             |   1 +
 testcases/kernel/mem/.gitignore        |   1 +
 testcases/kernel/mem/cpuset/Makefile   |   5 +
 testcases/kernel/mem/cpuset/cpuset02.c | 139 +++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

diff --git a/runtest/mm b/runtest/mm
index 871e1f026..5566a7742 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -68,6 +68,7 @@ ksm06_2 ksm06 -n 8000
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
index 000000000..ad5fae536
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,139 @@
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
