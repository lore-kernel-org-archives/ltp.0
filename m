Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D253C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DD013E7039
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 15:06:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDC063E20F7
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:05:53 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0418D60012A
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:05:52 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677ClqB31420153
 for <ltp@lists.linux.it>; Fri, 7 Aug 2026 13:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0vSAcOZNtSYBm15ZUJ3NCIlwCfWRdax6vX5V+LIaA
 fQ=; b=pKWsTJGDxvuJwxHF68Cbvdkw+Ki/W0QazmcQG/IoDTl8xgQFFEk8R3vXs
 soRD6I9h85lqxkRLChlGXpEKyGT/6weQr3M0H1CfO47t7vUy66ulJvwj4/to541t
 JFlKifcbVRiBY+lGf/O/0lMc5iPmAXZtY3s33/c340wYwQs1PLSR6kRONney2mPq
 71q6eGJOZal2mhSkBzemKqEEWb6LZA+OQ9kosfxN58/WhWxC1tlSwjqX0nJunJHI
 AkNEXsZlUznX4MhbGAJufGXBAz9fUEh2iPI7aeUHjNX8PN8tZXeJBraqVC+cAanH
 Uy3/BFPk0mtvWj3zrIwyQjV+45R3A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy023uwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:05:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CuHSM018757
 for <ltp@lists.linux.it>; Fri, 7 Aug 2026 13:05:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqptt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 13:05:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677D5kkd31785228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 13:05:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC4B2004E;
 Fri,  7 Aug 2026 13:05:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0668120040;
 Fri,  7 Aug 2026 13:05:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.215.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 13:05:44 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri,  7 Aug 2026 18:35:21 +0530
Message-ID: <20260807130523.49068-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iYBzEsCUrhInYapuIcTA-wA1JqtVyg6r
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75d82f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=y7OvGzmH0rteZBCWca8A:9
X-Proofpoint-GUID: iYBzEsCUrhInYapuIcTA-wA1JqtVyg6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXwZveGgnkY26z
 QzjRTjlVOaK0Vrh3m8GgtED0TZA7NLhDS1UJREkOKZHQsZ+7XHEA6w6GQgk0cr3CcIn3N3QFpIz
 qyKAme65rlnOg1m2087FLMAEdVH/4Ub8Actz5OvlGOEpnH7sgiN4TxFP2cWP7bTzAt0zw1kmBuk
 I6FRyABxiFHY+Jc61c4pUFxXqkKjn20qSfSPIhRLpTRda7/V99i/RqD4en2wSXSU42hlsoD/C8t
 Di6JKp7wrNjnD24LoxZTTyGtcGYgVPoOZle7vq9k4GHTOvfcUI7LU6EkGwWP+zHTmJJC4tXCDZs
 UiEpqtCZ6FH6HsyDiBaag3XgI3E+V7R3Cvkim9YfvcgUGuIVXeYt6jUvyvTEH3adwDIqvLj0TWb
 dEVNJgxx/oMei4YDD5/enOWG2z5yY6tXFLR5cYugvQtUpaL8fA1+tXIq4x+gKrRFM7y5SYYa+9f
 w5HKELwxBj5QHDO8cyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfX+WlMzQFQ526/
 S2laE4BrGZKq47NGUz4vAPC4XmqhFcAZzyNy4cf8UwIddSJrN9iTzjm6dxfrURCmP6A1PTQEfsz
 igBOkOgXioORR5mEWRliCEC8r0UWbnQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1011 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070100
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] memcg/memcontrol02: fix fd leak in cleanup path
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

fd is initialized to 0 (a valid file descriptor) so the cleanup()
guard 'if (fd > -1)' would never trigger. Initialize to -1 and
add SAFE_CLOSE to prevent the descriptor leaking when a SAFE_*
macro calls tst_brk() during the pagecache allocation test.

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 testcases/kernel/controllers/memcg/memcontrol02.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 0b79403c9..75a1e6d51 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -29,7 +29,7 @@
 
 static size_t page_size;
 static struct tst_cg_group *cg_child;
-static int fd;
+static int fd = -1;
 static int file_to_all_error = 10;
 
 static void alloc_anon_50M_check(void)
@@ -128,6 +128,8 @@ static void cleanup(void)
 {
 	if (cg_child)
 		cg_child = tst_cg_group_rm(cg_child);
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
