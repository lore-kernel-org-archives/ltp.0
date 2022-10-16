Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DB1C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 12:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C75AC3CAFAE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 14:59:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1249C3CAFC2
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:48 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 01A171A005E9
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:46 +0200 (CEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9V5wj027067
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4slua2WazX1N+2FPZN2+qsscAZo2MZLP7A/wE7siyAM=;
 b=c20MP7tRflD/4N57Gj9h8bBYZ5MgJ0l+0bOWthqg6pHiWiw45/SGL0lgpYQ/GUCNKgXU
 mam96IRDqQn7/ubv0FH456dCHqVnpe1A8Jiu9rk7Kf18fo7jJn8rCTMQix6NYTibljHI
 L54cVRW/Jp5DhcenS0gQEc7E5VEBbQkeyYVMGEFsEa4gLuZ1PXvnpyCoV5LahfP7mJcz
 SK/DhsMA7nZy9Ai/ceFKqsjgrkuqhGg20wisy8/5kNZ/RQT1AyfMflj4k7e4ZrKZxJGC
 wXHZmg3LG/udb9sqmSJHqzastTSukqSAaDDcgXW5HnRFZfv9avtv8f13vvpkcAK+Xd2O Qg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k865v4xdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:44 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpjqr020730
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma05fra.de.ibm.com with ESMTP id 3k7mg8s7pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:42 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCxBLD45023700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B15511C052;
 Sun, 16 Oct 2022 12:58:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80E0911C04A;
 Sun, 16 Oct 2022 12:58:36 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:36 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:05 +0530
Message-Id: <20221016125731.249078-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wwRMilHmxHJ3oK-DUsTU_D3Wb06CjBUr
X-Proofpoint-ORIG-GUID: wwRMilHmxHJ3oK-DUsTU_D3Wb06CjBUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=882
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/29] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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

Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test

Test Description: Test sanity of cow optimization on page cache. If a page
in page cache has only 1 ref count, it is mapped for a private mapping
directly and is overwritten freely, so next time we access the page, we
can see corrupt data.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 664f18827..e2ada7a97 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -5,6 +5,7 @@ hugemmap05 hugemmap05
 hugemmap06 hugemmap06
 hugemmap07 hugemmap07
 hugemmap08 hugemmap08
+hugemmap09 hugemmap09
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 003ce422b..1a242ffe0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -6,6 +6,7 @@
 /hugetlb/hugemmap/hugemmap06
 /hugetlb/hugemmap/hugemmap07
 /hugetlb/hugemmap/hugemmap08
+/hugetlb/hugemmap/hugemmap09
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
new file mode 100644
index 000000000..eeacf68a2
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ *
+ * Test Name: Corrupt by COW optimization
+ *
+ * Test Description: Test sanity of cow optimization on page cache. If a page
+ * in page cache has only 1 ref count, it is mapped for a private mapping
+ * directly and is overwritten freely, so next time we access the page, we
+ * can see corrupt data.
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
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void run_test(void)
+{
+	char *p;
+	char c;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	*p = 's';
+	if (verbose)
+		tst_res(TINFO, "Write %c to %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	*p = 'p';
+	if (verbose)
+		tst_res(TINFO, "Write %c to %p via private mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	c = *p;
+	if (verbose)
+		tst_res(TINFO, "Read %c from %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* Direct write from huge page */
+	if (c != 's') {
+		tst_res(TFAIL, "Data got corrupted.");
+		goto fail;
+	}
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
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
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
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
