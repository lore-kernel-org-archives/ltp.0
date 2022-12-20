Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77BBC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:56:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A39E3CBA6B
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:56:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84AFD3CBA51
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:56:23 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B5A5D1A00E40
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:56:22 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6jD0R003916; Tue, 20 Dec 2022 06:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0hE6VyGErrKwi3Kd3Bn/88NyA67PWoPW05ULqZyRz3E=;
 b=Ax9w33e+XOwMQXpgRQ/J2tUEy8MBmO/oiIBC8VqHesAgcK4D/ehnOy6ILW0H7VKbg7NA
 dAE2rTLTZcE8wEZzoEY1iD11tlWfdMS+pt1Qi+kQdv2PVi5vv8THQDeAurdZCQeUPkzk
 yFosMVfWm4sjBC4WxIEyF8G3TZZ7Kuz7xfr0VtsdJY8JOSuzq3YzjRVTw5BC5aV1EtbR
 3P4TdnbdIPvUDhJwwHaLb6lhTsHEKlpr5g5EArIShvL4/dAKwiUWO9xvqTGNCKHEMda+
 BNO7m9LfK1ZlojD6AtL8unf6sJGlrd5IuHls/gkpbyDjrrPffaA9iduAdN/6iINnY66+ AQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk82708ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:56:20 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK2bQJr002636;
 Tue, 20 Dec 2022 06:31:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mh6yvahu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VgR918219698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 423CF20043;
 Tue, 20 Dec 2022 06:31:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D87320040;
 Tue, 20 Dec 2022 06:31:39 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:39 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:06 +0530
Message-Id: <20221220063109.279007-6-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T0u8ZUqwyZ3gQ8Lb2VWKpZC_Q1b3u6IG
X-Proofpoint-ORIG-GUID: T0u8ZUqwyZ3gQ8Lb2VWKpZC_Q1b3u6IG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200054
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/8] Hugetlb: Migrating libhugetlbfs madvise_reserve
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

Migrating the libhugetlbfs/testcases/madvise_reserve.c test

Test Description: madvise() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated
for the reservation but not faulted in at the time of allocation. The
counters do not get updated and effectively "leak". This test
identifies whether the kernel is vulnerable to the problem or not.
It is fixed in kernel by 'commit f2deae9d4e70
("Remove implementation of readpage from the hugetlbfs_aops")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
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
index 000000000..2003e7013
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
+ * It is fixed in kernel by commit f2deae9d4e70
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
