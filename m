Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1458C43217
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 19:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1DE93CD90B
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 20:53:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791543CD912
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:36 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A07A110009AF
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 20:52:35 +0100 (CET)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JQL0a005524;
 Tue, 8 Nov 2022 19:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FxzXIx2/eNYNpk7UzKcj96G8+H4zT7KLP7oZgCf8kDc=;
 b=B8a8bhApKjQto9HO6+tUtLAOj2kbt3PBVzS1x2GnLW6VN1Y1aLb7M1J1l/7X7+XVCbil
 nf0hHOTJRSOALHjzx0SRWzKhYvjxBO2rlnv1tXyO1fMV9JHeVymMEi24uXK6YJ8eu+kM
 dfGHorCsmCK2d3JscsQvvLQUc4UwG6wW8yBzu2TpA9bNt0pMN3i8dEZayCvqMgkDREOL
 sM4DCm1bzO0d+zBYxK5QbI+mrBNMxggSoqTN6RCK2LwkhP23gez0WiPMGP0rZVTP3D1x
 B+urrxf30pI/i/preadcXM4vetIoDYb3kDldR1/vNt/YtxI6f+cNA6YCUKTamA+DjMsF tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqsrv0gnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:33 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A8JSiLa005410;
 Tue, 8 Nov 2022 19:52:32 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kqsrv0gmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:32 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A8JoRS6011431;
 Tue, 8 Nov 2022 19:52:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 3kngnccn4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Nov 2022 19:52:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2A8JqRdK27787920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Nov 2022 19:52:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44AB5A404D;
 Tue,  8 Nov 2022 19:52:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24B65A4040;
 Tue,  8 Nov 2022 19:52:24 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.4.5])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  8 Nov 2022 19:52:23 +0000 (GMT)
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  9 Nov 2022 01:22:05 +0530
Message-Id: <20221108195207.232115-4-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108195207.232115-1-tsahu@linux.ibm.com>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uGJwFS0tt-5KlJEzwgGOELaQYrgsvaTJ
X-Proofpoint-GUID: lWVnfM9vZxDkh7yzglBFKgwcEhvXP38h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080125
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] Hugetlb: Migrating libhugetlbfs fadvise_reserve
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
 vaibhav@linux.ibm.com, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Migrating the libhugetlbfs/testcases/fadvise_reserve.c test

Test Description: fadvise() on some kernels can cause the reservation
counter to get corrupted. The problem is that the patches are allocated for
the reservation but not faulted in at the time of allocation. The counters
do not get updated and effectively "leak". This test identifies whether the
kernel is vulnerable to the problem or not. It's fixed in kernel by 'commit
f2deae9d4e70 ("Remove implementation of readpage from the hugetlbfs_aops")'

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |  1 +
 testcases/kernel/mem/.gitignore               |  1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap12.c  | 93 +++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index b9ee7227d..b019c4195 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -8,6 +8,7 @@ hugemmap08 hugemmap08
 hugemmap09 hugemmap09
 hugemmap10 hugemmap10
 hugemmap11 hugemmap11
+hugemmap12 hugemmap12
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index 3e64b67be..ec250592d 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -9,6 +9,7 @@
 /hugetlb/hugemmap/hugemmap09
 /hugetlb/hugemmap/hugemmap10
 /hugetlb/hugemmap/hugemmap11
+/hugetlb/hugemmap/hugemmap12
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
new file mode 100644
index 000000000..9dec80029
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap12.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 IBM Corporation.
+ * Author: Mel Gorman
+ */
+
+/*\
+ * [Description]
+ *
+ * fadvise() on some kernels can cause the reservation counter to get
+ * corrupted. The problem is that the patches are allocated for the
+ * reservation but not faulted in at the time of allocation. The counters
+ * do not get updated and effectively "leak". This test identifies whether
+ * the kernel is vulnerable to the problem or not. It's fixed in kernel
+ * by commit f2deae9d4e70793568ef9e85d227abb7bef5b622.
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
+static int  fd = -1;
+
+static void run_test(void)
+{
+	void *p;
+	unsigned long initial_rsvd, map_rsvd, fadvise_rsvd, end_rsvd;
+
+	fd = tst_creat_unlinked(MNTPOINT);
+
+	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
+
+	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
+		 fd, 0);
+	map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after map: %lu", map_rsvd);
+
+	if (posix_fadvise(fd, 0, hpage_size, POSIX_FADV_WILLNEED) == -1) {
+		tst_res(TFAIL|TERRNO, "fadvise()");
+		goto cleanup;
+	}
+	fadvise_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after fadvise: %lu", fadvise_rsvd);
+
+	memset(p, 1, hpage_size);
+
+	SAFE_MUNMAP(p, hpage_size);
+	p = NULL;
+	SAFE_CLOSE(fd);
+	end_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
+	tst_res(TINFO, "Reserve count after close: %lu", end_rsvd);
+
+	TST_EXP_EQ_LU(end_rsvd, initial_rsvd);
+cleanup:
+	if (p)
+		SAFE_MUNMAP(p, hpage_size);
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tags = (struct tst_tag[]) {
+		{"linux-git", "f2deae9d4e70793568ef9e85d227abb7bef5b622"},
+		{}
+	},
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+	.needs_hugetlbfs = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+	.hugepages = {1, TST_NEEDS},
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
