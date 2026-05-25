Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB29BCD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 15:34:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CE633E52A7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:34:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8A943E1169
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:34:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EED86200205
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:34:03 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P3Sg4Y3789348
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hpS6cIV+b38+KjlguXQQaX99HbQYRpUbl76uwWoML
 Og=; b=apPEXtrsSdg9wYIDRw7LvJisDxS2nKKTt+6VjslrPbLA5SlQcT7WouFon
 WH2Ky1jP+QISyFSg8vwU7IN0rnPR8nl+j+wjNonX6ptebDqe1WEZrcfCuiipSAAC
 CBBWGHSRpRKUa1eT83E/nzjvCpvYVhTHf5VWdEFHGcG8V4SnPSjJsB4GQE0XThwz
 0CGL5y9OnNxoJNuoKq5RxDoPmpzEF/U1zYwY7pn2DSdOPj5uDuEFM7CsLhgx95yE
 +/hGnHIiIiDuuRRZx+NQau97Z7MBV4YsyPxCifRLBa1N8DhSSws69KIXHM7IaSay
 ur3UJun2h7NPfqebsfpbtZ1aDcVbA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pd7jaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:34:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64PFOAEQ015715
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:34:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjnnvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:34:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64PFXv6050397658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 May 2026 15:33:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 867A120040;
 Mon, 25 May 2026 15:33:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7986E20043;
 Mon, 25 May 2026 15:33:56 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.39.18.195]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 May 2026 15:33:56 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 21:03:52 +0530
Message-ID: <20260525153352.188816-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a146bea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZxxQnCxl6Fr_yrVozwkA:9
X-Proofpoint-GUID: NDgjY9izcquhtBGWLTNsF68zpIpiC4a8
X-Proofpoint-ORIG-GUID: NDgjY9izcquhtBGWLTNsF68zpIpiC4a8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE1NSBTYWx0ZWRfXzXFNgz5H9ezu
 J/XYMkRo3pMvop0VZrSiLhHSvst1TOv4vY8MoMFKYZOJH+VCm+vmaRnLx0CYTfgi77pAFqJoWNu
 B7BzUWemZARlPxfL3c1/DZC7+po9mV4OXpoNgCLnDU26iFUPzTNSQp+UoVZihQL+pn/gu9P8mkc
 32W5W6SvAuSoEinP0g6FpcpAHDeTyM88XyD8TlOAleFnEfcCyBHKFm95RAocm6Bg6bm476oDi3R
 KtwQz6UqG46PcTt65n8GQrD+SSMvdQjazl9K6QM8DNWTHATVeONTFZEysa9utXUJRyPtgjZOt6M
 a7B7AdUghJYTZbqAIfzvAVcMyuT02gM+PjNg474Y0323YQFTZXcOYaM+5VukVUMBUKH39SVVqjY
 gUu8qyEbRCOhpefKhSZnxqXpHVeBRHhS4Tpyifa4TFN8ay3tIhyRBJONeLYruYWi4gJGK6pAHQW
 GoGMv/2vX6G0KWLTyaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250155
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [PATCH V2] memcg/memcontrol04: Fix race in pagecache
 allocation measurement
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

The test was failing with memory.current values much lower than expected:
   TFAIL: (A/B/C memory.current=6684672) ~= 34603008
   TFAIL: (A/B/D memory.current=5373952) ~= 17825792

Root cause:
Child processes allocating pagecache were exiting immediately after
allocation (via tst_reap_children()), causing the pagecache to be
freed before the test could measure memory.current values.

Fix:
Modified alloc_pagecache_in_child() to keep children alive during test:
- Added TEST_DONE checkpoint for child lifecycle coordination
- Parent waits for CHILD_IDLE checkpoint before proceeding
- Child signals CHILD_IDLE after allocation and fsync
- Child waits for TEST_DONE to keep memory allocated during test
- Modified cleanup_sub_groups() to wake waiting children before cleanup
- Changed alloc_anon_in_child() to use SAFE_WAITPID() for specific child
- Added num_children_spawned tracking for accurate cleanup

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
v2:
  - Added num_children_spawned counter to track spawned children
  - Fixed cleanup_sub_groups() to wake correct number of children

Link to v2: https://lore.kernel.org/ltp/20260427171734.621893-1-pavrampu@linux.ibm.com/

v1:
  - Initial fix for child process lifecycle coordination
  - Added TEST_DONE and CHILD_IDLE checkpoint synchronization

Link to v1: https://lore.kernel.org/ltp/20260330050105.258630-1-pavrampu@linux.ibm.com/  
  
---
 .../kernel/controllers/memcg/memcontrol04.c   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 715cc5bcd..15d8f891c 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -45,9 +45,11 @@
 static struct tst_cg_group *trunk_cg[3];
 static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
+static unsigned int num_children_spawned;
 
 enum checkpoints {
-	CHILD_IDLE
+	CHILD_IDLE,
+	TEST_DONE,
 };
 
 enum trunk_cg {
@@ -67,6 +69,12 @@ static void cleanup_sub_groups(void)
 {
 	size_t i;
 
+	if (num_children_spawned > 0) {
+		TST_CHECKPOINT_WAKE2(TEST_DONE, num_children_spawned);
+		tst_reap_children();
+		num_children_spawned = 0;
+	}
+
 	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
 		if (!leaf_cg[i - 1])
 			continue;
@@ -88,7 +96,7 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 	const pid_t pid = SAFE_FORK();
 
 	if (pid) {
-		tst_reap_children();
+		SAFE_WAITPID(pid, NULL, 0);
 		return;
 	}
 
@@ -107,7 +115,8 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	const pid_t pid = SAFE_FORK();
 
 	if (pid) {
-		tst_reap_children();
+		num_children_spawned++;
+		TST_CHECKPOINT_WAIT(CHILD_IDLE);
 		return;
 	}
 
@@ -117,6 +126,11 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_pagecache(fd, size);
 
+	SAFE_FSYNC(fd);
+
+	TST_CHECKPOINT_WAKE(CHILD_IDLE);
+	TST_CHECKPOINT_WAIT(TEST_DONE);
+
 	exit(0);
 }
 
@@ -125,6 +139,7 @@ static void test_memcg_low(void)
 	long c[4];
 	unsigned int i;
 
+	num_children_spawned = 0;
 	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);
 	trunk_cg[A] = tst_cg_group_mk(tst_cg, "trunk_A");
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
