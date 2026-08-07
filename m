Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8AEC2A09B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA9B73E7018
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 15:06:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B7453E7021
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:05:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF00710006B4
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:05:57 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677ClbV31485049
 for <ltp@lists.linux.it>; Fri, 7 Aug 2026 13:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YLiuO+qBDc2aEmGSF
 qPnOxVKVT/e9KxVWzphUMdi2hg=; b=ZOZw9Kt6NrpnGuU4yXw4h2vY1nx/GB03j
 qM/sQxp5CEV+AI9YuU4uVOkqcFIuQDoIV0hO23mlBgi4b1thRPoJ0hC3/esictZf
 Yvq4I3w46GNi6JydJ4DXjUX/Tl15G1VhsWdwGP5UITTiHoA9qMndtldRegLg/rm8
 9gWDV3B8bhOZDyESNzun2Tp4Qrih4Gvm+WOayIGPkCjL0An0Q2qMXriAyHqz14Rq
 3y7r9GjBnrLy12e1+3m2Qble6r8KvqlbefAKjXGzLv02nWM6sJBLH+9gjzNPp4sA
 q/t9F10lkFYtLhsn3KRXodu7aJ7960HZCH2P7fjvnyUogl1wox56w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy044002-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:05:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CuGRl000984
 for <ltp@lists.linux.it>; Fri, 7 Aug 2026 13:05:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyyj6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:05:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677D5oKA52953360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 13:05:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B5312004F;
 Fri,  7 Aug 2026 13:05:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 506A72004D;
 Fri,  7 Aug 2026 13:05:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.215.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 13:05:49 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  7 Aug 2026 18:35:22 +0530
Message-ID: <20260807130523.49068-2-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260807130523.49068-1-disgoel@linux.ibm.com>
References: <20260807130523.49068-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXyg1PGMdpAKs7
 IuHriFCUDrgy0SJ5rcaIqWsz3ZrDNKDAsGuln1St/L7z/3OqUTwL8tUwukONJOJY8T9Ys9NGsNN
 wqRjzdeReq8xFW1Q7R8NrFpJv271Y91ljC5i0lIwWJFT6YkyL0SKniggtxIZvce7oAxLVJbxlaa
 kV1fK6gtFfO/KW4rvq5WmV46IOEY66eBn3SxYjn6IDBRWYA3C1RYIPkqMCa/yrhRwHEE6BE/mLP
 b0FpQabp/H6SWPpipxe5SEJRUIefGn1j2vDo5+0Mqoo0AEqypXAlmLtMS8vuvAeYqfvOc2UHlh8
 1h4neCD38ZBWwd0pXzO06/8WVaYoYabr3sAiu6JlU9NNqcQ3WEGxy0T+qYSDmxLiupacMUyoh1P
 Ncr6ZC4fssHKGm6W63ND3s6J2H6q+tcKxCjjLZ3XKbiovQg38rRv1tV3+Nt+3di7wKLnO5EMYW3
 b4hYYAKLn5LRJl7ofdg==
X-Proofpoint-ORIG-GUID: ug7ymH_FHPG77oS-Gbdg2uk6sL0z6MA7
X-Proofpoint-GUID: ug7ymH_FHPG77oS-Gbdg2uk6sL0z6MA7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX3/l9smhJ00cH
 QI9wJEr2RpPLGgEDDBGQQDMRrocThPrL3JZm4kHChQzw8dBBePAQLN7oy62Gs5kMPIBdl7BcQEV
 vMmnec66MgbyE1Qso+h4VXCTBFRJbBs=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75d833 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=BNMQH9M5uUm1AzBn5ogA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070100
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] memcg/memcontrol03-04: fix typos,
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

Fix typos in doc comments ('tempfs' -> 'tmpfs', 'becaue' -> 'because',
'dont not' -> 'do not'), remove '#define TMPDIR "mntdir"' which
duplicates the definition already in memcontrol_common.h, replace
PRIdPTR with %zu for size_t arguments (PRIdPTR is for signed intptr_t),
and fix continuation line indentation in tst_res() calls.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 12 +++++-------
 testcases/kernel/controllers/memcg/memcontrol04.c | 10 ++++------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 493e970ab..42298e5f0 100644
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
@@ -40,8 +40,6 @@
 
 #include "memcontrol_common.h"
 
-#define TMPDIR "mntdir"
-
 static struct tst_cg_group *trunk_cg[3];
 static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
@@ -105,8 +103,8 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 		SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
 		size = size > cgmem ? size - cgmem : 0;
 
-		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
-		getpid(), tst_cg_group_name(cg), size);
+		tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
+			getpid(), tst_cg_group_name(cg), size);
 
 		if (size)
 			alloc_anon(size);
@@ -148,7 +146,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	SAFE_CG_SCANF(cg, "memory.current", "%zu", &cgmem);
 	size = size > cgmem ? size - cgmem : 0;
 
-	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 
 	if (size)
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 15d8f891c..d448478d6 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -28,7 +28,7 @@
  * The closest thing to memory.low on V1 is soft_limit_in_bytes which
  * uses a different mechanism and has different semantics. So we only
  * test on V2 like the selftest. We do test on more file systems, but
- * not tempfs becaue it can't evict the page cache without swap. Also
+ * not tmpfs because it can't evict the page cache without swap. Also
  * we avoid filesystems which allocate extra memory for buffer heads.
  *
  * The tolerances have been increased from the self tests.
@@ -40,8 +40,6 @@
 
 #include "memcontrol_common.h"
 
-#define TMPDIR "mntdir"
-
 static struct tst_cg_group *trunk_cg[3];
 static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
@@ -102,7 +100,7 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 
 	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
-	tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_anon(size);
 
@@ -122,7 +120,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 
 	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
-	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_pagecache(fd, size);
 
@@ -227,7 +225,7 @@ static void test_memcg_low(void)
 			TST_EXP_EXPR(low == 0,
 				"(%c low events=%ld) == 0", id, low);
 		} else if (!tst_cg_memory_recursiveprot(leaf_cg[F])) {
-			/* dont not check F when recursive_protection enabled */
+			/* do not check F when recursive_protection enabled */
 			TST_EXP_EXPR(low == 0,
 				"(%c low events=%ld) == 0", id, low);
 		}
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
