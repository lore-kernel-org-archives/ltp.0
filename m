Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B8BC433FE
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 19:16:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62893CCCA5
	for <ltp@archiver.kernel.org>; Sun, 20 Nov 2022 20:16:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA1203CCC92
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:59 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E3B1141A43D
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 20:15:57 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AKICNah011773; Sun, 20 Nov 2022 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WMlho3FK3LL+bUXgMiqLQ1/PaPs9MlOvjzgGcinyeUA=;
 b=lQ/Q+xrGU41L1MGczUTifLyBBxuyYUFS4ldnR4jpGK9gcnJnNu09QXLUzDBfBZ6dfj9G
 hJ/1b25yw2K2leEJg84zFcfE7Uoq3TVBMSpN/3wEQJYDMuajxYaBSJb5QW0j7gzia1jJ
 y5hIU3xd/IXfvSDx0RDtlqgEho4K5DJSbdWYgILYLjH7CXkAGBtMpxTJP1hqdiFF50me
 WzNDYUnn1T2L56fLnrOEvpoF1+6zTXt2CSOh5sH48Dzk6ptnD6Ct3I7M8NJnJmoTp7zq
 WLcsAcshIEVwI8pBSLFxBjpGWNBnaYOR6rBZ/Xb2Q3DaP5vOrGM6S8U4uFYzhYSBFngN VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8qsxua7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:56 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKJ0xwo019159;
 Sun, 20 Nov 2022 19:15:56 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8qsxua0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKJ5bIj016642;
 Sun, 20 Nov 2022 19:15:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 3kxps8s6y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Nov 2022 19:15:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AKJFpxv7275120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Nov 2022 19:15:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E31F552050;
 Sun, 20 Nov 2022 19:15:50 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.36.159])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 633395204F;
 Sun, 20 Nov 2022 19:15:47 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 00:45:29 +0530
Message-Id: <20221120191533.164848-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221120191533.164848-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e9VJdyU5j5QhrWfPvr8ParmW__Bvi9jy
X-Proofpoint-GUID: jzQVj2IoAOVVlfTuXheRZjpoAmT2qOYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=967 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211200162
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/7] Hugetlb: Migrating libhugetlbfs directio
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/direct.c test

Test Description: This Test perform Direct Write/Read from/To hugetlbfs
file which is mapped to process address space. The test is checking if it
succeeds and data written or read is not corrupted.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 8a56d52a3..b9ee7227d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -7,6 +7,7 @@ hugemmap07 hugemmap07
 hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
+hugemmap11 hugemmap11
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index e7def68cb..3e64b67be 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -8,6 +8,7 @@
 /hugetlb/hugemmap/hugemmap08
 /hugetlb/hugemmap/hugemmap09
 /hugetlb/hugemmap/hugemmap10
+/hugetlb/hugemmap/hugemmap11
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
new file mode 100644
index 000000000..c39b383f2
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Description]
+ *
+ * This Test perform Direct Write/Read from/To hugetlbfs file
+ * which is mapped to process address space. The test is checking if it
+ * succeeds and data written or read is not corrupted.
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
+#define P0 "ffffffff"
+#define IOSZ 4096
+#define NORMAL_PATH ""
+#define MNTPOINT "hugetlbfs/"
+
+static long hpage_size;
+static int fd = -1, nfd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	char buf[IOSZ] __attribute__((aligned(IOSZ)));
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	nfd = tst_creat_unlinked(NORMAL_PATH, O_DIRECT);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	memcpy(p, P0, 8);
+
+	SAFE_WRITE(1, nfd, p, IOSZ);
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	SAFE_READ(1, nfd, buf, IOSZ);
+	if (memcmp(P0, buf, 8)) {
+		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
+		goto cleanup;
+	}
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	memset(p, 0, IOSZ);
+	SAFE_READ(1, nfd, p, IOSZ);
+
+	if (memcmp(p, P0, 8))
+		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
+	else
+		tst_res(TPASS, "Direct-IO read/write to/from hugepages is successful");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(nfd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (nfd > 0)
+		SAFE_CLOSE(nfd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
