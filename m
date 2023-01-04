Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D3C4332F
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2E523CCE13
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:23:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F0783CCDE8
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:07 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5FE18600285
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:05 +0100 (CET)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BqYH0008367; Wed, 4 Jan 2023 12:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Kxt+54v+8ZcLGEkv0meJhSazoorpDMAwtLAi8D1420A=;
 b=VXEfAM6+ZwMgFOv06LK1zDjMPEOCNdQq8peiWSMwPoMJRkriJonMvuyEStOANd1irmoo
 UR3k++BVajxz0ZEUshco5030isiWj0sqmTu/aNdx1cXRYnaK1VmydEXRKcd1gSiF52VR
 FGuK9QemcuctRiocC4Fut2zDCAgdeW/FIrKDG6nDHM1TTqiDk7xelzyFJ4kJKhtPZkqM
 vWTMm3JSiM8RsmiHwVdyveDuE4fIa1IPczImdL1t7BR72NC144wX5GEmfw/PQFjcsY9C
 OqfLO4wZwV5BV5p3bU4Xlpk5POhKwab+I3r+dWMhhwMcVtRRJUcv49t6pQ3CbEEY7nYc yA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8y30ncq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:04 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304BrkNQ010244;
 Wed, 4 Jan 2023 12:23:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8y30nc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303MoMXq020628;
 Wed, 4 Jan 2023 12:23:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d95v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CMvlK18743770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:22:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 683E320043;
 Wed,  4 Jan 2023 12:22:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E54620040;
 Wed,  4 Jan 2023 12:22:53 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:22:52 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:17 +0530
Message-Id: <20230104122224.369467-7-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RBYpygV-7tXsQz-P0QWNGTLi-Q7_TJVt
X-Proofpoint-ORIG-GUID: YWXuO5fRXfeVUpNsSrDI7KiKD8xLA_hE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040097
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/13] Hugetlb: Migrating libhugetlbfs
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com
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
 .../kernel/mem/hugetlb/hugemmap/hugemmap26.c  | 103 ++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 65265b0fe..55185f2f7 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -26,6 +26,7 @@ hugemmap21 hugemmap21
 hugemmap22 hugemmap22
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
index 000000000..db2d9ce81
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap26.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2009 IBM Corporation.
+ * Author: David Gibson
+ */
+
+/*\
+ * [Description]
+ *
+ * Test Description: The kernel has bug for mremap() on some architecture.
+ * mremap() can cause crashes on architectures with holes in the address
+ * space (like ia64) and on powerpc with it's distinct page size "slices".
+ *
+ * This test get the huge mapping address and mremap() normal mapping
+ * near to this huge mapping.
+ */
+
+#define _GNU_SOURCE
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+
+static int fd = -1;
+static long hpage_size, page_size;
+
+static int do_remap(void *target)
+{
+	void *a, *b;
+	int ret;
+
+	a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
+		  MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+
+	ret = do_readback(a, page_size, "base normal");
+	if (ret)
+		goto cleanup;
+	b = mremap(a, page_size, page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+		   target);
+
+	if (b != MAP_FAILED) {
+		do_readback(b, page_size, "remapped");
+		a = b;
+	} else
+		tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED) disallowed");
+
+cleanup:
+	SAFE_MUNMAP(a, page_size);
+	return ret;
+}
+
+static void run_test(void)
+{
+	void *p;
+	int ret;
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, 3*hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+
+	SAFE_MUNMAP(p, hpage_size);
+
+	SAFE_MUNMAP(p + 2*hpage_size, hpage_size);
+
+	p = p + hpage_size;
+
+	tst_res(TINFO, "Hugepage mapping at %p", p);
+
+	ret = do_readback(p, hpage_size, "base hugepage");
+	if (ret)
+		goto cleanup;
+	ret = do_remap(p - page_size);
+	if (ret)
+		goto cleanup;
+	ret = do_remap(p + hpage_size);
+	if (ret == 0)
+		tst_res(TPASS, "Successfully tested mremap normal near hpage mapping");
+cleanup:
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+	page_size = getpagesize();
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {3, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
