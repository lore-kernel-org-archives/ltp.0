Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF473E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 06:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733724127; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Sm+kvzCM4hAfhEOeVB4jmxNpQVj4mVW0f9w8was0xm8=;
 b=c0Qi0H/wtVAZHxMa8hxjxWVwXLYBRUqwVih81xbqiV2qz+119x3OJoNStYBvaoVbZ6rcT
 un2tfqTRP+S1XFvFUq/I0nKPg1enewvT5vObMyrpzpuzQSfc06zyPdyOVZhvdC2zo+1mpHL
 PhLOWWRqWoVoU6ic8sHCjNz8F5gckGc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 442B63E2CFF
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 07:02:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 432D93E2CFF
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:01:32 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B355633991
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 07:01:31 +0100 (CET)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so4339300a12.1
 for <ltp@lists.linux.it>; Sun, 08 Dec 2024 22:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733724090; x=1734328890; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2z6+k8COcnUAcfLyd6XPgC6nQ7raqjODEVqsaKKGKY=;
 b=Wl/LQp7DMCB4omAsM2JT4QVtaKFFc9wDIKpt3nPSklVRdLlyyL1ZEh6kufdOv8Japi
 iPQ1X1TeGCXdRCelMmPAispwI91i25AUgwEHQPK1afW8ALETgOalTZh5uYZJlMXxcXRc
 pOOzr3REwgZDMb6qkXJgNuWgbEEoIQvZexhXjdXnMERdajgCBMjzcS85bhzk8Hx45YIj
 9HzcHIF1EQyj3G71eJCQbDg3VHsfz9wiR3UgLPYI5bAlWHFxNy6JaNhmEuK9AqhX9jZc
 1B3SkMfCvbsEHe/jZribRANMa56FxDXAEdJxSbf0yB3eOmw7lfBdh7qdoxl941EDH1zI
 O5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733724090; x=1734328890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2z6+k8COcnUAcfLyd6XPgC6nQ7raqjODEVqsaKKGKY=;
 b=O2RrccLy9GoM5jL9WCnHDC60VLHM+rcom3Ip2TSvJtGjLfYrb7nKsZQ+OEkaYH9ESa
 MN75TD7O0MPWdHsfPDZ8dLB9eYuCYeeBq5HCCGfJ2DDsbieGuMVmHT9Q1JcdqcWALWzF
 r82YkYjiE4wtZYnNcL7H8isYEPwYZdkNkzC9qSObvA3a66lv663+uqN6RH9ya3e5npEh
 a3aN4ebHswMZ1LRsSTScdHIFEv3ORi9JCc6+UQB4/49lduI5InYDNHrkJgEeQYBkjRPu
 AxH/CU4JPO+RscXZqbJHknPV6j8PuuNtNcYMfGXR2YYcBP8iwclaioECZ4K2056O2DBW
 1gdQ==
X-Gm-Message-State: AOJu0Yx/XqeS//BJ+1TwqWhd5xlslxdH7ZB+WBalopmtGxNOdNMdB4jR
 U1nXXiq+udEOH50zBHtgsOlCxx+DIv00FqKyyCLu2eeedqO94mwXOLEzuWySRu6cTZlS5gJmhuo
 =
X-Gm-Gg: ASbGncu92Otd/KvKxxrqtLlCA1QjfXAsrpxIXR1FBi6pnICSvQjk6b+KMetPet9AqGV
 Nxdc+US2Ft6V7J7ERuYbwPLuCqwtaI6ZXgWegBiv4FxDnLilipj4jZQ4rQwK4qoICG2pxke+Kbb
 oqbAxCAJqb0WfEM2LANHzFOyBmcbLKznxk96b6w1c7ArAlb0Ghiti/djTAa5RcA5I54qitZ2b8K
 NB1LFu/gHF/5fH1EG7EJnlY7mE6k2fRaM23ywt0xlURsg==
