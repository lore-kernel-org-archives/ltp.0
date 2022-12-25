Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA9FC3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A80333CB8CF
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:44:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A523CB8CD
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:58 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4D26100035B
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:57 +0100 (CET)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFfP5t027874; Sun, 25 Dec 2022 15:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=U87AYB1+jZm4kfnmqqbLCELiqLZJMo7qsN6EDU/hrv4=;
 b=V1/N7d7o+sof3v9q19xNu1w776rW19SKyrex0tKVCqHRFbypeu4BX9Z5ODz3/mixa1CZ
 q7OJsvyGfhlUwbbdb4hWRCz55kjvY2owC66M77iiEDz1GcI9VIL/B+9YUoSe/aVLS4Sk
 No2F2swkYW5FFCzvyxfXHarbN1oEg8yCXy0u0C+BzATUcilL+ds9FEFGSfpBsz29cQ1s
 sA8ag7zSs9p4JJDg9a3bRHw1UfBceLO35Ac3BPxFLfkPUf+DPX8ayHyg8ns0D0wqBk9F
 KeGfYRnex5FdkdepYXatSck+h8SqKRqtqzSuJsalShdrhu8wCA/Sq/f8GCrqPNk2OyUr Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscp00gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:55 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgti8002315;
 Sun, 25 Dec 2022 15:42:55 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscp00fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BOFcZXX028628;
 Sun, 25 Dec 2022 15:42:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mns2691rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgmsW24576380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D117220043;
 Sun, 25 Dec 2022 15:42:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D2A520040;
 Sun, 25 Dec 2022 15:42:45 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:45 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:07 +0530
Message-Id: <20221225154213.84183-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ODJXlXqk-aYes5_1BnmojQVYUUevGqxZ
X-Proofpoint-ORIG-GUID: -y8O41NSQuxr2iVYeQRb2havFr6KradE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/13] Hugetlb: Migrating libhugetlbfs
 noresv-reserve-resv-page
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

Migrating the libhugetlbfs/testcases/noresv-preserve-resv-page.c test

Test Description: Test to preserve a reserved page against no-reserved
mapping. If all hugepages are reserved, access to no-reserved shared
mapping cause a process die, instead of stealing a hugepage which is
reserved for other process.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap27.c  | 136 ++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 55185f2f7..d108542d2 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -27,6 +27,7 @@ hugemmap22 hugemmap22
 hugemmap23 hugemmap23
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
+hugemmap27 hugemmap27
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 4886c6a5f..9862414c6 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -26,6 +26,7 @@
 /hugetlb/hugemmap/hugemmap23
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
+/hugetlb/hugemmap/hugemmap27
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
new file mode 100644
index 000000000..243a8abf7
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap27.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Test to preserve a reserved page against no-reserved mapping. If all
+ * hugepages are reserved, access to no-reserved shared mapping cause a
+ * process die, instead of stealing a hugepage which is reserved for other
+ * process.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <setjmp.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+
+#ifndef barrier
+# ifdef mb
+	/* Redefining the memory barrier */
+#   define barrier() mb()
+# else
+#   define barrier() __asm__ __volatile__ ("" : : : "memory")
+# endif
+#endif
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int fd1 = -1, fd2 = -1;
+static sigjmp_buf sig_escape;
+static void *sig_expected = MAP_FAILED;
+
+static void sig_handler(int signum, siginfo_t *si, void *uc)
+{
+	(void)uc;
+	if (signum == SIGBUS) {
+		if (si->si_addr == sig_expected)
+			siglongjmp(sig_escape, 1);
+		tst_res(TFAIL, "SIGBUS somewhere unexpected: %p (expected: %p)",
+				si->si_addr, sig_expected);
+	} else
+		tst_res(TFAIL, "Unexpected signal %s", strsignal(signum));
+}
+
+static int test_write(void *p)
+{
+	volatile char *pl = p;
+
+	if (sigsetjmp(sig_escape, 1)) {
+		/* We got a SIGBUS */
+		return 1;
+	}
+
+	sig_expected = p;
+	barrier();
+	*pl = 's';
+	return 0;
+}
+
+static void run_test(void)
+{
+	int nr_hugepages;
+	int surp_hugepages;
+	int ret;
+	char *p, *q;
+	struct sigaction sa = {
+		.sa_sigaction = sig_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	nr_hugepages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
+
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+
+	p = SAFE_MMAP(NULL, hpage_size * nr_hugepages,
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
+
+	tst_res(TINFO, "Reserve all hugepages %d", nr_hugepages);
+
+	q = SAFE_MMAP(NULL, hpage_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd2, 0);
+
+	tst_res(TINFO, "Write to %p to steal reserved page", q);
+
+	surp_hugepages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP);
+	ret = test_write(q);
+	if (ret == 1) {
+		tst_res(TPASS, "Successful with SIGSEGV received");
+		goto cleanup;
+	}
+	/* Provisioning succeeded because of overcommit */
+	if (SAFE_READ_MEMINFO(MEMINFO_HPAGE_SURP) ==
+			surp_hugepages + 1) {
+		tst_res(TPASS, "Successful because of surplus pages");
+		goto cleanup;
+	}
+
+	tst_res(TFAIL, "Steal reserved page");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size * nr_hugepages);
+	SAFE_MUNMAP(q, hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	fd1 = tst_creat_unlinked(MNTPOINT, 0);
+	fd2 = tst_creat_unlinked(MNTPOINT, 0);
+}
+
+static void cleanup(void)
+{
+	if (fd1 >= 0)
+		SAFE_CLOSE(fd1);
+	if (fd2 >= 0)
+		SAFE_CLOSE(fd2);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
