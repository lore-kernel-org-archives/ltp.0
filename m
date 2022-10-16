Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3567C433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E0E3CAFDE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59673CAF9E
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:28 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BBB421A00678
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:27 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9DeQu003660
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CYhWEwgkxem5jgc4MBLZXqpsTOQpACy+bQUpmVsvUpU=;
 b=FK4cWHCROuxnquZj6uUwiAhn/Sa55zTNSUQ4KciJ5fzrDT622e/7w03JAgHhP9Fs3vh1
 GH2Wh15HEWUaPeVVJBiXU994Pg/GQgqgPc+V7DT9ON1vGsfwl9CDZQDuSfu0aB3J1MMe
 IaG39BYweOTgcnvKKNsXXCrwm14G60cPrnh6Hn39jhTL4qF2DwCM9tnVGhkqKKNUoayN
 nH+bGC3EIvHluK4qcxyC2H11l94u27P6vYu7qpi1ERcfXup+37+Fhiold54TPYWfmz4B
 2AAeN8LOBMZKUT2REdt5gGTP6KMCMEsuxWj94BfT9k8LIo1wAzWyGc+NYc8BAKPWKawK HA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86vt4b4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCqEMj017289
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03fra.de.ibm.com with ESMTP id 3k7mg997a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCxrxw51315130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BF8111C050;
 Sun, 16 Oct 2022 12:59:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FE7311C04A;
 Sun, 16 Oct 2022 12:59:19 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:18 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:21 +0530
Message-Id: <20221016125731.249078-20-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mei_yi9zAU8WSVB5HxVvI4mtWov7fOQ1
X-Proofpoint-GUID: Mei_yi9zAU8WSVB5HxVvI4mtWov7fOQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 19/29] Hugetlb: Migrating libhugetlbfs mmap-gettest
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

Migrating the libhugetlbfs/testcases/mmap-gettest.c test

Test Description: This baseline test validates that a mapping of a
certain size can be created, correctly.  Once created, all the pages are
filled with a pattern and rechecked to test for corruption. The mapping is
then released.  This process is repeated for a specified number of
iterations.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 170 ++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 449fad56a..5d06c8679 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -23,6 +23,7 @@ hugemmap18 hugemmap18
 hugemmap19 hugemmap19
 hugemmap20 hugemmap20
 hugemmap21 hugemmap21 -T 2 -s 5
+hugemmap22 hugemmap22 -T 2 -s 5
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 74edfa392..0fd01dbce 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -22,6 +22,7 @@
 /hugetlb/hugemmap/hugemmap19
 /hugetlb/hugemmap/hugemmap20
 /hugetlb/hugemmap/hugemmap21
+/hugetlb/hugemmap/hugemmap22
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
new file mode 100644
index 000000000..5bc7b9389
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: mmap gettest
+ *
+ * Test Description: This baseline test validates that a mapping of a
+ * certain size can be created, correctly.  Once created, all the pages are
+ * filled with a pattern and rechecked to test for corruption. The mapping is
+ * then released.  This process is repeated for a specified number of
+ * iterations.
+ *
+ * HISTORY
+ *  Written by David Gibson & Adam Litke
+ *  Migrated from libhugetlbfs by Tarun Sahu
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+
+#include "hugetlb.h"
+
+#define BUF_SZ 256
+
+/* Setup Configuration */
+static unsigned long nr_hugepages;	/* Number of huge pages to allocate */
+static char *iterations_opt;
+static int iter;
+static char *verbose;
+static char hfile[MAXPATHLEN];
+static unsigned long hpage_size;
+static int fha = -1;
+
+static int do_one(size_t size)
+{
+	char *ma;
+	size_t i, j;
+	char pattern = 'A';
+
+	fha = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	/* Map the files with MAP_PRIVATE */
+	ma = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fha, 0);
+
+	/* Make sure the page is zeroed */
+	for (i = 0; i < nr_hugepages; i++) {
+		if (verbose)
+			tst_res(TINFO, "Verifying %p\n", (ma+(i*hpage_size)));
+		for (j = 0; j < hpage_size; j++) {
+			if (*(ma+(i*hpage_size)+j) != 0) {
+				tst_res(TFAIL, "Verifying the mmap area failed. "
+				     "Got %c, expected 0",
+				     *(ma+(i*hpage_size)+j));
+				goto fail;
+			}
+		}
+	}
+	/* Fill each file with a pattern */
+	for (i = 0; i < nr_hugepages; i++) {
+		pattern = 65+(i%26);
+		if (verbose)
+			tst_res(TINFO, "Touching %p with %c\n", ma+(i*hpage_size), pattern);
+		memset(ma+(i*hpage_size), pattern, hpage_size);
+	}
+
+	/* Verify the pattern */
+	for (i = 0; i < nr_hugepages; i++) {
+		pattern = 65+(i%26);
+		if (verbose)
+			tst_res(TINFO, "Verifying %p\n", (ma+(i*hpage_size)));
+		for (j = 0; j < hpage_size; j++) {
+			if (*(ma+(i*hpage_size)+j) != pattern) {
+				tst_res(TFAIL, "Verifying the mmap area failed. "
+				     "Got %c, expected %c",
+				     *(ma+(i*hpage_size)+j), pattern);
+				goto fail;
+			}
+		}
+	}
+
+	/* Munmap the area */
+	SAFE_MUNMAP(ma, size);
+
+	/* Close and delete the file */
+	SAFE_CLOSE(fha);
+	return 0;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+	return 0;
+}
+
+static void run_test(void)
+{
+	size_t size;
+	int i;
+
+	size = nr_hugepages * hpage_size;
+
+	for (i = 0; i < iter; i++) {
+		if (verbose)
+			tst_res(TINFO, "Iteration %d\n", i);
+		do_one(size);
+	}
+
+	tst_res(TPASS, "Successful");
+}
+
+static void setup(void)
+{
+	int nr_hpages, ret;
+
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_mmapfile%d", Hopt, getpid());
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (!(iterations_opt) || !(nr_opt))
+		tst_brk(TCONF, "Usage: -T <# iterations> -s <# pages>\n");
+
+	ret = tst_parse_int(iterations_opt, &iter, 1, INT_MAX);
+	if (ret || iter <= 0)
+		tst_brk(TCONF, "Invalid iteration argument");
+	ret = tst_parse_int(nr_opt, &nr_hpages, 1, INT_MAX);
+	if (ret || nr_hpages <= 0)
+		tst_brk(TCONF, "Invalid pages argument");
+	nr_hugepages = nr_hpages;
+}
+
+static void cleanup(void)
+{
+	if (fha >= 0)
+		SAFE_CLOSE(fha);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"v", &verbose, "Turns on verbose mode"},
+		{"T:", &iterations_opt, "Number of Iterations"},
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
