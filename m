Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A47EC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 12:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913283CC4A4
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 13:04:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 953973CC4CB
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:13 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C18C560CEF7
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 13:03:12 +0100 (CET)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2B1AFEdM008084; Thu, 1 Dec 2022 12:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Y8f8Sms3BbkyQwT390wDmXtwcv7M+gvpzbMok3JVDwc=;
 b=hlmcoGGM7E3ErJSgkpKVHwlAP/xwOjt8ynMFFeYGjZVKuji46m1RFZ7e99AeRbYPz2VJ
 5jWuzEmMw+75sGcVamOsRItlBgTy8Uz2flGuUlnTYd93V1vQqTFcIdWfiwUebjXhCNbA
 YmXxqS1ZjgtnKsWgYrVMZgUkwnSOiGsW64cDU+2B2mC/WXah03MJhG0NvbHURFlkuzot
 536zucfp3eunH2bzT6+lLjox4u7/8y7rweRHA87/CliYdNMQZYXj5l66KthYHDiUoUPE
 ZBslx8OuTeG1OXDqas1JwVprw27nMWOIdwklpBC5QOLCK0M5kk+PCaPwbQYr0ER1N7Pr wg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6tbuajua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:11 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1BnbJc014949;
 Thu, 1 Dec 2022 12:03:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma04fra.de.ibm.com with ESMTP id 3m3ae959dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Dec 2022 12:03:09 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2B1C3n6Y59244932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Dec 2022 12:03:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FFC9A405F;
 Thu,  1 Dec 2022 12:03:06 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9219FA4054;
 Thu,  1 Dec 2022 12:03:04 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  1 Dec 2022 12:03:04 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  1 Dec 2022 17:32:46 +0530
Message-Id: <20221201120248.139396-7-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221201120248.139396-1-tsahu@linux.ibm.com>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221201120248.139396-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dkDHwoDGvaf_g4RM_HU98GwpRCOrTLRw
X-Proofpoint-ORIG-GUID: dkDHwoDGvaf_g4RM_HU98GwpRCOrTLRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=962 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010086
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/8] Hugetlb: Migrating libhugetlbfs
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
 vaibhav@linux.ibm.com
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
index 000000000..1815765d2
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
+ * 856fc29505556cf263f3dcda2533cf3766c14ab6.
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
