Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BEDC4332F
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 13:01:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1A23CA2B3
	for <ltp@archiver.kernel.org>; Sun, 16 Oct 2022 15:01:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441B73CAFBA
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:16 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A95BE100037D
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 14:59:14 +0200 (CEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29GATJT3028317
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9sT7uJhrYc+BMVEPO2NvjnvQtqNtjuaKTJfBsHyyCD8=;
 b=Ev/s4xWHopYZliQ8pb7WvxzgZLP6m1p33cTltBN2r5PyAa/9twXV7yxFGRSXRbaGjY42
 p3Xhlnyz2ALvC4wvCY/9/GoNwcF+nKQlehvGOT5+saJhvJ6KPYLx/PqA8L1QhiKesd0o
 HPQyEjbpA0AevfAsL7UYKyzjTBRRP/3qK2W2IHfhlTduMMObKl+zxvDud+k+IgXi2SLj
 gTweQrgmqSRxJaYdGkNdOPPEsQphQgRzR00mz6Dl+F0Ut7sHq4Ay0q10gQpVG1Ffh9Hk
 zCijWD9y7rArVI+9X2ThcbMF0wl6ktoPDTx67Kx9ZQb6GCa0yFVwjmZbex+TB2Eh/cZz zA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86wrcb9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29GCpUfQ002766
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06fra.de.ibm.com with ESMTP id 3k7m4j98f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 16 Oct 2022 12:59:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 29GCxdBW40370634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Oct 2022 12:59:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2890911C050;
 Sun, 16 Oct 2022 12:59:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A67F11C04A;
 Sun, 16 Oct 2022 12:59:05 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.63.52])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sun, 16 Oct 2022 12:59:04 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 16 Oct 2022 18:27:16 +0530
Message-Id: <20221016125731.249078-15-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221016125731.249078-1-tsahu@linux.ibm.com>
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fL1TbcnLbDA6RILIESZ8ikyy6GVd-RTy
X-Proofpoint-ORIG-GUID: fL1TbcnLbDA6RILIESZ8ikyy6GVd-RTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-16_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210160077
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 14/29] Hugetlb: Migrating libhugetlbfs
 map_high_truncate_2
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

Migrating the libhugetlbfs/testcases/map_high_truncate_2.c test

Test Description: At one stage, a misconversion of hugetlb_vmtruncate_list
to a prio_tree meant that on 32-bit machines, certain combinations of
mapping and truncations could truncate incorrect pages, or
overwrite pmds from other VMAs, triggering BUG_ON()s or other
wierdness.

Test adapted from an example by Kenneth Chen <kenneth.w.chen@intel.com>

WARNING: The offsets and addresses used within are specifically
calculated to trigger the bug as it existed.  Don't mess with them
unless you *really* know what you're doing.

The kernel bug in question was fixed with
'commit 856fc2950555 ("[PATCH] hugetlb: fix prio_tree unit")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 1691ce37d..5fac3481c 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -18,6 +18,7 @@ hugemmap13 hugemmap13
 hugemmap14 hugemmap14
 hugemmap15 hugemmap15
 hugemmap16 hugemmap16
+hugemmap17 hugemmap17
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index eb8e87c40..6aa54f902 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -17,6 +17,7 @@
 /hugetlb/hugemmap/hugemmap14
 /hugetlb/hugemmap/hugemmap15
 /hugetlb/hugemmap/hugemmap16
+/hugetlb/hugemmap/hugemmap17
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
new file mode 100644
index 000000000..8679dcece
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ *
+ * Test Name: Map High Truncate 2
+ *
+ * Test Description: At one stage, a misconversion of hugetlb_vmtruncate_list
+ * to a prio_tree meant that on 32-bit machines, certain combinations of
+ * mapping and truncations could truncate incorrect pages, or
+ * overwrite pmds from other VMAs, triggering BUG_ON()s or other
+ * wierdness.
+ *
+ * Test adapted from an example by Kenneth Chen <kenneth.w.chen@intel.com>
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
+#define MAP_LENGTH	(4UL * hpage_size)
+#if defined(__s390__) && __WORDSIZE == 32
+#define TRUNCATE_POINT 0x20000000UL
+#else
+#define TRUNCATE_POINT 0x60000000UL
+#endif
+#define HIGH_ADDR	0xa0000000UL
+#define FOURGIG		((off64_t)0x100000000ULL)
+
+static char *verbose;
+static unsigned long hpage_size;
+static int  fd = -1;
+static char hfile[MAXPATHLEN];
+
+static void run_test(void)
+{
+	char *p, *q;
+	unsigned long i;
+
+	fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(hfile);
+	/* First mapping */
+	p = SAFE_MMAP(0, MAP_LENGTH + TRUNCATE_POINT, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_NORESERVE, fd, 0);
+
+	SAFE_MUNMAP(p, 4*hpage_size + TRUNCATE_POINT);
+
+	q = SAFE_MMAP((void *)HIGH_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE, fd, 0);
+	if (verbose)
+		tst_res(TINFO, "High map at %p\n", q);
+
+	for (i = 0; i < MAP_LENGTH; i += hpage_size)
+		q[i] = 1;
+
+	SAFE_FTRUNCATE(fd, TRUNCATE_POINT);
+
+	if (q[0] != 1) {
+		tst_res(TFAIL, "data mismatch");
+		goto fail;
+	}
+
+	tst_res(TPASS, "Successful");
+	SAFE_MUNMAP(p, MAP_LENGTH + TRUNCATE_POINT);
+	SAFE_MUNMAP(q, MAP_LENGTH);
+	return;
+fail:
+	tst_brk(TBROK, "Once failed, No point in continuing to next iteration");
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
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (hpage_size > TRUNCATE_POINT)
+		tst_brk(TCONF, "Huge page size is too large");
+
+	if (TRUNCATE_POINT % hpage_size)
+		tst_brk(TCONF, "Truncation point is not aligned to huge page size");
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
