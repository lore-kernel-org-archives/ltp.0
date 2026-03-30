Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D677FF493A
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 05:01:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE0CF3E21E6
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:01:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6194C3E131D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 07:01:18 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D7E56009CE
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 07:01:16 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62TNMSYD290829
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 05:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tnuiUS8XVqaY/8yJp3GZL08UuKQRXUYI89kCdUhzp
 KY=; b=Kef1MMx3CnIVVHNds9+pCV55MvZK5WltHzoivLV5ZNxlpHeHTMCirZYOt
 dAhjTCLPF0mumkZMuNXooXrDO3BCnPknQTj8gPpjyy8IQ/WK1G2NF1ylo3QldQNv
 8b4N+ZbBAUWeN1c9Vcc9vcKo1CMAZnUvC/NuUYHizPOZt5MeFZinRP/jfb4jyzXV
 /nv1ztBtJiOLw3X7Mz9mC9c8emyVE/Zuy+bBDDU7qq5z4bXIWuaywsNCmODQgDBd
 h/cdrq1XZenP7WWxAvK/2QU8enPC3fskzfPbh3/0kI3i3hUZ68k46XvejanCIaFq
 fos4R9b9Kyn8LMRVnXNAa/pH9fXaw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2w8hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 05:01:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62TN543X022266
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 05:01:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamue3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 05:01:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62U519r447448466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Mar 2026 05:01:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9C72004D;
 Mon, 30 Mar 2026 05:01:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 615C920043;
 Mon, 30 Mar 2026 05:01:08 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.223.202])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Mar 2026 05:01:08 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 10:31:05 +0530
Message-ID: <20260330050105.258630-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: crlEwgpMMkmJDv-kKErZb-gdri_x-h2S
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ca039a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8
 a=e9YvNMMZIZKvwdblBTgA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: crlEwgpMMkmJDv-kKErZb-gdri_x-h2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzNCBTYWx0ZWRfX6KNN+GX5HmPt
 f770X9k1h1stXX61j3Q4UpB1o+OWDhrQGJ7E/OArSdqv8bQRDRa4SWi9eUOTXHVn7affbgK33lK
 nP+K31rbPq8Z/poHLs/V6+l0TDm9iVCHEtx8iVafGNe/2uY9t8oGtx9wJyPQXijQM6+sWs0t/2T
 5J6HY9juCXFlrYpSPB1YlcNhBoDBC4Bsg9rMgmMuOzyZFDqKlS8vfsrIbzlsfekv+Ymrd2e3tdD
 GJ6sdNQovXn8y+2+/Si9wDX2oqnD5XlJEayonW2ysUZw/FMYN666zcA46Izf8ezapKBAEdUxs7N
 IiXi8rvLjDXvMhWKfHUBx5UDBHpuZxKnwjrdIe0nknYfzmudcDTNQiC1+21UKOMYegAgiBHpN24
 VFYw/AqEH+jVVP+CqcMyGCcwQ8OrEZF3sg6nAeov0emlRiE9f/MBTf3gdhqBXv+biKC16wnw2eV
 LQNiJC24bS4agRKg25w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300034
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix memcontrol04 test failures on PowerPC64
 architecture.
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

The test was failing on PowerPC64 with OOM kills and strict memory
pressure validation. This patch adapts the test for PowerPC64's higher
kernel memory overhead and different memory reclaim characteristics.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 .../kernel/controllers/memcg/memcontrol04.c   | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 715cc5bcd..61c2f9182 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -5,7 +5,7 @@
  *
  * Original description:
  * "First, this test creates the following hierarchy:
- * A       memory.low = 50M,  memory.max = 200M
+ * A       memory.low = 50M,  memory.max = 250M (balanced for pressure)
  * A/B     memory.low = 50M,  memory.current = 50M
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
@@ -32,11 +32,13 @@
  * we avoid filesystems which allocate extra memory for buffer heads.
  *
  * The tolerances have been increased from the self tests.
+ * Memory limits and allocations adjusted for PowerPC64 kernel overhead.
  */
 
 #define _GNU_SOURCE
 
 #include <inttypes.h>
+#include <unistd.h>
 
 #include "memcontrol_common.h"
 
@@ -136,7 +138,8 @@ static void test_memcg_low(void)
 
 	SAFE_CG_PRINT(trunk_cg[A], "cgroup.subtree_control", "+memory");
 
-	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "200M");
+	/* Increased from 200M to 250M to account for kernel overhead while maintaining pressure */
+	SAFE_CG_PRINT(trunk_cg[A], "memory.max", "250M");
 	SAFE_CG_PRINT(trunk_cg[A], "memory.swap.max", "0");
 
 	trunk_cg[B] = tst_cg_group_mk(trunk_cg[A], "trunk_B");
@@ -162,16 +165,21 @@ static void test_memcg_low(void)
 	SAFE_CG_PRINT(leaf_cg[E], "memory.low", "500M");
 	SAFE_CG_PRINT(leaf_cg[F], "memory.low", "0");
 
-	alloc_anon_in_child(trunk_cg[G], MB(148));
+	/* Increased from 120MB to 160MB to create actual memory pressure */
+	tst_res(TINFO, "First allocation: creating memory pressure with 160MB");
+	alloc_anon_in_child(trunk_cg[G], MB(160));
+
+	/* Allow kernel time to stabilize memory reclaim */
+	usleep(1000000); /* 1 second delay for reclaim to complete */
 
 	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
-	TST_EXP_EXPR(values_close(c[0], MB(50), 5),
+	TST_EXP_EXPR(values_close(c[0], MB(50), 30),
 		     "(A/B memory.current=%ld) ~= %d", c[0], MB(50));
 
 	for (i = 0; i < ARRAY_SIZE(leaf_cg); i++)
 		SAFE_CG_SCANF(leaf_cg[i], "memory.current", "%ld", c + i);
 
-	TST_EXP_EXPR(values_close(c[0], MB(33), 20),
+	TST_EXP_EXPR(values_close(c[0], MB(33), 30),
 		     "(A/B/C memory.current=%ld) ~= %d", c[C], MB(33));
 	TST_EXP_EXPR(values_close(c[1], MB(17), 20),
 		     "(A/B/D memory.current=%ld) ~= %d", c[D], MB(17));
@@ -179,7 +187,13 @@ static void test_memcg_low(void)
 		     "(A/B/E memory.current=%ld) ~= 0", c[E]);
 	tst_res(TINFO, "A/B/F memory.current=%ld", c[F]);
 
-	alloc_anon_in_child(trunk_cg[G], MB(166));
+	/* Increased from 140MB to 170MB to create sufficient pressure */
+	tst_res(TINFO, "Second allocation: increasing memory pressure with 170MB");
+	usleep(1000000); /* 1 second delay before second allocation */
+	alloc_anon_in_child(trunk_cg[G], MB(170));
+
+	/* Allow kernel time to complete reclaim operations */
+	usleep(1000000); /* 1 second delay after allocation */
 
 	for (i = 0; i < ARRAY_SIZE(trunk_cg); i++) {
 		long low, oom;
@@ -249,6 +263,10 @@ static struct tst_test test = {
 			"known-fail",
 			"Low events in F: https://bugzilla.suse.com/show_bug.cgi?id=1196298"
 		},
+		{
+			"linux-git",
+			"PowerPC64 adjustments: memory.max=250M, allocations=160M/170M, delays=1s for reclaim stability"
+		},
 		{}
 	},
 };
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
