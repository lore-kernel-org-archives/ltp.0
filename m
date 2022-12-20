Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218CC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 06:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21D9C3CBA5B
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:32:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CBDD3CBA6B
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:54 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61088200967
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 07:31:52 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BK6DU9Z025634; Tue, 20 Dec 2022 06:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=otLR21U7rsJPAClBrPkyaDyBhsgJObVU5JMb1267uXs=;
 b=cQJlxoByc+kDP4J3+VQNc9MAYCGDsuoyDKGeZRAEyD9aDNYAH5bIqUdenhPVDrsY5VAi
 4GskxS3f1b8xpgEr0tLvyr8NwNGmSjDHPdbZbLznnDwCWljzX9DyTpLV2UeJKgqFMB2V
 WqBiAMYkdgCevdi3/6t12NCTEpYLRBXnbU/WWLvO0yph6/WjStNeh7/Mig0QvPL7oloV
 Iq1i7++UnI4OdzH5eDGszYSldQwLmEgP6iniSPORskpwCMRNNAq+bHYw1YMB+fDgqE3y
 Tkb9aGYkPgEmySHWv2Y64wJLYOfDnHxO4+tF1dVIHipMz99bdbe/GHIencDVHPFfMt6c LQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mk7ke0ds5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK6OZv9024486;
 Tue, 20 Dec 2022 06:31:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mh6ywkhr0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Dec 2022 06:31:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2BK6VksE45613478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Dec 2022 06:31:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1EB72004B;
 Tue, 20 Dec 2022 06:31:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79F820040;
 Tue, 20 Dec 2022 06:31:42 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.119.42])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Dec 2022 06:31:42 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 12:01:07 +0530
Message-Id: <20221220063109.279007-7-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221220063109.279007-1-tsahu@linux.ibm.com>
References: <20221220063109.279007-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: prs1uIQpldTgoVsn9boLLcxavJKqAfE4
X-Proofpoint-ORIG-GUID: prs1uIQpldTgoVsn9boLLcxavJKqAfE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_05,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=957 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200051
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/8] Hugetlb: Migrating libhugetlbfs
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
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
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap17.c  | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
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
index 000000000..b8105bbf3
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap17.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Author: David Gibson & Adam Litke
+ */
+
+/*\
+ * [Descriptiom]
+ *
+ * At one stage, a misconversion of hugetlb_vmtruncate_list to a prio_tree
+ * meant that on 32-bit machines, certain combinations of mapping and
+ * truncations could truncate incorrect pages, or overwrite pmds from
+ * other VMAs, triggering BUG_ON()s or other wierdness.
+ *
+ * Test adapted from an example by Kenneth Chen <kenneth.w.chen@intel.com>
+ *
+ * WARNING: The offsets and addresses used within are specifically
+ * calculated to trigger the bug as it existed.  Don't mess with them
+ * unless you *really* know what you're doing.
+ *
+ * The kernel bug in question was fixed with commit
+ * 856fc2950555.
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
+#define MAP_LENGTH	(4UL * hpage_size)
+#if defined(__s390__) && __WORDSIZE == 32
+#define TRUNCATE_POINT 0x20000000UL
+#else
+#define TRUNCATE_POINT 0x60000000UL
+#endif
+#define HIGH_ADDR	0xa0000000UL
+#define FOURGIG		((off64_t)0x100000000ULL)
+
+static unsigned long hpage_size;
+static int  fd = -1;
+
+static void run_test(void)
+{
+	char *p, *q;
+	unsigned long i;
+
+	p = SAFE_MMAP(0, MAP_LENGTH + TRUNCATE_POINT, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_NORESERVE, fd, 0);
+
+	SAFE_MUNMAP(p, MAP_LENGTH + TRUNCATE_POINT);
+
+	q = SAFE_MMAP((void *)HIGH_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE, fd, 0);
+	tst_res(TINFO, "High map at %p", q);
+
+	for (i = 0; i < MAP_LENGTH; i += hpage_size)
+		q[i] = 1;
+
+	SAFE_FTRUNCATE(fd, TRUNCATE_POINT);
+
+	if (q[0] != 1)
+		tst_res(TFAIL, "data mismatch");
+	else
+		tst_res(TPASS, "Successful");
+
+	SAFE_MUNMAP(q, MAP_LENGTH);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
+
+	if (hpage_size > TRUNCATE_POINT)
+		tst_brk(TCONF, "Huge page size is too large");
+	if (TRUNCATE_POINT % hpage_size)
+		tst_brk(TCONF, "Truncation point is not aligned to huge page size");
+	fd = tst_creat_unlinked(MNTPOINT, 0);
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
+		{"linux-git", "856fc2950555"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {4, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
