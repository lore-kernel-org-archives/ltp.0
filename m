Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81142CD4F54
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 23:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A70623E1CB0
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 01:42:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDF0B3C4C09
 for <ltp@lists.linux.it>; Sun, 31 May 2026 01:41:58 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF6CB1A002E2
 for <ltp@lists.linux.it>; Sun, 31 May 2026 01:41:47 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c0bd02d97eso3142645ad.2
 for <ltp@lists.linux.it>; Sat, 30 May 2026 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780184506; x=1780789306; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SlPoYksB0SUnM8oXhtPzdkkfxufxYYY0k31Qq8FMkOg=;
 b=DvueeujwzTuqQ895u3ATJGMtwt1sv8IFNEi5I8sEDY8s3kJ2S399lyNN3nC5XpKsmu
 9MMSWvTKmufqwDzUa2H3afmKh/hD5MP04+N9dP2xyUWmzT5ooRl6Zp5JJGpoygfQWo8m
 B0EkhXGxWD0taKy/or4Omn3/n7npbU4M+xBglVsbVBPDymG/J6nkJ+uCKa3VMHQq8/O2
 KTSYBcVfaVkkegUahZVZVtEvM5t7CWNzzoBCUXr/BBhN2+NDrYV8YbixbvIRcFoCysaz
 l6sJA4MpsSywJ7CXiM3iC5fBUkA0CB99nAeA9gNjPBkQ0F/2z198Kk4hWJeOi6iQgP3e
 VcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780184506; x=1780789306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlPoYksB0SUnM8oXhtPzdkkfxufxYYY0k31Qq8FMkOg=;
 b=dJgzsAgyImnAQqAf8d2n8FsjjzjdIffvYOrx3Mw9bw/mHtZnlJB3/QX3DtNErAtiT+
 CqUjQGcwR7vYUwZyeSE9gF5VuJNKN7yO3WA83+ZkHLDXUpmFzVzTdG5nApFsdAy22UA+
 6eVNYKHTEtKAoNDrIUeEpqWnZ6CYefR4UEB4gG+CXqjB1rSAX5hmWGZIKGFgxS/YSEXf
 kM3MJWZt4C5wh3TZUq4Hkgw50dS+L/9efxPOg2MwMK4ntsq+7hJxLo2tKNZK25iOlaF1
 DR00GyVOF0E7iacGIhtjgbPSE1U2h2NvDwmBWb2UdZcHHJefVZOCviu5/BqkzCM95jEr
 30/A==
X-Gm-Message-State: AOJu0Yxc8mjET+oVYvIj0bTErq5V4FBiK3eXgh0/26gfgGiaCT/w1LeP
 5MplfNmBj3Ae5y7WtWr/yTScIV/am/undD84Q4A0MwqdT9eN1PNghWE9n/cw3MsQD4o=
X-Gm-Gg: Acq92OFCnH5YqQotxmq8gQSnfNfsJ8lPgBVwDzJAcJz6rLXNpOLdT/+/lQh1Koz/90t
 dpXDmhtqPPJwDla1/5Jxeg7OqJdY9xKMg7eUrKdNRlzzLkD98ouwZKa8xfXMdKvo/5rQpclj4bC
 n27BwfdCwa1kNf2wXfWE78poy2YsdYw1X19A94fhhb8yRC5gZKyPX0O6qVAn7DrI5wUuQcZPFu3
 yVfq4lHgQZq5b3YFtRZC/NCeIDWgTLIJ9jD1ChnBOSFz++e4REzfM6EG5db3lydn8uvex9OEdNh
 L/GdDA0FCAlglhFLXqUwEY7knEjWhX6SEHrwbAKwMPXpxYAaYMjGiwkb+4I2UiU6RQNHxqB94l0
 H+xTJgUbbYZz5noqKlS52RnWZRMJ7i8D4ZuVm+ylrNZNNe37tWaFAVzLABm0w2duXWW4SwjQStQ
 /fiGv9SI22Yuac+jZBEYynYyPWxvEjfQRJ0anlNlDq90RF/mekdHATxNLjgtYlV/AYFo0dcX8sI
 dZ0b+8HSxf53GnCfmLWMtSsYg==
