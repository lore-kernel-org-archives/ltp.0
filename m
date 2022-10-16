Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1283DC433FE
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:03:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 601593CAFC0
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:03:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F223CAFC8
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:39 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 746181A00668
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:38 +0200 (CEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G8biZD032641
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/A22ZU11+3mvotRA1HI6D+d7L8JY/f1HQRNtyyiP62c=;
 b=S+Wb5NBRKc975ILJla6sQQF1xwVNkLtKRd2xr+aaPJAKG0NFXuYJ6B+WCjQMeKfDKvPU
 aqpj/oSYYFg0HBWhER2dbiDOnU97idpnAidRs29PGn2Z7SLy7FPH2QNnoNELY8JH5Cx7
 AWFTi9xf2IhlXJK8AztZq3YEZ9RgDDaOs7dCuYxZPWdtXcBktjGL3lYfKGRhT44ly4r3
 Q65e8DwDuh8YjYKN6tcF3TwZfEgcLBmpvgYRCBN2njFq5dJAUKViS7BebV6dn0LbO/gc
 bBOS5QJD+oa+NB8n7OqyWvfAhHg5h0yuio4hGuErayl05iLYOBs5Rgw8KSJjWby2DOJZ 6A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k866aw3yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:36 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCoMOF014573
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma01fra.de.ibm.com with ESMTP id 3k7mg8s81d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:34 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxV3W60948900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8B3E11C04A;
 Sun, 16 Oct 2022 12:59:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E60911C04C;
 Sun, 16 Oct 2022 12:59:28 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:28 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:24 +0530
Message-Id: <20221016125731.249078-23-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E9nGkVaYI-cZ9-x9Y9bZW4WHJr1HSWwG
X-Proofpoint-ORIG-GUID: E9nGkVaYI-cZ9-x9Y9bZW4WHJr1HSWwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210160074
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 22/29] Hugetlb: Migrating libhugetlbfs
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 148 ++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 3ae1065c7..2c65c1439 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -26,6 +26,7 @@ hugemmap21 hugemmap21 -T 2 -s 5
 hugemmap22 hugemmap22 -T 2 -s 5
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
index 000000000..0a6981470
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 David Gibson, IBM Corporation.
+ *
+ * Test Name: mremap fixed normal near huge
+ *
+ * Test Description: The kernel has bug for mremap() on some architecture.
+ * mremap() can cause crashes on architectures with holes in the address
+ * space (like ia64) and on powerpc with it's distinct page size "slices".
+ *
+ * This test get the huge mapping address and mremap() normal mapping
+ * near to this huge mapping.
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
+
+static char *verbose;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+static long hpage_size, page_size;
+
+static void do_readback(void *p, size_t size, const char *stage)
+{
+	unsigned int *q = p;
+	size_t i;
+
+	if (verbose)
+		tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
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
+static void do_remap(void *target)
+{
+	void *a, *b;
+
+	a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
+		  MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+
+	if (verbose)
+		tst_res(TINFO, "Normal base mapping at %p\n", a);
+
+	do_readback(a, page_size, "base normal");
+
+	if (verbose)
+		tst_res(TINFO, "Attempting mremap(MAYMOVE|FIXED) to %p...", target);
+
+	b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		   target);
+
+	if (b != MAP_FAILED) {
+		do_readback(b, page_size, "remapped");
+	} else {
+		if (verbose)
+			tst_res(TINFO|TERRNO, "disallowed");
+		b = a;
+	}
+
+	SAFE_MUNMAP(b, page_size);
+}
+
+static void run_test(void)
+{
+	void *p;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+	p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	SAFE_MUNMAP(p, hpage_size);
+
+	SAFE_MUNMAP(p + 2*hpage_size, hpage_size);
+
+	p = p + hpage_size;
+
+	if (verbose)
+		tst_res(TINFO, "Hugepage mapping at %p\n", p);
+
+	do_readback(p, hpage_size, "base hugepage");
+
+	do_remap(p - page_size);
+	do_remap(p + hpage_size);
+
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, hpage_size);
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
+	page_size = getpagesize();
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
