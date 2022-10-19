Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4548C4332F
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 18:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 932F83CB12A
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 20:49:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0B2E3CB13B
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 20:49:10 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6DFEE1A00937
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 20:49:08 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIclH0004122
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 18:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O4eTBZPluSIsiyvRKKC71A4bH6zWrZ7T0NCyp2GBMwI=;
 b=WW77sn5x3hLf/KKarjYD0sAmtsjhwgF5GRgyM3ATSI0Ng0PU71Z40+/mSKA+JNsPonzU
 4sNXPUdq0BfU4SsfUw1BeVAqV2WI0GxFPsRYyxJpe2Cdx6HGWosW8Ii6k9be5P2V5ZqQ
 7+bvDx5xhq/Dn4GqRqV5HwZECvAI9Vl2wX/yA//Nkeoq7/Ili8DpWBUCR6z++hSgKDEJ
 8WTUyD0+BVt3M855v+XLQJSXzq8MY25QOP3z7YcPdACN+vwSGAUGcxwKbmICeqE0VsUT
 cO6KIH2YSeU0Ba7IYY+Lb7BKP9NcZy0YPJ4ogYcHSQg9Y1rKRsccBiFlViKmSAaAsUnV Jg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kanu822e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 18:49:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JIZp5G029000
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 18:49:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg97h4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 18:49:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29JIn1vA3408558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 18:49:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66C284C040;
 Wed, 19 Oct 2022 18:49:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C46FC4C044;
 Wed, 19 Oct 2022 18:48:57 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.225])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Oct 2022 18:48:57 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Oct 2022 00:18:45 +0530
Message-Id: <20221019184846.89318-3-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019184846.89318-1-tsahu@linux.ibm.com>
References: <20221019184846.89318-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvg4mfSCQEC3K8-gieS3zHcicPv17noF
X-Proofpoint-ORIG-GUID: yvg4mfSCQEC3K8-gieS3zHcicPv17noF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210190105
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  | 166 ++++++++++++++++++
 3 files changed, 168 insertions(+)
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
index 000000000..2fbda0fcb
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -0,0 +1,166 @@
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
+static char hfile[MAXPATHLEN];
+static int fd = -1;
+static long hpage_size;
+
+static void test_chunk_overcommit(void)
+{
+	unsigned long totpages, chunk1, chunk2;
+	void *p, *q;
+	pid_t child;
+	int status;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
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
+		 fd, 0);
+
+	q = mmap(NULL, chunk2*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, chunk1*hpage_size);
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
+	SAFE_CLOSE(fd);
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
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_huetlbfile%d", Hopt, getpid());
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	SAFE_UMOUNT(Hopt);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PROC_OVERCOMMIT, NULL},
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
