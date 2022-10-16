Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38908C4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:02:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B62CD3CAB0D
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:02:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D76B3CAF9E
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:22 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 332E21A0067E
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:20 +0200 (CEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29G9OGCT027079
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nz+5AYKmlID/YW2sMhvdP5sqHJdGnNPlD0yyGQJjK7U=;
 b=JdtZHVxPdUSyAj7BzGxBfJRA53xSpsohpjJhnPYu74yEQZfVeCrnQm3JErA1QDOlQqLp
 fQfBubbQvmBuyiDCLVW2t8He9+1p6TliSaFLhCeJUb966Fq4HKe/DjotgyJJR7tyjrOU
 zb+3o1mMK/v6Wu2Pa4TJpq0CYjzxGZ5jgTA/waJfAFkA1PUW9EdcaSlFgIfpBVzPzCsa
 eF4r/+hQTEYGX7ETq5v1RWtp8gpcVMTCMj6JYcIqhiwnTjNcnDhhWbfLfZ+NuK4amIw/
 SRS7qBLIbNSLmvbQaR0S52Y+C6yIFL5bnKICLTNHvgZwxFUoS4n8tNbp8lK7EKeWDL5A TQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86shvkbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:18 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpX4E008577
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:16 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 3k7mg917r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 29GCxC2561276428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC6A311C052;
 Sun, 16 Oct 2022 12:59:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D67DA11C04A;
 Sun, 16 Oct 2022 12:59:10 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:10 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:18 +0530
Message-Id: <20221016125731.249078-17-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JT7XjaZ0SbTGB0P7zp-1jSqJ1SBgtSSQ
X-Proofpoint-GUID: JT7XjaZ0SbTGB0P7zp-1jSqJ1SBgtSSQ
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
Subject: [LTP] [PATCH 16/29] Hugetlb: Migrating libhugetlbfs
 misaligned_offset
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

Migrating the libhugetlbfs/testcases/misaligned_offset.c test

Test Name: Misaligned offset

Test Description: At one stage, a misconversion of hugetlb_vmtruncate_list
to a prio_tree meant that on 32-bit machines, truncates at or above 4GB
could truncate lower pages, resulting in BUG_ON()s.

WARNING: The offsets and addresses used within are specifically
calculated to trigger the bug as it existed.  Don't mess with them
unless you *really* know what you're doing.

The kernel bug in question was fixed with
'commit 856fc2950555 ("[PATCH] hugetlb: fix prio_tree unit")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap19.c  | 166 ++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index de76cdaf2..4da1525a7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -20,6 +20,7 @@ hugemmap15 hugemmap15
 hugemmap16 hugemmap16
 hugemmap17 hugemmap17
 hugemmap18 hugemmap18
+hugemmap19 hugemmap19
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index daee70586..b6b3e5ddd 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -19,6 +19,7 @@
 /hugetlb/hugemmap/hugemmap16
 /hugetlb/hugemmap/hugemmap17
 /hugetlb/hugemmap/hugemmap18
+/hugetlb/hugemmap/hugemmap19
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
new file mode 100644
index 000000000..57965307e
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap19.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ *
+ * Test Name: Misaligned offset
+ *
+ * Test Description: At one stage, a misconversion of hugetlb_vmtruncate_list
+ * to a prio_tree meant that on 32-bit machines, truncates at or above 4GB
+ * could truncate lower pages, resulting in BUG_ON()s.
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
+ * unless you *really* know what you're doing.
+ *
+ * The kernel bug in question was fixed with commit
+ * 856fc29505556cf263f3dcda2533cf3766c14ab6.
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
+#define RANDOM_CONSTANT	0x1234ABCD
+static char *verbose;
+static int page_size;
+static long hpage_size;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+
+static void run_test(void)
+{
+	off_t buggy_offset;
+	void *p, *q;
+	volatile int *pi;
+	int err;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+	/* First, we make a 2 page sane hugepage mapping.  Then we
+	 * memset() it to ensure that the ptes are instantiated for
+	 * it.  Then we attempt to replace the second half of the map
+	 * with one at a bogus offset.  We leave the first page of
+	 * sane mapping in place to ensure that the corresponding
+	 * pud/pmd/whatever entries aren't cleaned away.  It's those
+	 * bad entries which can trigger bad_pud() checks if the
+	 * backout path for the bogus mapping is buggy, which it was
+	 * in some kernels.
+	 */
+	if (verbose)
+		tst_res(TINFO, "Initial free hugepages: %lu\n",
+			SAFE_READ_MEMINFO("HugePages_Free:"));
+
+	/* First get arena of three hpages size, at file offset 4GB */
+	p = SAFE_MMAP(NULL, 2*hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (verbose) {
+		tst_res(TINFO, "After Mapping reference map, Free hugepages: %lu",
+			SAFE_READ_MEMINFO("HugePages_Free:"));
+		tst_res(TINFO, "Mapped Address Range: %p-%p", p, p+2*hpage_size-1);
+	}
+
+	/* Instantiate the pages */
+	memset(p, 0, 2*hpage_size);
+	pi = p;
+	*pi = RANDOM_CONSTANT;
+
+	if (verbose)
+		tst_res(TINFO, "After instantiate the pages, Free hugepages: %lu",
+			   SAFE_READ_MEMINFO("HugePages_Free:"));
+
+	/* Toggle the permissions on the first page.  This forces TLB
+	 * entries (including hash page table on powerpc) to be
+	 * flushed, so that the page tables must be accessed for the
+	 * test further down.  In the buggy case, those page tables
+	 * can get thrown away by a pud_clear()
+	 */
+	err = mprotect(p, hpage_size, PROT_READ);
+	if (err)
+		tst_brk(TBROK|TERRNO, "mprotect(%p, 0x%lx, PROT_READ)", p, hpage_size);
+
+	/* Replace top hpage by hpage mapping at confusing file offset */
+	buggy_offset = page_size;
+	if (verbose)
+		tst_res(TINFO, "Replacing map at %p with map from offset 0x%lx...",
+		       p + hpage_size, (unsigned long)buggy_offset);
+	q = mmap(p + hpage_size, hpage_size, PROT_READ|PROT_WRITE,
+		 MAP_FIXED|MAP_PRIVATE, fd, buggy_offset);
+	if (q != MAP_FAILED) {
+		tst_res(TFAIL|TERRNO, "bogus offset mmap() succeeded at %p", q);
+		goto fail;
+	}
+	if (errno != EINVAL) {
+		tst_res(TFAIL|TERRNO, "bogus mmap() failed should be \"%s\" but it is",
+		     strerror(EINVAL));
+		goto fail;
+	}
+
+	if (verbose)
+		tst_res(TINFO, "After Mapping with buggy offset, Free hugepages: %lu",
+			SAFE_READ_MEMINFO("HugePages_Free:"));
+
+	if (*pi != RANDOM_CONSTANT) {
+		tst_res(TFAIL, "Pre-existing mapping clobbered: %x instead of %x",
+		     *pi, RANDOM_CONSTANT);
+		goto fail;
+	}
+
+	/* The real test is whether we got a bad_pud() or similar
+	 * during the run.  The check above, combined with the earlier
+	 * mprotect()s to flush the TLB are supposed to catch it, but
+	 * it's hard to be certain.  Once bad_pud() is called
+	 * behaviour can be very strange.
+	 */
+
+	tst_res(TPASS, "Successful but inconclusive");
+	SAFE_MUNMAP(p, 2*hpage_size);
+	SAFE_CLOSE(fd);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing to next interation");
+}
+
+static void setup(void)
+{
+	if (tst_hugepages < 4)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt, getpid());
+	page_size = getpagesize();
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
+	.hugepages = {4, TST_REQUEST},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
