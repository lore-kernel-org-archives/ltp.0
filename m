Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E90C4708D
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:43:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E88E53CB8EF
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:43:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF3203CB8DF
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:54 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EAB1C1A002D8
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:42:53 +0100 (CET)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFg7Ka015969; Sun, 25 Dec 2022 15:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VINSRA2YGub/uDpjcx0rgbKPhjB737QTOF8G/P5jYTY=;
 b=THDgCimKmZAXAcZ4AbLTKLgOymMv9XX58W1kxcb0Yh2Ixwn3XKv/LRihSvywHl4XwcXB
 JFNht99JdvQhB13O+xExH2+QpbHDN1IyeakUxyRC5WM53x0zDX17oM5vGD8n5nf6GKKx
 PwgWyG7i1wUqvSzbF+t8lz/8ffZGIhPGuy1y8BrIAF8Pphp16YY5wxhJrPb7yLC6g1tP
 5lihAGYWR/PpwAIpFpb8O2undQJpQNncB/Wq/WuVPEoBPF+9IcA19YrcTvOqfOoHLqRe
 skU/ZbmVAmrNZHGuOJeiylH2BBk5KrgMYNlpC6mX+sBrfq3f5FeL1ijnl1FCqR7R2rOt jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscqg08f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:51 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFgpHr032433;
 Sun, 25 Dec 2022 15:42:51 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mpscqg088-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP6O7RZ020578;
 Sun, 25 Dec 2022 15:42:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mns2691r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:42:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFgjHJ38404448
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:42:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E745C20043;
 Sun, 25 Dec 2022 15:42:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D62020040;
 Sun, 25 Dec 2022 15:42:41 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:42:40 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:06 +0530
Message-Id: <20221225154213.84183-7-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NfQD733j906iK1eQFKFMJmPqWwSXQHW1
X-Proofpoint-ORIG-GUID: shOWNlxzBPyYQVys9grwcefzxOdEsW9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/13] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-normal-near-huge
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

Migrating the libhugetlbfs/testcases/mremap-fixed-normal-near-huge.c test

Test Description: The kernel has bug for mremap() on some architecture.
mremap() can cause crashes on architectures with holes in the address
space (like ia64) and on powerpc with it's distinct page size "slices".

This test get the huge mapping address and mremap() normal mapping
near to this huge mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 131 ++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 65265b0fe..55185f2f7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -26,6 +26,7 @@ hugemmap21 hugemmap21
 hugemmap22 hugemmap22
 hugemmap23 hugemmap23
 hugemmap25 hugemmap25
+hugemmap26 hugemmap26
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index c865a1e55..4886c6a5f 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -25,6 +25,7 @@
 /hugetlb/hugemmap/hugemmap22
 /hugetlb/hugemmap/hugemmap23
 /hugetlb/hugemmap/hugemmap25
+/hugetlb/hugemmap/hugemmap26
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
new file mode 100644
index 000000000..03dd248bd
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 IBM Corporation.
+ * Author: David Gibson
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Description: The kernel has bug for mremap() on some architecture.
+ * mremap() can cause crashes on architectures with holes in the address
+ * space (like ia64) and on powerpc with it's distinct page size "slices".
+ *
+ * This test get the huge mapping address and mremap() normal mapping
+ * near to this huge mapping.
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
+#define RANDOM_CONSTANT	0x1234ABCD
+#define MNTPOINT "hugetlbfs/"
+
+static int  fd = -1;
+static long hpage_size, page_size;
+
+static int do_readback(void *p, size_t size, const char *stage)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
+	       (unsigned long)size, stage);
+
+	for (i = 0; i < (size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Stage \"%s\": Mismatch at offset 0x%lx: 0x%x "
+					"instead of 0x%lx", stage, i, q[i], RANDOM_CONSTANT ^ i);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int do_remap(void *target)
+{
+	void *a, *b;
+	int ret;
+
+	a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
+		  MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+
+	ret = do_readback(a, page_size, "base normal");
+	if (ret)
+		goto cleanup;
+	b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		   target);
+
+	if (b != MAP_FAILED) {
+		do_readback(b, page_size, "remapped");
+		a = b;
+	} else
+		tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
+
+cleanup:
+	SAFE_MUNMAP(a, page_size);
+	return ret;
+}
+
+static void run_test(void)
+{
+	void *p;
+	int ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	SAFE_MUNMAP(p, hpage_size);
+
+	SAFE_MUNMAP(p + 2*hpage_size, hpage_size);
+
+	p = p + hpage_size;
+
+	tst_res(TINFO, "Hugepage mapping at %p", p);
+
+	ret = do_readback(p, hpage_size, "base hugepage");
+	if (ret)
+		goto cleanup;
+	ret = do_remap(p - page_size);
+	if (ret)
+		goto cleanup;
+	ret = do_remap(p + hpage_size);
+	if (ret == 0)
+		tst_res(TPASS, "Successfully tested mremap normal near hpage mapping");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	page_size = getpagesize();
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
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
