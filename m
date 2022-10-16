Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE3C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A08603CAFAB
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FA633CAFAE
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:45 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73C661A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:43 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9MOnD026893
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K8esUIq5e3ZbkHNgAs9TV214S970Uu6G1SSXvbi+vv0=;
 b=pQz1saH1lIZZYvsJXFlGS88avwYjDyWfi/tmRTHvBMiEZYVxCCLcI2ZRKmC46g8VOyga
 tnGKbAsG1FIWcdqOlqPRtFGNtil894lfMgqmuSBSrh/ktn8VtARwiO35odM7HjcaR01p
 X1rsO3k+tyPl8GDNbfuUMwBtgNXfiheVjsp1SuxKJSFRSSUGBhIvoy5l84HLVUV2oP70
 AZj64p3LL9uRk7g5upQ1MtSJdo/ELdGRNxDz5TBi+M97FqOKIygn432cLSVSt79OMiyC
 HF4EyM/GPBSqAoRnIkrq6l3+4MuE3t6HjRFJJLUvpdAoQKv8J6ILYM8B1tOVVvkqzFFn nQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k865v4xv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:42 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpgKK008585
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg917rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:39 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCsgie49873382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:54:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A365311C04C;
 Sun, 16 Oct 2022 12:59:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DC7E11C04A;
 Sun, 16 Oct 2022 12:59:34 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:33 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:26 +0530
Message-Id: <20221016125731.249078-25-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dND5SrmJLDGC3lgxEl56-bTuY0i5c52V
X-Proofpoint-ORIG-GUID: dND5SrmJLDGC3lgxEl56-bTuY0i5c52V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 24/29] Hugetlb: Migrating libhugetlbfs
 noresv-regarded-as-resv
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

Migrating the libhugetlbfs/testcases/noresv-regarded-as-resv.c test

Test Description: Test to correct handling for reserve count. If no
reserved mapping is created to reserved file region, it should be
considered as reserve mapping. Otherwise, reserve count will be
overflowed.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index c1c2c38bf..f9a9501b7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -28,6 +28,7 @@ hugemmap23 hugemmap23
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
+hugemmap28 hugemmap28
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 9862414c6..2f8ed0df0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -27,6 +27,7 @@
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
+/hugetlb/hugemmap/hugemmap28
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
new file mode 100644
index 000000000..55399c3b6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ *
+ * Test Name: noresv-regarded-as-resv
+ *
+ * Test Description: Test to correct handling for reserve count. If no
+ * reserved mapping is created to reserved file region, it should be
+ * considered as reserve mapping. Otherwise, reserve count will be
+ * overflowed.
+ *
+ * HISTORY
+ *  Written by Joonsoo Kim
+ *
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
+#include "hugetlb.h"
+
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	int nr_resvpages1, nr_resvpages2;
+	int fd;
+	char *p, *q;
+
+	nr_resvpages1 = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Number of reserve page is %d\n", nr_resvpages1);
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Reserve a page to file offset 0");
+
+	q = SAFE_MMAP(NULL, hpage_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Map a page of file offset 0 with no resv mapping");
+	*q = 's';
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd);
+
+	nr_resvpages2 = SAFE_READ_MEMINFO("HugePages_Rsvd:");
+	if (verbose)
+		tst_res(TINFO, "Number of reserve page is now %d\n", nr_resvpages2);
+
+	if (nr_resvpages1 != nr_resvpages2) {
+		tst_res(TFAIL, "Reserve count overflowed");
+		tst_brk(TBROK, "Once failed, No point in continuing the test");
+	}
+
+	tst_res(TPASS, "Successful");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlb1file%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
