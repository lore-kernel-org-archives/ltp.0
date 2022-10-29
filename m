Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EE2C433FE
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 07:14:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BFD83CA8B0
	for <ltp@archiver.kernel.org>; Sat, 29 Oct 2022 09:14:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 805DA3C93F2
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:10 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5DB2B1000A72
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 09:14:08 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29T4dsTv025330
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ylFDIAYmygIBLmxAyyH82uYxy31sYyX4BjIJSUbn1Ug=;
 b=gUI6DchJtOzC4NFtUAjJhFM0LfmIcAXU8/XNq+EYsLP47daN5vrm5F3yHs17UpK4kPhp
 F6EwEcVRDeEux3aoCZofJtFm10Z9cKrY6nF++qnakjJjxK4wuyCGrIj6aPWvrseTe3wP
 l5MueHm3ytjZxpiav55rOnEI/KG2gP8w+8XFnN+/D6yHaFFdaJORRYoBI1w2w3g0G+7z
 HifZmm4v0qIXaIn/MJbDJclSEhVZfmCaR29hVKSu2Wx8pQ0CsuxIjZJmH0vgUyFFNNff
 5m0Q/3yF8h8xw0fgRAa8Wj6BNNOHaO9x7+t5CVWAp3I3eM8d4N2fh4njRc/8uDxYSk3m iw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgw6jtsjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29T6bSov030477
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03ams.nl.ibm.com with ESMTP id 3kgut8r7fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sat, 29 Oct 2022 07:14:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29T78eMj47907298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Oct 2022 07:08:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B5A911C04A;
 Sat, 29 Oct 2022 07:14:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B061611C052;
 Sat, 29 Oct 2022 07:13:58 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.56])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 29 Oct 2022 07:13:58 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sat, 29 Oct 2022 12:43:43 +0530
Message-Id: <20221029071344.45447-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221029071344.45447-1-tsahu@linux.ibm.com>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PRq7M38Eq6VHXXNAjr0FTBr3niJFHC78
X-Proofpoint-ORIG-GUID: PRq7M38Eq6VHXXNAjr0FTBr3niJFHC78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-29_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210290030
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com, sbhat@linux.ibm.com,
 vaibhav@linux.ibm.com
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
index 000000000..61db030d5
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
+ * Chunk Overcommit:
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
+#define PROC_OVERCOMMIT "/proc/sys/vm/nr_overcommit_hugepages"
+#define WITH_OVERCOMMIT 0
+#define WITHOUT_OVERCOMMIT 1
+
+static long hpage_size;
+
+static void test_chunk_overcommit(void)
+{
+	unsigned long totpages, chunk1, chunk2;
+	void *p, *q;
+	pid_t child;
+	int status;
+
+	totpages = SAFE_READ_MEMINFO("HugePages_Free:");
+
+	chunk1 = (totpages / 2) + 1;
+	chunk2 = totpages - chunk1 + 1;
+
+	tst_res(TINFO, "Free: %ld hugepages available: "
+	       "chunk1=%ld chunk2=%ld", totpages, chunk1, chunk2);
+
+	p = SAFE_MMAP(NULL, chunk1*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 tst_hugetlb_fd, 0);
+
+	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 tst_hugetlb_fd, chunk1*hpage_size);
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
+	SAFE_FTRUNCATE(tst_hugetlb_fd, 0);
+}
+
+static void run_test(unsigned int test_type)
+{
+	unsigned long saved_oc_hugepages;
+
+	SAFE_FILE_SCANF(PROC_OVERCOMMIT, "%ld", &saved_oc_hugepages);
+	switch (test_type) {
+	case WITHOUT_OVERCOMMIT:
+		tst_res(TINFO, "Without overcommit testing...");
+		if (saved_oc_hugepages > 0)
+			SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 0);
+		break;
+	case WITH_OVERCOMMIT:
+		tst_res(TINFO, "With overcommit testing...");
+		if (saved_oc_hugepages == 0)
+			SAFE_FILE_PRINTF(PROC_OVERCOMMIT, "%d", 2);
+		break;
+	}
+	test_chunk_overcommit();
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_hugetlbfs = 1,
+	.needs_unlinked_hugetlb_file = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PROC_OVERCOMMIT, NULL},
+		{}
+	},
+	.tcnt = 2,
+	.setup = setup,
+	.test = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
+
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
