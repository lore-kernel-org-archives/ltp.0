Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E70DD232C1
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 22:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 074BF3C6792
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 23:44:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83013C64B3
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 23:44:23 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 18D1614001EC
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 23:44:22 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso21955915e9.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 14:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767912261; x=1768517061; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRYeWMEB0bUyxgYmdNmkX0AeyRAxmlqgFY7rAkrT+DA=;
 b=Ihn+IfnnZSiCO05JuXgEZMDtdky3J0f4XuPQfkmMFxmNd6Q2CaBVliqmB3AXxXXMZe
 XJVF1wQh7iY3jOO17OhKF6ZfN/1Mz5G/YpayKOL9hKsNr6lBTuODWUsUSS9+//RZ1Axu
 T0cR0Ox0OcFzruC+DQw1kx7wPLnxf7y4+bHxA4rJSLtA9g22s32vGFTE4EVJFuIavQDG
 iF7wjHBTnvgyPdnlZKlxinHNnARgYUu2o/TUn6vjx45oxksmZmsMRcp9QIFzKTwb2YNk
 5JKTctRzv/mnGfNXoY5X9BO9QEOEJWXUKI91xyNSZ8GbWRhAQhduSV7Z1a+CcrHBaBmb
 k1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767912261; x=1768517061;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRYeWMEB0bUyxgYmdNmkX0AeyRAxmlqgFY7rAkrT+DA=;
 b=HfptEXZdKPK3eC4T1KHmX7sYwknnZ8YPR14whw1g+ofKHN+RcUQIhT1E1ELRTHs+6q
 5SYvmm+lLjkQypi0S/LDq8qPm9UnWwmRU6+jeIj215kzD3hA3hLCVcsv44LbRJ4m9eNK
 dWcIK7gFw+xD4t5eBftemmI/BXqRBNGcorN3/50FHyQMgzVw9INdXKxy9QYo0O1+SF6s
 9Z4scSDibLmlE/wARozLjC1HO6cE8ZbtsHk5Ezq4kuQcoVO8UZeo69PvJdxK1c0yyyku
 e52OuEmsufjFfjyDZBDtNJ+Fml2/P/YXVtwfHCPGnDLu39DM/+H8B5rYaqNRqvW/4i3F
 NX5Q==
X-Gm-Message-State: AOJu0Ywe6C4cI6wnFrVqr0fW3dRrzhdWMpXr3dTAujV3uOUabg6bjbtG
 9vBPFMMhokp8hUfAxftSudCMhFxwhMIoGFJ6yf3usOXYMYcfOJa6wDYwTP9N4SMO3Dsv8w==
X-Gm-Gg: AY/fxX67R7tT2emuxl+L6ctqkuAkNSsNitlYXAzsrtlkMpG60L5OhAS3UFPKCIrQr+o
 NjXsqwtxcR5jdXk2c26sh9we0gmdiC4PmkWop+fuAgv3svbs/rgGbUwM4h9uW+WyD7EhHT6IotC
 alcKapHdLMqFLvhL6pMw1L9NJhW06otlVnlIY8Z1+hqkPrLXlrEVpXAMJnWJvwelh/7db27SPoO
 +RsMWe3qcGVn8iifTThMYcMUKYxvOOM5ssVik//oWAaAets+QufuzMA3CcJ218wIadt0oToqYO2
 CBGn4uDaS6Vwcjw9D92pPCStxk8V1/8XAa8lRd6BlnYxU43IvoeqoWgCoS+fpIQV9s3G9WzYafY
 7oxpqWNQ3oT2C8X3lI+dce4tnxpvWsiUCU3kWigGh0nVEoTWdQv2LnOTD8YZqnOW6QB286TAGOq
 Q5OWYwmDy6XdkvOiM86Qt8f7KorHmXJLLkP2EIIA==
X-Google-Smtp-Source: AGHT+IHSf/OnGYtSO/I1r7IPHrzKyqhyJ3LAhqOwoKfJ5XJUEvHv2MdworNdFURedpme5aapRZcVXw==
X-Received: by 2002:a05:600c:1d19:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47d84b3989bmr73657525e9.32.1767912260392; 
 Thu, 08 Jan 2026 14:44:20 -0800 (PST)
