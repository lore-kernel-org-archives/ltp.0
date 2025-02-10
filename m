Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA8C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:35:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 281493C98BC
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:35:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1ECE3C98AA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:14 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 843C8140F8B3
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECC1721102
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftn1VDH8Aq1mFNDN6cu6CkDRKUsEvIalYUeZNUM8iNI=;
 b=wuK2rUtCvvEXjAeo5OunECfPviRN6ohnENDaqnHV7xvCN1w5dRjaRzq/KDsVVhAyzMRtxC
 DPRDausXo7LFKpkxQc/Wi/a68Bv89VyeOh0Te5oVfquN1GuiswXF3fHX1Fkm7c2PUwkJmA
 8O5jQEH/ytJxZma4dCoXRY99ATtROR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftn1VDH8Aq1mFNDN6cu6CkDRKUsEvIalYUeZNUM8iNI=;
 b=VikRLMY/InYRJx6huPJpIbeigM63pSCvT6EMCVkaJVB2jUJw+db24Kca9VPnDD2PjVKObS
 4d5vRNyvFX907xCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftn1VDH8Aq1mFNDN6cu6CkDRKUsEvIalYUeZNUM8iNI=;
 b=xFe7fP6QwbywM2GTgVFW2ZyHxBef5Qgy5CBVGtiMcsKhRMxYFnWL2zfIXOgSQjQOkPB836
 efkxgwqV0oQF8/AiYYERH1q7nqvbIW3XtHcic2Ks0KNMzV+14gJA38MG8sBFyf204498Iq
 YkBCHOK4A6KUOa2t8tHHu9cyWR4bWWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ftn1VDH8Aq1mFNDN6cu6CkDRKUsEvIalYUeZNUM8iNI=;
 b=mczhHdXcb2PBA/YWukSSnjm4E6wXSwTb3Gxdmr5cIGCtWPIBvHV7UFuEpMm2UUUZaZL2LX
 Kn3y/CTYaHntqxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D34AE13A62
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uKCiMrzjqWf7YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 11:32:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:08 +0100
Message-ID: <20250210113212.29520-10-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 09/13] testcases/kernel/mem: Move KSM bits to ksm
 tests
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

Moves the ksm helpers into a ksm/ksm_test.h since these are not used by
any other but ksm tests.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/include/mem.h    |   5 -
 testcases/kernel/mem/ksm/Makefile     |   2 +-
 testcases/kernel/mem/ksm/ksm01.c      |   2 +-
 testcases/kernel/mem/ksm/ksm02.c      |   2 +-
 testcases/kernel/mem/ksm/ksm03.c      |   2 +-
 testcases/kernel/mem/ksm/ksm04.c      |   2 +-
 testcases/kernel/mem/ksm/ksm05.c      |   2 +-
 testcases/kernel/mem/ksm/ksm06.c      |   4 +-
 testcases/kernel/mem/ksm/ksm07.c      |   3 +-
 testcases/kernel/mem/ksm/ksm_common.h |   3 +-
 testcases/kernel/mem/ksm/ksm_test.h   | 302 ++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c        | 287 ------------------------
 12 files changed, 315 insertions(+), 301 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm_test.h

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 5ebedc175..25389f34c 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -16,11 +16,6 @@
 
 /* KSM */
 
-void create_same_memory(int size, int num, int unit);
-void test_ksm_merge_across_nodes(unsigned long nr_pages);
-void ksm_group_check(int run, int pg_shared, int pg_sharing, int pg_volatile,
-                     int pg_unshared, int sleep_msecs, int pages_to_scan);
-
 /* HUGETLB */
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index 6aba73e61..2af02a274 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -7,5 +7,5 @@ LTPLIBS = numa
 ksm06: LTPLDLIBS = -lltpnuma
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index e2d3d9e00..a22e4830f 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -56,7 +56,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
 #include "ksm_common.h"
 
 static void verify_ksm(void)
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index b9e80e813..ab16af29e 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -53,7 +53,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
 #include "ksm_common.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index cff74700d..78844b30e 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -56,7 +56,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
 #include "ksm_common.h"
 
 static void verify_ksm(void)
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 0e264b10f..978214034 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -38,7 +38,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
 #include "ksm_common.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 1d9d9699a..025dffc09 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -39,7 +39,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include "tst_test.h"