X-Received: by 2002:a05:6a20:2448:b0:3a2:e26b:2940 with SMTP id
 adf61e73a8af0-3b427bed72emr5520287637.0.1780184505558; 
 Sat, 30 May 2026 16:41:45 -0700 (PDT)
Received: from Win11.lan (cpc92710-cmbg20-2-0-cust486.5-4.cable.virginm.net.
 [82.17.135.231]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5670647a12.21.2026.05.30.16.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:41:43 -0700 (PDT)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
X-Google-Original-From: Pradeep Susarla <pradeep.susarla@inmarsat.com>
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 00:41:23 +0100
Message-Id: <20260530234123.1718-1-pradeep.susarla@inmarsat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] hugetlb: Migrate library and numa helpers to libs/
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

From: Pradeep Susarla <pradeep.susarla@gmail.com>

Consolidate two test helpers into the global libs/ location, following
the tse_ (extended, non-core library) naming adopted for libs/ (tst_ =
core lib/, tse_ = extended libs/, tso_ = legacy):

hugetlb library:
  testcases/kernel/mem/hugetlb/lib/hugetlb.h -> include/tse_hugetlb.h
  testcases/kernel/mem/hugetlb/lib/hugetlb.c -> libs/hugetlb/tse_hugetlb.c

  The hand-rolled per-suite library build (lib/Makefile and Makefile.inc)
  is replaced by the standard LTPLIBS mechanism: each hugetlb test
  directory sets "LTPLIBS = hugetlb" and links -lltphugetlb, and the
  library builds as libs/hugetlb/libltphugetlb.a.

write_node_cpusets():
  Moved from testcases/kernel/lib/numa_cpuset.c (libkerntest.a) into
  libs/numa/tse_numa.c (libltpnuma.a) and declared in include/tse_numa.h.
  Tests that call it (ksm02, ksm04, oom04, oom05) now link -lltpnuma,
  matching ksm06 which already did. The per-CPU sysfs path buffer is
  sized to fit the "/online" suffix to avoid a -Wformat-truncation
  warning.

This covers the hugetlb library and numa_cpuset.c. The remaining helpers
from the issue are left as follow-ups: numa_helper.c still uses the
legacy test API and should be rewritten before being moved, and the
placement of the single ksm_helper.c function is still open.

No functional changes intended.

