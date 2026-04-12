Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A12AE937E1
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 14:13:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019C83E294E
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 16:13:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECF7B3D024C
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:12:49 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4A23A200348
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:12:46 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63C2OWkk987509; Sun, 12 Apr 2026 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zzeLs63ZRH+SUKL0pnPJZGOl3t+5uEAVQv21zhcvc
 Jo=; b=hEj+SPS+VKAdyby0IYSvdnhZ3/Ty88/CaZ0/eZBksoN061SCuZBnXyoi0
 fxrDC8t2DFv9rEoJ92LrnruM/eoj8AfS0m5Kmm/6C7qCdqAX+AiPUeMu04SuHGLd
 Xa0IprXrCNoHLYV1mQUQrZW+xBRBNkxX5v3S53HYXjlMbVdrfU6BFiGSIggj98IO
 pglkeGoR5shB1ojmOewO5w/+4m2Tv5sJSdAzD14afXACdela/aM5XAMCoBMrC8s1
 FXo+oNHRglE2R4p+lKX3pAbEUrs5rbwxwQ6zVTVjtD1KW9YxmpIceV1OzkHoYOfw
 qwKmV0K4ob/JYUugtFI+2VxF2AHLg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17m41m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 14:12:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63C9aDek025621;
 Sun, 12 Apr 2026 14:12:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2uj9fvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 12 Apr 2026 14:12:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63CECgrR48496898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 12 Apr 2026 14:12:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 503342004B;
 Sun, 12 Apr 2026 14:12:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59A8320043;
 Sun, 12 Apr 2026 14:12:41 +0000 (GMT)
Received: from ltcden9-lp1.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 12 Apr 2026 14:12:41 +0000 (GMT)
From: Samir <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 12 Apr 2026 16:10:39 +0200
Message-ID: <20260412141039.1075095-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDEzNSBTYWx0ZWRfX0ZNIuxZSVelc
 26JEjopSnJCVivd/nF6ZxewWS4e0LfvHV4Qqs2uatAcieX09GYSO1Xhk4C11JIL1sZDe43A3flj
 dKxVRrkw+tPYoRvsPqXAD1y1Z4VRCm+qEwcyQa2dGxDh3YYWvhgL1IK8jh5eCLqsrHVwTHKxYfv
 KdaCtP6IcpBuYJmoJo97M4XGVmGAmgR51GIOVXfXv84TWC142RmZfLK/aYcQcul7Fa2jXZNQNbX
 ZGSuuFPjlaa4MTDVOSgkTZCIRWWMS2Fj646AU9gnH08nJx0/QYjxHvy8c9YZ6eFm2X+norK0iH1
 NMvOZ1vmR2lgC+hWaFRAdrfjqLyXrf9iKJ6EngRbC+Gj1s1CGzKpcqLUO31/L0evyUYvCqivQD6
 PBeIkgBRURUFDfLFJpNifIWTtxIwqLAMuIWkmoQN0NgZAANmM4J4P2PXNrBypNYTJ9zmMWXAFMK
 MnuvHuWFbph+/xEkecA==
X-Proofpoint-ORIG-GUID: 4oYEP5MRX_UduRlrOP4OSnFFesvypL3o
X-Proofpoint-GUID: 4oYEP5MRX_UduRlrOP4OSnFFesvypL3o
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dba85c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yhrbMPq3iphc3UI8JUQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120135
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mem/hugetlb: use SAFE_SHMGET() in hugeshmget setup
 function.
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
Cc: Samir <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I updated hugeshmget02.c and hugeshmget05.c to use SAFE_SHMGET() and configured the setup paths
so that shared memory allocation succeeds as expected.

In hugeshmget03.c, I also simplified the tst_brk() message by removing the unnecessary
__func__ usage and keeping a straightforward shmget() error message.

Patch v1: https://lore.kernel.org/ltp/20260407054943.125260-1-samir@linux.ibm.com/

Signed-off-by: Samir <samir@linux.ibm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c | 7 +++----
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c | 2 +-
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c | 7 +++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index bbd968c06..f808ac193 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -12,6 +12,7 @@
  *	04/2004 - Updated by Robbie Williamson
  */
 #include <limits.h>
+#include "tst_safe_sysv_ipc.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -77,10 +78,8 @@ void setup(void)
 
 	shmkey = getipckey();
 	shmkey2 = shmkey + 1;
-	shm_id_1 = shmget(shmkey, shm_size,
-			  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
-	if (shm_id_1 == -1)
-		tst_brk(TBROK | TERRNO, "shmget #setup");
+	shm_id_1 = SAFE_SHMGET(shmkey, shm_size,
+			      SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 625761f6e..0e8ad16fc 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -73,7 +73,7 @@ static void setup(void)
 				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	}
 	if (errno != ENOSPC)
-		tst_brk(TBROK | TERRNO, "shmget #setup");
+		tst_brk(TBROK | TERRNO, "shmget()");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 336319603..b34c93a08 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
+#include "tst_safe_sysv_ipc.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -69,10 +70,8 @@ void setup(void)
 	shm_size = hpage_size * tst_hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
-	shm_id_1 = shmget(shmkey, shm_size,
-			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id_1 == -1)
-		tst_brk(TBROK | TERRNO, "shmget #setup");
+	shm_id_1 = SAFE_SHMGET(shmkey, shm_size,
+			      SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 
 	/* get the userid for a non-root user */
 	ltp_uid = getuserid(ltp_user);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
