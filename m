Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8075AC433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 16:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 857B23CB03E
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 17:26:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211A53CB001
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 17:25:48 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 528181000760
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 17:25:47 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Eqard023752;
 Fri, 4 Nov 2022 16:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fX6WAmSWRM3V2ZBDe7PVQXulGuQi5+1MCzqB7xZniXA=;
 b=Ix1tK2dM8Tnuz2WCoTLqaIAH2qYi+B/A8AZkIiuLYWPU7nEB0BLzimHhrBnu1Vw0EoVJ
 lnT7/pRkgYedGCLRZfvnWCL75aqnmWpFakwNxQvAHFU22sindajufGdd1//pP5r5b3eJ
 DPRjASXiXbjKLyGZpLRjUYob8iuN7Y4Pt4i81MnalrPwsEoiie9P311R5OzKXPEdzofU
 ecegPI2jgeYoYed3CsgckzD1QC5kOShSothTn8K6rNv26gNUEyhidk7xyrQtkqb5mNcG
 dhSajsCm5fkGVdFiwsYM4/Nqfg/zdo7XlQ8jYDWX2bmjowlb1JpKxcOlRsqJgAP6J+mp Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpjfnj4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:46 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4CqIP3006595;
 Fri, 4 Nov 2022 16:25:46 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpjfnj38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4G5udE019261;
 Fri, 4 Nov 2022 16:25:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 3kgut92p12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A4GPfV61835688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 16:25:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A6594C046;
 Fri,  4 Nov 2022 16:25:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A4144C040;
 Fri,  4 Nov 2022 16:25:37 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.23.48])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 16:25:36 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 21:55:10 +0530
Message-Id: <20221104162511.28658-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104162511.28658-1-tsahu@linux.ibm.com>
References: <20221104162511.28658-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UGLWbZLB4hbSQauXztM6-unq0Y5DKqgn
X-Proofpoint-ORIG-GUID: -abvQpGpnUyP2rXIngt-_x6_xrJvcZwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040104
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/4] Hugetlb: Migrating libhugetlbfs
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 144 ++++++++++++++++++
 3 files changed, 146 insertions(+)
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
index 000000000..ce40e7b69
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -0,0 +1,144 @@
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