Part of #1276

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>
---
v2 (rebase of the original Jan 2026 submission):
 - Rebased onto the merged tse_ naming scheme (v1 still used tst_).
 - Fix the ksm02 link failure reported on v1: ksm02, ksm04, oom04 and
   oom05 now link -lltpnuma (v1 only adjusted #includes, which does
   not resolve the moved symbol at link time).
 - Use the standard LTPLIBS mechanism for the hugetlb tests instead of
   a hand-rolled Makefile.inc.
 - Size the per-CPU sysfs path buffer to avoid -Wformat-truncation.
 - Keep the file relocation as a clean git rename (no style churn).

 .../lib/hugetlb.h => include/tse_hugetlb.h    | 11 ++--
 include/tse_numa.h                            | 13 ++++
 libs/hugetlb/Makefile                         | 11 ++++
 .../hugetlb.c => libs/hugetlb/tse_hugetlb.c   |  2 +-
 libs/numa/tse_numa.c                          | 57 +++++++++++++++++
 testcases/kernel/include/numa_helper.h        |  4 --
 testcases/kernel/lib/numa_cpuset.c            | 64 -------------------
 testcases/kernel/mem/hugetlb/Makefile         | 21 +-----
 testcases/kernel/mem/hugetlb/Makefile.inc     | 35 ----------
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  4 +-
 .../hugetlb/hugefallocate/hugefallocate01.c   |  2 +-
 .../hugetlb/hugefallocate/hugefallocate02.c   |  2 +-
 .../kernel/mem/hugetlb/hugefork/Makefile      |  4 +-
 .../kernel/mem/hugetlb/hugefork/hugefork01.c  |  2 +-
 .../kernel/mem/hugetlb/hugefork/hugefork02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/Makefile      |  4 +-
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
 .../kernel/mem/hugetlb/hugeshmat/Makefile     |  4 +-
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat05.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmctl/Makefile    |  4 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../kernel/mem/hugetlb/hugeshmdt/Makefile     |  4 +-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../kernel/mem/hugetlb/hugeshmget/Makefile    |  4 +-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget06.c     |  2 +-
 testcases/kernel/mem/hugetlb/lib/Makefile     | 10 ---
 testcases/kernel/mem/ksm/Makefile             |  2 +
 testcases/kernel/mem/ksm/ksm_common.h         |  1 +
 testcases/kernel/mem/oom/Makefile             |  4 ++
 testcases/kernel/mem/oom/oom04.c              |  1 +
 testcases/kernel/mem/oom/oom05.c              |  1 +
 72 files changed, 169 insertions(+), 196 deletions(-)
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.h => include/tse_hugetlb.h (87%)
 create mode 100644 libs/hugetlb/Makefile
 rename testcases/kernel/mem/hugetlb/lib/hugetlb.c => libs/hugetlb/tse_hugetlb.c (99%)
 delete mode 100644 testcases/kernel/lib/numa_cpuset.c
 delete mode 100644 testcases/kernel/mem/hugetlb/Makefile.inc
 delete mode 100644 testcases/kernel/mem/hugetlb/lib/Makefile

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/include/tse_hugetlb.h
similarity index 87%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.h
rename to include/tse_hugetlb.h
index fa742eb..1c86da8 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/include/tse_hugetlb.h
@@ -1,16 +1,15 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- *
  * Copyright (c) Linux Test Project, 2004-2025
  * Copyright (c) International Business Machines Corp., 2001
  */
 
 /*
- * hugetlb.h - common definitions for the hugepage tests
+ * Common definitions for the hugepage tests
  */
 
-#ifndef __HUGETLB_H
-#define __HUGETLB_H
+#ifndef TSE_HUGETLB_H
+#define TSE_HUGETLB_H
 
 #include <stdlib.h>
 #include <sys/ipc.h>
@@ -61,4 +60,4 @@ int do_readback(void *p, size_t size, char *desc);
 
 void update_shm_size(size_t *shm_size);
 
-#endif /* hugetlb.h */
+#endif /* TSE_HUGETLB_H */
diff --git a/include/tse_numa.h b/include/tse_numa.h
index 839512b..5bad174 100644
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
diff --git a/libs/hugetlb/Makefile b/libs/hugetlb/Makefile
new file mode 100644
index 0000000..9a0d008
--- /dev/null
+++ b/libs/hugetlb/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines Corp., 2001
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= libltphugetlb.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/libs/hugetlb/tse_hugetlb.c
similarity index 99%
rename from testcases/kernel/mem/hugetlb/lib/hugetlb.c
rename to libs/hugetlb/tse_hugetlb.c
index 92b484d..212e973 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/libs/hugetlb/tse_hugetlb.c
@@ -10,7 +10,7 @@
 #include <sys/shm.h>
 #include <sys/time.h>
 #include <pwd.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 key_t shmkey;
 
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
diff --git a/testcases/kernel/mem/hugetlb/Makefile b/testcases/kernel/mem/hugetlb/Makefile
index 82ae533..d38ed7a 100644
--- a/testcases/kernel/mem/hugetlb/Makefile
+++ b/testcases/kernel/mem/hugetlb/Makefile
@@ -1,25 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) International Business Machines  Corp., 2001
+# Copyright (c) International Business Machines Corp., 2001
 
 top_srcdir		?= ../../../..
 
