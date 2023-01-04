Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8529C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59A023CE095
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:25:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 134A83CCDF7
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:35 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55A5D600721
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:33 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BU8I9024896; Wed, 4 Jan 2023 12:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j9osn4KBJ72EuffxWM5ug5xMDbJrsP0YiJm9f08tRQ4=;
 b=KwAiLaAD5wzrryjrVhssjV7tvJaLef1HtHiRsy2rACHjOpX6+hwHrOD/SksnKuXm8KHs
 fxGDZM4o/DTpiGIjlDmrsGLdI3UEvsxR4yrbJzubVwAtfQ8iziRdopSFdS9z/Po5ocEa
 ejIJxlwHaxhDEKmSJC6B7eg65uGchky6JYCdT/ciAxiyvWACZ40Zy2PWKJiXmICaPHlH
 KIasnE9j8pG39t3gZ3TGpODLPmumUh4Cz3myzzQa/UNTekaKHYoouCjYPZIaBP/BSCUs
 6cXFuqiyMBTuAHlmHe3T/ZnDpxLBLWHi1yE8bjaDUDRNOCzjHC07d53IguElpKLn4gbz 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8mp93u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:32 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304BeaaA001024;
 Wed, 4 Jan 2023 12:23:32 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8mp93tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30466OP7032663;
 Wed, 4 Jan 2023 12:23:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6kuy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CNPBp24314224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32E3220043;
 Wed,  4 Jan 2023 12:23:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A247320040;
 Wed,  4 Jan 2023 12:23:21 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:23:21 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:24 +0530
Message-Id: <20230104122224.369467-14-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0_CxdbFuD0v5vyzmQNpWlFZe6WHhxXzi
X-Proofpoint-GUID: l2QGl3FAsFlUrBxPzExyiZXd7t9y9-kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=794 mlxscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040102
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/13] Hugetlb: Migrating libhugetlbfs
 mremap-expand-slice-collision
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

Kernel has bug in mremap for some architecture. mremap() can cause
crashes on architectures with holes in the address space (like ia64)
and on powerpc with it's distict page size slices.

This test perform mremap() with normal and hugepages around powerpc
slice boundary.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  | 186 ++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6d63fec5d..feb5dec32 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -26,6 +26,7 @@ hugemmap20 hugemmap20
 hugemmap21 hugemmap21
 hugemmap22 hugemmap22
 hugemmap23 hugemmap23
+hugemmap23 hugemmap24
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 0c1311303..06e125d03 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -25,6 +25,7 @@
 /hugetlb/hugemmap/hugemmap21
 /hugetlb/hugemmap/hugemmap22
 /hugetlb/hugemmap/hugemmap23
