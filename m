Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF9C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:34:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61E23C98AF
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:34:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0BAA3C9876
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3EBF6100FEE8
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DCD9B1F393;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViuDzGtbZ8Z7dv91q5L+aMQzPATY6Lm2pGa6th2QLFg=;
 b=LY2BS4fGrkY8Pi5+GMtyRldAd/qLFiBG/WsQwWgnvHwGU+b63lSx8XDbBe6CgKOdj6zGP3
 LN/kqvWfQjfgtWvx0JKmmv3UI22dQAJEVgWYQcmoYBtiWLWuNvpRsQyZRW3cB3MwmhNeui
 V214G1aHj0DnYl//Ny8M81jddQLKzfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViuDzGtbZ8Z7dv91q5L+aMQzPATY6Lm2pGa6th2QLFg=;
 b=AjagO1BnkJk9o+ISZkH5NwTa6FSWc0RFB97YdLUL2Ebm0XCyVzh4n9YaB4sSguZ69i7Wcn
 A5wOSgfCVyZN4MBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViuDzGtbZ8Z7dv91q5L+aMQzPATY6Lm2pGa6th2QLFg=;
 b=LY2BS4fGrkY8Pi5+GMtyRldAd/qLFiBG/WsQwWgnvHwGU+b63lSx8XDbBe6CgKOdj6zGP3
 LN/kqvWfQjfgtWvx0JKmmv3UI22dQAJEVgWYQcmoYBtiWLWuNvpRsQyZRW3cB3MwmhNeui
 V214G1aHj0DnYl//Ny8M81jddQLKzfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViuDzGtbZ8Z7dv91q5L+aMQzPATY6Lm2pGa6th2QLFg=;
 b=AjagO1BnkJk9o+ISZkH5NwTa6FSWc0RFB97YdLUL2Ebm0XCyVzh4n9YaB4sSguZ69i7Wcn
 A5wOSgfCVyZN4MBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC00713A62;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kw21MLvjqWf2YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:06 +0100
Message-ID: <20250210113212.29520-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/13] testcases/kernel/mem: Move NUMA bits to
 numa_helper.h
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

Testcases that use these macros and functions include numa_helper.h
anyways so there is no point in keeping numa related functions in mem.h.

Note that the unused clear_node() function was removed.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/include/numa_helper.h | 21 +++++++++
 testcases/kernel/lib/numa_cpuset.c     | 64 ++++++++++++++++++++++++++
 testcases/kernel/mem/cpuset/cpuset01.c |  1 -
 testcases/kernel/mem/include/mem.h     | 24 ----------
 testcases/kernel/mem/ksm/ksm02.c       |  2 +-
 testcases/kernel/mem/ksm/ksm04.c       |  2 +-
 testcases/kernel/mem/lib/mem.c         | 57 -----------------------
 testcases/kernel/mem/oom/oom04.c       |  2 +-
 testcases/kernel/mem/oom/oom05.c       |  2 +-
 9 files changed, 89 insertions(+), 86 deletions(-)
 create mode 100644 testcases/kernel/lib/numa_cpuset.c

diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index ed45ec8a8..e67ddaaca 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -27,13 +27,34 @@
 # include <numaif.h>
 #endif
 
+struct tst_cg_group;
+
 #define NH_MEMS (1 << 0)
 #define NH_CPUS (1 << 1)
 
+#if defined(__powerpc__) || defined(__powerpc64__)
+# define MAXNODES                256
+#else
+# define MAXNODES                512
+#endif
+
+#define TESTMEM                 (1UL<<30)
+
+#define BITS_PER_LONG (8 * sizeof(long))
+
+#define PATH_SYS_SYSTEM         "/sys/devices/system"
+
+static inline void set_node(unsigned long *array, unsigned int node)
+{
+	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
+}
+
 unsigned long get_max_node(void);
 int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
 int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes(void);
 int is_numa(void (*cleanup_fn)(void), int flag, int min_nodes);
 
+void write_node_cpusets(const struct tst_cg_group *cg, long nd);
+
 #endif /* NUMA_HELPER_H */
diff --git a/testcases/kernel/lib/numa_cpuset.c b/testcases/kernel/lib/numa_cpuset.c
new file mode 100644
index 000000000..088d2d4e5
--- /dev/null
+++ b/testcases/kernel/lib/numa_cpuset.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2011-2021
+ * Copyright (c) Cyril Hrubis <chrubis@suse.cz> 2024
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_cgroup.h"
+#include "numa_helper.h"
+
+static void gather_node_cpus(char *cpus, long nd)
+{
+	int ncpus = 0;
+	int i;
+	long online;
+	char buf[BUFSIZ];
+	char path[BUFSIZ], path1[BUFSIZ];
+
+	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++) {
+		snprintf(path, BUFSIZ,
+			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
+		if (tst_path_exists("%s", path)) {
+			snprintf(path1, BUFSIZ, "%s/online", path);
+			/*
+			 * if there is no online knob, then the cpu cannot
+			 * be taken offline
+			 */
+			if (tst_path_exists("%s", path1)) {
+				SAFE_FILE_SCANF(path1, "%ld", &online);
+				if (online == 0)
+					continue;
+			}
+			sprintf(buf, "%d,", i);
+			strcat(cpus, buf);
+		}
+	}
+	/* Remove the trailing comma. */
+	cpus[strlen(cpus) - 1] = '\0';
+}
+
+void write_node_cpusets(const struct tst_cg_group *cg, long nd)
+{
+	char cpus[BUFSIZ] = "";
+
+	SAFE_CG_PRINTF(cg, "cpuset.mems", "%ld", nd);
+
+	gather_node_cpus(cpus, nd);
+	/*
+	 * If the 'nd' node doesn't contain any CPUs,
+	 * the first ID of CPU '0' will be used as
+	 * the value of cpuset.cpus.
+	 */
+	if (strlen(cpus) != 0) {
+		SAFE_CG_PRINT(cg, "cpuset.cpus", cpus);
+	} else {
+		tst_res(TINFO, "No CPUs in the node%ld; "
+				"using only CPU0", nd);
+		SAFE_CG_PRINT(cg, "cpuset.cpus", "0");
+	}
+}
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index e70c7c7dc..4f4415a18 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -30,7 +30,6 @@
 #include <numaif.h>
 #endif
 