Received: from pradeep-susarla-LTP.home
 ([2a00:23c8:d60c:ca01:6935:c28d:e4e8:dcf3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865f0cf2sm47546755e9.3.2026.01.08.14.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 14:44:19 -0800 (PST)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  8 Jan 2026 22:44:09 +0000
Message-ID: <20260108224409.165481-1-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugetlb: migrate library and numa helpers to libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>

Closes: #1276
---
 .../lib/hugetlb.h => include/tst_hugetlb.h    |  8 +-
 include/tst_numa.h                            |  9 +++
 libs/hugetlb/Makefile                         |  8 ++
 .../hugetlb.c => libs/hugetlb/libhugetlb.c    | 10 +--
 libs/numa/tst_numa.c                          | 79 ++++++++++++++++---
 testcases/kernel/include/numa_helper.h        |  2 +-
 testcases/kernel/lib/numa_cpuset.c            | 64 ---------------
 testcases/kernel/mem/hugetlb/Makefile         | 28 ++-----
 testcases/kernel/mem/hugetlb/Makefile.inc     | 24 +++---
 .../hugetlb/hugefallocate/hugefallocate01.c   |  2 +-
 .../hugetlb/hugefallocate/hugefallocate02.c   |  2 +-
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  2 +-
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap06.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap15.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap18.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap20.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap21.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap23.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap29.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     |  2 +-
 testcases/kernel/mem/hugetlb/lib/Makefile     | 10 ---
 testcases/kernel/mem/ksm/ksm02.c              |  5 +-
 testcases/kernel/mem/ksm/ksm04.c              |  7 +-
 testcases/kernel/mem/oom/oom04.c              |  1 +
 testcases/kernel/mem/oom/oom05.c              |  1 +
 64 files changed, 179 insertions(+), 177 deletions(-)
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.h => include/tst_hugetlb.h (91%)
 create mode 100644 libs/hugetlb/Makefile
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.c => libs/hugetlb/libhugetlb.c (90%)
 delete mode 100644 testcases/kernel/lib/numa_cpuset.c
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/Makefile

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/include/tst_hugetlb.h
similarity index 91%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.h
rename to include/tst_hugetlb.h
index fa742eb8d..409302137 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/include/tst_hugetlb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  * Copyright (c) Linux Test Project, 2004-2025
@@ -9,8 +9,8 @@
  * hugetlb.h - common definitions for the hugepage tests
  */
 
-#ifndef __HUGETLB_H
-#define __HUGETLB_H
+#ifndef TST_HUGETLB_H
+#define TST_HUGETLB_H
 
 #include <stdlib.h>
 #include <sys/ipc.h>
@@ -61,4 +61,4 @@ int do_readback(void *p, size_t size, char *desc);
 
 void update_shm_size(size_t *shm_size);
 
-#endif /* hugetlb.h */
+#endif /* TST_HUGETLB_H */
diff --git a/include/tst_numa.h b/include/tst_numa.h
index a1f961630..38019a17f 100644
--- a/include/tst_numa.h
+++ b/include/tst_numa.h
@@ -119,4 +119,13 @@ enum tst_numa_types {
  */
 struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
 
+struct tst_cg_group;
+
+/**
+ * write_node_cpusets() - Writes cpusets for a given node.
+ * @cg: Cgroup structure.
+ * @nd: Node number.
+ */
+void write_node_cpusets(const struct tst_cg_group *cg, long nd);
+
 #endif /* TST_NUMA_H__ */
diff --git a/libs/hugetlb/Makefile b/libs/hugetlb/Makefile
new file mode 100644
index 000000000..c60468976
--- /dev/null
+++ b/libs/hugetlb/Makefile
@@ -0,0 +1,8 @@
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+# This follows the naming convention seen in your ls -R output
+LIB := libltphugetlb.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/libs/hugetlb/libhugetlb.c
similarity index 90%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.c
rename to libs/hugetlb/libhugetlb.c
index 92b484d4a..a1addc565 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/libs/hugetlb/libhugetlb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) Linux Test Project, 2006-2025
  * Copyright (c) International Business Machines Corp., 2001
@@ -10,7 +10,7 @@
 #include <sys/shm.h>
 #include <sys/time.h>
 #include <pwd.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 key_t shmkey;
 
@@ -91,15 +91,15 @@ int do_readback(void *p, size_t size, char *desc)
 
 	for (i = 0; i < (size / sizeof(*q)); i++) {
 		if (q[i] != (RANDOM_CONSTANT ^ i)) {
-			tst_res(TFAIL, "At \"%s\": Mismatch at offset 0x%lx: 0x%x "
-					"instead of 0x%lx", desc, i, q[i], RANDOM_CONSTANT ^ i);
+			tst_res(TFAIL, "At \"%s\": Mismatch at offset 0x%lx: 0x%x instead of 0x%lx",
+					desc, i, q[i], RANDOM_CONSTANT ^ i);
 			return -1;
 		}
 	}
 	return 0;
 }
 
-void update_shm_size(size_t * shm_size)
+void update_shm_size(size_t *shm_size)
 {
 	size_t shmmax;
 
diff --git a/libs/numa/tst_numa.c b/libs/numa/tst_numa.c
index c3297013b..d9e7e7817 100644
--- a/libs/numa/tst_numa.c
+++ b/libs/numa/tst_numa.c
@@ -16,6 +16,7 @@
 #include "tst_test.h"
 #include "tst_numa.h"
 #include "lapi/numaif.h"
+#include "tst_cgroup.h"
 
 void tst_nodemap_print_counters(struct tst_nodemap *nodes)
 {
@@ -23,7 +24,7 @@ void tst_nodemap_print_counters(struct tst_nodemap *nodes)
 
 	for (i = 0; i < nodes->cnt; i++) {
 		tst_res(TINFO, "Node %i allocated %u pages",
-		        nodes->map[i], nodes->counters[i]);
+				nodes->map[i], nodes->counters[i]);
 	}
 }
 
@@ -77,7 +78,7 @@ static void inc_counter(unsigned int node, struct tst_nodemap *nodes)
 }
 
 void tst_nodemap_count_pages(struct tst_nodemap *nodes,
-                             void *ptr, size_t size)
+							 void *ptr, size_t size)
 {
 	size_t page_size = getpagesize();
 	unsigned int i;
@@ -113,7 +114,7 @@ void *tst_numa_map(const char *path, size_t size)
 	}
 
 	ptr = SAFE_MMAP(NULL, size,
-	                PROT_READ|PROT_WRITE, flags, fd, 0);
+					PROT_READ|PROT_WRITE, flags, fd, 0);
 
 	if (path) {
 		SAFE_CLOSE(fd);
@@ -131,6 +132,7 @@ static int node_has_enough_memory(int node, size_t min_kb)
 	long mem_used = -1;
 	long file_pages = 0;
 	long mem_avail;
+	FILE *fp;
 
 	/* Make sure there is some space for kernel upkeeping as well */
 	min_kb += 4096;
@@ -142,7 +144,7 @@ static int node_has_enough_memory(int node, size_t min_kb)
 		return 0;
 	}
 
