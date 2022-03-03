Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BB3C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:48:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19AD73CA334
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:48:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 002193CA1EC
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75E6E1A0079E
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 15:48:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 169951F384
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646318894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEpl2zxA/wMor/6h90eumJW1A6bcL7xQObRg2Q3NI8M=;
 b=Ml8ihPHa5cZq+yDCmzOyWXpcOO4GdDDE3p6uth7rfv9z0eFBj0og4UU9rlq9eRi9FMZntD
 AMRzf+seBSJBau41/Ia0YncoDt2l8jnXHESd2b/QSQHG3HAW0AYqh8YxelvC0jmhDlBJBb
 Kj+n8R64Ipyzkwezm6KF6XSENSyMl2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646318894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEpl2zxA/wMor/6h90eumJW1A6bcL7xQObRg2Q3NI8M=;
 b=zIzUC9J6Ml+5oi7ZyRWUIim299SXM1UiaXy1x3xkDlN12YumAOmdk/F6Y9UimK1/2kRv/W
 b6XsxBF6HOuxHHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0037E13AD9
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YPWLOi3VIGL5AgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 14:48:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Mar 2022 15:50:28 +0100
Message-Id: <20220303145032.21493-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303145032.21493-1-chrubis@suse.cz>
References: <20220303145032.21493-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] mem/ksm06: Move test code from library to the test
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

There is no point in keeping the test code in the library since ksm06 is
the only test that actually uses it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/ksm/ksm06.c | 82 +++++++++++++++++++++++++++++-
 testcases/kernel/mem/lib/mem.c   | 85 --------------------------------
 2 files changed, 81 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 379236f1f..0f5e4b05d 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -48,7 +48,87 @@ static char *n_opt;
 
 static void test_ksm(void)
 {
-	test_ksm_merge_across_nodes(nr_pages);
+	char **memory;
+	int i, ret;
+	int num_nodes, *nodes;
+	unsigned long length;
+	unsigned long pagesize;
+
+#ifdef HAVE_NUMA_V2
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
+#endif
+
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
+	if (ret != 0)
+		tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
+	if (num_nodes < 2) {
+		tst_res(TINFO, "need NUMA system support");
+		free(nodes);
+		return;
+	}
+
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	length = nr_pages * pagesize;
+
+	memory = SAFE_MALLOC(num_nodes * sizeof(char *));
+	for (i = 0; i < num_nodes; i++) {
+		memory[i] = SAFE_MMAP(NULL, length, PROT_READ|PROT_WRITE,
+			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+#ifdef HAVE_DECL_MADV_MERGEABLE
+		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
+			tst_brk(TBROK|TERRNO, "madvise");
+#endif
+
+#ifdef HAVE_NUMA_V2
+		clean_node(nmask);
+		set_node(nmask, nodes[i]);
+		/*
+		 * Use mbind() to make sure each node contains
+		 * length size memory.
+		 */
+		ret = mbind(memory[i], length, MPOL_BIND, nmask, MAXNODES, 0);
+		if (ret == -1)
+			tst_brk(TBROK|TERRNO, "mbind");
+#endif
+
+		memset(memory[i], 10, length);
+
+		if (mlock(memory[i], length))
+			tst_res(TWARN | TERRNO, "mlock() failed");
+	}
+
+	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
+			 nr_pages * num_nodes);
+	/*
+	 * merge_across_nodes and max_page_sharing setting can be changed
+	 * only when there are no ksm shared pages in system, so set run 2
+	 * to unmerge pages first, then to 1 after changing merge_across_nodes,
+	 * to remerge according to the new setting.
+	 */
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
+		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
+			"%ld", nr_pages * num_nodes);
+	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
+	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	ksm_group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
+			nr_pages * num_nodes);
+
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
+	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	ksm_group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
+			0, 0, 0, nr_pages * num_nodes);
+
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+
+	for (i = 0; i < num_nodes; i++)
+		SAFE_MUNMAP(memory[i], length);
+
+	free(memory);
 }
 
 static void setup(void)
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 102fc5665..090569ebb 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -519,91 +519,6 @@ void create_same_memory(int size, int num, int unit)
 				 WEXITSTATUS(status));
 }
 
-void test_ksm_merge_across_nodes(unsigned long nr_pages)
-{
-	char **memory;
-	int i, ret;
-	int num_nodes, *nodes;
-	unsigned long length;
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
-
-	pagesize = sysconf(_SC_PAGE_SIZE);
-	length = nr_pages * pagesize;
-
-	memory = SAFE_MALLOC(num_nodes * sizeof(char *));
-	for (i = 0; i < num_nodes; i++) {
-		memory[i] = SAFE_MMAP(NULL, length, PROT_READ|PROT_WRITE,
-			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-#ifdef HAVE_DECL_MADV_MERGEABLE
-		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
-			tst_brk(TBROK|TERRNO, "madvise");
-#endif
-
-#ifdef HAVE_NUMA_V2
-		clean_node(nmask);
-		set_node(nmask, nodes[i]);
-		/*
-		 * Use mbind() to make sure each node contains
-		 * length size memory.
-		 */
-		ret = mbind(memory[i], length, MPOL_BIND, nmask, MAXNODES, 0);
-		if (ret == -1)
-			tst_brk(TBROK|TERRNO, "mbind");
-#endif
-
-		memset(memory[i], 10, length);
-
-		if (mlock(memory[i], length))
-			tst_res(TWARN | TERRNO, "mlock() failed");
-	}
-
-	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
-	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
-			 nr_pages * num_nodes);
-	/*
-	 * merge_across_nodes and max_page_sharing setting can be changed
-	 * only when there are no ksm shared pages in system, so set run 2
-	 * to unmerge pages first, then to 1 after changing merge_across_nodes,
-	 * to remerge according to the new setting.
-	 */
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
-			"%ld", nr_pages * num_nodes);
-	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
-	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	ksm_group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
-		        nr_pages * num_nodes);
-
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
-	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	ksm_group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
-		        0, 0, 0, nr_pages * num_nodes);
-
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-
-	for (i = 0; i < num_nodes; i++)
-		SAFE_MUNMAP(memory[i], length);
-
-	free(memory);
-}
-
 /* THP */
 
 /* cpuset/memcg */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
