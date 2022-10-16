Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86717C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:00:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 104C03CAF9A
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:00:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AF0E3CAFD3
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:53 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA5241000373
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:52 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9fHQL027263
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+Zjct9biN9+MxLuOF4aNQgAhDC5wyzdb7GxYVU6ywZk=;
 b=GO97PkSmRsMDxJGSmxrt8kFGjIp3koIMSFX2Ug/eyXa/dMQp55dW6v81D6Z/9AJwcwii
 XeYmuRV+kZBw5l1A7bMPQO515nvXdSC3cxdQZy100RbXMUb+yP6PTfABS/2Gu1VZtJMQ
 VDiUr0m4K5EgMYKsVdJo9R1QhGte2PB02MVWPijQWeaj4NRwX9N+BVBg1IE+4IQicr8w
 xqTFVenY2G5Q/odYmYPA4GU+6CP7KmT77CSBFqgmmzph08TkmIQJfO8w/IuKZ1aY3wBw
 Z6G2PIWsNONM/yc8BH1UFuqYqPsLd7oE3N2qLIHq+imPSFXFvWuJxO6VXg7uCQd9/fIP RA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvk2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:50 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpfbB010060
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCwi0531523072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:58:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D00AA11C058;
 Sun, 16 Oct 2022 12:58:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4E7D11C04A;
 Sun, 16 Oct 2022 12:58:42 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:42 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:07 +0530
Message-Id: <20221016125731.249078-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ByQwVdNoazcs3yRTbcLBDwHiQUxc7NuN
X-Proofpoint-GUID: ByQwVdNoazcs3yRTbcLBDwHiQUxc7NuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=995 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/29] Hugetlb: Migrating libhugetlbfs directio
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

Migrating the libhugetlbfs/testcases/direct.c test

Test Description: This Test perform Direct Write/Read from/To hugetlbfs
file which is mapped to process address space. The test is checking if it
succeeds and data written or read is not corrupted.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap11.c  | 111 ++++++++++++++++++
 3 files changed, 113 insertions(+)
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
index 000000000..c4dbe76e6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Direct I/O
+ *
+ * Test Description: This Test perform Direct Write/Read from/To hugetlbfs file
+ * which is mapped to process address space. The test is checking if it
+ * succeeds and data written or read is not corrupted.
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
+#include <sys/types.h>
+
+#include "hugetlb.h"
+
+#define P0 "ffffffff"
+#define IOSZ 4096
+#define NHFILE "ltp_nfile"
+
+static char buf[IOSZ] __attribute__((aligned(IOSZ)));
+static int  fd = -1, nfd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void run_test(void)
+{
+	void *p;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	nfd = SAFE_OPEN(NHFILE, O_CREAT|O_EXCL|O_RDWR|O_DIRECT, 0600);
+	SAFE_UNLINK(NHFILE);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	memcpy(p, P0, 8);
+
+	/* Direct write from huge page */
+	SAFE_WRITE(1, nfd, p, IOSZ);
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	/* Check for accuracy */
+	SAFE_READ(1, nfd, buf, IOSZ);
+	if (memcmp(P0, buf, 8)) {
+		tst_res(TFAIL, "Memory mismatch after Direct-IO write");
+		goto fail;
+	}
+	SAFE_LSEEK(nfd, 0, SEEK_SET);
+
+	/* Direct read to huge page */
+	memset(p, 0, IOSZ);
+	SAFE_READ(1, nfd, p, IOSZ);
+
+	/* Check for accuracy */
+	if (memcmp(p, P0, 8)) {
+		tst_res(TFAIL, "Memory mismatch after Direct-IO read");
+		goto fail;
+	}
+	tst_res(TPASS, "Successfully tested Hugepage Direct I/O");
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(nfd);
+	return;
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
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	if (nfd >= 0)
+		SAFE_CLOSE(nfd);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
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
