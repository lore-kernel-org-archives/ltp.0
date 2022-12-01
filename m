Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA73C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:30:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00DE83CC498
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:30:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEE903CC4B1
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:07 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E01431A0432C
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:29:06 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1CHZor030311; Thu, 1 Dec 2022 12:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YeYfPSlK8XYflrcBpmGDFTuQr+li4Qv622Ypwv0g8BI=;
 b=S+fY0mcxZec/BFJa9mcURMyRMDwKdRnhHucyFeYYuGxs/7L8Bcj0/QQk6B2NewkB4Lv9
 LL7bWg1rgtGALSYZApHP1eWa0GPfU4GBSv6EtysDrEClSHiPR9pys1j/XG+AK2hpW4x9
 kPeKtSUvvJ2+cPBV5ZIasrD63m08CdWaiUVzf622CLKZxUQQN61AooxnIf4SK4fO3j2B
 VmKgIrUAkww3hXLUYDVETpzWaPQrhDI9Ki9eTav9UUldvSCwnSWAYJHrkUFlhkbrj98M
 kVi5vyylAyLLt9m3X8rmhnlF/CbelaMUojivRN0Lx6QD5EXFPCHHQ3aCYseDEcN0BodA Ag== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6v57g7nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:29:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1CLkKF012606;
 Thu, 1 Dec 2022 12:29:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3m3ae9fagt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:29:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2B1CMRuK63635960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:22:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 680255204E;
 Thu,  1 Dec 2022 12:28:59 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 82E275204F;
 Thu,  1 Dec 2022 12:28:57 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:58:41 +0530
Message-Id: <20221201122844.142062-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201122844.142062-1-tsahu@linux.ibm.com>
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QFvqD1X65sHuDWVrYf8JAGs6v6tjxoZP
X-Proofpoint-GUID: QFvqD1X65sHuDWVrYf8JAGs6v6tjxoZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/8] Hugetlb: Migrating libhugetlbfs madvise_reserve
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
 vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/madvise_reserve.c test

Test Description: madvise() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated
for the reservation but not faulted in at the time of allocation. The
counters do not get updated and effectively "leak". This test
identifies whether the kernel is vulnerable to the problem or not.
It is fixed in kernel by 'commit f2deae9d4e70
("Remove implementation of readpage from the hugetlbfs_aops")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap16.c  | 83 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0714ed34c..1691ce37d 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -17,6 +17,7 @@ hugemmap12 hugemmap12
 hugemmap13 hugemmap13
 hugemmap14 hugemmap14
 hugemmap15 hugemmap15
+hugemmap16 hugemmap16
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index d59b60fd4..eb8e87c40 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -16,6 +16,7 @@
 /hugetlb/hugemmap/hugemmap13
 /hugetlb/hugemmap/hugemmap14
 /hugetlb/hugemmap/hugemmap15
+/hugetlb/hugemmap/hugemmap16
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
new file mode 100644
index 000000000..ea940e90c
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap16.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: Eric B Munson and Mel Gorman
+ */
+
+/*\
+ * [Description]
+ *
+ * madvise() on some kernels can cause the reservation counter to get
+ * corrupted. The problem is that the patches are allocated
+ * for the reservation but not faulted in at the time of allocation. The
+ * counters do not get updated and effectively "leak". This test
+ * identifies whether the kernel is vulnerable to the problem or not.
+ * It is fixed in kernel by commit f2deae9d4e70793568ef9e85d227abb7bef5b622
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
+#define MNTPOINT "hugetlbfs/"
+static int  fd = -1;
+static long hpage_size;
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long initial_rsvd, map_rsvd, madvise_rsvd, end_rsvd;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+	map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after map: %lu", map_rsvd);
+
+	if (madvise(p, hpage_size, MADV_WILLNEED) == -1)
+		tst_brk(TBROK|TERRNO, "madvise()");
+	madvise_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after madvise: %lu", madvise_rsvd);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	end_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after close(): %lu", end_rsvd);
+
+	TST_EXP_EQ_LU(end_rsvd, initial_rsvd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "f2deae9d4e70"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
