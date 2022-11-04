Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96CDC43219
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 16:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DB4E3CAF92
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 17:26:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9193CAF73
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 17:25:54 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 469561400520
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 17:25:52 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4GE73F010044;
 Fri, 4 Nov 2022 16:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5/ZfNdaPBemF9FmLg/ZsdOGBFv4cR0U2MTfttiLm4T8=;
 b=E9KEGmlOFqOOIMUPZoVS89BRRIajuofWXjgu4PRp1KHbVoWRAh2Ie4zWw38qBqaor6w2
 H3LpVOhnJHP02jIcTUt6mNPbyE3UNEZ1SdZyZpQZGjp8jA2YvwX0MoauSbWPmgZJa3Gr
 nii+XTLqHJXcwnhEH2xrrCmr7AxwbLaUxk7T/pYP4Ulw53O+7HsVKuw40jlUHGBHrTlk
 dFm3B1P531nGCAPgeSDeNvh/802Vr0SkDNVOo3wyB3Dk2AiHFTZ8KwPp5VKP3oj5WaT/
 ljyHGUjcHC/gXKL3vjdG6BKHuivaIEjWeYM/lASQ9AuwVAVHySNsHgIDPC9JKGNrJbN3 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpt1d9v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:51 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4Feh1j014718;
 Fri, 4 Nov 2022 16:25:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmpt1d9tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A4G5sbo031464;
 Fri, 4 Nov 2022 16:25:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 3kgut8yxfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Nov 2022 16:25:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A4GPj0465405258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Nov 2022 16:25:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 802864C04A;
 Fri,  4 Nov 2022 16:25:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0A234C046;
 Fri,  4 Nov 2022 16:25:41 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.23.48])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Nov 2022 16:25:41 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  4 Nov 2022 21:55:11 +0530
Message-Id: <20221104162511.28658-5-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221104162511.28658-1-tsahu@linux.ibm.com>
References: <20221104162511.28658-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T9jzd_jSc42vJRgWmG2Pj06aFOH2Ss_E
X-Proofpoint-ORIG-GUID: 2q406P8IgXRKn5p8okZO_OdbjSIYHKox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=963
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211040104
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/4] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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

Migrating the libhugetlbfs/testcases/corrupt-by-cow-opt.c test

Test Description: Test sanity of cow optimization on page cache. If a page
in page cache has only 1 ref count, it is mapped for a private mapping
directly and is overwritten freely, so next time we access the page, we
can see corrupt data.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  | 79 +++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 664f18827..e2ada7a97 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -5,6 +5,7 @@ hugemmap05 hugemmap05
 hugemmap06 hugemmap06
 hugemmap07 hugemmap07
 hugemmap08 hugemmap08
+hugemmap09 hugemmap09
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 003ce422b..1a242ffe0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -6,6 +6,7 @@
 /hugetlb/hugemmap/hugemmap06
 /hugetlb/hugemmap/hugemmap07
 /hugetlb/hugemmap/hugemmap08
+/hugetlb/hugemmap/hugemmap09
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
new file mode 100644
index 000000000..1008395a4
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 Joonsoo Kim, LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Test sanity of cow optimization on page cache. If a page in page cache
+ * has only 1 ref count, it is mapped for a private mapping directly and
+ * is overwritten freely, so next time we access the page, we can see
+ * corrupt data.
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
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int huge_fd = -1;
+
+static void run_test(void)
+{
+	char *p;
+	char c;
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			huge_fd, 0);
+	*p = 's';
+	tst_res(TINFO, "Write %c to %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
+			huge_fd, 0);
+	*p = 'p';
+	tst_res(TINFO, "Write %c to %p via private mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+			huge_fd, 0);
+	c = *p;
+	tst_res(TINFO, "Read %c from %p via shared mapping", *p, p);
+	SAFE_MUNMAP(p, hpage_size);
+
+	/* Direct write from huge page */
+	if (c != 's')
+		tst_res(TFAIL, "Data got corrupted.");
+	else
+		tst_res(TPASS, "Successful");
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+	huge_fd = tst_creat_unlinked(MNTPOINT);
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(huge_fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