-include	$(top_srcdir)/include/mk/env_pre.mk
-
-LIBDIR			:= lib
-LIB			:= $(LIBDIR)/libhugetlb.a
-FILTER_OUT_DIRS		:= $(LIBDIR)
-
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
+include $(top_srcdir)/include/mk/env_pre.mk
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
deleted file mode 100644
index b272e62..0000000
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-#    kernel/mem/hugetlb testcase suite common definitions Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-# DO NOT USE THIS FILE FOR hugetlb / lib!!!
-LIBIPCDIR		:= ../lib
-LIBIPC			:= $(LIBIPCDIR)/libhugetlb.a
-
-$(LIBIPCDIR):
-	mkdir -p "$@"
-$(LIBIPC): $(LIBIPCDIR)
-	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
-
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
-LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
-LDLIBS			+= -lhugetlb
-MAKE_DEPS		+= $(LIBIPC)
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
index 77ebb0a..720063c 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
@@ -4,7 +4,9 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
index 53fef3d..5801fbe 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
index 1f7c4dc..abc9068 100644
--- a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
@@ -16,7 +16,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/fallocate.h"
 
 #define MAX_PAGES_TO_USE 5
diff --git a/testcases/kernel/mem/hugetlb/hugefork/Makefile b/testcases/kernel/mem/hugetlb/hugefork/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugefork/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
index 54603b9..2580cf9 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
@@ -19,7 +19,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define C1		0x1234ABCD
 #define C2		~0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
index cafeaa2..1d66e67 100644
--- a/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
+++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork02.c
@@ -11,7 +11,7 @@
  */
 
 #include "tst_safe_sysv_ipc.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static int shmid = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6e72e70..6e72c13 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -4,8 +4,10 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
 CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index de51333..557892e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -26,7 +26,7 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static long *addr;
 static int  fildes;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 611ae70..919e5ad 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -29,7 +29,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define LOW_ADDR       0x80000000
 #define LOW_ADDR2      0x90000000
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f52747e..6a79a5d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -28,7 +28,7 @@
 #include <limits.h>
 #include <sys/param.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static char TEMPFILE[MAXPATHLEN];
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 75f2810..ec4e472 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -17,7 +17,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 1ac9894..55554fd 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -26,7 +26,7 @@
 #define _GNU_SOURCE
 #include <pthread.h>
 #include <stdio.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/mmap.h"
 
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
index 5a965e1..d11ee5f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_stdio.h"
 
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index b9d61dd..d348d20 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -26,7 +26,7 @@
 #include <sys/wait.h>
 #include <signal.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define WITH_OVERCOMMIT 0
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
index 10f6467..684d62b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -18,7 +18,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index e179515..0377321 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 087e8c6..d88bf9f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -17,7 +17,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define P0 "ffffffff"
 #define IOSZ 4096
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
index 523ea90..f7a8068 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
index 206582e..e82ac8a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
@@ -21,7 +21,7 @@
 #include <sys/types.h>
 #include <lapi/mmap.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
index 5a0fba9..27c79b1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap14.c
@@ -21,7 +21,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define FOURGB (1ULL << 32)
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
index f2984e2..8a64fd3 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
@@ -22,7 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #if defined(__powerpc__) || defined(__powerpc64__) || defined(__ia64__) || \
 	defined(__s390__) || defined(__s390x__) || defined(__sparc__) || \
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
index bd5fae5..a8bcf04 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -20,7 +20,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static int  fd = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
index b784005..3fbeb9f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -27,7 +27,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define MAP_LENGTH	(4UL * hpage_size)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
index 45796de..5a90eb0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap18.c
@@ -26,7 +26,7 @@
 #include <stdlib.h>
 #include <sys/mman.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
index 13c3c7a..5f3865b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -25,7 +25,7 @@
 #include <sys/param.h>
 #include <sys/types.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT	0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