-#include "../include/mem.h"
 #include "tst_test.h"
 #include "numa_helper.h"
 
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index ba5a996a7..e0f443b4b 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -9,35 +9,14 @@
 #include "ksm_helper.h"
 #include "tst_memutils.h"
 
-#if defined(__powerpc__) || defined(__powerpc64__)
-#define MAXNODES		256
-#else
-#define MAXNODES		512
-#endif
 #define MB			(1UL<<20)
 #define KB			(1UL<<10)
-#define PATH_SYS_SYSTEM		"/sys/devices/system"
 #define PATH_SYSVM		"/proc/sys/vm/"
 #define PATH_MEMINFO		"/proc/meminfo"
-#define BITS_PER_LONG           (8 * sizeof(long))
-
-static inline void set_node(unsigned long *array, unsigned int node)
-{
-	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
-}
-
-static inline void clean_node(unsigned long *array)
-{
-	unsigned int i;
-
-	for (i = 0; i < MAXNODES / BITS_PER_LONG; i++)
-		array[i] &= 0UL;
-}
 
 /* OOM */
 
 #define LENGTH			(3UL<<30)
-#define TESTMEM			(1UL<<30)
 #define NORMAL			1
 #define MLOCK			2
 #define KSM			3
@@ -58,7 +37,4 @@ void ksm_group_check(int run, int pg_shared, int pg_sharing, int pg_volatile,
 
 void write_memcg(void);
 
-/* cpuset/memcg - include/tst_cgroup.h */
-void write_cpusets(const struct tst_cg_group *cg, long nd);
-
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index ab0725303..b9e80e813 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -76,7 +76,7 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(tst_cg, node);
+	write_node_cpusets(tst_cg, node);
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	create_same_memory(size, num, unit);
 	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 7b478c46d..0e264b10f 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -63,7 +63,7 @@ static void verify_ksm(void)
 	}
 	create_same_memory(size, num, unit);
 
-	write_cpusets(tst_cg, node);
+	write_node_cpusets(tst_cg, node);
 	create_same_memory(size, num, unit);
 }
 
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 02199349d..c7c05aa03 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -527,60 +527,3 @@ void create_same_memory(int size, int num, int unit)
 			tst_res(TFAIL, "child exit status is %d",
 				 WEXITSTATUS(status));
 }
-
-/* THP */
-
-/* cpuset/memcg */
-static void gather_node_cpus(char *cpus, long nd)
-{
-	int ncpus = 0;
-	int i;
-	long online;
-	char buf[BUFSIZ];
-	char path[BUFSIZ], path1[BUFSIZ];
-
-	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
-		ncpus++;
-
-	for (i = 0; i < ncpus; i++) {
-		snprintf(path, BUFSIZ,
-			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
-		if (tst_path_exists("%s", path)) {
-			snprintf(path1, BUFSIZ, "%s/online", path);
-			/*
-			 * if there is no online knob, then the cpu cannot
-			 * be taken offline
-			 */
-			if (tst_path_exists("%s", path1)) {
-				SAFE_FILE_SCANF(path1, "%ld", &online);
-				if (online == 0)
-					continue;
-			}
-			sprintf(buf, "%d,", i);
-			strcat(cpus, buf);
-		}
-	}
-	/* Remove the trailing comma. */
-	cpus[strlen(cpus) - 1] = '\0';
-}
-
-void write_cpusets(const struct tst_cg_group *cg, long nd)
-{
-	char cpus[BUFSIZ] = "";
-
-	SAFE_CG_PRINTF(cg, "cpuset.mems", "%ld", nd);
-
-	gather_node_cpus(cpus, nd);
-	/*
-	 * If the 'nd' node doesn't contain any CPUs,
-	 * the first ID of CPU '0' will be used as
-	 * the value of cpuset.cpus.
-	 */
-	if (strlen(cpus) != 0) {
-		SAFE_CG_PRINT(cg, "cpuset.cpus", cpus);
-	} else {
-		tst_res(TINFO, "No CPUs in the node%ld; "
-				"using only CPU0", nd);
-		SAFE_CG_PRINT(cg, "cpuset.cpus", "0");
-	}
-}
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 94e70f3c5..1edde3676 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -60,7 +60,7 @@ static void setup(void)
 	if (ret < 0)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
-	write_cpusets(tst_cg, memnode);
+	write_node_cpusets(tst_cg, memnode);
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 }
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 16e4018cf..851ec652e 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -80,7 +80,7 @@ void setup(void)
 		tst_brk(TBROK, "Failed to get a memory node "
 			      "using get_allowed_nodes()");
 
-	write_cpusets(tst_cg, memnode);
+	write_node_cpusets(tst_cg, memnode);
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
