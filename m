Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D80C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2DE3CC67D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:15:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FC53CC708
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:15:05 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A803F10007D8
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:15:04 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IAVcij3109617; Tue, 18 Aug 2026 12:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I/DqHhjXiAK0A1MWM
 7AidruqkfhmM+ShMSPr5ey4Onw=; b=KED3y6W9AR0lP1lej9XJtYWdWfaMUJUwb
 lWyQc1cVEGm8UBFhtrjGDMf3g87X8hsF8MHq+kZW0SNxuPPjOLoKxkqdbmLmuJq8
 pphq1TSjUCvPPWUm4+8Ih+WtK74Wb6hmkGEha1r7bphA1+E+RKQPisGx0Q9PLrWb
 p1vChc/v0LUmCSy2pQCsSUYYORzhQcMdTpbDU7R9dv52IYaabTPBl+mJ1Ql9ueYm
 6Nqv5qSFhKir0jRDIqdAuDJ/liOmneMLWmZhlUP93NqHHHWckjyLaEaXJ5yG+dGh
 kRmuiVgE/u5EA4yKB8uFC1y7hxS9k4dA6ZUsrUhzejh2cXJhlW67g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe7ppr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:15:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBuQVj013671;
 Tue, 18 Aug 2026 12:15:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw37ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 12:15:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ICEw9K44433878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 12:14:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2930520049;
 Tue, 18 Aug 2026 12:14:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 446C920040;
 Tue, 18 Aug 2026 12:14:57 +0000 (GMT)
Received: from dhcp-9-123-14-0.bl1-in.ibm.com (unknown [9.123.14.0])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 12:14:57 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 17:44:36 +0530
Message-ID: <20260818121436.1397-3-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260818121436.1397-1-disgoel@linux.ibm.com>
References: <20260818121436.1397-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX/su2oNum9BTD
 DXiOvl7o2spnnjzqn9V02/ZLOHyLNy4nJaaDubEnoL7g9IHgjK4xFXeBnoKV5slNrpS8wCBnrDi
 Xoj2oqkRSMbvpa/e8ZaOYlM30xYu2Z4+JSBE2LpLIa94lNXu4WCPYHpvQ1htBl3sGDi2sATzgxb
 SoU1cG8qcq8mKuYqM99rVakUsc/PZsZqAaefLI0Ng/Ciq/Xd0LhtIe7cwekVo3y2E0bzlswKGRl
 4LTGhtAh8vJ1ERiK/Q8KbuMS+o1MxjoNk+BqkyentE2cKHEcu++sJxmP8d2F0cQfeZWh8Avxuba
 koHfR7q09H3/rMyuxgxTql+BNl2/+C0dxDXZjwxVq5LPpCgDt7v+3OAzNB2RZB+DBEVwcFMdSfX
 69fMsA5sIAuIpsn5y68lSKEz32lKCzawQCgMGHW+ycAxSg3EiteLYqmxzRF+jAL42fqNLDUTTjd
 +pT3eNyqTOLCNfVZbZA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a844cc6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_4OTK6wLgNj2_ei1wbUA:9
X-Proofpoint-ORIG-GUID: q5VwfhcwuHWHHV2hVel3FZLbfRr8wiEA
X-Proofpoint-GUID: q5VwfhcwuHWHHV2hVel3FZLbfRr8wiEA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX1voXy6J1dmz/
 UT2yIdc6SjclnmuVCP+Ln7WhIRJ1OMisIv4v7xxWuFHq6aNJX5ZN4dULjDkfdzGFxxatsb+RruH
 tdDrIhLpOSghY7UJQkeNRF/Tgm5lo5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180088
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] memcg/memcontrol04: fix typos,
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
(PRIdPTR is for signed intptr_t, not unsigned size_t), fix 'dont not'
-> 'do not' in inline comment, and remove now-unused <inttypes.h>
include.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
v1 -> v2:
- Remove now-unused <inttypes.h> include (PRIdPTR was its only user)
- Split from combined memcontrol03+04 patch into separate patch per file

 testcases/kernel/controllers/memcg/memcontrol04.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 15d8f891c..22ca1df8c 100644
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
@@ -102,7 +98,7 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 
 	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
-	tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_anon(size);
 
@@ -122,7 +118,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 
 	SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
 
-	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
+	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %zu",
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_pagecache(fd, size);
 
@@ -227,7 +223,7 @@ static void test_memcg_low(void)
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
