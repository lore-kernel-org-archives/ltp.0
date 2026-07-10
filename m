Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C16C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:15:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79DC33E5BBE
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 11:15:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5BE3C036C
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:14:45 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D234A1A00CC1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 11:14:44 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7mRXp3742702
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+nmxvAFHDdKkJSriXyYd5kdpqWbvUY3pzUuV34qy0
 vk=; b=P3MwO4AWeozbzM0w4ZTXMupoghAMZNPPLjvkrC207ocDJXhHDwaV3TVWQ
 DnUBk5vfIrThC9ErL5+u3Ci2feBnRyPzrdKY+Ia+khJP6Vj2/d2vQK53XApNpFhx
 3Ad9Yr+G670IXIw6/ML+xbHnSql6OM15unw/M5P40+a8acWek2nZ2dLJMCpBLwDm
 YOfuFzTJnPX5OPX+YNrAMptk3IreUrr9AkgrNfsdH6MIklvYgrXvpXkJO8hPhC+u
 VH7HQuKg6fpKUKEA9wDeKGoig9GxeC6OKiib7Y2GCQgmWiGj+61T5f6w+mnzKzU5
 NVECFtOdy2+RQ1ZhI2T4+ckOiglGQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt63sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A94pPo028761
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwhfx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A9EdG848890218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 971C62004D
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42FC20040
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.124.87])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:14:38 +0000 (GMT)
From: Sachin Sant <sachinp@linux.ibm.com>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 14:44:36 +0530
Message-Id: <20260710091437.92148-1-sachinp@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PtD0fYKG7KEBt1eci9NkBIDtgj7ZkaXm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX2q4ncnUikPNL
 Uojl5S72sEYTUK7nm4RdGU8aIaw1R7gLEP8l1CXkTNs4RitUYlYwE+oYtPZQww2oCeYP1z/hL1R
 Cqmt5V2u8jaC24reEfmN1JgOxEhzR1E=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a50b802 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=p6csepz9IMAN-DVo89AA:9
X-Proofpoint-GUID: PtD0fYKG7KEBt1eci9NkBIDtgj7ZkaXm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX6/XvBLRf9nsr
 AusXhGds41ir9I0ywipXwcbmHytORJiY2RBhWv+w3tqYYFvbECX1kcXrPGyOIaVfKWcyU0i7XKT
 Y+UruNXS2bHqopBlXQavBhh5gkKf1Rar73+8nw+RkVvD6i28O9n8bnmZuNx2qXctshpmUGXVUHC
 RtLvkq0RcaGvI7nTu1VP4/uNBGDMWUG730AwzG3Zam5PAIrAPytqmHpM91qS+rgzYA+t8HZf9JP
 Jh5ISrwwHWdU7uN2GnldKNeRe5JjCCVIQ0zUT2zdzUABTSye08sirJ/9we1zBsRrZ6oBsg86TDb
 ipObqEM42dgsVaGSOj4LXzNnGM1ZhsJmQHrlLRG+Dt6a6mAxU383aiS0cGeZgbSs8xZmsYvFbxF
 LnJE+Ii7K/v+aSXgDA1jj9mHQG+wuUVl3BTmsnfbK0xnglFNGajymzYiCivrxDyicxp+uAnBCQx
 LVw6F0cLFHXbR7UtR/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100085
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] mem/min_free_kbytes: fix comment typo and
 whitespace alignment
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix the typo '%2 MemTotal' -> '2% MemTotal' in the file header comment.
Remove spurious leading spaces from continuation lines in tst_res()
calls and remove unnecessary braces around a single-statement if body,
bringing the file in line with LTP coding style.

Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index bdc9126c2..b1d00e453 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -17,7 +17,7 @@
  *
  * 1. default min_free_kbytes with all ``overcommit_memory`` policy
  * 2. 2x default value with all ``overcommit_memory`` policy
- * 3. 5% of MemFree or %2 MemTotal with all ``overcommit_memory`` policy
+ * 3. 5% of MemFree or 2% MemTotal with all ``overcommit_memory`` policy
  *
  * [References]
  *
@@ -114,7 +114,7 @@ static void test_tune(unsigned long overcommit_policy)
 		if (overcommit_policy == 2) {
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_res(TFAIL, "child unexpectedly failed: %s",
-					 tst_strstatus(status));
+					tst_strstatus(status));
 		} else if (overcommit_policy == 1) {
 			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
 #ifdef TST_ABI32
@@ -122,20 +122,19 @@ static void test_tune(unsigned long overcommit_policy)
 				if (total_mem < 3145728UL)
 #endif
 					tst_res(TFAIL, "child unexpectedly failed: %s",
-						 tst_strstatus(status));
+						tst_strstatus(status));
 #ifdef TST_ABI32
 				/* in 32-bit system, a process allocate about 3Gb memory at most */
 				else
 					tst_res(TINFO, "Child can't allocate "
-						 ">3Gb memory in 32bit system");
+						">3Gb memory in 32bit system");
 			}
 #endif
 		} else {
 			if (WIFEXITED(status)) {
-				if (WEXITSTATUS(status) != 0) {
+				if (WEXITSTATUS(status) != 0)
 					tst_res(TFAIL, "child unexpectedly failed: %s",
 						tst_strstatus(status));
-				}
 			} else if (!WIFSIGNALED(status) ||
 				   WTERMSIG(status) != SIGKILL) {
 				tst_res(TFAIL, "child unexpectedly failed: %s",
@@ -182,7 +181,7 @@ static void check_monitor(void)
 
 		if (memfree < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
+				"min_free_kbytes is %lu kB", memfree, tune);
 			tst_res(TFAIL, "MemFree < min_free_kbytes");
 		}
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
