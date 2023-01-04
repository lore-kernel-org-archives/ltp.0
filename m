Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9116C46467
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6258D3CCE0F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:24:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92EC33CCDDF
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:23 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 331A760073B
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:21 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BqeGM008585; Wed, 4 Jan 2023 12:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OucA6jNyU7hUo2VOveCyByVOMrCH3+sS4UG2xuImG8s=;
 b=Sliq5+JY69dukrMca99Y6twbDcO1SqY4nKgzAw8IpXBMyw4LGldLbLsE0zH6pgRiv9n5
 uY/tMdZJVzgodanGy3N7uTjDaLCLBJDPIdlCN1HCiGSyzLWk5Hj0FnbscqdfVaUd7f/e
 +bFgWMa4Uhk3uVRrqhXbxKGym9h5GiirECCXEY/Zv5BQDj5YKN6Bz7n6sVfdXp593wbE
 DD5ZDjQBjVbGluTMFicdp+2/NVxepa/Pzohi04tmfpVpZSH2TSLhnD2fdGJdH1qj+xYN
 3P8jnEtOpe6EcMVF5jDR+JHApN6XUsS15gERGIEXhA4UK9DYWO+CtMKxwes45BKxOWGc lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8y30njy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:19 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304BqmQM008738;
 Wed, 4 Jan 2023 12:23:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8y30nj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303MoMXs020628;
 Wed, 4 Jan 2023 12:23:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d963-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CNDvj21496126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8108A20040;
 Wed,  4 Jan 2023 12:23:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B15520043;
 Wed,  4 Jan 2023 12:23:10 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:23:09 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:21 +0530
Message-Id: <20230104122224.369467-11-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DEhxAtphXls-vZKvjYUO_12-tG38r2tZ
X-Proofpoint-ORIG-GUID: M8jNva7fTrTDenynC1u9Yf6rYvDIjtXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/13] Hugetlb: Migrating libhugetlbfs
 readahead_reserve
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

Migrating the libhugetlbfs/testcases/readahead_reserve.c test

Test Description: readahead() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated
for the reservation but not faulted in at the time of allocation. The
counters do not get updated and effectively "leak". This test
identifies whether the kernel is vulnerable to the problem or not.
It's fixed in kernel by 'commit f2deae9d4e70
("Remove implementation of readpage from the hugetlbfs_aops")'.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Li Wang <liwang@redhat.com>

---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap30.c  | 75 +++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 6ec8d1018..60cca4eb7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -30,6 +30,7 @@ hugemmap26 hugemmap26
 hugemmap27 hugemmap27
 hugemmap28 hugemmap28
 hugemmap29 hugemmap29
+hugemmap30 hugemmap30
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index fef0a76d6..bb9720452 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -29,6 +29,7 @@
 /hugetlb/hugemmap/hugemmap27
 /hugetlb/hugemmap/hugemmap28
 /hugetlb/hugemmap/hugemmap29
+/hugetlb/hugemmap/hugemmap30
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
new file mode 100644
index 000000000..7ed9046f3
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap30.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: Mel Gorman
+ */
+
+/*\
+ * [Description]
+ *
+ * readahead() on some kernels can cause the reservation counter to get
+ * corrupted. The problem is that the pages are allocated for the
+ * reservation but not faulted in at the time of allocation. The
+ * counters do not get updated and effectively "leak". This test
+ * identifies whether the kernel is vulnerable to the problem or not.
+ * It's fixed in kernel by commit f2deae9d4e70.
+ */
+
+#define _GNU_SOURCE
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long initial_rsvd, map_rsvd, readahead_rsvd, end_rsvd;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+	map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "map_rsvd: %lu", map_rsvd);
+
+	readahead(fd, 0, hpage_size);
+	readahead_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "readahead_rsvd: %lu", readahead_rsvd);
+
+	memset(p, 1, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+	end_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(end_rsvd, initial_rsvd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
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