X-Google-Smtp-Source: AGHT+IFIkGtMtx+fsiABAEX4LgnPoK6FSzLxDsMAVo2UnSaAlGcEAVStR3dbZQvWzJW7SNOBUC1EEQ==
X-Received: by 2002:a05:6402:2696:b0:5d2:719c:8bf3 with SMTP id
 4fb4d7f45d1cf-5d3be67e27fmr10146957a12.9.1733724089966; 
 Sun, 08 Dec 2024 22:01:29 -0800 (PST)
Received: from localhost ([223.72.85.1]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3dc2602b0sm3036604a12.18.2024.12.08.22.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 22:01:29 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  9 Dec 2024 01:01:16 -0500
Message-Id: <20241209060117.16870-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241209060117.16870-1-wegao@suse.com>
References: <20240930135809.9300-1-wegao@suse.com>
 <20241209060117.16870-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] cpuset02: Convert the test6 from
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

Base Cyril Hrubis's suggestion [1].
We should stop applying band aids over the mess called cpuset tests
and start actually rewriting them into something saner, and start by
reimplementing the test6 as a separate C testcase so that we can make
use of all the infrastructure for hugepages we have in the tst_test.

[1] https://patchwork.ozlabs.org/project/ltp/patch/20240801104004.15514-1-wegao@suse.com/

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_cgroup.c                              |   1 +
 runtest/mm                                    |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 testcases/kernel/mem/cpuset/Makefile          |   6 +
 testcases/kernel/mem/cpuset/cpuset02.c        | 142 ++++++++++++++++++
 .../mq_timedreceive/mq_timedreceive01.c       |  80 +++++++---
 6 files changed, 210 insertions(+), 21 deletions(-)
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
index 8e41c0223..9311985b1 100644
--- a/testcases/kernel/mem/cpuset/Makefile
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -19,6 +19,12 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = numa
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+
+LDLIBS  += $(NUMA_LIBS)
+LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
new file mode 100644
index 000000000..2bd226bab
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
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
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index be437e19a..6dadc3de6 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -145,32 +145,16 @@ static void setup(void)
 	setup_common();
 }
 
-static void do_test(unsigned int i)
+
+static void verify_mqt_receive(unsigned int i, pid_t pid)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
-	unsigned int j;
-	unsigned int prio;
 	size_t len = MAX_MSGSIZE;
 	char rmsg[len];
-	pid_t pid = -1;
 	void *abs_timeout;
-
-	tst_ts_set_sec(&ts, tc->tv_sec);
-	tst_ts_set_nsec(&ts, tc->tv_nsec);
-
-	if (tc->signal)
-		pid = set_sig(tc->rq, tv->clock_gettime);
-
-	if (tc->timeout)
-		set_timeout(tc->rq, tv->clock_gettime);
-
-	if (tc->send) {
-		if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
-			tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
-			return;
-		}
-	}
+	unsigned int j;
+	unsigned int prio;
 
 	if (tc->invalid_msg)
 		len -= 1;
@@ -199,7 +183,7 @@ static void do_test(unsigned int i)
 		return;
 	}
 
-	if (tc->len != TST_RET) {
+	if ((long)tc->len != TST_RET) {
 		tst_res(TFAIL, "mq_timedreceive() wrong length %ld, expected %u",
 			TST_RET, tc->len);
 		return;
@@ -224,6 +208,60 @@ static void do_test(unsigned int i)
 			TST_RET, prio, len);
 }
 
+static void test_bad_addr(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_mqt_receive(i, pid);
+		_exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
+		return;
+
+	if (tv->ts_type == TST_LIBC_TIMESPEC &&
+		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Child killed by expected signal");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static void do_test(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	const struct test_case *tc = &tcase[i];
+	pid_t pid = -1;
+
+	tst_ts_set_sec(&ts, tc->tv_sec);
+	tst_ts_set_nsec(&ts, tc->tv_nsec);
+
+	if (tc->bad_ts_addr) {
+		test_bad_addr(i);
+		return;
+	}
+
+	if (tc->signal)
+		pid = set_sig(tc->rq, tv->clock_gettime);
+
+	if (tc->timeout)
+		set_timeout(tc->rq, tv->clock_gettime);
+
+	if (tc->send && tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+		tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
+		return;
+	}
+
+	verify_mqt_receive(i, pid);
+}
+
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