-#include "mem.h"
+#include "ksm_helper.h"
 
 #ifdef HAVE_DECL_MADV_MERGEABLE
 
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 80fdf1e47..09a54fd18 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -33,8 +33,10 @@
 #include <unistd.h>
 #include <limits.h>
 
-#include "mem.h"
+#include "tst_test.h"
 #include "tst_numa.h"
+#include "ksm_helper.h"
+#include "ksm_test.h"
 
 #ifdef HAVE_NUMA_V2
 # include <numa.h>
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
index 619bd7b55..24b393283 100644
--- a/testcases/kernel/mem/ksm/ksm07.c
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -23,7 +23,8 @@
  */
 
 #include <sys/wait.h>
-#include "mem.h"
+#include "tst_test.h"
+#include "ksm_helper.h"
 
 /* This test allocates one page, fills the page with a's, captures the
  * full_scan and pages_skipped counters. Then it makes sure at least 3
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index 43ea8f8c2..d677b224d 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -11,7 +11,9 @@
 #define KSM_COMMON_H__
 
 #include "tst_test.h"
+#include "ksm_helper.h"
 #include "numa_helper.h"
+#include "ksm_test.h"
 
 #define DEFAULT_MEMSIZE 128
 
@@ -67,5 +69,4 @@ static inline unsigned int get_a_numa_node(void)
 	abort();
 }
 
-
 #endif /* KSM_COMMON_H__ */
