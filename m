Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD79CD1284
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 09:22:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4E453CC868
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 11:22:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BF843C04BE
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 19:07:52 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 537CE607135
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 19:07:51 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so2368979b3a.0
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711735669; x=1712340469; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s96EYfSu1w5TMYS8M5rGmUFkd6cEjqV4UYUnq4ejtVM=;
 b=lz2xzBlAi3Qj8DA0i8mowlvQyI7N9v8waFtt4gNmddInYjqc8ZpgKl6bYX7RYyWl7E
 XItO4vaaYRILv/8rLjH/wHX/5YU3NJQypg8oViZ3W0ObRGdS5nUH0kgrhzlD93c7WjS4
 +ypMBxUWYm3FmJxHdIPDl3nelE5Rv5iRpDBnqKpgcRUMkbm6ANo3g0lfS/0OkR0qDWv0
 i4ge9hZoB4MTq41otPPvH52/MY4Lzt7tZAYdBJtYiXwPMjn7TaPT5JZ2ZD/SQjuiTbsL
 vLxi7SL37aZbOr/Q3oeLWn3K/FWs7dl47zZ29fDWgmpjPO7kwACNyYp51BF5HT15hQcg
 40FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711735669; x=1712340469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s96EYfSu1w5TMYS8M5rGmUFkd6cEjqV4UYUnq4ejtVM=;
 b=PBaS3zdF4Dx7lMi1f8IPRnVmtlBUDjz/v5anGOuMFjPLDHKwDUz+XW+q7YVdcE78P8
 X0MYb8jKCiaoQ0ZvceHSsbgOZSOfvfVMrnaeR4fKHmGc3fkTqFjwjOS1Ce+7etPygd6p
 lRCxo+MGmMEVupUyjNP9zbGt/JaGrAXTReBrxkBntCTBBHKU1SX3qoDQdMMaw3UMoHPN
 45TO73BfVcYbTv6sXIFnfHBobZZayqUahBMkqRgLv4o5Fn8ZqOISGB8FLU5f7pvZrj/D
 NDmt8hwuR2kUqUOBuESUPs5buL0qv6xEPxU16zLh5FQv4reV1hDTdnuWWJ8EQxaL85Ez
 nxaw==
X-Gm-Message-State: AOJu0YxXu5/4Y7FUPqPlVWJRNKqeeQHTflj20nH24g8q7ppywivaVBnv
 S12nSzGJojQhhlg92MZ+dFWX0MTvTQ6QOMU2Par8rxab05WBU/2JlCJvjgI0pQ==
X-Google-Smtp-Source: AGHT+IGrAkgK5CVRj+LoFemSSZpdx31MR5KX8DoJppqTXzmEET9R3lpwn/lB46dhnUr5dd8T+l+9/A==
X-Received: by 2002:a17:90a:5d15:b0:2a0:8ab3:e7f5 with SMTP id
 s21-20020a17090a5d1500b002a08ab3e7f5mr8853743pji.15.1711735669148; 
 Fri, 29 Mar 2024 11:07:49 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 ev9-20020a17090aeac900b002a03d13fef5sm5448657pjb.7.2024.03.29.11.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 11:07:48 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: ltp@lists.linux.it
Date: Fri, 29 Mar 2024 14:07:42 -0400
Message-Id: <20240329180742.384709-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Apr 2024 11:21:16 +0200
Subject: [LTP] [PATCH] mempolicy/mbind: update syscall tests for weighted
 interleave
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
Cc: Gregory Price <gregory.price@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add the MPOL_WEIGHTED_INTERLEAVE policy to the syscall test suite for
get_mempolicy, set_mempolicy, and mbind.

The functional memory distribution test only tests that the default
behavior of WEIGHTED_INTERLEAVE is the same as INTERLEAVE, since the
values for each node default to '1', and because behavior actually
depends on what node the test runs on.  This test at least demonstrates
the interleave mechanism is in use and works by default as intended.

MPOL_WEIGHTED_INTERLEAVE is ifdef defined because it is not upstream
in libnuma yet, so this ensures compilation.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c  |  15 ++
 testcases/kernel/syscalls/mbind/mbind01.c     |  17 ++
 testcases/kernel/syscalls/mbind/mbind02.c     |   5 +
 testcases/kernel/syscalls/mbind/mbind03.c     |   5 +
 testcases/kernel/syscalls/mbind/mbind04.c     |   5 +
 .../kernel/syscalls/set_mempolicy/.gitignore  |   2 +
 .../kernel/syscalls/set_mempolicy/Makefile    |   2 +-
 .../syscalls/set_mempolicy/set_mempolicy06.c  | 122 +++++++++++++++
 .../syscalls/set_mempolicy/set_mempolicy07.c  | 148 ++++++++++++++++++
 9 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy06.c
 create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy07.c

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 23f62091a..8b0aa60bf 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -26,6 +26,10 @@
 #include <errno.h>
 #include "tst_numa.h"
 
