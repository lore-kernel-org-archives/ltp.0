Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D6EC5DF84
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 833353CC67D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:15:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E6533CC831
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:15:03 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63FBB200A0D
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:15:02 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAW3aB4174544; Tue, 18 Aug 2026 12:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nDXJYHctu/xxiBaB2
 q9eAGUktfw2NjnkHXF0Fbr3WAQ=; b=K+KI5OQRRFe8Dox+Q2bg5v938p2sqBAds
 sI3n7h5dxOf3Z4E2jG3XSuKd1wmUaZ33wPZCFU2kbHrUg26bYkeHQI0SCIH2nhet
 JYKBHOnnOZ0EyK9wBPozxFrzeFWMgJB39JUz2Kszdk3nJeobqpT+PMuGnpf7MQ0V
 csGludbgIV/m5dZ2Azeq+u5zn68DtHC5XQJLIgdgZwS4w0JeqqPD5gOWBEKVjeCy
 Xt6URPdJLHaNA3+lXeMQRbZa5a5h/V0kK8V0Rjkt21LW5mGv9f6m8CsGtMlb4lhk
 Z00tRjV4U4/myN6YaNOFfXUCg4b8JGaaaOlRTISgT55yHL3GCcyIw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3r1te-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:15:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICBIrH001874;
 Tue, 18 Aug 2026 12:14:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngavyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:14:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ICEt5d46596372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 12:14:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A47AC20049;
 Tue, 18 Aug 2026 12:14:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C085220040;
 Tue, 18 Aug 2026 12:14:54 +0000 (GMT)
Received: from dhcp-9-123-14-0.bl1-in.ibm.com (unknown [9.123.14.0])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 12:14:54 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 17:44:35 +0530
Message-ID: <20260818121436.1397-2-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260818121436.1397-1-disgoel@linux.ibm.com>
References: <20260818121436.1397-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XUor5z7t9pwnf4fpe8dwRi5WYIwHnCnU
X-Proofpoint-ORIG-GUID: XUor5z7t9pwnf4fpe8dwRi5WYIwHnCnU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX4WGjMHKP102+
 weA0alZoMTwXhrgg6XYs3pgED9owZNcmrBoGNN7qrVvE74BqGKI7dtLraESAa+WX1JfhiNsHGPp
 zT6e4wcqHjS/sC6Ca+WgeT79vQdca4E=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a844cc4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=q73d4Io-3vUQZXOjN84A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX4G5BLk4Fz97P
 Nno4cXmm95RKytYVFlSZWCpfrJCO0sqQrl5qaqAmcngeNSznHgYPzP+OnMJAcJbL0NN1IIgB/QH
 /J61/+HgO6uiZsN3D00f1pCoEg5tBz8mZ6t0Fb4eM3cnItyUzIjFpQxVJyp/OOlC3T9fv1RHfs4
 lcRfqS5jic0fubzrzsE1Kx+UtcRLOGiXsl3CJSHlNqCWHWSt8NdbOVWt0PdYT4RendzCrHekPhd
 xMo3DpamDlegvEL325HimNh4dHte0YFISb9edoOgRgAN6PebIqyIKjW1S1iHUPdIg01QTrFt2gq
 /bD2OZIebV78HA+kCOc1qwfBNx4BOFaPybzOlUhdk8EjQ956bPLwq32f6daXaM4BPzsMLd0KfQp
 kUUJCFqGYo66ALZOPPEWbW6FjWPN8h4AfeodRZxQdo4p+mYjZ9gMwFnoANff6UKd1V/ZcZNDJVl
 xg6VACutHs3t+EmI0rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180088
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] memcg/memcontrol03: fix typos,
 redundant define and format specifiers
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
Cc: Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix typos in doc comment ('tempfs' -> 'tmpfs', 'becaue' -> 'because'),
remove '#define TMPDIR \"mntdir\"' which duplicates the definition already
in memcontrol_common.h, replace PRIdPTR with %zu for size_t arguments
(PRIdPTR is for signed intptr_t, not unsigned size_t), fix continuation
line indentation in tst_res() calls, and remove now-unused <inttypes.h>
include.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
v1 -> v2:
- Remove now-unused <inttypes.h> include (PRIdPTR was its only user)
- Split from combined memcontrol03+04 patch into separate patch per file

 testcases/kernel/controllers/memcg/memcontrol03.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 493e970ab..96224c4ee 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -27,8 +27,8 @@
  * pagecache even in this case."
  *
  * memory.min doesn't appear to exist on V1 so we only test on V2 like
- * the selftest. We do test on more file systems, but not tempfs
- * becaue it can't evict the page cache without swap. Also we avoid
+ * the selftest. We do test on more file systems, but not tmpfs
+ * because it can't evict the page cache without swap. Also we avoid
  * filesystems which allocate extra memory for buffer heads.
  *
  * The tolerances have been increased from the self tests.
@@ -36,12 +36,8 @@
 
 #define _GNU_SOURCE
 
-#include <inttypes.h>
-
 #include "memcontrol_common.h"
 
-#define TMPDIR "mntdir"
-
 static struct tst_cg_group *trunk_cg[3];
 static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
@@ -105,8 +101,8 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 		SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
 		size = size > cgmem ? size - cgmem : 0;
 
-		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
-		getpid(), tst_cg_group_name(cg), size);
+		tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
+			getpid(), tst_cg_group_name(cg), size);
 
 		if (size)
 			alloc_anon(size);
@@ -148,7 +144,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
 	size = size > cgmem ? size - cgmem : 0;
 
-	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 
 	if (size)
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