diff --git a/testcases/kernel/mem/ksm/ksm_test.h b/testcases/kernel/mem/ksm/ksm_test.h
new file mode 100644
index 000000000..0db759d5a
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm_test.h
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2011-2021
+ * Copyright (c) Cyril Hrubis <chrubis@suse.cz> 2024
+ */
+#ifndef KSM_TEST_
+#define KSM_TEST_
+
+#include <sys/wait.h>
+
+static inline void check(char *path, long int value)
+{
+	char fullpath[BUFSIZ];
+	long actual_val;
+
+	snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);
+	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
+
+	if (actual_val != value)
+		tst_res(TFAIL, "%s is not %ld but %ld.", path, value,
+			actual_val);
+	else
+		tst_res(TPASS, "%s is %ld.", path, actual_val);
+}
+
+static inline void final_group_check(int run, int pages_shared, int pages_sharing,
+			  int pages_volatile, int pages_unshared,
+			  int sleep_millisecs, int pages_to_scan)
+{
+	int ksm_run_orig;
+
+	tst_res(TINFO, "check!");
+	check("run", run);
+
+	/*
+	 * Temporarily stop the KSM scan during the checks: during the
+	 * KSM scan the rmap_items in the stale unstable tree of the
+	 * old pass are removed from it and are later reinserted in
+	 * the new unstable tree of the current pass. So if the checks
+	 * run in the race window between removal and re-insertion, it
+	 * can lead to unexpected false positives where page_volatile
+	 * is elevated and page_unshared is recessed.
+	 */
+	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+
+	check("pages_shared", pages_shared);
+	check("pages_sharing", pages_sharing);
+	check("pages_volatile", pages_volatile);
+	check("pages_unshared", pages_unshared);
+	check("sleep_millisecs", sleep_millisecs);
+	check("pages_to_scan", pages_to_scan);
+
+	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+}
+
+static inline void ksm_group_check(int run, int pages_shared, int pages_sharing,
+		     int pages_volatile, int pages_unshared,
+		     int sleep_millisecs, int pages_to_scan)
+{
+	if (run != 1) {
+		tst_res(TFAIL, "group_check run is not 1, %d.", run);
+	} else {
+		/* wait for ksm daemon to scan all mergeable pages. */
+		wait_ksmd_full_scan();
+	}
+
+	final_group_check(run, pages_shared, pages_sharing,
+			  pages_volatile, pages_unshared,
+			  sleep_millisecs, pages_to_scan);
+}
+
+static inline void verify(char **memory, char value, int proc,
+		    int start, int end, int start2, int end2)
+{
+	int i, j;
+	void *s = NULL;
+
+	s = SAFE_MALLOC((end - start) * (end2 - start2));
+
+	tst_res(TINFO, "child %d verifies memory content.", proc);
+	memset(s, value, (end - start) * (end2 - start2));
+	if (memcmp(memory[start], s, (end - start) * (end2 - start2))
+	    != 0)
+		for (j = start; j < end; j++)
+			for (i = start2; i < end2; i++)
+				if (memory[j][i] != value)
+					tst_res(TFAIL, "child %d has %c at "
+						 "%d,%d,%d.",
+						 proc, memory[j][i], proc,
+						 j, i);
+	free(s);
+}
+
+struct ksm_merge_data {
+	char data;
+	unsigned int mergeable_size;
+};
+
+static inline void ksm_child_memset(int child_num, unsigned int size,
+				    unsigned int total_unit,
+				    struct ksm_merge_data ksm_merge_data,
+				    char **memory)
+{
+	unsigned int i = 0, j;
+	unsigned int unit = size / total_unit;
+
+	tst_res(TINFO, "child %d continues...", child_num);
+
+	if (ksm_merge_data.mergeable_size == size * TST_MB) {
+		tst_res(TINFO, "child %d allocates %u MB filled with '%c'",
+			child_num, size, ksm_merge_data.data);
+
+	} else {
+		tst_res(TINFO, "child %d allocates %u MB filled with '%c'"
+				" except one page with 'e'",
+				child_num, size, ksm_merge_data.data);
+	}
+
+	for (j = 0; j < total_unit; j++) {
+		for (i = 0; (unsigned int)i < unit * TST_MB; i++)
+			memory[j][i] = ksm_merge_data.data;
+	}
+
+	/* if it contains unshared page, then set 'e' char
+	 * at the end of the last page
+	 */
+	if (ksm_merge_data.mergeable_size < size * TST_MB)
+		memory[j-1][i-1] = 'e';
+}
+
+static inline void create_ksm_child(int child_num, unsigned int size,
+				    unsigned int unit,
+				    struct ksm_merge_data *ksm_merge_data)
+{
+	unsigned int j, total_unit;
+	char **memory;
+
+	/* The total units in all */
+	total_unit = size / unit;
+
+	/* Apply for the space for memory */
+	memory = SAFE_MALLOC(total_unit * sizeof(char *));
+	for (j = 0; j < total_unit; j++) {
+		memory[j] = SAFE_MMAP(NULL, unit * TST_MB, PROT_READ|PROT_WRITE,
+			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+#ifdef HAVE_DECL_MADV_MERGEABLE
+		if (madvise(memory[j], unit * TST_MB, MADV_MERGEABLE) == -1)
+			tst_brk(TBROK|TERRNO, "madvise");
+#endif
+	}
+
+	tst_res(TINFO, "child %d stops.", child_num);
+	if (raise(SIGSTOP) == -1)
+		tst_brk(TBROK|TERRNO, "kill");
+	fflush(stdout);
+
+	for (j = 0; j < 4; j++) {
+
+		ksm_child_memset(child_num, size, total_unit,
+				  ksm_merge_data[j], memory);
+
+		fflush(stdout);
+
+		tst_res(TINFO, "child %d stops.", child_num);
+		if (raise(SIGSTOP) == -1)
+			tst_brk(TBROK|TERRNO, "kill");
+
+		if (ksm_merge_data[j].mergeable_size < size * TST_MB) {
+			verify(memory, 'e', child_num, total_unit - 1,
+				total_unit, unit * TST_MB - 1, unit * TST_MB);
+			verify(memory, ksm_merge_data[j].data, child_num,
+				0, total_unit, 0, unit * TST_MB - 1);
+		} else {
+			verify(memory, ksm_merge_data[j].data, child_num,
+				0, total_unit, 0, unit * TST_MB);
+		}
+	}
+
+	tst_res(TINFO, "child %d finished.", child_num);
+}
+
+static inline void stop_ksm_children(int *child, int num)
+{
+	int k, status;
+
+	tst_res(TINFO, "wait for all children to stop.");
+	for (k = 0; k < num; k++) {
+		SAFE_WAITPID(child[k], &status, WUNTRACED);
+		if (!WIFSTOPPED(status))
+			tst_brk(TBROK, "child %d was not stopped", k);
+	}
+}
+
+static inline void resume_ksm_children(int *child, int num)
+{
+	int k;
+
+	tst_res(TINFO, "resume all children.");
+	for (k = 0; k < num; k++)
+		SAFE_KILL(child[k], SIGCONT);
+
+	fflush(stdout);
+}
+
+static inline void create_same_memory(unsigned int size, int num, unsigned int unit)
+{
+	int i, j, status, *child;
+	unsigned long ps, pages;
+	struct ksm_merge_data **ksm_data;
+
+	struct ksm_merge_data ksm_data0[] = {
+	       {'c', size*TST_MB}, {'c', size*TST_MB}, {'d', size*TST_MB}, {'d', size*TST_MB},
+	};
+	struct ksm_merge_data ksm_data1[] = {
+	       {'a', size*TST_MB}, {'b', size*TST_MB}, {'d', size*TST_MB}, {'d', size*TST_MB-1},
+	};
+	struct ksm_merge_data ksm_data2[] = {
+	       {'a', size*TST_MB}, {'a', size*TST_MB}, {'d', size*TST_MB}, {'d', size*TST_MB},
+	};
+
+	ps = sysconf(_SC_PAGE_SIZE);
+	pages = TST_MB / ps;
+
+	ksm_data = malloc((num - 3) * sizeof(struct ksm_merge_data *));
+	/* Since from third child, the data is same with the first child's */
+	for (i = 0; i < num - 3; i++) {
+		ksm_data[i] = malloc(4 * sizeof(struct ksm_merge_data));
+		for (j = 0; j < 4; j++) {
+			ksm_data[i][j].data = ksm_data0[j].data;
+			ksm_data[i][j].mergeable_size =
+				ksm_data0[j].mergeable_size;
+		}
+	}
+
+	child = SAFE_MALLOC(num * sizeof(int));
+
+	for (i = 0; i < num; i++) {
+		fflush(stdout);
+		switch (child[i] = SAFE_FORK()) {
+		case 0:
+			if (i == 0) {
+				create_ksm_child(i, size, unit, ksm_data0);
+				exit(0);
+			} else if (i == 1) {
+				create_ksm_child(i, size, unit, ksm_data1);
+				exit(0);
+			} else if (i == 2) {
+				create_ksm_child(i, size, unit, ksm_data2);
+				exit(0);
+			} else {
+				create_ksm_child(i, size, unit, ksm_data[i-3]);
+				exit(0);
+			}
+		}
+	}
+
+	stop_ksm_children(child, num);
+
+	tst_res(TINFO, "KSM merging...");
+	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
+		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing", "%ld", size * pages * num);
+	}
+
+	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", size * pages * num);
+	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+
+	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
+	ksm_group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
+
+	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
+	ksm_group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
+
+	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
+	ksm_group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
+
+	resume_ksm_children(child, num);
+	stop_ksm_children(child, num);
+	ksm_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
+
+	tst_res(TINFO, "KSM unmerging...");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+
+	resume_ksm_children(child, num);
+	final_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
+
+	tst_res(TINFO, "stop KSM.");
+	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
+
+	while (waitpid(-1, &status, 0) > 0)
+		if (WEXITSTATUS(status) != 0)
+			tst_res(TFAIL, "child exit status is %d",
+				 WEXITSTATUS(status));
+}
+
+#endif /* KSM_TEST_ */
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f3b844994..4e5c0b873 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -28,290 +28,3 @@
 
 /* KSM */
 