-	FILE *fp = fopen(path, "r");
+	fp = fopen(path, "r");
 	if (!fp)
 		tst_brk(TBROK | TERRNO, "Failed to open '%s'", path);
 
@@ -170,8 +172,8 @@ static int node_has_enough_memory(int node, size_t min_kb)
 
 	if (mem_avail < (long)min_kb) {
 		tst_res(TINFO,
-		        "Not enough free RAM on node %i, have %likB needs %zukB",
-		        node, mem_avail, min_kb);
+				"Not enough free RAM on node %i, have %likB needs %zukB",
+				node, mem_avail, min_kb);
 		return 0;
 	}
 
@@ -200,15 +202,15 @@ struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
 	tst_res(TINFO, "Found %u NUMA memory nodes", cnt);
 
 	nodes = SAFE_MALLOC(sizeof(struct tst_nodemap)
-	                    + sizeof(unsigned int) * cnt);
+						+ sizeof(unsigned int) * cnt);
 	nodes->cnt = cnt;
 	nodes->counters = NULL;
 
 	cnt = 0;
 	for (i = 0; i < membind->size; i++) {
 		if (type & TST_NUMA_MEM &&
-		    (!numa_bitmask_isbitset(membind, i) ||
-		     !node_has_enough_memory(i, min_mem_kb)))
+			(!numa_bitmask_isbitset(membind, i) ||
+			 !node_has_enough_memory(i, min_mem_kb)))
 			continue;
 
 		nodes->map[cnt++] = i;