index 313efb4..9f898f0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap20.c
@@ -9,7 +9,7 @@
  * of MAP_PRIVATE and MAP_SHARED with and without MAP_LOCKED specified.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define FLAGS_DESC(x) .flags = x, .flags_str = #x
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
index 3792cff..bb8ad4e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap21.c
@@ -11,7 +11,7 @@
  * were not corrupted by the other threads.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define THREADS 5
 #define NR_HUGEPAGES 6
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
index 78e4a3b..93899df 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -12,7 +12,7 @@
  * iterations.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define NR_HUGEPAGES 2
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
index 86157d2..2960ac4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap23.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 #define RANDOM_CONSTANT 0x1234ABCD
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 0de44d5..9262e36 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
index 7d9fd0b..d010e8b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
index cd60d74..3982451 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
index f79258d..b4695f2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -12,7 +12,7 @@
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
index 48cedd1..369799c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -10,7 +10,7 @@
  * mapping. Otherwise, reserve count will be overflowed.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
index f049745..39b0329 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap29.c
@@ -12,7 +12,7 @@
  * shared mmap data.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define C1 0x1234ABCD
 #define C2 0xFEDC9876
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
index a624f4a..f2caa5f 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -14,7 +14,7 @@
  */
 
 #define _GNU_SOURCE
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define MNTPOINT "hugetlbfs/"
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
index 57367b6..652f108 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -10,7 +10,7 @@
  * seen to other mapping or not?
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define RANDOM_CONSTANT 0x1234ABCD
 #define MNTPOINT "hugetlbfs/"
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 188ee21..0d67271 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -19,7 +19,7 @@
 
 #include <stdio.h>
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
 #define GIGANTIC_MIN_ORDER 10
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index ab7469c..646735a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -20,7 +20,7 @@
 
 #define _GNU_SOURCE
 #include "lapi/mmap.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_stdio.h"
 #include <errno.h>
 #include <inttypes.h>
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 3a50e6b..9dde63c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -27,7 +27,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define CASE0 10 /* values to write into the shared */
 #define CASE1 20 /* memory location.                */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index e79d682..1245d5c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -26,7 +26,7 @@
 #include <pwd.h>
 #include <limits.h>
 #include "lapi/abisize.h"
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #ifdef TST_ABI64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 9de9257..3f71b05 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -31,7 +31,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 9f877fd..df97f04 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -19,7 +19,7 @@
  * 	test must be run at root
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index eb8663f..961e766 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -26,7 +26,7 @@
  *
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static long page_size;
 static long hpage_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index bd4437b..c932409 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -10,7 +10,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 #define N_ATTACH	4U
 #define NEWMODE		0066
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 82126f5..076ff8b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -26,7 +26,7 @@
 
 #include <pwd.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "lapi/syscalls.h"
 
 static size_t shm_size;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index ec46406..c28fdeb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -36,7 +36,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
index 8a795ac..8d6ea40 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
@@ -4,6 +4,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 0b9515f..d9e7a7a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -30,7 +30,7 @@
 
 #include <setjmp.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
index 261c5de..e34360f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
@@ -3,6 +3,8 @@
 
 top_srcdir		?= ../../../../..
 
+LTPLIBS = hugetlb
+LTPLDLIBS = -lltphugetlb
+
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 6273565..d10c972 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -13,7 +13,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index bbd968c..4efe956 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -12,7 +12,7 @@
  *	04/2004 - Updated by Robbie Williamson
  */
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 625761f..4ebeddd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -12,7 +12,7 @@
  */
 
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 3363196..c6e6a63 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -14,7 +14,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
index ca93ae6..690add2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget06.c
@@ -12,7 +12,7 @@
  * works correctly by validating the data written to segment.
  */
 
-#include "hugetlb.h"
+#include "tse_hugetlb.h"
 #include "tst_safe_sysv_ipc.h"
 
 #define NR_HUGEPAGES 4
diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
deleted file mode 100644
index 45606b1..0000000
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
index d4beb12..28a6685 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -19,6 +19,7 @@
 
 #include "tst_test.h"
 #include "numa_helper.h"
+#include "tse_numa.h"
 #include "oom.h"
 
 #ifdef HAVE_NUMA_V2
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 6b8d436..a1bf3e9 100644
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