-static void check(char *path, long int value)
-{
-	char fullpath[BUFSIZ];
-	long actual_val;
-
-	snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);
-	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
-
-	if (actual_val != value)
-		tst_res(TFAIL, "%s is not %ld but %ld.", path, value,
-			actual_val);
-	else
-		tst_res(TPASS, "%s is %ld.", path, actual_val);
-}
-
-static void final_group_check(int run, int pages_shared, int pages_sharing,
-			  int pages_volatile, int pages_unshared,
-			  int sleep_millisecs, int pages_to_scan)
-{
-	int ksm_run_orig;
-
-	tst_res(TINFO, "check!");
-	check("run", run);
-
-	/*
-	 * Temporarily stop the KSM scan during the checks: during the
-	 * KSM scan the rmap_items in the stale unstable tree of the
-	 * old pass are removed from it and are later reinserted in
-	 * the new unstable tree of the current pass. So if the checks
-	 * run in the race window between removal and re-insertion, it
-	 * can lead to unexpected false positives where page_volatile
-	 * is elevated and page_unshared is recessed.
-	 */
-	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
-
-	check("pages_shared", pages_shared);
-	check("pages_sharing", pages_sharing);
-	check("pages_volatile", pages_volatile);
-	check("pages_unshared", pages_unshared);
-	check("sleep_millisecs", sleep_millisecs);
-	check("pages_to_scan", pages_to_scan);
-
-	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
-}
-
-void ksm_group_check(int run, int pages_shared, int pages_sharing,
-		     int pages_volatile, int pages_unshared,
-		     int sleep_millisecs, int pages_to_scan)
-{
-	if (run != 1) {
-		tst_res(TFAIL, "group_check run is not 1, %d.", run);
-	} else {
-		/* wait for ksm daemon to scan all mergeable pages. */
-		wait_ksmd_full_scan();
-	}
-
-	final_group_check(run, pages_shared, pages_sharing,
-			  pages_volatile, pages_unshared,
-			  sleep_millisecs, pages_to_scan);
-}
-
-static void verify(char **memory, char value, int proc,
-		    int start, int end, int start2, int end2)
-{
-	int i, j;
-	void *s = NULL;
-
-	s = SAFE_MALLOC((end - start) * (end2 - start2));
-
-	tst_res(TINFO, "child %d verifies memory content.", proc);
-	memset(s, value, (end - start) * (end2 - start2));
-	if (memcmp(memory[start], s, (end - start) * (end2 - start2))
-	    != 0)
-		for (j = start; j < end; j++)
-			for (i = start2; i < end2; i++)
-				if (memory[j][i] != value)
-					tst_res(TFAIL, "child %d has %c at "
-						 "%d,%d,%d.",
-						 proc, memory[j][i], proc,
-						 j, i);
-	free(s);
-}
-
-struct ksm_merge_data {
-	char data;
-	unsigned int mergeable_size;
-};
-
-static void ksm_child_memset(int child_num, int size, int total_unit,
-		 struct ksm_merge_data ksm_merge_data, char **memory)
-{
-	int i = 0, j;
-	int unit = size / total_unit;
-
-	tst_res(TINFO, "child %d continues...", child_num);
-
-	if (ksm_merge_data.mergeable_size == size * MB) {
-		tst_res(TINFO, "child %d allocates %d MB filled with '%c'",
-			child_num, size, ksm_merge_data.data);
-
-	} else {
-		tst_res(TINFO, "child %d allocates %d MB filled with '%c'"
-				" except one page with 'e'",
-				child_num, size, ksm_merge_data.data);
-	}
-
-	for (j = 0; j < total_unit; j++) {
-		for (i = 0; (unsigned int)i < unit * MB; i++)
-			memory[j][i] = ksm_merge_data.data;
-	}
-
-	/* if it contains unshared page, then set 'e' char
-	 * at the end of the last page
-	 */
-	if (ksm_merge_data.mergeable_size < size * MB)
-		memory[j-1][i-1] = 'e';
-}
-
-static void create_ksm_child(int child_num, int size, int unit,
-		       struct ksm_merge_data *ksm_merge_data)
-{
-	int j, total_unit;
-	char **memory;
-
-	/* The total units in all */
-	total_unit = size / unit;
-
-	/* Apply for the space for memory */
-	memory = SAFE_MALLOC(total_unit * sizeof(char *));
-	for (j = 0; j < total_unit; j++) {
-		memory[j] = SAFE_MMAP(NULL, unit * MB, PROT_READ|PROT_WRITE,
-			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-#ifdef HAVE_DECL_MADV_MERGEABLE
-		if (madvise(memory[j], unit * MB, MADV_MERGEABLE) == -1)
-			tst_brk(TBROK|TERRNO, "madvise");
-#endif
-	}
-
-	tst_res(TINFO, "child %d stops.", child_num);
-	if (raise(SIGSTOP) == -1)
-		tst_brk(TBROK|TERRNO, "kill");
-	fflush(stdout);
-
-	for (j = 0; j < 4; j++) {
-
-		ksm_child_memset(child_num, size, total_unit,
-				  ksm_merge_data[j], memory);
-
-		fflush(stdout);
-
-		tst_res(TINFO, "child %d stops.", child_num);
-		if (raise(SIGSTOP) == -1)
-			tst_brk(TBROK|TERRNO, "kill");
-
-		if (ksm_merge_data[j].mergeable_size < size * MB) {
-			verify(memory, 'e', child_num, total_unit - 1,
-				total_unit, unit * MB - 1, unit * MB);
-			verify(memory, ksm_merge_data[j].data, child_num,
-				0, total_unit, 0, unit * MB - 1);
-		} else {
-			verify(memory, ksm_merge_data[j].data, child_num,
-				0, total_unit, 0, unit * MB);
-		}
-	}
-
-	tst_res(TINFO, "child %d finished.", child_num);
-}
-
-static void stop_ksm_children(int *child, int num)
-{
-	int k, status;
-
-	tst_res(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		SAFE_WAITPID(child[k], &status, WUNTRACED);
-		if (!WIFSTOPPED(status))
-			tst_brk(TBROK, "child %d was not stopped", k);
-	}
-}
-
-static void resume_ksm_children(int *child, int num)
-{
-	int k;
-
-	tst_res(TINFO, "resume all children.");
-	for (k = 0; k < num; k++)
-		SAFE_KILL(child[k], SIGCONT);
-
-	fflush(stdout);
-}
-
-void create_same_memory(int size, int num, int unit)
-{
-	int i, j, status, *child;
-	unsigned long ps, pages;
-	struct ksm_merge_data **ksm_data;
-
-	struct ksm_merge_data ksm_data0[] = {
-	       {'c', size*MB}, {'c', size*MB}, {'d', size*MB}, {'d', size*MB},
-	};
-	struct ksm_merge_data ksm_data1[] = {
-	       {'a', size*MB}, {'b', size*MB}, {'d', size*MB}, {'d', size*MB-1},
-	};
-	struct ksm_merge_data ksm_data2[] = {
-	       {'a', size*MB}, {'a', size*MB}, {'d', size*MB}, {'d', size*MB},
-	};
-
-	ps = sysconf(_SC_PAGE_SIZE);
-	pages = MB / ps;
-
-	ksm_data = malloc((num - 3) * sizeof(struct ksm_merge_data *));
-	/* Since from third child, the data is same with the first child's */
-	for (i = 0; i < num - 3; i++) {
-		ksm_data[i] = malloc(4 * sizeof(struct ksm_merge_data));
-		for (j = 0; j < 4; j++) {
-			ksm_data[i][j].data = ksm_data0[j].data;
-			ksm_data[i][j].mergeable_size =
-				ksm_data0[j].mergeable_size;
-		}
-	}
-
-	child = SAFE_MALLOC(num * sizeof(int));
-
-	for (i = 0; i < num; i++) {
-		fflush(stdout);
-		switch (child[i] = SAFE_FORK()) {
-		case 0:
-			if (i == 0) {
-				create_ksm_child(i, size, unit, ksm_data0);
-				exit(0);
-			} else if (i == 1) {
-				create_ksm_child(i, size, unit, ksm_data1);
-				exit(0);
-			} else if (i == 2) {
-				create_ksm_child(i, size, unit, ksm_data2);
-				exit(0);
-			} else {
-				create_ksm_child(i, size, unit, ksm_data[i-3]);
-				exit(0);
-			}
-		}
-	}
-
-	stop_ksm_children(child, num);
-
-	tst_res(TINFO, "KSM merging...");
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
-		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing", "%ld", size * pages * num);
-	}
-
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", size * pages * num);
-	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
-
-	resume_ksm_children(child, num);
-	stop_ksm_children(child, num);
-	ksm_group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
-
-	resume_ksm_children(child, num);
-	stop_ksm_children(child, num);
-	ksm_group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
-
-	resume_ksm_children(child, num);
-	stop_ksm_children(child, num);
-	ksm_group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
-
-	resume_ksm_children(child, num);
-	stop_ksm_children(child, num);
-	ksm_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
-
-	tst_res(TINFO, "KSM unmerging...");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-
-	resume_ksm_children(child, num);
-	final_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
-
-	tst_res(TINFO, "stop KSM.");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
-	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
-
-	while (waitpid(-1, &status, 0) > 0)
-		if (WEXITSTATUS(status) != 0)
-			tst_res(TFAIL, "child exit status is %d",
-				 WEXITSTATUS(status));
-}
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
