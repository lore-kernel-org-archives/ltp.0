Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7E8D10375
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 07:23:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A67D93CBA00
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:23:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8ED3CC54D
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:54 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 69F7A200776
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 08:22:53 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28C6g010950;
 Thu, 27 Nov 2025 07:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6o/PmYHb9uSdi10+f
 iC6HC3IokYsRKQUQrEIrTZAc+c=; b=UbiwtLMeDfvU4LeCr/bX7xTCbIP4Kve29
 dwYresPpKMt6RNSQWLRjCMPELlw/6Korqls6JhTWjPmVZ+QLIuOu+YIAAO4qZ29b
 E3SKzwKda9VRN6fO+001yH2DFvBJNH5hjpCDtFGsQg8iF/BEGYXg75iEwJFS5NoJ
 Lv04WcIa/RztVgFFRdLJPOSDoNhDNhWWVBjIAonoL8oDNfaetfnWj6h/ibiJ7Ur8
 buHI802fxnqQP1uIkNJiLDwjAFMdF/ScRpwBzJVF24oVnPYAEBe6vILL1iviMdas
 /qJbk/SdgCT9W6jvE0UaNbMJVkejfPSKhT0hE1WMr6/wvoVefYs7g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9rame-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR6RdEU001398;
 Thu, 27 Nov 2025 07:22:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvy6w8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 07:22:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AR7Mk9f43975022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 07:22:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D4F20040;
 Thu, 27 Nov 2025 07:22:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E4A520043;
 Thu, 27 Nov 2025 07:22:45 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.124.217.43]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 07:22:44 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 12:52:31 +0530
Message-ID: <20251127072231.2104445-3-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
References: <20251127072231.2104445-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX3bzXwb7UrG5P
 Ct6WI3UYASTO0j33i7xiFLJYEQacXP6wrkehTmSqkBbypHpkBYnsHzjM74LNzPMms7JdCiGAo0t
 ilrTEpoP0NKDG00SEGNjIeyc+6rZgybcDcruD+x65JWdXhFWopeD3rEtleHZHlkGl2Z/fxRX8Oj
 7lXsWTqzI5hcm4UspXAktcKu2COlQnV/TQ5sKofLAP1LYTuCH5F9ud3HD2WkwpkYWNh4WJB7tzL
 tjPR6PwYWBkbRhrd1hyW11KM0+MgUWu7TQYlNmsSFHerfhsFefe7Pb4PCTjP6jmlc7om5jWTyE1
 +MJnNLgKno4g1Fa3nB7BdaM4M7C8NIZl+Gl/BQFWLYYWrKFyoa7UscsSJroKsqIVD++icmwEZ7/
 pGMexoXWLvFAyLi/Wt+LFTJnOV1Qcg==
X-Proofpoint-ORIG-GUID: eeyAqQA7onBhf4l_8PI9isig4aAocmDj
X-Proofpoint-GUID: eeyAqQA7onBhf4l_8PI9isig4aAocmDj
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=6927fc4b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=npRE8wLiAAAA:8
 a=BJIFxfXHzFHq2DS7swsA:9 a=RAb4T5FLMvhYbp7Aw4eJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/straddle_4GB.c v3
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This testcase attempts to map a memory range that straddles the 4GB boundary using mmap() with and without the MAP_FIXED flag.

Changes in v3:
- Added magic definition to include/tst_fs.h as separate patch.
- Moved CFLAGS to make file.
- Added read_maps definition to separate patch.
- Removed \n from tst_res

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap40.c  | 147 ++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index 0896d3c94..8124ba3e5 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -36,6 +36,7 @@ hugemmap30 hugemmap30
 hugemmap31 hugemmap31
 hugemmap32 hugemmap32
 hugemmap34 hugemmap34
+hugemmap40 hugemmap40
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index b4455de51..314396274 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -36,6 +36,7 @@
 /hugetlb/hugemmap/hugemmap31
 /hugetlb/hugemmap/hugemmap32
 /hugetlb/hugemmap/hugemmap34
+/hugetlb/hugemmap/hugemmap40
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 6e72e7009..a1711f978 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -12,3 +12,4 @@ CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
 
 hugemmap06: CFLAGS+=-pthread
 hugemmap34: CFLAGS=$(CFLAGS_no_stack_prot)
