Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51505C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 814E63CB8DB
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2B193CB8B5
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:40 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 32FBC6000E6
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:39 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFgQql009506; Sun, 25 Dec 2022 15:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O5+5PIS36cF3lk2YGeS36itLuPhs64lojeg5+8S57i0=;
 b=na0eP4TEZ277wMqYno5vJRTBojhIVEF0s0/FoWLEifwxo3IIgVPpY0nr5bpFFm039n/r
 d2JAgW1GUpZy8/Q+zZMRn7Uqiy6I2GeXOJNXDWA5Bs+XVfB9w1XULvBAnxIy1wMAgO94
 oepwDTxIzvdwXrAxQGMSFkaJP5U0hUeDsoxT0tFH/JBeySqYRPqrh0opL10gFeIRT4dD
 /ArJ0mHhEy1W8l2iEHEUkHxamertXLDCjufT3wdcf55vlciqgcQEcUtBNbQ6jP08uylk
 O5psq/iDcazIf8a1Gg+Jy870+s111ZIbx0kjBFPdKXlrdcabgbCuNQlgkpgZNdM1WkZx GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpsd30042-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:38 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgb1h010176;
 Sun, 25 Dec 2022 15:42:37 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpsd3003j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP2BatN004783;
 Sun, 25 Dec 2022 15:42:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mns26hdvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgWgU23724362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E30020043;
 Sun, 25 Dec 2022 15:42:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D291E20040;
 Sun, 25 Dec 2022 15:42:28 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:28 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:03 +0530
Message-Id: <20221225154213.84183-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ynsgvvo7mORCbUBQlJOMoU8Qdm6m5YCM
X-Proofpoint-GUID: 2Mb6DtqIsYIYEhyl0XoFqb-B30t4A2MT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/13] Hugetlb: Migrating libhugetlbfs mmap-gettest
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 104 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 71b4d57e4..8e80db140 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -23,6 +23,7 @@ hugemmap18 hugemmap18
 hugemmap19 hugemmap19
 hugemmap20 hugemmap20
 hugemmap21 hugemmap21
+hugemmap22 hugemmap22
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
index 000000000..50addbe62
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This baseline test validates that a mapping of a certain size can be
+ * created, correctly.  Once created, all the pages are filled with a
+ * pattern and rechecked to test for corruption. The mapping is then
+ * released. This process is repeated for a specified number of
+ * iterations.
+ */
+
+#include <stdio.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <unistd.h>
+
+#include "hugetlb.h"
+
+#define ITERATIONS 10
+#define NR_HUGEPAGES 2
+#define MNTPOINT "hugetlbfs/"
+
+static unsigned long hpage_size;
+static int fd = -1;
+
+static void test_per_iteration(size_t size, int iter)
+{
+	char *m;
+	size_t i, j;
+	char pattern = 'A';
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	m = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, 0);
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		for (j = 0; j < hpage_size; j++) {
+			if (*(m+(i*hpage_size)+j) != 0) {
+				tst_res(TFAIL, "Iter %d: Verifying the mmap area failed. "
+				     "Got %c, expected 0", iter,
+				     *(m+(i*hpage_size)+j));
+				goto cleanup;
+			}
+		}
+	}
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65+(i%26);
+		memset(m+(i*hpage_size), pattern, hpage_size);
+	}
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		pattern = 65+(i%26);
+		for (j = 0; j < hpage_size; j++) {
+			if (*(m+(i*hpage_size)+j) != pattern) {
+				tst_res(TFAIL, "Verifying the mmap area failed. "
+				     "got: %c, expected: %c",
+				     *(m+(i*hpage_size)+j), pattern);
+				goto cleanup;
+			}
+		}
+	}
+
+cleanup:
+	SAFE_MUNMAP(m, size);
+	SAFE_CLOSE(fd);
+}
+
+static void run_test(void)
+{
+	size_t size;
+	int i;
+
+	size = NR_HUGEPAGES * hpage_size;
+	for (i = 0; i < ITERATIONS; i++)
+		test_per_iteration(size, i);
+
+	tst_res(TPASS, "Successfully verified the mmap area.");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
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
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
