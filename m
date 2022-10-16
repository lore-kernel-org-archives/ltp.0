Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32E8C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42EC03CAF9B
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:00:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4246C3CAFC1
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:59 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7BC61A005E9
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:58:57 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9p1A8027006
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OYbsFcCmsjgnz2QIHjiYDVjsL5Vo06fO3Op8avCeuVg=;
 b=fhBylgWm9AQNcVfHk/uaTXg61tVPWcr0nnds+gWaKVMiLVFujsO2X9UwICA+eFyS0s1c
 Jc6FlKW4Wbf6xyE+ckyQfEs+Gk7b4iFsCVIVmNugQWFaakr/pLRcniDdbeYaRp/5FMFJ
 GQ1lmuFAjFbQTAFYdYWwc/zAOpflHKvZQKTlKeBqAU7S7ww5m+tF8pHe2MFKGBC4HDXt
 9zfN2mClttzcuzz0U0xCtIwuUA5UVa/+9FGDtJctfgsZzyxAfN0X6+g0gNZ9SK2nOggl
 K0sDPmuK+eNPf5KGS+B6DD/1RM145snO0HpvpGnRdlhhiBAANg26WfAWksRz2FlUPzFY dw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvk4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpDL5010007
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 3k7mg91kkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:58:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCwoYe8585818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:58:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BF0711C04C;
 Sun, 16 Oct 2022 12:58:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D69311C04A;
 Sun, 16 Oct 2022 12:58:48 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:58:48 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:09 +0530
Message-Id: <20221016125731.249078-8-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1z2cdolpk4DO6XEavAd6Zr7q5BpMTZDp
X-Proofpoint-GUID: 1z2cdolpk4DO6XEavAd6Zr7q5BpMTZDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/29] Hugetlb: Migrating libhugetlbfs fallocate_align
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

Migrating the libhugetlbfs/testcases/fallocate_align.c test

Test Description: It tests alignment of fallocate arguments. fallocate will
take non-huge page aligned offsets and addresses.  However, operations are
only performed on huge pages.  This is different that than fallocate
behavior in "normal" filesystems.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   2 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugefallocate/Makefile |  10 +
 .../hugetlb/hugefallocate/hugefallocate01.c   | 187 ++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/Makefile
 create mode 100644 testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index b019c4195..ca92dfcff 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -1,3 +1,5 @@
+hugefallocate01 hugefallocate01
+
 hugemmap01 hugemmap01
 hugemmap02 hugemmap02
 hugemmap04 hugemmap04
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ec250592d..cafdb5259 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -1,4 +1,5 @@
 /cpuset/cpuset01
+/hugetlb/hugefallocate/hugefallocate01
 /hugetlb/hugemmap/hugemmap01
 /hugetlb/hugemmap/hugemmap02
 /hugetlb/hugemmap/hugemmap04
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/Makefile b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
new file mode 100644
index 000000000..77ebb0aef
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(abs_srcdir)/../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
diff --git a/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
new file mode 100644
index 000000000..a4dae9812
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2015 Mike Kravetz, Oracle Corporation
+ *
+ * Test Name: fallocate_align
+ *
+ * Test Description: It tests alignment of fallocate arguments. fallocate will
+ * take non-huge page aligned offsets and addresses.  However, operations are
+ * only performed on huge pages.  This is different that than fallocate
+ * behavior in "normal" filesystems.
+ *
+ * HISTORY
+ *  Written by Mike Kravetz
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
+	int err;
+	unsigned long free_before, free_after;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+
+	free_before = SAFE_READ_MEMINFO("HugePages_Free:");
+
+	/*
+	 * First preallocate file with just 1 byte.  Allocation sizes
+	 * are rounded up, so we should get an entire huge page.
+	 */
+	err = fallocate(fd, 0, 0, 1);
+	if (err) {
+		if (errno == EOPNOTSUPP)
+			tst_brk(TCONF, "Operation Not Supported");
+		tst_res(TFAIL|TERRNO, "fallocate()");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_before - free_after != 1) {
+		tst_res(TFAIL, "fallocate 1 byte did not preallocate entire huge page");
+		goto fail;
+	}
+
+	/*
+	 * Now punch a hole with just 1 byte.  On hole punch, sizes are
+	 * rounded down.  So, this operation should not create a hole.
+	 */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, 1);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_after == free_before) {
+		tst_res(TFAIL, "fallocate hole punch 1 byte free'ed a huge page");
+		goto fail;
+	}
+
+	/*
+	 * Now punch a hole with of 2 * hpage_size - 1 byte.  This size
+	 * should be rounded down to a single huge page and the hole created.
+	 */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, (2 * hpage_size) - 1);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_after != free_before) {
+		tst_res(TFAIL, "fallocate hole punch 2 * hpage_size - 1 byte did not"
+				" free huge page");
+		goto fail;
+	}
+
+	/*
+	 * Perform a preallocate operation with offset 1 and size of
+	 * hpage_size.  The offset should be rounded down and the
+	 * size rounded up to preallocate two huge pages.
+	 */
+	err = fallocate(fd, 0, 1, hpage_size);
+	if (err) {
+		tst_res(TFAIL, "fallocate()");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_before - free_after != 2) {
+		tst_res(TFAIL, "fallocate 1 byte offset, huge page size did not"
+				" preallocate two huge pages");
+		goto fail;
+	}
+
+	/*
+	 * The hole punch code will only delete 'whole' huge pags that are
+	 * in the specified range.  The offset is rounded up, and (offset
+	 * + size) is rounded down to determine the huge pages to be deleted.
+	 * In this case, after rounding the range is (hpage_size, hpage_size).
+	 * So, no pages should be deleted.
+	 */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			1, hpage_size);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_before - free_after != 2) {
+		tst_res(TFAIL, "fallocate hole punch 1 byte offset, huge page size"
+				" incorrectly deleted a huge page");
+		goto fail;
+	}
+
+	/*
+	 * To delete both huge pages, the range passed to hole punch must
+	 * overlap the allocated pages
+	 */
+	err = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			0, 2 * hpage_size);
+	if (err) {
+		tst_res(TFAIL|TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
+		goto fail;
+	}
+
+	free_after = SAFE_READ_MEMINFO("HugePages_Free:");
+	if (free_after != free_before) {
+		tst_res(TFAIL, "fallocate hole punch did not delete two huge pages");
+		goto fail;
+	}
+	tst_res(TPASS, "Successful");
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing the test");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 2)
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
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