+hugemmap40: CFLAGS += -D_LARGEFILE64_SOURCE
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
new file mode 100644
index 000000000..7b4ad7b05
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test tries to allocate hugepages to cover a memory range that straddles the
+ * 4GB boundary, using mmap(2) with and without MAP_FIXED.
+ */
+
+#define MAPS_BUF_SZ 4096
+#define FOURGB (1UL << 32)
+#define MNTPOINT "hugetlbfs/"
+
+#include "hugetlb.h"
+
+static unsigned long hpage_size;
+static int fd = -1;
+static unsigned long straddle_addr;
+
+static int test_addr_huge(void *p)
+{
+	char name[256];
+	char *dirend;
+	int ret;
+	struct statfs64 sb;
+
+	ret = read_maps((unsigned long)p, name);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0) {
+		tst_res(TINFO, "Couldn't find address %p in /proc/self/maps", p);
+		return -1;
+	}
+
+	/* looks like a filename? */
+	if (name[0] != '/')
+		return 0;
+
+	/* Truncate the filename portion */
+
+	dirend = strrchr(name, '/');
+	if (dirend && dirend > name)
+		*dirend = '\0';
+
+	ret = statfs64(name, &sb);
+	if (ret)
+		return -1;
+
+	return (sb.f_type == HUGETLBFS_MAGIC);
+}
+
+static void run_test(void)
+{
+	void *p;
+
+	/* We first try to get the mapping without MAP_FIXED */
+	tst_res(TINFO, "Mapping without MAP_FIXED at %lx...", straddle_addr);
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+			MAP_SHARED, fd, 0);
+	if (p == (void *)straddle_addr) {
+		/* These tests irrelevant if we didn't get the straddle address*/
+		if (test_addr_huge(p) != 1) {
+			tst_brk(TFAIL, "1st Mapped address is not hugepage");
+			goto windup;
+		}
+		if (test_addr_huge(p + hpage_size) != 1) {
+			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
+			goto windup;
+		}
+		memset(p, 0, hpage_size);
+		memset(p + hpage_size, 0, hpage_size);
+		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
+	} else {
+		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED", p);
+		munmap(p, 2*hpage_size);
+	}
+
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+				MAP_SHARED|MAP_FIXED, fd, 0);
+
+	if (p == MAP_FAILED) {
+		/* this area crosses last low slice and first high slice */
+		unsigned long below_start = FOURGB - 256L*1024*1024;
+		unsigned long above_end = 1024L*1024*1024*1024;
+
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
+			tst_res(TINFO, "region (4G-256M)-1T is not free");
+			tst_res(TINFO, "mmap() failed: %s", strerror(errno));
+			tst_res(TWARN, "Pass Inconclusive!");
+			goto windup;
+		} else
+			tst_res(TFAIL, "mmap() FIXED failed: %s", strerror(errno));
+	}
+
+		if (p != (void *)straddle_addr) {
+			tst_res(TINFO, "got %p instead", p);
+			tst_res(TFAIL, "Wrong address with MAP_FIXED");
+			goto windup;
+		}
+
+		if (test_addr_huge(p) != 1) {
+			tst_brk(TFAIL, "1st Mapped address is not hugepage");
+			goto windup;
+		}
+
+		if (test_addr_huge(p + hpage_size) != 1) {
+			tst_brk(TFAIL, "2nd Mapped address is not hugepage");
+			goto windup;
+		}
+		memset(p, 0, hpage_size);
+		memset(p + hpage_size, 0, hpage_size);
+		tst_res(TPASS, "Mapping with MAP_FIXED at %lx... completed", straddle_addr);
+
+windup:
+	SAFE_MUNMAP(p, 2*hpage_size);
+}
+
+static void setup(void)
+{
+	straddle_addr = FOURGB - hpage_size;
+	hpage_size = tst_get_hugepage_size();
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	if (hpage_size > FOURGB)
+		tst_brk(TCONF, "Huge page size is too large!");
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
+	.hugepages = {2, TST_NEEDS},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run_test,
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
