Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8082EC43219
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 15:49:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE133CB0F3
	for <ltp@archiver.kernel.org>; Wed, 19 Oct 2022 17:48:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42D923CB140
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:22 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D0FC1A001C9
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 17:48:20 +0200 (CEST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFl9bi016970
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CYKxP3uEue2jsK57KWZLCxO203FbSZRDSZGEWA8eOq8=;
 b=ZS7sNyiy+eP2aRk3T3DQWisUtxw6gwgi4LZzcWNjiR2ERAJBqH6AYYicWuRGTbJ78jiM
 HgkpeWLgEgSaM4cUjr6FkLjL/UxS6pCvGITR4teBmSv3DGt9QoqjNH4JUEfabBwqEO8f
 KO8qPDzgB/ZiWbUEca9k1tHdj2xXR28k3oaTXreFTrgDo61BhKItUHHOsiQIkVhQnuNZ
 gUP/DvxwMMix16B7+hDErXLSCi/3ci2s+gTEDSPJ/aucb5IihEX+WhhPuVBA0v7qRCLr
 s6FGzAqaQoqaMybRPwr+0yUum8Ml8aHJGs7KHeTybbT4ZiAdvwFXbkdrC51bk8cYa6s7 MQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kam6500pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JFaLUo019150
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06fra.de.ibm.com with ESMTP id 3k7m4jdm17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 15:48:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29JFmDSH49021412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Oct 2022 15:48:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D49011C04C;
 Wed, 19 Oct 2022 15:48:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC67711C04A;
 Wed, 19 Oct 2022 15:48:10 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.20.142])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 19 Oct 2022 15:48:10 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed, 19 Oct 2022 21:17:54 +0530
Message-Id: <20221019154754.75624-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019154754.75624-1-tsahu@linux.ibm.com>
References: <20221019154754.75624-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P0dMDJ1v674Kqjfeimrr52yeSdQ_pAWy
X-Proofpoint-GUID: P0dMDJ1v674Kqjfeimrr52yeSdQ_pAWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=843
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190087
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Hugetlb: Migrating libhugetlbfs corrupt-by-cow-opt
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
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
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
index 000000000..067556793
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Corrupt by COW optimization:
+ * Test sanity of cow optimization on page cache. If a page in page cache
+ * has only 1 ref count, it is mapped for a private mapping directly and
+ * is overwritten freely, so next time we access the page, we can see
+ * corrupt data.
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
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void run_test(void)
+{
+	char *p;
+	char c;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	*p = 's';
+	tst_res(TINFO, "Write %c to %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	*p = 'p';
+	tst_res(TINFO, "Write %c to %p via private mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	c = *p;
+	tst_res(TINFO, "Read %c from %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* Direct write from huge page */
+	if (c != 's')
+		tst_res(TFAIL, "Data got corrupted.");
+	else
+		tst_res(TPASS, "Successful");
+}
+
+static void setup(void)
+{
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
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
+	.options = (struct tst_option[]) {
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
