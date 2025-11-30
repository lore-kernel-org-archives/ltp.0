Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E19D111A8
	for <ltp@archiver.kernel.org>; Sun, 30 Nov 2025 05:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D099F3C827B
	for <ltp@archiver.kernel.org>; Sun, 30 Nov 2025 06:14:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C3FE3C1455
 for <ltp@lists.linux.it>; Sun, 30 Nov 2025 06:13:44 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4325A140042A
 for <ltp@lists.linux.it>; Sun, 30 Nov 2025 06:13:43 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AU3PnaZ020351;
 Sun, 30 Nov 2025 05:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tDJJgrI1ye1xoj59b9tXaDxiMphbWykzIvGZPKkSl
 aU=; b=kRbFv1tfBIrrjIjKnxgl9SkSFkJNHcJTSRA6wxo6AgAWsi8ghCf8SM3g2
 0fA6l/nHaXe2aog2+oZnIWQUfInxOfbXwsrdIG0geX/vXD6aqQAHV7H/lvs6dRlI
 VKcc34RlbcvTgWL6OXvcoCBBQkGeoyE6yIEmPAUSPatqZDfT8XBD6CrV8ANry9rH
 7uh19LyhSvTU9Td02LP6B0jv9tCaQj3nlOYabtnIXb5+HTH8JnqaHy+Y1NyTf3Fb
 0D4dFjfO/ESfmNSUMk355eDcRRQyDQEIGqdiQG/8PLkOt1ykVFphCyyGsfrO/1J2
 3m0ic/2qtI053GwzRq9C0fZM1SZJg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg52a5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 05:13:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AU2gLqP003834;
 Sun, 30 Nov 2025 05:13:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcj8ame-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Nov 2025 05:13:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AU5DaI926607960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Nov 2025 05:13:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B09BE20043;
 Sun, 30 Nov 2025 05:13:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC48020040;
 Sun, 30 Nov 2025 05:13:35 +0000 (GMT)
Received: from li-6442e9cc-24ed-11b2-a85c-915a5b5fa426.ibm.com.com (unknown
 [9.39.29.79]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Nov 2025 05:13:35 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 30 Nov 2025 10:43:31 +0530
Message-ID: <20251130051331.26149-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OKn7ykK11QcwRjnCNzdr8eI6jnHxkLEe
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692bd285 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=npRE8wLiAAAA:8
 a=BJIFxfXHzFHq2DS7swsA:9 a=RAb4T5FLMvhYbp7Aw4eJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX/mH4XS41l/e3
 xMSHwR071BAboMZOTGnE1nVLpdHuQ9I9j1vVwW1wAvE+9KHVPYqUsphyXuy6lp9981QndLgFZdE
 n4qE/VRBKjk/+dperbl5GntfbbJ82L0FRGzlt3h16m26irihO/MLpE3PSX7VMleGnYjOnWmA5Sf
 W0Dxx3wJSBJ5J6rqi3ByDsyfuT2Vcqh49x7YMqj86HF/4JIdoumsfgFDadFBrlTfwSdb6hfuNh6
 AKD1bIPaMM057LWx9BZrJRZpmt9sVq/ioJEFCq96lvL7lN0yxBN2Hpu+iXwALHlAm0SyrZkRkME
 HfZxYZgXs/vufG2EXmUUAO11qI9dLzhgR2JZ1mUj7N55W92jtGzjiwtaPyHfYvHXWeQXO46P4MZ
 eBGartg6R7MddhlBUcMp4pi/ah+3ew==
X-Proofpoint-GUID: OKn7ykK11QcwRjnCNzdr8eI6jnHxkLEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH 3/3] [PATCH] Migrating the
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

