Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A45FF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A33423E28AF
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 19:18:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EE273D0338
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 19:17:47 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98FB1600348
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 19:17:46 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RE0AaJ3076657
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pOoThPiGeEU/6PGcavVAnaSJ9nVK4euDi8TAD4siJ
 CM=; b=BaF95RkBAav1DKyJ3oqfdMZeP2135trA06NzD80jM+qcFdxaoz0O0joAM
 6J60+ld7sDhHhhZm73VxMxj9Z2AI5xYA4vZPwlVRhmE871FUbcWDZMZbagVPKANS
 OLJQKwUg+dyejN77ypR22WNPRKnPvAi2wzb1m4vZO2hSDOZjRFVxkM4AYa95/1Mq
 vOGaqVvhSNtjd3j5WA8WfTsl6q8Z7PkRJCEEnZ8O/U8WSJj59PrgS/gbJkCJozT6
 epS0+iT+UHrJQ7dVFpXBrCS5zGbnMOnKlWevvmYiveNkqia8tgFyniTux9WJpddf
 dp/iJVStr04ZotNgh8IRJ1Jh05fLA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44hrs8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:17:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RH8qHA003073
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:17:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avpa32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 17:17:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RHHd6b38535486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 17:17:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CB8E20040;
 Mon, 27 Apr 2026 17:17:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF82F20043;
 Mon, 27 Apr 2026 17:17:37 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.220.170])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 17:17:37 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 27 Apr 2026 22:47:34 +0530
Message-ID: <20260427171734.621893-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lu7qWg5LtHzCS8HKYRt4xsyKbcIxUFro
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69ef9a38 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=41JfSkleQcHGdEibQjgA:9
X-Proofpoint-GUID: Lu7qWg5LtHzCS8HKYRt4xsyKbcIxUFro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfX1QIqEXB/oS/Q
 U69a6Icsj6OXnrzG6h5Pl06ExLAkTkXTaV+d1JcwVXQ7OhsfJwDR5MiiJ5izk/0+IY5iZAtT57z
 WxWuAIwWIn09Az0nIcGSZdsqg0C+JwIydzCxpJ02TVWMTfqaun++BTpbkwdVk9L6WN0jn4Anse/
 5AQFWX49kzesEzqJzkeg0Wc+S+SmC9f+i9iis51dFLyXJyQmWNkcbxejfNc0BPOPq4ifJe9G0/p
 UozHSXZ2ThGLQ/Bu++3mDHFR2JA/TjQtMGECR7WGtOGBxSF8l5sEUHrnriiNMf+Yo9wOE5vzJr6
 hjmn581jzmrojXmmo88loJki/7hifp9IWuYRfJAqYrJ89MSHKAZ6ftnXIDbOOFlnAX73VUEgoLj
 FXSNOlcG4zO/W40TysbtXbzpC3o/BcqY/jRvjgR+Hqa29e9Q0/DZpxMDdVZc0ExyIzaEOM1jkPH
 2VhgyqKzsEsOEn+oKZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270184
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcontrol04: Fix test failure by keeping pagecache
 children alive
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

This matches the pattern used in memcontrol03.c and ensures pagecache
remains allocated during memory pressure testing, allowing correct
memory.current measurements.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>
---
 .../kernel/controllers/memcg/memcontrol04.c   | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index 715cc5bcd..d0188a1da 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -47,7 +47,8 @@ static struct tst_cg_group *leaf_cg[4];
 static int fd = -1;
 
 enum checkpoints {
-	CHILD_IDLE
+	CHILD_IDLE,
+	TEST_DONE,
 };
 
 enum trunk_cg {
@@ -67,6 +68,16 @@ static void cleanup_sub_groups(void)
 {
 	size_t i;
 
+	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
+		if (!leaf_cg[i - 1])
+			continue;
+
+		TST_CHECKPOINT_WAKE2(TEST_DONE,
+				     ARRAY_SIZE(leaf_cg) - 1);
+		tst_reap_children();
+		break;
+	}
+
 	for (i = ARRAY_SIZE(leaf_cg); i > 0; i--) {
 		if (!leaf_cg[i - 1])
 			continue;
@@ -88,7 +99,7 @@ static void alloc_anon_in_child(const struct tst_cg_group *const cg,
 	const pid_t pid = SAFE_FORK();
 
 	if (pid) {
-		tst_reap_children();
+		SAFE_WAITPID(pid, NULL, 0);
 		return;
 	}
 
@@ -107,7 +118,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 	const pid_t pid = SAFE_FORK();
 
 	if (pid) {
-		tst_reap_children();
+		TST_CHECKPOINT_WAIT(CHILD_IDLE);
 		return;
 	}
 
@@ -117,6 +128,11 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
 		getpid(), tst_cg_group_name(cg), size);
 	alloc_pagecache(fd, size);
 
+	SAFE_FSYNC(fd);
+
+	TST_CHECKPOINT_WAKE(CHILD_IDLE);
+	TST_CHECKPOINT_WAIT(TEST_DONE);
+
 	exit(0);
 }
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