@@ -222,3 +224,62 @@ struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
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
+	char path[BUFSIZ], path1[BUFSIZ + 16];
+	int ret;
+
+	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++) {
+		snprintf(path, BUFSIZ,
+			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
+		if (tst_path_exists("%s", path)) {
+			ret = snprintf(path1, sizeof(path1), "%s/online", path);
+			if (ret < 0 || (size_t)ret >= sizeof(path1))
+				tst_brk(TBROK, "Path truncated for %s/online", path);
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
index e67ddaaca..2eae1160e 100644
--- a/testcases/kernel/include/numa_helper.h
+++ b/testcases/kernel/include/numa_helper.h
@@ -55,6 +55,6 @@ int get_allowed_nodes(int flag, int count, ...);
 void nh_dump_nodes(void);
 int is_numa(void (*cleanup_fn)(void), int flag, int min_nodes);
 
-void write_node_cpusets(const struct tst_cg_group *cg, long nd);
+
 
 #endif /* NUMA_HELPER_H */
diff --git a/testcases/kernel/lib/numa_cpuset.c b/testcases/kernel/lib/numa_cpuset.c
deleted file mode 100644
index 088d2d4e5..000000000
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
diff --git a/testcases/kernel/mem/hugetlb/Makefile b/testcases/kernel/mem/hugetlb/Makefile
index 82ae5330e..c456d5e16 100644
--- a/testcases/kernel/mem/hugetlb/Makefile
+++ b/testcases/kernel/mem/hugetlb/Makefile
@@ -1,25 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) International Business Machines Corp., 2001
 
-top_srcdir		?= ../../../..
+top_srcdir      ?= ../../../..
 
-include	$(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/env_pre.mk
 
-LIBDIR			:= lib
-LIB			:= $(LIBDIR)/libhugetlb.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
+# The actual test subdirectories are automatically found 
+# by generic_trunk_target.mk. 
+# We don't need to define LIB or MAKE_DEPS here because 
+# they are now handled in Makefile.inc.
 
-$(LIBDIR):
-	mkdir -p "$@"
-
-$(LIB): $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
-
-MAKE_DEPS		:= $(LIB)
-
-trunk-clean:: | lib-clean
-
-lib-clean:: $(LIBDIR)
-	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
-
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index b272e62a8..d4c9ecab1 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -21,15 +21,19 @@
 #
 
 # DO NOT USE THIS FILE FOR hugetlb / lib!!!
-LIBIPCDIR		:= ../lib
-LIBIPC			:= $(LIBIPCDIR)/libhugetlb.a
 
-$(LIBIPCDIR):
-	mkdir -p "$@"
-$(LIBIPC): $(LIBIPCDIR)
-	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
+# Point to the new global library location
+LIBHUGETLB_DIR  := $(top_srcdir)/libs/hugetlb
+LIBHUGETLB      := $(LIBHUGETLB_DIR)/libltphugetlb.a
 
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
-LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
-LDLIBS			+= -lhugetlb
-MAKE_DEPS		+= $(LIBIPC)
+# We don't need to mkdir here anymore because the folder is part of the repo
+# But we must ensure the library is built before the test
+$(LIBHUGETLB):
+	$(MAKE) -C $(LIBHUGETLB_DIR) all
+
+# Linker flags: Tell the compiler where to find the .a file and what to call it
+LDFLAGS         += -L$(LIBHUGETLB_DIR)
+LDLIBS          += -lltphugetlb
+
+# Ensure the library is a dependency for the tests
+MAKE_DEPS       += $(LIBHUGETLB)
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index 53fef3ddb..9568ac40d 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index 1f7c4dcc6..fb7f0e40d 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -16,7 +16,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MAX_PAGES_TO_USE 5
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 54603b98b..a1afedda3 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -19,7 +19,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define C1		0x1234ABCD
 #define C2		~0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
index cafeaa242..013e6d77a 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -11,7 +11,7 @@
  */
 
 #include "tst_safe_sysv_ipc.h"
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static int shmid = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index de5133381..d6cde4492 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -26,7 +26,7 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static long *addr;
 static int  fildes;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 611ae7090..4c05f7757 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -29,7 +29,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define LOW_ADDR       0x80000000
 #define LOW_ADDR2      0x90000000
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f52747e68..02516e4ae 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -28,7 +28,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static char TEMPFILE[MAXPATHLEN];
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 75f28102d..2f34b3d52 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -17,7 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 1ac989487..42eee50c3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -26,7 +26,7 @@
 #define _GNU_SOURCE
 #include <pthread.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "lapi/mmap.h"
 
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 5a965e182..360ab9255 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "tst_safe_stdio.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index b9d61dd66..07dbafdf1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -26,7 +26,7 @@
 #include <sys/wait.h>
 #include <signal.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define WITH_OVERCOMMIT 0
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 10f64674d..0aa81c2b1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index e1795153d..833996d6d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 087e8c691..622f82830 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -17,7 +17,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define P0 "ffffffff"
 #define IOSZ 4096
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 523ea9025..e962ac26b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 206582ebe..e517f47ee 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -21,7 +21,7 @@
 #include <sys/types.h>
 #include <lapi/mmap.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index 5a0fba9bb..1dbc0a863 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -21,7 +21,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index 1dde9e87b..4413b59d3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -22,7 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
 	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index bd5fae5c9..9ced89906 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
index b784005af..5dd623baf 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -27,7 +27,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define MAP_LENGTH	(4UL * hpage_size)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index 45796decd..fcc33808f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -26,7 +26,7 @@
 #include <stdlib.h>
 #include <sys/mman.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
index 13c3c7ac6..67db1a4dd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -25,7 +25,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define RANDOM_CONSTANT	0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index 313efb4bc..50075498e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -9,7 +9,7 @@
  * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define FLAGS_DESC(x) .flags = x, .flags_str = #x
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index 3792cff89..86b67a517 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -11,7 +11,7 @@
  * were not corrupted by the other threads.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define THREADS 5
 #define NR_HUGEPAGES 6
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index 78e4a3bf9..6793906d6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -12,7 +12,7 @@
  * iterations.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define NR_HUGEPAGES 2
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index 86157d262..7f9dc2fb8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define RANDOM_CONSTANT 0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 0de44d58a..eef6b0fb0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 7d9fd0b60..605ed2556 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index cd60d7403..34fdbc1ba 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index f79258da6..ab7d95f52 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 48cedd158..2567eb996 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -10,7 +10,7 @@
  * mapping. Otherwise, reserve count will be overflowed.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index f04974500..e5ed91005 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -12,7 +12,7 @@
  * shared mmap data.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define C1 0x1234ABCD
 #define C2 0xFEDC9876
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index a624f4a26..09a3f3c06 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 57367b641..0f9c366a6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -10,7 +10,7 @@
  * seen to other mapping or not?
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 188ee2176..c99554277 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -19,7 +19,7 @@
 
 #include <stdio.h>
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
 #define GIGANTIC_MIN_ORDER 10
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index ab7469cd7..b355a1497 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -20,7 +20,7 @@
 
 #define _GNU_SOURCE
 #include "lapi/mmap.h"
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "tst_safe_stdio.h"
 #include <errno.h>
 #include <inttypes.h>
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 3a50e6b55..7729a7e83 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -27,7 +27,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define CASE0 10 /* values to write into the shared */
 #define CASE1 20 /* memory location.                */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index e79d682f3..8e8e4a04d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -26,7 +26,7 @@
 #include <pwd.h>
 #include <limits.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #ifdef TST_ABI64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 9de925739..39ecbaaec 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -31,7 +31,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 9f877fd07..48b9d917b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -19,7 +19,7 @@
  * 	test must be run at root
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 3b2ae351c..6725de8d5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -26,7 +26,7 @@
  *
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static long page_size;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index bd4437b13..b1fc18b46 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -10,7 +10,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 #define N_ATTACH	4U
 #define NEWMODE		0066
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 82126f52c..883cf522e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -26,7 +26,7 @@
 
 #include <pwd.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "lapi/syscalls.h"
 
 static size_t shm_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index ec4640686..544e7c04b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -36,7 +36,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 0b9515fda..540927b68 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -30,7 +30,7 @@
 
 #include <setjmp.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 627356510..f977c8ed6 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -13,7 +13,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index bbd968c06..aff45f305 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -12,7 +12,7 @@
  *	04/2004 - Updated by Robbie Williamson
  */
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 625761f6e..5b1c914a7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -12,7 +12,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 336319603..c1dc2d0d5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -14,7 +14,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
index ca93ae6d8..8f1d1d6ae 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -12,7 +12,7 @@
  * works correctly by validating the data written to segment.
  */
 
-#include "hugetlb.h"
+#include "tst_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 
 #define NR_HUGEPAGES 4
diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
deleted file mode 100644
index 45606b17f..000000000
--- a/testcases/kernel/mem/hugetlb/lib/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INTERNAL_LIB		:= libhugetlb.a
-
-include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index ab16af29e..142aa868c 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -54,7 +54,10 @@
 #include <stdio.h>
 #include <unistd.h>
 #include "tst_test.h"
-#include "ksm_common.h"
+#include "tst_safe_stdio.h"
+#include "tst_numa.h"
+#include "ksm_helper.h"
+#include "numa_helper.h"
 
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 26506b4f6..5877a04ea 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -34,10 +34,11 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
-#include <stdio.h>
-#include <unistd.h>
 #include "tst_test.h"
-#include "ksm_common.h"
+#include "tst_safe_stdio.h"
+#include "tst_numa.h"
+#include "ksm_helper.h"
+#include "numa_helper.h"
 
 #ifdef HAVE_NUMA_V2
 #include <numaif.h>
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index d4beb12c7..b0859271c 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -19,6 +19,7 @@
 
 #include "tst_test.h"
 #include "numa_helper.h"
+#include "tst_numa.h"
 #include "oom.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 6b8d436d1..30321a342 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -19,6 +19,7 @@
 
 #include "tst_test.h"
 #include "numa_helper.h"
+#include "tst_numa.h"
 #include "oom.h"
 
 #ifdef HAVE_NUMA_V2
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
