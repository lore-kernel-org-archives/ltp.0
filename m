Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C026BC4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D843CA9CF
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:04:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 883923CAFC2
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:53 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B677C1A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:52 +0200 (CEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9CBUu010756
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6UojW8y2UeBb5jIofLAmzCDYX8hNvIg6fqPGzkAc39I=;
 b=TSXKqY8ZJA75C7iK1Za3YU9vBxZBbvofg78GiFdv+JpRJw3DO6hyyySOToh8RmaRM0Pi
 uDgp+UCyWYtMNbfXyOXQOF0uPJf9U5FJQZcIgPWSeaFKN5AM/qWywNPAXEecjeoWpwjl
 LMLGpY3idXBw0BcQiKhy36XbjBynXQYR4hBqUQGRnejwj70b8dALRkEwUQMxkkH9VSnj
 lE46UaqDkoNAKc2G7Hs48dxOELDJkLxQR2wSAr1pGLBl1FO67ZOTPlSXizutq3bgwat/
 TkhopdL6N4m8Y2wednDXpvEZ/4kG9gjgOuRBPbTD17LjXvIxASe0dBeMmEf2AHE8+Vk3 ZQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86nsvgru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCq7ZS015128
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma01fra.de.ibm.com with ESMTP id 3k7mg8s81s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxiCd2884316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B17F511C04C;
 Sun, 16 Oct 2022 12:59:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DECC711C04A;
 Sun, 16 Oct 2022 12:59:42 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:42 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:29 +0530
Message-Id: <20221016125731.249078-28-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DvXouYG3Z5KliB3LboqJFVv4WAKFBdZN
X-Proofpoint-GUID: DvXouYG3Z5KliB3LboqJFVv4WAKFBdZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=943 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 27/29] Hugetlb: Migrating libhugetlbfs readback
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

Migrating the libhugetlbfs/testcases/readback.c test

Test Description: This test is basic test for data validation written on
hugepages. It writes random data in chunks, read back and confirm they
are same.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap31.c  | 98 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 76ff1a3dd..32d22dd88 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -31,6 +31,7 @@ hugemmap27 hugemmap27
 hugemmap28 hugemmap28
 hugemmap29 hugemmap29
 hugemmap30 hugemmap30
+hugemmap31 hugemmap31
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index bb9720452..8375389cd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -30,6 +30,7 @@
 /hugetlb/hugemmap/hugemmap28
 /hugetlb/hugemmap/hugemmap29
 /hugetlb/hugemmap/hugemmap30
+/hugetlb/hugemmap/hugemmap31
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
new file mode 100644
index 000000000..8d3a62e28
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap31.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Readback
+ *
+ * Test Description: This test is basic test for data validation written on
+ * hugepages. It writes random data in chunks, read back and confirm they
+ * are same.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
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
+#define RANDOM_CONSTANT	0x1234ABCD
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long *q;
+	unsigned long i;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	q = p;
+	for (i = 0; i < (hpage_size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (hpage_size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Mismatch at offset 0x%lx: 0x%lx instead of 0x%lx",
+			     i, q[i], RANDOM_CONSTANT ^ i);
+			goto fail;
+		}
+	}
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	return;
+
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 1)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
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
+	.hugepages = {1, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
