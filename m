Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6A606A33C
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VoVBlNT9
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C2E3CB969
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 05:41:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B69663CB3EC
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 05:41:23 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2AF17140004E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 05:41:22 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A51EG9f975354 for <ltp@lists.linux.it>; Thu, 5 Nov 2026 04:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0UckrX2/hvvkcQERNhQvG6m+mMU+xTOs1k+ndZf7q
 xs=; b=VoVBlNT9ZXu84UlovKQxb3euOzNLJP6l3fBuAzxf9WtV4iEKuu8yU/cc8
 9vg+Px3hRHTAODpb8LsD7uKIEL7Etifw8AkhFSZlczV5VeXqiw4eG7Wo07AT372Z
 3Kg1HWoDvwFBHWx4PRr9z2IVqSh91nFdM2T6XbJIBMvp1Id/WXVpljs8scQC0jWc
 iV8h8cTxIjtg1WR1sCzE2WqahuhYylaw/lKdaYu+kYMah550UdRyGYH2llzp1cjd
 ZqQZ70yP8l4VgHCYZSaDufbaRUfhHKnJDJPKkpLHwROKFiXfxUru+Rc1Kc+0EUiN
 5VCV4E7ucpaiMtwvLaWqP8dKfDoyg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdfr75-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 04:41:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A50nuSw795084 for <ltp@lists.linux.it>; Thu, 5 Nov 2026 04:41:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqkjcg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 04:41:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A54fFeI37683676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2026 04:41:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E4ED2004B;
 Thu,  5 Nov 2026 04:41:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE00220043;
 Thu,  5 Nov 2026 04:41:13 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.43.121.225]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2026 04:41:13 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  5 Nov 2026 10:11:03 +0530
Message-ID: <20261105044103.259138-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EOVGvkjrYfYajjK-f5y3SJ53rNpFaO1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAxNiBTYWx0ZWRfX8NMCRgjnZt/A
 nSuuna/FS/GkFXLlwhetZdVxa6wDqXMXp9YbNBT7EkEo5fbv6vdSIgg9fsxkMG/LQHx+12Sd7Hi
 8Jx1GgBYrScnNThzCRUJ2TIw7GfkJhG/HGgBqST6pETveeCghZe0wjDl2JGCTosNhCMQpErTXCg
 aDPdM4bdYrYn+lq2r1Ap6RMVttFZQEdTjHN4jSK1/VWST3J5tZwOLdo0eZJxxKsSKVx6CGLYrrk
 evqJAd0H++fqWAVK74k7YtAuxjN2lRUsuNTw5t1nbokreOWFh8acKsiNSHfpy3KJMN96bInlAoX
 YaAfA9sqphK/HjSYVUCe3wiuAMxfLZiqWLfZU8ZQLRc3Ok8DbjbllrRuw1ODPpUWviIK4eGCyIn
 Fu/kriABbjXFeIQ5M5CupqRnOs+/GtnGUEAmgCaw6NqNGWqZkiP8avcJzAvxhnvMKNJkk3fLROR
 9FIJuaTTGfAc9xpEQow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAxNiBTYWx0ZWRfX2KCt9QWqjLmT
 rvlLVBWPmpTnrwgP67GLS9w6c+/lPMAF8UzcRNafp3Mwyhm3/Mv8SNWVqu9rqDePGczK9MLkL3r
 83qSp4k6ae0X7KI8+3/PZjyPIxhErzY=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec08ef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pMoprIylaEOVEeqZZLkA:9
X-Proofpoint-ORIG-GUID: EOVGvkjrYfYajjK-f5y3SJ53rNpFaO1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050016
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mincore05: Add test for per-page residency accuracy
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test that mincore() correctly reports per-page residency
for a partially faulted anonymous mapping. Even-indexed
pages are written and mlocked; odd-indexed pages are left
untouched. The vec[] bitmap is verified to match exactly.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/mincore/.gitignore  |  1 +
 testcases/kernel/syscalls/mincore/mincore05.c | 94 +++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 testcases/kernel/syscalls/mincore/mincore05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ca190dd97..28abac41c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1045,6 +1045,7 @@ mincore01 mincore01
 mincore02 mincore02
 mincore03 mincore03
 mincore04 mincore04
+mincore05 mincore05
 
 madvise01 madvise01
 madvise02 madvise02
diff --git a/testcases/kernel/syscalls/mincore/.gitignore b/testcases/kernel/syscalls/mincore/.gitignore
index 25a5e8ab1..406b47749 100644
--- a/testcases/kernel/syscalls/mincore/.gitignore
+++ b/testcases/kernel/syscalls/mincore/.gitignore
@@ -2,3 +2,4 @@
 /mincore02
 /mincore03
 /mincore04
+/mincore05
diff --git a/testcases/kernel/syscalls/mincore/mincore05.c b/testcases/kernel/syscalls/mincore/mincore05.c
new file mode 100644
index 000000000..9aa5072d4
--- /dev/null
+++ b/testcases/kernel/syscalls/mincore/mincore05.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+/*\
+ * Verify that mincore() reports per-page residency accurately for a
+ * partially faulted anonymous mapping.
+ *
+ * A MAP_PRIVATE | MAP_ANONYMOUS region of NUM_PAGES pages is created.
+ * Only even-indexed pages (0, 2, 4) are written to and individually
+ * mlocked. The odd-indexed pages (1, 3, 5) are left untouched.
+ *
+ * After calling mincore() the vec[] bitmap must satisfy:
+ *   even pages -> bit 0 set   (resident)
+ *   odd  pages -> bit 0 clear (not resident)
+ */
+
+#include <sys/mman.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+#define NUM_PAGES 6
+
+static int page_size;
+static int map_size;
+static char *map_addr;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+	map_size  = page_size * NUM_PAGES;
+}
+
+static void cleanup(void)
+{
+	if (map_addr) {
+		SAFE_MUNMAP(map_addr, map_size);
+		map_addr = NULL;
+	}
+}
+
+static void test_mincore(void)
+{
+	unsigned char vec[NUM_PAGES];
+	int i, fail = 0;
+
+	map_addr = SAFE_MMAP(NULL, map_size,
+			     PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS,
+			     -1, 0);
+
+	for (i = 0; i < NUM_PAGES; i += 2) {
+		map_addr[i * page_size] = 1;
+		SAFE_MLOCK(map_addr + i * page_size, page_size);
+	}
+
+	if (mincore(map_addr, map_size, vec) == -1)
+		tst_brk(TBROK | TERRNO, "mincore() failed");
+
+	for (i = 0; i < NUM_PAGES; i += 2)
+		SAFE_MUNLOCK(map_addr + i * page_size, page_size);
+
+	for (i = 0; i < NUM_PAGES; i++) {
+		int resident = vec[i] & 1;
+		int expected = (i % 2 == 0) ? 1 : 0;
+
+		if (resident != expected) {
+			tst_res(TFAIL,
+				"page %d: expected %s but mincore() reports %s",
+				i,
+				expected ? "resident"     : "not resident",
+				resident ? "resident"     : "not resident");
+			fail = 1;
+		}
+	}
+
+	if (!fail) {
+		tst_res(TPASS,
+			"mincore() correctly reports even pages resident "
+			"and odd pages not resident");
+	}
+
+	SAFE_MUNMAP(map_addr, map_size);
+	map_addr = NULL;
+}
+
+static struct tst_test test = {
+	.setup    = setup,
+	.cleanup  = cleanup,
+	.test_all = test_mincore,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
