Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC187C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:03:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52B423CAF9D
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F20B3CAFB3
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:35 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A6F531A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:34 +0200 (CEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9aPoq003556
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oLDftU4WfgOmjt9SrurYcATvkukIIYUp/IFbLwNYrh0=;
 b=ZOwiII8vjw2BH5n1LNUfQwitOHf7GR8wWNgDzaYQaeMNaJyEMHji2pL6boXihGNKCYTT
 SFFNTRzf3gVGbiqfuLTrC298chCjblsMdpFB8HJY+tQhC/+Hr9/pbQDCERdy53sINWfb
 9FbpResECESTEQbKN8jP+iuiS7PCLMSyvzkDBsDl94uH0h2hsE5t46zURyzWvzIHCzuE
 oDUpkvYj2gqx6SdmQnNwUFoqqS76gJchs6l7z5O0FGdPASzmdumGRp4B5LNUSkh0NYAY
 xbOm66Q3NwmGnhF3v6hBhPYSfZ3uJ1s9+Ep70uYtU3pE8lVBtMIZ/Wqiu7rtT7LfAqeC 8A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86vt4b6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:32 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCqFTK017296
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:31 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma03fra.de.ibm.com with ESMTP id 3k7mg997ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxRgv55771592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:27 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A49B411C04C;
 Sun, 16 Oct 2022 12:59:27 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 958CF11C04A;
 Sun, 16 Oct 2022 12:59:24 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:24 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:23 +0530
Message-Id: <20221016125731.249078-22-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q3RXxFZYoLA8-AbcQl-2bIGLF6dT8sm_
X-Proofpoint-GUID: Q3RXxFZYoLA8-AbcQl-2bIGLF6dT8sm_
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
Subject: [LTP] [PATCH 21/29] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-huge-near-normal
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

Migrating the libhugetlbfs/testcases/mremap-fixed-huge-near-normal.c test

Test Description: The kernel has bug for mremap() on some architecture.
mremap() can cause crashes on architectures with holes in the address
space (like ia64) and on powerpc with it's distinct page size "slices".

This test get the normal mapping address and mremap() hugepage mapping
near to this normal mapping.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap25.c  | 168 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 2e8d58857..3ae1065c7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -25,6 +25,7 @@ hugemmap20 hugemmap20
 hugemmap21 hugemmap21 -T 2 -s 5
 hugemmap22 hugemmap22 -T 2 -s 5
 hugemmap23 hugemmap23
+hugemmap25 hugemmap25
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ffd831f2e..c865a1e55 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -24,6 +24,7 @@
 /hugetlb/hugemmap/hugemmap21
 /hugetlb/hugemmap/hugemmap22
 /hugetlb/hugemmap/hugemmap23
+/hugetlb/hugemmap/hugemmap25
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
new file mode 100644
index 000000000..59d07734a
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap25.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 David Gibson, IBM Corporation.
+ *
+ * Test Name: mremap fixed huge near normal
+ *
+ * Test Description: The kernel has bug for mremap() on some architecture.
+ * mremap() can cause crashes on architectures with holes in the address
+ * space (like ia64) and on powerpc with it's distinct page size "slices".
+ *
+ * This test get the normal mapping address and mremap() hugepage mapping
+ * near to this normal mapping.
+ *
+ * HISTORY
+ *  Written by David Gibson
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
+#define RANDOM_CONSTANT	0x1234ABCD
+#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
+#define PALIGN(p, a) ((void *)ALIGN((unsigned long)(p), (a)))
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size;
+
+static void do_readback(void *p, size_t size, const char *stage)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	if (verbose)
+		tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")\n", __func__, p,
+		       (unsigned long)size, stage);
+
+	for (i = 0; i < (size / sizeof(*q)); i++)
+		q[i] = RANDOM_CONSTANT ^ i;
+
+	for (i = 0; i < (size / sizeof(*q)); i++) {
+		if (q[i] != (RANDOM_CONSTANT ^ i)) {
+			tst_res(TFAIL, "Stage \"%s\": Mismatch at offset 0x%lx: 0x%x "
+					"instead of 0x%lx", stage, i, q[i], RANDOM_CONSTANT ^ i);
+			tst_brk(TBROK, "Once failed, No point in continue further");
+		}
+	}
+}
+
+static void do_remap(int fd, void *target)
+{
+	void *a, *b;
+
+	a = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Huge base mapping at %p\n", a);
+
+	do_readback(a, hpage_size, "base huge");
+
+	if (verbose)
+		tst_res(TINFO, "Attempting mremap(MAYMOVE|FIXED) to %p...", target);
+
+	b = mremap(a, hpage_size, hpage_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		   target);
+
+	if (b != MAP_FAILED) {
+		do_readback(b, hpage_size, "remapped");
+
+	} else {
+		if (verbose)
+			tst_res(TINFO|TERRNO, "disallowed");
+		b = a;
+	}
+	SAFE_MUNMAP(b, hpage_size);
+}
+
+static void *map_align(size_t size, size_t align)
+{
+	unsigned long xsize = size + align - getpagesize();
+	size_t t;
+	void *p, *q;
+
+	p = SAFE_MMAP(NULL, xsize, PROT_READ|PROT_WRITE,
+		 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	q = PALIGN(p, align);
+
+	t = q - p;
+	if (t)
+		SAFE_MUNMAP(p, t);
+
+	t = p + xsize - (q + size);
+	if (t)
+		SAFE_MUNMAP(q + size, t);
+
+	return q;
+}
+
+static void run_test(void)
+{
+	void *p;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	p = map_align(3*hpage_size, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(p + 2*hpage_size, hpage_size);
+
+	p = p + hpage_size;
+
+	if (verbose)
+		tst_res(TINFO, "Normal mapping at %p\n", p);
+
+	do_readback(p, hpage_size, "base normal page");
+
+	do_remap(fd, p - hpage_size);
+	do_remap(fd, p + hpage_size);
+
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 3)
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
+	.hugepages = {3, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
