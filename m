Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F54DC5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 18:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C5C3CD32D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 20:49:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E3BD3CC708
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 20:49:37 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 355931400965
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 20:49:35 +0200 (CEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHVcV43306867; Tue, 18 Aug 2026 18:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gIQqtc7c9cZdT5Sd0fcf8wPrIJSd6CERA2/ghUzQV
 sI=; b=PRW9E6hkFV2gNA8uysYOd2iHvbHh+yj73T0HMjSfpJpPNa8xN3vt5Tc7f
 +RZC8QMuBeJ33clcBMKvixf2Qk7MgDshMIZliAMKwXSgY7s/ZSdpaaSAuewCr0ny
 qbthP9W42rleTdSQX6xU5Y1ZfRZSFzSPeJvbl5+PJgRACZ1jwxGBiMylRFSKMrjJ
 VLFYH5URuPz11kNejYCk278Kzw8uhaaRSEA6ns+Fdt15RQRaxF0Puhdr8QJWbESi
 kingAgZBFTu0ayiQKAdvLRNqjMWm0H5mgQHc0xXifWzxyLgPOtI4qtkQS2YQ9tCj
 4HAx7vYRv6nuSEWVPRKQEIz5f1rQQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqt7nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 18:49:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IIfPmc008944;
 Tue, 18 Aug 2026 18:49:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek4w6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 18:49:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IInTZD27459986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 18:49:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 558DA20043;
 Tue, 18 Aug 2026 18:49:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50FDD20040;
 Tue, 18 Aug 2026 18:49:28 +0000 (GMT)
Received: from ltcden9-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 18:49:28 +0000 (GMT)
From: Samir Mulani <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 18:48:00 +0530
Message-ID: <20260818131800.42931-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzNiBTYWx0ZWRfXzMPLkELSk979
 HiEBvITBZq3xXbTCo5TBEZ+Gf/e7eYGpvZUx/SY+gMV+a9IDdpsxEIAShyqO9YvaNOJCWgWKPuW
 pEp0C+/Rayae7cY8noTvbiAxzZ9x9LFNbn9fyvYhpMsN5tEZgwGk2aJ6im+9SWY3fXhQmxJWacy
 1bjOq7GRfM9nY8tn8OnhJl656l6gxk98MGmrHnqZONc0t1VGXkBloSfoaf3aMGjAGmMtXSjWjFv
 NdzxTG0UeNpyQRmXoaypAHTHMZfMibDbVNuN7Dl8Z3LXOjIDslHou3pjhkS9x073fYcrffYssGu
 yGDIDw5l2DpTe3IwuGMm3yO+fvtQL6n5Z5I52Bk9CN+pkzUR5Y59EUb0zVdZOHdUScWlBPyF3tn
 msC1R4Bid33qOQCaoZTdzrz9LbQbi3u3rfRTiQ/5DXK0/y5BOve2yue43F6ju5jB7hsgTH8ZkFk
 +bP8LOfVZy/YSrI0NHA==
X-Proofpoint-ORIG-GUID: q3fchAnKnkhY9kF_ML9Jm6NyJFieXKfJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEzNiBTYWx0ZWRfX+LpGhlpjnnWq
 u9s4whZyioGoGHIIdoZ3F0a7iC09KXp+1FKvy6OoNtvYsHwb1BjrFmjIguNjSzeSWcYj9/QDUFJ
 b5utDjmMFRwpeJxuC4+O7doig1EheHU=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84a93d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=9Wtqm9-jjMRE5o7Xd_sA:9
X-Proofpoint-GUID: ONHoeOwn6ZTzZ_mSjG4uszl7lEfgfjYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180136
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mem/hugetlb: use SAFE_SHMGET() and fix checkpatch
 warnings in hugeshmget
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
Cc: Samir Mulani <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace the manual shmget()/error-check/tst_brk() pattern in the
setup() functions of hugeshmget02 and hugeshmget05 with SAFE_SHMGET()
to align with LTP conventions and reduce boilerplate error handling.
Include "tst_safe_sysv_ipc.h" explicitly in both files to make the
SAFE_SHMGET() declaration directly visible.

In hugeshmget03, simplify the tst_brk() error message by removing
the "shmget #setup" string and replacing it with "shmget()" to avoid
embedding the function name as a plain string literal.

Also fix the following pre-existing checkpatch warnings across all
three files:
- hugeshmget02: remove unnecessary parentheses around pointer
  dereferences of tcases[i].skey
- hugeshmget02: fix continuation line alignment in TEST() call
- hugeshmget03: merge split string literals in tst_res() and
  tst_brk() calls into single strings
- hugeshmget05: merge split string literal in tst_res() call into
  a single string


Signed-off-by: Samir Mulani <samir@linux.ibm.com>
Reviewed-by: Li Wang <wangli.ahau@gmail.com>
---
Patch v2: https://lore.kernel.org/ltp/20260412141039.1075095-1-samir@linux.ibm.com/
Patch v1: https://lore.kernel.org/ltp/20260407054943.125260-1-samir@linux.ibm.com/

 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c  | 15 +++++++--------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c  | 12 +++++-------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c  | 11 +++++------
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index bbd968c06..c1fd41509 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -12,6 +12,7 @@
  *	04/2004 - Updated by Robbie Williamson
  */
 #include <limits.h>
+#include "tst_safe_sysv_ipc.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -41,19 +42,19 @@ static void test_hugeshmget(unsigned int i)
 	int shm_id_2 = -1;
 
 	if (*tcases[i].skey == -1) {
-		shm_id_2 = shmget(*(tcases[i].skey), 0, 0);
+		shm_id_2 = shmget(*tcases[i].skey, 0, 0);
 		if (shm_id_2 != -1)
 			shmctl(shm_id_2, IPC_RMID, NULL);
 	}
 
-	TEST(shmget(*(tcases[i].skey), tcases[i].size_coe * shm_size,
-					tcases[i].flags));
+	TEST(shmget(*tcases[i].skey, tcases[i].size_coe * shm_size,
+		    tcases[i].flags));
 	if (TST_RET != -1) {
 		tst_res(TFAIL, "shmget succeeded unexpectedly");
 		return;
 	}
 
-	if (TST_ERR != tcases[i].error) {
+	if (tcases[i].error != TST_ERR) {
 		tst_res(TFAIL | TTERRNO,
 			"shmget failed unexpectedly, expected %s",
 			tst_strerrno(tcases[i].error));
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
index 0e9c7d5f0..8a5e2708d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -37,8 +37,8 @@ static void test_hugeshmget(void)
 	if (TST_ERR == ENOSPC)
 		tst_res(TPASS | TTERRNO, "shmget failed as expected");
 	else
-		tst_res(TFAIL | TTERRNO, "shmget failed unexpectedly "
-				"- expect errno=ENOSPC, got");
+		tst_res(TFAIL | TTERRNO,
+			"shmget failed unexpectedly - expect errno=ENOSPC, got");
 }
 
 static void setup(void)
@@ -64,15 +64,13 @@ static void setup(void)
 	while (shm_id_1 != -1) {
 		shm_id_arr[num_shms++] = shm_id_1;
 		if (num_shms == MAXIDS)
-			tst_brk(TBROK, "The maximum number of "
-				 "shared memory ID's has been reached. "
-				 "Please increase the MAXIDS value in "
-				 "the test.");
+			tst_brk(TBROK,
+				"The maximum number of shared memory ID's has been reached. Please increase the MAXIDS value in the test.");
 		shm_id_1 = shmget(IPC_PRIVATE, shm_size,
 				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	}
 	if (errno != ENOSPC)
-		tst_brk(TBROK | TERRNO, "shmget #setup");
+		tst_brk(TBROK | TERRNO, "shmget()");
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 336319603..de96d9824 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <limits.h>
+#include "tst_safe_sysv_ipc.h"
 #include "hugetlb.h"
 
 static size_t shm_size;
@@ -53,8 +54,8 @@ static void do_child(void)
 	if (TST_ERR == EACCES)
 		tst_res(TPASS | TTERRNO, "shmget failed as expected");
 	else
-		tst_res(TFAIL | TTERRNO, "shmget failed unexpectedly "
-				"- expect errno=EACCES, got");
+		tst_res(TFAIL | TTERRNO,
+			"shmget failed unexpectedly - expect errno=EACCES, got");
 }
 
 void setup(void)
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
