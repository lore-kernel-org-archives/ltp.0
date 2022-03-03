Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889B7C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D33EF3CA361
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:49:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52BC83CA367
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0D2F100093A
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53E2E218A9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646318896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwp+ljcUno/J/iTa0fw0s4BsQPCM6GZMpJi8wNH5TrM=;
 b=fq3x6GAz3s24VfkHdqgUBxf79dHUtp9Hn/KdyUsTvaI5c/s/5PzG8uKwq3lat67NJBBSyH
 2GgySxMe/vqnRZXQK5LaEwqx9Rfs5Dy6SqPW28hHV6R1r1KHXDItjVa379jZRamPQiwGXn
 gnclqFeb/rbrK/XKw+OEvWe6IWf85rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646318896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwp+ljcUno/J/iTa0fw0s4BsQPCM6GZMpJi8wNH5TrM=;
 b=dGYDsDpKhM+Ck+HOd4MWB9OJb635H5PFBhAXnhvdNoQixsaGFb96cDULcpRhPUl/P63awv
 oHivwALtwmTxErCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B2C013AD9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m+iwCzDVIGIEAwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 14:48:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Mar 2022 15:50:32 +0100
Message-Id: <20220303145032.21493-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303145032.21493-1-chrubis@suse.cz>
References: <20220303145032.21493-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] mem/ksm06: Make use of the new libltpnuma
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

THe main benefit is that the new library also makes sure that memory
nodes have enough memory for the test.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/ksm/Makefile |  3 ++
 testcases/kernel/mem/ksm/ksm06.c  | 72 ++++++++++++++-----------------
 2 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index e8ea801bc..236625690 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -3,6 +3,9 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = ltpnuma
+ksm06: LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index f5f7319d7..80426bbb0 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -34,41 +34,30 @@
 #include <limits.h>
 
 #include "mem.h"
-#include "numa_helper.h"
+#include "tst_numa.h"
 
 #ifdef HAVE_NUMA_V2
-#include <numaif.h>
+# include <numa.h>
+# include <numaif.h>
 
 static unsigned long nr_pages = 100;
-
 static char *n_opt;
 
+static size_t page_size;
+static struct tst_nodemap *nodes;
+
 static void test_ksm(void)
 {
 	char **memory;
-	int i, ret;
-	int num_nodes, *nodes;
+	unsigned int i;
+	int ret;
 	unsigned long length;
-	unsigned long pagesize;
-
-#ifdef HAVE_NUMA_V2
-	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
-#endif
-
-	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
-	if (ret != 0)
-		tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
-	if (num_nodes < 2) {
-		tst_res(TINFO, "need NUMA system support");
-		free(nodes);
-		return;
-	}
+	struct bitmask *bm = numa_allocate_nodemask();
 
-	pagesize = sysconf(_SC_PAGE_SIZE);
-	length = nr_pages * pagesize;
+	length = nr_pages * page_size;
 
-	memory = SAFE_MALLOC(num_nodes * sizeof(char *));
-	for (i = 0; i < num_nodes; i++) {
+	memory = SAFE_MALLOC(nodes->cnt * sizeof(char *));
+	for (i = 0; i < nodes->cnt; i++) {
 		memory[i] = SAFE_MMAP(NULL, length, PROT_READ|PROT_WRITE,
 			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 #ifdef HAVE_DECL_MADV_MERGEABLE
@@ -77,15 +66,13 @@ static void test_ksm(void)
 #endif
 
 #ifdef HAVE_NUMA_V2
-		clean_node(nmask);
-		set_node(nmask, nodes[i]);
-		/*
-		 * Use mbind() to make sure each node contains
-		 * length size memory.
-		 */
-		ret = mbind(memory[i], length, MPOL_BIND, nmask, MAXNODES, 0);
+		numa_bitmask_setbit(bm, nodes->map[i]);
+
+		ret = mbind(memory[i], length, MPOL_BIND, bm->maskp, bm->size+1, 0);
 		if (ret == -1)
 			tst_brk(TBROK|TERRNO, "mbind");
+
+		numa_bitmask_clearbit(bm, nodes->map[i]);
 #endif
 
 		memset(memory[i], 10, length);
@@ -94,9 +81,11 @@ static void test_ksm(void)
 			tst_res(TWARN | TERRNO, "mlock() failed");
 	}
 
+	numa_free_nodemask(bm);
+
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
 	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
-			 nr_pages * num_nodes);
+			 nr_pages * nodes->cnt);
 	/*
 	 * merge_across_nodes and max_page_sharing setting can be changed
 	 * only when there are no ksm shared pages in system, so set run 2
@@ -106,23 +95,23 @@ static void test_ksm(void)
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
 		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
-			"%ld", nr_pages * num_nodes);
+			"%ld", nr_pages * nodes->cnt);
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
 	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	ksm_group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
-			nr_pages * num_nodes);
+	ksm_group_check(1, 1, nr_pages * nodes->cnt - 1, 0, 0, 0,
+			nr_pages * nodes->cnt);
 
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
 	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
 	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	ksm_group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
-			0, 0, 0, nr_pages * num_nodes);
+	ksm_group_check(1, nodes->cnt, nr_pages * nodes->cnt - nodes->cnt,
+			0, 0, 0, nr_pages * nodes->cnt);
 
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
 
-	for (i = 0; i < num_nodes; i++)
+	for (i = 0; i < nodes->cnt; i++)
 		SAFE_MUNMAP(memory[i], length);
 
 	free(memory);
@@ -133,11 +122,14 @@ static void setup(void)
 	if (access(PATH_KSM "merge_across_nodes", F_OK) == -1)
 		tst_brk(TCONF, "no merge_across_nodes sysfs knob");
 
-	if (!is_numa(NULL, NH_MEMS, 2))
-		tst_brk(TCONF, "The case needs a NUMA system.");
-
 	if (n_opt)
 		nr_pages = SAFE_STRTOUL(n_opt, 0, ULONG_MAX);
+
+	page_size = getpagesize();
+
+	nodes = tst_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024);
+	if (nodes->cnt <= 1)
+		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