Changes in v3:
- Removed [Description] line
- Replaced mmap(2) with :man2:`mmap`
- Used TST_GB inplace of FOURGB
- Added tst_brk incase of statfs64 failure
- Replaced munmap with SAFE_MUNMAP
- Modified print messages based on review comments
- Added check for hpage_size

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/hugetlb                               |   1 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/Makefile      |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap40.c  | 155 ++++++++++++++++++
 4 files changed, 158 insertions(+)
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
index 000000000..01ba0c316
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap40.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
+ * Copyright (C) 2006 Hugh Dickins <hugh@veritas.com>
+ */
+
+/*\
+ *
+ * Test tries to allocate hugepages to cover a memory range that straddles the
+ * 4GB boundary, using :man2:`mmap` with and without MAP_FIXED.
+ */
+
+#define MAPS_BUF_SZ 4096
+#define MNTPOINT "hugetlbfs/"
+
+#include "hugetlb.h"
+
+static long hpage_size;
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
+	dirend = strrchr(name, '/');
+	if (dirend && dirend > name)
+		*dirend = '\0';
+
+	ret = statfs64(name, &sb);
+	if (ret)
+		tst_brk(TBROK | TERRNO, "statfs check on filesystem failed");
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
+			tst_res(TFAIL, "1st Mapped address is not hugepage");
+			goto windup;
+		}
+		if (test_addr_huge(p + hpage_size) != 1) {
+			tst_res(TFAIL, "2nd Mapped address is not hugepage");
+			goto windup;
+		}
+		memset(p, 0, hpage_size);
+		memset(p + hpage_size, 0, hpage_size);
+		tst_res(TPASS, "Mapping without MAP_FIXED at %lx... completed", straddle_addr);
+	} else {
+		tst_res(TINFO, "Got %p instead, never mind, let's move to mapping with MAP_FIXED", p);
+		SAFE_MUNMAP(p, 2*hpage_size);
+	}
+
+	tst_res(TINFO, "Mapping with MAP_FIXED at %lx...", straddle_addr);
+	p = mmap((void *)straddle_addr, 2*hpage_size, PROT_READ|PROT_WRITE,
+				MAP_SHARED|MAP_FIXED, fd, 0);
+
+	if (p == MAP_FAILED) {
+		/* this area crosses last low slice and first high slice */
+		unsigned long below_start = 4.0*TST_GB - 256L*1024*1024;
+		unsigned long above_end = 1024L*1024*1024*1024;
+
+		if (tst_mapping_in_range(below_start, above_end) == 1) {
+			tst_res(TFAIL | TERRNO, "region (4G-256M)-1T is not free");
+			goto windup;
+		} else {
+			tst_res(TFAIL, "mmap() with MAP_FIXED failed: %s", strerror(errno));
+			goto windup;
+		}
+	}
+
+	if (p != (void *)straddle_addr) {
+		tst_res(TINFO, "got %p instead", p);
+		tst_res(TFAIL, "Wrong address with MAP_FIXED");
+		goto windup;
+	}
+
+	if (test_addr_huge(p) != 1) {
+		tst_res(TFAIL, "1st Mapped address is not hugepage");
+		goto windup;
+	}
+
+	if (test_addr_huge(p + hpage_size) != 1) {
+		tst_res(TFAIL, "2nd Mapped address is not hugepage");
+		goto windup;
+	}
+
+	memset(p, 0, hpage_size);
+	memset(p + hpage_size, 0, hpage_size);
+	tst_res(TPASS, "Mapping with MAP_FIXED at %lx... completed", straddle_addr);
+
+windup:
+	SAFE_MUNMAP(p, 2*hpage_size);
+}
+
+static void setup(void)
+{
+	hpage_size = tst_get_hugepage_size();
+
+	if (hpage_size < 0) {
+		if (errno == ENOSYS)
+			tst_res(TINFO, "No hugepage kernel support");
+		else if (errno == EOVERFLOW)
+			tst_res(TINFO, "Hugepage size too large");
+		else
+			tst_res(TINFO, "Hugepage size (%s)", strerror(errno));
+	}
+
+	straddle_addr = 4.0*TST_GB - hpage_size;
+	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
+	if (hpage_size > 4.0*TST_GB)
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
