Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6407BCA5FEC
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 21:16:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 995713E4E5F
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 23:16:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD59B3E4EF5
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:53 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1017E1000224
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 23:15:53 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so10197885e9.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791148552; x=1791753352; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1X6A2MIKYzRZw9pFAC+zryzYx3s7sn0/rk1axo7DGNQ=;
 b=gROVXBGKq1+pl3tHNux9xIxisx3ZLlhGMssaL8CgzDTyzCJe0NL3gr/KQvm3QPy8Z0
 sEY1ld6o6r2SPm6bJ7X5QQxBSVcpm9wONB+KbRRd8SlaB7OyNtWejhmsjgernyAZVHZX
 /DYXSNqmZfp7RDIbUERkhMBIVEPWH2+brPfVkwlrbov2UM2pRdn+45ry6LKKuLCIXhMi
 kBo6y+GW4JE6lDep0pH3LOLtRcOLowTu8BXmvrFXoW5HC7/636ZPuB+qSPh+X+ZdkNuK
 U0FkjKc0Y5Keiu2QoBw0F1A3t8dqni0dG/98uCFv8aBBKEVMZJdxyQOkdDqsT8CrAPqU
 2e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791148552; x=1791753352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1X6A2MIKYzRZw9pFAC+zryzYx3s7sn0/rk1axo7DGNQ=;
 b=O2C1tau4BNjJ38GRlbPh/fw5D6uZc3xAXQPouNx6Jmxgc4MTY5/rdwksjt8mxs60gh
 WotW61gnKOMOEz1HLSV4o4SF9mCxUyEDDi9u6pv2xjZBSNfbIhR4vl2/tZQw/KFQllUn
 IStSUEcrNdGBQwfXXoawpzrB2V8mgbLf+WeBaPdMkcAPU+bZlIXNrFTKUzE6NJ0zghnk
 4qS+IzMbYu5yTkxPlZH8fwtILOIFQVhTXW9UGu7JptoSjsoVXtW3NFZcENZTcbFysQ29
 IvCSSsLBZ6JRPdccqkR41g+js1BwzolA8kktO3w/hZLNiwUkHgNtT2C/RAMQX/0FV2rZ
 FeUA==
X-Gm-Message-State: AFuF++kirG61/U+J4P1/VH/paa6mhPG5DsotloOH7ZwGGYzqZa4fKYzg
 /aQ4XrYtYflrsdw/11knKmiaiN2zoNDgN1bwggTFB8BkgVri60jwFVvi6Mx9/rjFEYo=
X-Gm-Gg: AYBFou1Re07wwWF/6FH54uwpDU4ApdNneLDZJ5+JWKI01jlF2GC5DhXK8JZHH0Vfc/B
 aOkZoe4H8klQFO2q8QwFImUNcxG9vCJV0Nn8WSl4my56gkUpz6Md0av3y5PjteDNIyVOp+fwwSH
 bXmipI4uH2KXYKFR1Qr4ER66lzwvZ0gsyu4qtsrTXjbfK+8r9gHn0La0xJd4P54t4U9UagSR6+6
 g0br3U2N7sG3Pc2Rhz0rtqjtPQ+847jUiz5PQEEH3L7aN5UzoXSkIEHfLr3jKW13Z/6IQNmHqKY
 FzIJ1PDkXlos9Tgup/B+xV3DMk3wH+vpypl8ebSlOoBy+eBrpqpOK3n6WFif94jUnbvwZvvMOiX
 /NLlPbPRITRhWSz0mwM8c1ZfFQ9gaXVYpCyqSHzDYVU1MjcUlzNEWxntzisoyKjVSoPFDKufLPW
 X1QzJQyqG2W2mtDW73hnic2IuRSBqpl10oAO1q5FIGOg0srnsyuAjywqOj0nku0vS/h7SkhDKDK
 yMsT35sc7DK5SA+DhKo9PSkQZIS+mqMR6gH8Fysutc73Eu+S8mpi1dTV05fKeghdaMGtFWD6/KA
 Rc6njK0Abiohh8XXr0spSpTb
X-Received: by 2002:a7b:cd8e:0:b0:49f:bd3c:bc18 with SMTP id
 5b1f17b1804b1-4a02758ff89mr102313015e9.19.1791148552352; 
 Sun, 04 Oct 2026 14:15:52 -0700 (PDT)