+#ifndef
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
 #define MEM_LENGTH	(4 * 1024 * 1024)
 #define PAGES_ALLOCATED 16u
 
@@ -68,6 +72,11 @@ static struct test_case tcase[] = {
 		.alloc = test_set_mempolicy_default,
 		.exp_nodemask = &nodemask,
 	},
+	{
+		POLICY_DESC(MPOL_WEIGHTED_INTERLEAVE),
+		.alloc = test_set_mempolicy_default,
+		.exp_nodemask = &nodemask,
+	},
 	{
 		POLICY_DESC_NO_TARGET(MPOL_PREFERRED),
 		.alloc = test_set_mempolicy_none,
@@ -95,6 +104,12 @@ static struct test_case tcase[] = {
 		.alloc = test_set_mempolicy_default,
 		.exp_nodemask = &nodemask,
 	},
+	{
+		POLICY_DESC_FLAGS(MPOL_WEIGHTED_INTERLEAVE, MPOL_F_ADDR),
+		.pre_test = test_mbind_default,
+		.alloc = test_set_mempolicy_default,
+		.exp_nodemask = &nodemask,
+	},
 	{
 		POLICY_DESC_FLAGS_NO_TARGET(MPOL_PREFERRED, MPOL_F_ADDR),
 		.pre_test = test_mbind_none,
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4b8d168cd..d3d3b0049 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -20,6 +20,10 @@
 #include "tst_numa.h"
 #include "lapi/numaif.h"
 
+#ifndef
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
 #ifdef HAVE_NUMA_V2
 
 #define MEM_LENGTH (4 * 1024 * 1024)
@@ -80,6 +84,12 @@ static struct test_case tcase[] = {
 		.err = EINVAL,
 		.test = test_none,
 	},
+	{
+		POLICY_DESC_TEXT(MPOL_WEIGHTED_INTERLEAVE, "no target"),
+		.ret = -1,
+		.err = EINVAL,
+		.test = test_none,
+	},
 	{
 		POLICY_DESC(MPOL_INTERLEAVE),
 		.ret = 0,
@@ -87,6 +97,13 @@ static struct test_case tcase[] = {
 		.test = test_default,
 		.exp_nodemask = &nodemask,
 	},
+	{
+		POLICY_DESC(MPOL_WEIGHTED_INTERLEAVE),
+		.ret = 0,
+		.err = 0,
+		.test = test_default,
+		.exp_nodemask = &nodemask,
+	},
 	{
 		POLICY_DESC_TEXT(MPOL_PREFERRED, "no target"),
 		.ret = 0,
diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index cd6a03226..66d9cd826 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -23,6 +23,10 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 
+#ifndef MPOL_WEIGHTED_INTERLEAVE
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
 #ifdef HAVE_NUMA_V2
 
 static size_t page_size;
@@ -92,6 +96,7 @@ static const int modes[] = {
 	MPOL_PREFERRED,
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
+	MPOL_WEIGHTED_INTERLEAVE,
 };
 
 static void verify_mbind(unsigned int n)
diff --git a/testcases/kernel/syscalls/mbind/mbind03.c b/testcases/kernel/syscalls/mbind/mbind03.c
index 3d477c9cb..7da3c217d 100644
--- a/testcases/kernel/syscalls/mbind/mbind03.c
+++ b/testcases/kernel/syscalls/mbind/mbind03.c
@@ -20,6 +20,10 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 
+#ifndef MPOL_WEIGHTED_INTERLEAVE
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
 #ifdef HAVE_NUMA_V2
 
 static size_t page_size;
@@ -103,6 +107,7 @@ static const int modes[] = {
 	MPOL_PREFERRED,
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
+	MPOL_WEIGHTED_INTERLEAVE,
 };
 
 static void verify_mbind(unsigned int n)
diff --git a/testcases/kernel/syscalls/mbind/mbind04.c b/testcases/kernel/syscalls/mbind/mbind04.c
index 50028835f..db41f9e29 100644
--- a/testcases/kernel/syscalls/mbind/mbind04.c
+++ b/testcases/kernel/syscalls/mbind/mbind04.c
@@ -20,6 +20,10 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 
+#ifndef MPOL_WEIGHTED_INTERLEAVE
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
 #ifdef HAVE_NUMA_V2
 
 static size_t page_size;
@@ -114,6 +118,7 @@ static const int modes[] = {
 	MPOL_PREFERRED,
 	MPOL_BIND,
 	MPOL_INTERLEAVE,
+	MPOL_WEIGHTED_INTERLEAVE,
 };
 
 static void verify_mbind(unsigned int n)
diff --git a/testcases/kernel/syscalls/set_mempolicy/.gitignore b/testcases/kernel/syscalls/set_mempolicy/.gitignore
index 4c121d2e0..3af10e9f9 100644
--- a/testcases/kernel/syscalls/set_mempolicy/.gitignore
+++ b/testcases/kernel/syscalls/set_mempolicy/.gitignore
@@ -3,3 +3,5 @@
 /set_mempolicy03
 /set_mempolicy04
 /set_mempolicy05
+/set_mempolicy06
+/set_mempolicy07
diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index 100780dc3..04208837d 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -5,7 +5,7 @@ LTPLIBS = ltpnuma
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-NEEDS_LIBS = set_mempolicy01 set_mempolicy02 set_mempolicy03 set_mempolicy04
+NEEDS_LIBS = set_mempolicy01 set_mempolicy02 set_mempolicy03 set_mempolicy04 set_mempolicy05 set_mempolicy06 set_mempolicy07
 
 $(NEEDS_LIBS): LDLIBS  += $(NUMA_LIBS)
 $(NEEDS_LIBS): LTPLDLIBS = -lltpnuma
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy06.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy06.c
new file mode 100644
index 000000000..287fd316a
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy06.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_WEIGHTED_INTERLEAVE.
+ *
+ * The test tries different subsets of memory nodes, sets the mask with
+ * memopolicy, and checks that the memory was interleaved between the nodes
+ * accordingly.
+ */
+
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_V2
+# include <numa.h>
+# include <numaif.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#ifdef HAVE_NUMA_V2
+
+#include "set_mempolicy.h"
+
+#ifndef MPOL_WEIGHTED_INTERLEAVE
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
+#define ALLOC_ON_NODE 8
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * ALLOC_ON_NODE * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void alloc_and_check(size_t size, unsigned int *exp_alloc)
+{
+	unsigned int i;
+	const char *prefix = "child: ";
+
+	if (SAFE_FORK()) {
+		prefix = "parent: ";
+		tst_reap_children();
+	}
+
+	tst_nodemap_reset_counters(nodes);
+	alloc_fault_count(nodes, NULL, size * page_size);
+
+	for (i = 0; i < nodes->cnt; i++) {
+		if (nodes->counters[i] == exp_alloc[i]) {
+			tst_res(TPASS, "%sNode %u allocated %u",
+					prefix, nodes->map[i], exp_alloc[i]);
+		} else {
+			tst_res(TFAIL, "%sNode %u allocated %u, expected %u",
+					prefix, nodes->map[i], nodes->counters[i],
+					exp_alloc[i]);
+		}
+	}
+}
+
+static void verify_set_mempolicy(unsigned int n)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int exp_alloc[nodes->cnt];
+	unsigned int alloc_per_node = n ? ALLOC_ON_NODE : 2;
+	unsigned int alloc_on_nodes = n ? 2 : nodes->cnt;
+	unsigned int alloc_total = alloc_per_node * alloc_on_nodes;
+	unsigned int i;
+
+	memset(exp_alloc, 0, sizeof(exp_alloc));
+
+	for (i = 0; i < alloc_on_nodes; i++) {
+		exp_alloc[i] = alloc_per_node;
+		numa_bitmask_setbit(bm, nodes->map[i]);
+	}
+
+	TEST(set_mempolicy(MPOL_WEIGHTED_INTERLEAVE, bm->maskp, bm->size+1));
+
+	tst_res(TINFO, "Allocating on nodes 1-%u - %u pages",
+			alloc_on_nodes, alloc_total);
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+				"set_mempolicy(MPOL_WEIGHTED_INTERLEAVE)");
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(MPOL_WEIGHTED_INTERLEAVE)");
+
+	numa_free_nodemask(bm);
+
+	alloc_and_check(alloc_total, exp_alloc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_set_mempolicy,
+	.tcnt = 2,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_V2 */
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy07.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy07.c
new file mode 100644
index 000000000..d88998ed5
--- /dev/null
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy07.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * We are testing set_mempolicy() with MPOL_WEIGHTED_INTERLEAVE on mmaped buffers
+ * backed by files.
+ *
+ * Apparently it takes a larger sample for the allocations to be correctly
+ * interleaved. The reason for this is that buffers for file metadata are
+ * allocated in batches in order not to loose performance. Also the pages
+ * cannot be interleaved completely evenly unless the number of pages is
+ * divideable by the number of nodes, which will not happen even if we tried
+ * hard since we do not have control over metadata blocks for instance. Hence
+ * we cannot really expect to allocate a single file and have the memory
+ * interleaved precisely but it works well if we allocate statistic for a more
+ * than a few files.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include "config.h"
+#ifdef HAVE_NUMA_V2
+# include <numa.h>
+# include <numaif.h>
+#endif
+#include "tst_test.h"
+#include "tst_numa.h"
+
+#define MNTPOINT "mntpoint"
+#define FILES 10
+
+#ifdef HAVE_NUMA_V2
+
+#ifndef MPOL_WEIGHTED_INTERLEAVE
+#define MPOL_WEIGHTED_INTERLEAVE 6
+#endif
+
+#include "set_mempolicy.h"
+
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
+static void setup(void)
+{
+	int node_min_pages = FILES * (FILES + 1) / 2 * 10 + FILES * 10;
+
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, node_min_pages * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
+}
+
+static void cleanup(void)
+{
+	tst_nodemap_free(nodes);
+}
+
+static void alloc_and_check(void)
+{
+	unsigned int i, j;
+	char path[1024];
+	unsigned int total_pages = 0;
+	unsigned int sum_pages = 0;
+
+	tst_nodemap_reset_counters(nodes);
+
+	/*
+	 * The inner loop loops node->cnt times to ensure the sum could
+	 * be evenly distributed among the nodes.
+	 */
+	for (i = 1; i <= FILES; i++) {
+		for (j = 1; j <= nodes->cnt; j++) {
+			size_t size = 10 * i + j % 10;
+
+			snprintf(path, sizeof(path), MNTPOINT "/numa-test-file-%i-%i", i, j);
+			alloc_fault_count(nodes, path, size * page_size);
+			total_pages += size;
+		}
+	}
+
+	for (i = 0; i < nodes->cnt; i++) {
+		float threshold = 1.00 * total_pages / 60; /* five percents */
+		float min_pages = 1.00 * total_pages / nodes->cnt - threshold;
+		float max_pages = 1.00 * total_pages / nodes->cnt + threshold;
+
+		if (nodes->counters[i] > min_pages && nodes->counters[i] < max_pages) {
+			tst_res(TPASS, "Node %u allocated %u <%.2f,%.2f>",
+					nodes->map[i], nodes->counters[i], min_pages, max_pages);
+		} else {
+			tst_res(TFAIL, "Node %u allocated %u, expected <%.2f,%.2f>",
+					nodes->map[i], nodes->counters[i], min_pages, max_pages);
+		}
+
+		sum_pages += nodes->counters[i];
+	}
+
+	if (sum_pages != total_pages) {
+		tst_res(TFAIL, "Sum of nodes %u != allocated pages %u",
+				sum_pages, total_pages);
+		return;
+	}
+
+	tst_res(TPASS, "Sum of nodes equals to allocated pages (%u)", total_pages);
+}
+
+static void verify_set_mempolicy(void)
+{
+	struct bitmask *bm = numa_allocate_nodemask();
+	unsigned int alloc_on_nodes = nodes->cnt;
+	unsigned int i;
+
+	for (i = 0; i < alloc_on_nodes; i++)
+		numa_bitmask_setbit(bm, nodes->map[i]);
+
+	TEST(set_mempolicy(MPOL_WEIGHTED_INTERLEAVE, bm->maskp, bm->size+1));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TTERRNO,
+				"set_mempolicy(MPOL_WEIGHTED_INTERLEAVE)");
+		return;
+	}
+
+	tst_res(TPASS, "set_mempolicy(MPOL_WEIGHTED_INTERLEAVE)");
+
+	alloc_and_check();
+
+	numa_free_nodemask(bm);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_set_mempolicy,
+	.forks_child = 1,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mntpoint = MNTPOINT,
+	.needs_checkpoints = 1,
+};
+
+#else
+
+TST_TEST_TCONF(NUMA_ERROR_MSG);
+
+#endif /* HAVE_NUMA_V2 */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
