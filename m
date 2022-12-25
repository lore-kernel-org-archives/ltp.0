Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B14C3DA7A
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 15:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EDEF3CB8F0
	for <ltp@archiver.kernel.org>; Sun, 25 Dec 2022 16:45:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBC43CB8C9
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:22 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82FFF100035B
 for <ltp@lists.linux.it>; Sun, 25 Dec 2022 16:43:21 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BPFINPg023273; Sun, 25 Dec 2022 15:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YnzuV/wDYayxWYd2NgmvW1yqQsr7mtNgN+kGpWlEl04=;
 b=h9iN3sl/oq0JWCX+L7ww49y1HaWi/FC8F2z6Bu1nNH5ISdVAknkb857Swvk2Fc4Bt/7U
 19/ytNoCujDPc0l6v3tbC5/VOI9aVV1bmmrsXbPK7PA2s3MRlAjfES91fdeJUQZvubG0
 XGqw/nJM6fvb+sh/6ZbzwxF3md1OwB8YGHYxFCFnoHojkiO3iw/7+kEky+STPpRmpxF/
 06KtgcIp+eSL2o1z4JYMm82Wug9rQAmi41+zB/H/xb1sQrv+kSndM7nZFkRqj/J7YRg4
 okRukxaCCGaEd/Xm2zY58YrF6/IWV2GLRQrpKN7MY/jiaj0eDt/CAICm5Rq/fSxChw47 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps1ugb2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:19 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BPFhJ5D004351;
 Sun, 25 Dec 2022 15:43:19 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mps1ugb20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:19 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BP48cna002780;
 Sun, 25 Dec 2022 15:43:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mnrpfh1t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 25 Dec 2022 15:43:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BPFhDVR46530852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 25 Dec 2022 15:43:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B154820040;
 Sun, 25 Dec 2022 15:43:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B3E220049;
 Sun, 25 Dec 2022 15:43:10 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.100.54])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 25 Dec 2022 15:43:09 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 25 Dec 2022 21:12:13 +0530
Message-Id: <20221225154213.84183-14-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221225154213.84183-1-tsahu@linux.ibm.com>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uJh8qdk5HXQJ5T79_mWKS7Q8j2mQc2pG
X-Proofpoint-GUID: jQkgl1Ps2zuODAOF_t2PRDAXPpBe1NvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-25_12,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=943
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212250138
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/13] Hugetlb: Migrating libhugetlbfs
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap24.c  | 212 ++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 348a7dc5f..238ce6498 100644
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
index 000000000..7e986a471
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -0,0 +1,212 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+
+#define RANDOM_CONSTANT	0x1234ABCD
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
+static int do_readback(void *p, size_t size, const char *stage)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Stage \"%s\": Mismatch at offset 0x%lx: 0x%x instead of 0x%lx",
+			     stage, i, q[i], RANDOM_CONSTANT ^ i);
+			return -1;
+		}
+	}
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
+	.hugepages = {4, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