Received: from pradeep-susarla-LTP.tail3351fa.ts.net
 (cmbg-20-b2-v4wan-174372-cust280.vm17.cable.virginm.net. [80.3.67.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03950375dsm115151725e9.1.2026.10.04.14.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 14:15:51 -0700 (PDT)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Oct 2026 22:15:34 +0100
Message-ID: <20261004211535.7307-3-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004211535.7307-1-pradeep.susarla@gmail.com>
References: <20261004211535.7307-1-pradeep.susarla@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] numa: Move write_node_cpusets() into libs/numa
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
Cc: Li Wang <liwang@redhat.com>, pradeep.susarla@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

write_node_cpusets() lived in testcases/kernel/lib/numa_cpuset.c and was
built into libkerntest.a, while its declaration sat in numa_helper.h.
Move the function into libs/numa/tse_numa.c (libltpnuma.a) next to the
rest of the NUMA helpers and declare it in include/tse_numa.h, so that
the exposed header matches the libs/ code it belongs to.

Tests that call write_node_cpusets() (ksm02, ksm04, oom04, oom05) now
link -lltpnuma, matching ksm06 which already did. The buffer used to
build the per-CPU sysfs path is sized to fit the "/online" suffix to
avoid a -Wformat-truncation warning.

No functional changes intended.

Part of #1276.

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>
---
 include/tse_numa.h                     | 13 ++++++
 libs/numa/tse_numa.c                   | 57 +++++++++++++++++++++++
 testcases/kernel/include/numa_helper.h |  4 --
 testcases/kernel/lib/numa_cpuset.c     | 64 --------------------------
 testcases/kernel/mem/ksm/Makefile      |  2 +
 testcases/kernel/mem/ksm/ksm_common.h  |  1 +
 testcases/kernel/mem/oom/Makefile      |  4 ++
 testcases/kernel/mem/oom/oom04.c       |  1 +
 testcases/kernel/mem/oom/oom05.c       |  1 +
 9 files changed, 79 insertions(+), 68 deletions(-)
 delete mode 100644 testcases/kernel/lib/numa_cpuset.c

diff --git a/include/tse_numa.h b/include/tse_numa.h
index ac6aab4..20da7d7 100644
--- a/include/tse_numa.h
+++ b/include/tse_numa.h
@@ -119,4 +119,17 @@ enum tse_numa_types {
  */
 struct tse_nodemap *tse_get_nodemap(int type, size_t min_mem_kb);
 
+struct tst_cg_group;
+
+/**
+ * write_node_cpusets() - Sets up the cpuset cgroup controller for a NUMA node.
+ *
+ * Writes the node id to cpuset.mems and the list of the node's online CPUs to
+ * cpuset.cpus. If the node has no CPUs, CPU 0 is used instead.
+ *
+ * @cg: Cgroup to configure.
+ * @nd: NUMA node id.
+ */
+void write_node_cpusets(const struct tst_cg_group *cg, long nd);
+
 #endif /* TSE_NUMA_H__ */
diff --git a/libs/numa/tse_numa.c b/libs/numa/tse_numa.c
index 835b458..3852e0c 100644
--- a/libs/numa/tse_numa.c
+++ b/libs/numa/tse_numa.c
@@ -15,6 +15,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tse_numa.h"
+#include "tst_cgroup.h"
 #include "lapi/numaif.h"
 
 void tse_nodemap_print_counters(struct tse_nodemap *nodes)
@@ -222,3 +223,59 @@ struct tse_nodemap *tse_get_nodemap(int type, size_t min_mem_kb)
 }
 
 #endif
+
+#define PATH_SYS_SYSTEM "/sys/devices/system"
+
+static void gather_node_cpus(char *cpus, long nd)
+{
+	int ncpus = 0;
+	int i;
+	long online;
+	char buf[BUFSIZ];
+	char path[BUFSIZ], path1[BUFSIZ + sizeof("/online")];
+
+	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++) {
+		snprintf(path, BUFSIZ,
+			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
+		if (tst_path_exists("%s", path)) {
+			snprintf(path1, sizeof(path1), "%s/online", path);
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
diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
index e67ddaa..0d449c3 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -27,8 +27,6 @@
 # include <numaif.h>
 #endif
 
-struct tst_cg_group;
-
 #define NH_MEMS (1 << 0)
 #define NH_CPUS (1 << 1)
 
@@ -55,6 +53,4 @@ int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes(void);
 int is_numa(void (*cleanup_fn)(void), int flag, int min_nodes);
 
-void write_node_cpusets(const struct tst_cg_group *cg, long nd);
-
 #endif /* NUMA_HELPER_H */
diff --git a/testcases/kernel/lib/numa_cpuset.c b/testcases/kernel/lib/numa_cpuset.c
deleted file mode 100644
index 088d2d4..0000000
--- a/testcases/kernel/lib/numa_cpuset.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) Linux Test Project, 2011-2021
- * Copyright (c) Cyril Hrubis <chrubis@suse.cz> 2024
- */
-
-#define TST_NO_DEFAULT_MAIN
-#include "tst_test.h"
-#include "tst_cgroup.h"
-#include "numa_helper.h"
-
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
-void write_node_cpusets(const struct tst_cg_group *cg, long nd)
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
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index 2af02a2..5af7289 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -4,6 +4,8 @@
 top_srcdir		?= ../../../..
 
 LTPLIBS = numa
+ksm02: LTPLDLIBS = -lltpnuma
+ksm04: LTPLDLIBS = -lltpnuma
 ksm06: LTPLDLIBS = -lltpnuma
 
 include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index d677b22..cb89b5e 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -13,6 +13,7 @@
 #include "tst_test.h"
 #include "ksm_helper.h"
 #include "numa_helper.h"
+#include "tse_numa.h"
 #include "ksm_test.h"
 
 #define DEFAULT_MEMSIZE 128
diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index db621b9..dc038f8 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -18,6 +18,10 @@
 
 top_srcdir		?= ../../../..
 
+LTPLIBS = numa
+oom04: LTPLDLIBS = -lltpnuma
+oom05: LTPLDLIBS = -lltpnuma
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/testcases/kernel/include/lib.mk
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index b879e68..394a138 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -19,6 +19,7 @@
 
 #include "tst_test.h"
 #include "numa_helper.h"
+#include "tse_numa.h"
 #include "oom.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 998bd86..93c0bc3 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -19,6 +19,7 @@
 
 #include "tst_test.h"
 #include "numa_helper.h"
+#include "tse_numa.h"
 #include "oom.h"
 
 #ifdef HAVE_NUMA_V2
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
