Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22849C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:23:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068473CCDE9
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F0E23CCDDB
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:54 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A93EC10006AB
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:22:53 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304CLdVE002514; Wed, 4 Jan 2023 12:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=c8hVUOI5Zqkg8Jxn7JZtCUSDs81E1kdalo3huTZXJm4=;
 b=q8wN+xDL3g1N6QjkksIG5nhXzkrqqQrKR4lKmZEdrLzu7Bxdm4hzlyWmi7Tyr/EcqhwQ
 ///17o8KX+HVAKKUZ4D9HoVgFEL6yx7OQIvJ1Py/jQrPM4JXEAbevAeifFiTIt5DyTvB
 LhtwjxhfAq03cnK1dlqysJATbtCELWWQ4EeWq2tRUY/QSmo3QUXDwayuxJj/x7TgfA5K
 peO0tikyrRnPyxtZbnrd/PbVj75x4YLlKgkEKrZpPl1uLXhqD1dwa2tvsgLt0R7JhVbP
 kA+bqmX4DLqYUCiJ7iTBKjf+SMEXRMJajs1cjsPLeQe9MYkgaI56RESRlVHv7vAByA7x 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw9d480s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:51 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304CMpxX006170;
 Wed, 4 Jan 2023 12:22:51 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw9d480rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303GwwFL027483;
 Wed, 4 Jan 2023 12:22:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6kux6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:22:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMisp39846388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 329B020049;
 Wed,  4 Jan 2023 12:22:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AFBF20040;
 Wed,  4 Jan 2023 12:22:40 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:40 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:14 +0530
Message-Id: <20230104122224.369467-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AJjgmxG-PYa6AU3BcOEI_GZmdJ0Rug5R
X-Proofpoint-ORIG-GUID: Fpv51vl33J6vZUJCARwqV8Z6QQwws3DY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/13] Hugetlb: Migrating libhugetlbfs mmap-gettest
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
Reviewed-by: Li Wang <liwang@redhat.com>

---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap22.c  | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
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
index 000000000..567d0448c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap22.c
@@ -0,0 +1,89 @@
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
+ * created, correctly. Once created, all the pages are filled with a
+ * pattern and rechecked to test for corruption. The mapping is then
+ * released. This process is repeated for a specified number of
+ * iterations.
+ */
+
+#include "hugetlb.h"
+
+#define NR_HUGEPAGES 2
+#define MNTPOINT "hugetlbfs/"
+
+static unsigned long hpage_size;
+static int fd = -1;
+
+static void run_test(unsigned int iter)
+{
+	char *m;
+	size_t i, j;
+	char pattern = 'A';
+	size_t size = NR_HUGEPAGES*hpage_size;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	m = SAFE_MMAP(NULL, size, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, 0);
+
+	for (i = 0; i < NR_HUGEPAGES; i++) {
+		for (j = 0; j < hpage_size; j++) {
+			if (*(m+(i*hpage_size)+j) != 0) {
+				tst_res(TFAIL, "Iter %u: Verifying the mmap area failed. "
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
+				tst_res(TFAIL, "Iter %u: Verifying the mmap area failed. "
+				     "got: %c, expected: %c", iter,
+				     *(m+(i*hpage_size)+j), pattern);
+				goto cleanup;
+			}
+		}
+	}
+	tst_res(TPASS, "Iter %u: Successfully verified the mmap area.", iter);
+
+cleanup:
+	SAFE_MUNMAP(m, size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = 2,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run_test,
+	.hugepages = {NR_HUGEPAGES, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