+/hugetlb/hugemmap/hugemmap24
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
new file mode 100644
index 000000000..3316f04c2
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 IBM Corporation.
+ * Author: David Gibson
+ */
+
+/*\
+ * [Description]
+ *
+ * Kernel has bug in mremap for some architecture. mremap() can cause
+ * crashes on architectures with holes in the address space (like ia64)
+ * and on powerpc with it's distict page size slices.
+ *
+ * This test perform mremap() with normal and hugepages around powerpc
+ * slice boundary.
+ */
+
+#define _GNU_SOURCE
+#include "hugetlb.h"
+
+#define RANDOM_CONSTANT 0x1234ABCD
+#define MNTPOINT "hugetlbfs/"
+
+static int  fd = -1;
+static unsigned long slice_boundary;
+static long hpage_size, page_size;
+
+static int init_slice_boundary(int fd)
+{
+	unsigned long slice_size;
+	void *p, *heap;
+	int i;
+#if defined(__LP64__) && !defined(__aarch64__)
+	/* powerpc: 1TB slices starting at 1 TB */
+	slice_boundary = 0x10000000000;
+	slice_size = 0x10000000000;
+#else
+	/* powerpc: 256MB slices up to 4GB */
+	slice_boundary = 0x00000000;
+	slice_size = 0x10000000;
+#endif
+
+	/* dummy malloc so we know where is heap */
+	heap = malloc(1);
+	free(heap);
+
+	/* Find 2 neighbour slices with couple huge pages free
+	 * around slice boundary.
+	 * 16 is the maximum number of slices (low/high)
+	 */
+	for (i = 0; i < 16-1; i++) {
+		slice_boundary += slice_size;
+		p = mmap((void *)(slice_boundary-2*hpage_size), 4*hpage_size,
+			PROT_READ, MAP_SHARED | MAP_FIXED, fd, 0);
+		if (p == MAP_FAILED) {
+			tst_res(TINFO|TERRNO, "can't use slice_boundary: 0x%lx",
+					slice_boundary);
+		} else {
+			SAFE_MUNMAP(p, 4*hpage_size);
+			break;
+		}
+	}
+
+	if (p == MAP_FAILED) {
+		tst_res(TFAIL|TERRNO, "couldn't find 2 free neighbour slices");
+		return -1;
+	}
+	tst_res(TINFO, "using slice_boundary: 0x%lx", slice_boundary);
+	return 0;
+}
+
+static void run_test(void)
+{
+	void *p = NULL, *q = NULL, *r;
+	long p_size, q_size;
+	int ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	ret = init_slice_boundary(fd);
+	if (ret)
+		goto cleanup;
+
+	/* First, hugepages above, normal below */
+	tst_res(TINFO, "Testing with hpage above & normal below the slice_boundary");
+	p_size = hpage_size;
+	p = SAFE_MMAP((void *)(slice_boundary + hpage_size), p_size,
+		 PROT_READ | PROT_WRITE,
+		 MAP_SHARED | MAP_FIXED, fd, 0);
+
+	ret = do_readback(p, p_size, "huge above");
+	if (ret)
+		goto cleanup;
+
+	q_size = page_size;
+	q = SAFE_MMAP((void *)(slice_boundary - page_size), q_size,
+		 PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+
+	ret = do_readback(q, q_size, "normal below");
+	if (ret)
+		goto cleanup;
+
+	r = mremap(q, page_size, 2*page_size, 0);
+	if (r == MAP_FAILED) {
+		tst_res(TINFO, "mremap(%p, %lu, %lu, 0) disallowed",
+				q, page_size, 2*page_size);
+	} else {
+		q_size = 2*page_size;
+		if (r != q) {
+			tst_res(TFAIL, "mremap() moved without MREMAP_MAYMOVE!?");
+			ret = -1;
+		} else
+			ret = do_readback(q, 2*page_size, "normal below expanded");
+	}
+
+	SAFE_MUNMAP(p, p_size);
+	SAFE_MUNMAP(q, q_size);
+	if (ret)
+		goto cleanup_fd;
+
+	/* Next, normal pages above, huge below */
+	tst_res(TINFO, "Testing with normal above & hpage below the slice_boundary");
+	p_size = page_size;
+	p = SAFE_MMAP((void *)(slice_boundary + hpage_size), p_size,
+		 PROT_READ|PROT_WRITE,
+		 MAP_SHARED | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
+
+	ret = do_readback(p, p_size, "normal above");
+	if (ret)
+		goto cleanup;
+
+	q_size = hpage_size;
+	q = SAFE_MMAP((void *)(slice_boundary - hpage_size),
+		 q_size, PROT_READ | PROT_WRITE,
+		 MAP_SHARED | MAP_FIXED, fd, 0);
+
+	ret = do_readback(q, q_size, "huge below");
+	if (ret)
+		goto cleanup;
+
+	r = mremap(q, hpage_size, 2*hpage_size, 0);
+	if (r == MAP_FAILED) {
+		tst_res(TINFO, "mremap(%p, %lu, %lu, 0) disallowed",
+				q, hpage_size, 2*hpage_size);
+	} else {
+		q_size = 2*hpage_size;
+		if (r != q) {
+			tst_res(TFAIL, "mremap() moved without MREMAP_MAYMOVE!?");
+			ret = -1;
+		} else
+			ret = do_readback(q, 2*hpage_size, "huge below expanded");
+	}
+	if (ret)
+		goto cleanup;
+	tst_res(TPASS, "Successful");
+cleanup:
+	if (p)
+		SAFE_MUNMAP(p, p_size);
+	if (q)
+		SAFE_MUNMAP(q, q_size);
+cleanup_fd:
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
+	.hugepages = {4, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
