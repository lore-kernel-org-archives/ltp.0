Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF9BC4332F
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2BA03CAEBE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:07:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BCC03CB395
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:07 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C53D200AE6
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 07:27:44 +0100 (CET)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A460cuZ008588;
 Fri, 4 Nov 2022 06:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A0PPvpFdjWhtPEIVtwQ8Zig/DPRk3QuyFEkFOHhJQ50=;
 b=TGAx0rEKj42yBpl1TYooxEXHT9Qz5nCICmpno4ppdA082KAaR843MtLTQ0kShm+JwR84
 IOuf7qEyM8yihX6z3CRa1E882LBrXyOu8xqB8sway+jlEKb1/AXmSKnCh/6tEPlv10Rk
 DKJRE4qMcd62RDasT26aigECFpFkVB6jx+0wna1I1Lvj932EOzOsMSCueQkqH701xsfx
 xGXEWWqkZoPV9eDIAThzIt99VFKv7NxcFq6dtPr9Q58K2/fv+jVUuhd9FgYe1SIRjcuM
 SfS4jENpM38cv0+YdUbm+HX/3UaQyW6SN7Us/zWrFgiZVZ19haSY2c6mPjDdiYMhtKxW oA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmq07jng2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A46EBOt001908;
 Fri, 4 Nov 2022 06:27:42 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmq07jnfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A46MMe7011149;
 Fri, 4 Nov 2022 06:27:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma01fra.de.ibm.com with ESMTP id 3kgut9fda0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 06:27:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2A46SDMo41943514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 06:28:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E36E44C04A;
 Fri,  4 Nov 2022 06:27:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48DD94C044;
 Fri,  4 Nov 2022 06:27:33 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.126.70])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 06:27:33 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 11:57:15 +0530
Message-Id: <20221104062716.615021-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104062716.615021-1-tsahu@linux.ibm.com>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ym8QibcziWnpE4NZ8pfReOQ6xPKck5PH
X-Proofpoint-ORIG-GUID: vHT0YLHAhesgOpdEwf3rL_Lwk_jTHoYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040041
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/chunk-overcommit.c test

Test Description: Some kernel versions after hugepage demand allocation was
added used a dubious heuristic to check if there was enough hugepage space
available for a given mapping.  The number of not-already-instantiated
pages in the mapping was compared against the total hugepage free pool. It
was very easy to confuse this heuristic into overcommitting by allocating
hugepage memory in chunks, each less than the total available pool size but
together more than available.  This would generally lead to OOM SIGKILLs of
one process or another when it tried to instantiate pages beyond the
available pool.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 146 ++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f7ff81cb3..664f18827 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -4,6 +4,7 @@ hugemmap04 hugemmap04
 hugemmap05 hugemmap05
 hugemmap06 hugemmap06
 hugemmap07 hugemmap07
+hugemmap08 hugemmap08
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index df5256ec8..003ce422b 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -5,6 +5,7 @@
 /hugetlb/hugemmap/hugemmap05
 /hugetlb/hugemmap/hugemmap06
 /hugetlb/hugemmap/hugemmap07
+/hugetlb/hugemmap/hugemmap08
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
new file mode 100644
index 000000000..3efabc4aa
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * Some kernel versions after hugepage demand allocation was added used a
+ * dubious heuristic to check if there was enough hugepage space available
+ * for a given mapping.  The number of not-already-instantiated pages in
+ * the mapping was compared against the total hugepage free pool. It was
+ * very easy to confuse this heuristic into overcommitting by allocating
+ * hugepage memory in chunks, each less than the total available pool size
+ * but together more than available.  This would generally lead to OOM
+ * SIGKILLs of one process or another when it tried to instantiate pages
+ * beyond the available pool.
+ *
+ * HISTORY
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+#define WITH_OVERCOMMIT 0
+#define WITHOUT_OVERCOMMIT 1
+
+static long hpage_size;
+static int huge_fd = -1;
+
+static void test_chunk_overcommit(void)
+{
+	unsigned long totpages, chunk1, chunk2;
+	void *p, *q;
+	pid_t child;
+	int status;
+
+	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+
+	chunk1 = (totpages / 2) + 1;
+	chunk2 = totpages - chunk1 + 1;
+
+	tst_res(TINFO, "Free: %ld hugepages available: "
+	       "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
+
+	p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 huge_fd, 0);
+
+	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 huge_fd, chunk1*hpage_size);
+	if (q == MAP_FAILED) {
+		if (errno != ENOMEM) {
+			tst_res(TFAIL | TERRNO, "mmap() chunk2");
+			goto cleanup1;
+		} else {
+			tst_res(TPASS, "Successful without overcommit pages");
+			goto cleanup1;
+		}
+	}
+
+	tst_res(TINFO, "Looks like we've overcommitted, testing...");
+	/* Looks like we're overcommited, but we need to confirm that
+	 * this is bad.  We touch it all in a child process because an
+	 * overcommit will generally lead to a SIGKILL which we can't
+	 * handle, of course.
+	 */
+	child = SAFE_FORK();
+
+	if (child == 0) {
+		memset(p, 0, chunk1*hpage_size);
+		memset(q, 0, chunk2*hpage_size);
+		exit(0);
+	}
+
+	SAFE_WAITPID(child, &status, 0);
+
+	if (WIFSIGNALED(status)) {
+		tst_res(TFAIL, "Killed by signal '%s' due to overcommit",
+		     tst_strsig(WTERMSIG(status)));
+		goto cleanup2;
+	}
+
+	tst_res(TPASS, "Successful with overcommit pages");
+
+cleanup2:
+	SAFE_MUNMAP(q, chunk2*hpage_size);
+
+cleanup1:
+	SAFE_MUNMAP(p, chunk1*hpage_size);
+	SAFE_FTRUNCATE(huge_fd, 0);
+}
+
+static void run_test(unsigned int test_type)
+{
+	switch (test_type) {
+	case WITHOUT_OVERCOMMIT:
+		tst_res(TINFO, "Without overcommit testing...");
+		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 0);
+		break;
+	case WITH_OVERCOMMIT:
+		tst_res(TINFO, "With overcommit testing...");
+		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 2);
+		break;
+	}
+	test_chunk_overcommit();
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	huge_fd = tst_creat_unlinked(MNTPOINT);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(huge_fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_OC_HPAGES, NULL},
+		{}
+	},
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
+
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
