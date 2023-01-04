Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3FBC4708E
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 12:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4FCF3CCE04
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 13:24:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 615833CB7E3
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:14 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83865200740
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 13:23:12 +0100 (CET)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 304BHHR7004005; Wed, 4 Jan 2023 12:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Hc0snoXRtpUJTC+dQJxok7QrTVQlvAqEJ5l1Dkoo1tI=;
 b=cRRsrYyZtnzoWRafW7jLVcaFSbYQImHdGAd3vlE/29MZ6KZ5FnD4JmTi+xjeAMvT0KQb
 v5vGJyRK7yw79dydZf9K0adSNo4N5eusjJ+Tp2GqLSaaZ+C44BasQOTnZP4Wg5lh8TRA
 0Knqh80KruL/QeZRKnaSryaB+wSWu2w2VeoAtR9Q/cfdn/YtIINIBIdAfmr+ZF5ucihf
 Ny57JlxR7WwOXr36snu76QQ3wf+aqUtr1e4ejSpq9tmIE4OemLkz+FBAS+sXls6+TtPb
 Ue3wRt5IuxXA9GftjedF9NgG3BjG0DGVRyN3c/+IQ4Vat/6YLXYiW8m/Y2TAyacMRST1 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8exsc1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:11 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 304C0Qb7020047;
 Wed, 4 Jan 2023 12:23:11 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mw8exsc15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:11 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303H9Tcc010837;
 Wed, 4 Jan 2023 12:23:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6ku7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jan 2023 12:23:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 304CN5WQ42074582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jan 2023 12:23:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 807E320049;
 Wed,  4 Jan 2023 12:23:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08A3920040;
 Wed,  4 Jan 2023 12:23:02 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.18.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jan 2023 12:23:01 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  4 Jan 2023 17:52:19 +0530
Message-Id: <20230104122224.369467-9-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230104122224.369467-1-tsahu@linux.ibm.com>
References: <20230104122224.369467-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: esLzLXhSQLLtmHXaj1SwT3M3dlZW56jn
X-Proofpoint-GUID: hXM2Ve0zej-yo-nkUABfkaX_EwvFhrOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040102
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/13] Hugetlb: Migrating libhugetlbfs
 noresv-regarded-as-resv
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

Migrating the libhugetlbfs/testcases/noresv-regarded-as-resv.c test

Test Description: Test to correct handling for reserve count. If no
reserved mapping is created to reserved file region, it should be
considered as reserve mapping. Otherwise, reserve count will be
overflowed.

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Li Wang <liwang@redhat.com>

---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap28.c  | 66 +++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index d108542d2..95afe009e 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -28,6 +28,7 @@ hugemmap23 hugemmap23
 hugemmap25 hugemmap25
 hugemmap26 hugemmap26
 hugemmap27 hugemmap27
+hugemmap28 hugemmap28
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 9862414c6..2f8ed0df0 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -27,6 +27,7 @@
 /hugetlb/hugemmap/hugemmap25
 /hugetlb/hugemmap/hugemmap26
 /hugetlb/hugemmap/hugemmap27
+/hugetlb/hugemmap/hugemmap28
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
new file mode 100644
index 000000000..060d1c858
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap28.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2013 LG Electronics.
+ * Author: Joonsoo Kim
+ */
+
+/*\
+ * [Description]
+ *
+ * Test to correct handling for reserve count. If no reserved mapping is
+ * created to reserved file region, it should be considered as reserve
+ * mapping. Otherwise, reserve count will be overflowed.
+ */
+
+#include "hugetlb.h"
+
+#define MNTPOINT "hugetlbfs/"
+static long hpage_size;
+static int fd = -1;
+
+static void run_test(void)
+{
+	unsigned long initial_resv, end_resv;
+	int fd;
+	char *p, *q;
+
+	initial_resv = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	fd = tst_creat_unlinked(MNTPOINT, 0);
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	q = SAFE_MMAP(NULL, hpage_size,
+		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd, 0);
+
+	*q = 's';
+
+	SAFE_MUNMAP(p, hpage_size);
+	SAFE_MUNMAP(q, hpage_size);
+	SAFE_CLOSE(fd);
+
+	end_resv = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+
+	TST_EXP_EQ_LU(initial_resv, end_resv);
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
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {2, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
