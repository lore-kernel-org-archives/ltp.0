Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D50CD37B6
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 06:23:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2C43DC7CE
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 08:23:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394253CDA69
 for <ltp@lists.linux.it>; Wed, 13 May 2026 08:23:26 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF995200AFA
 for <ltp@lists.linux.it>; Wed, 13 May 2026 08:23:25 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D1jYHL3775689
 for <ltp@lists.linux.it>; Wed, 13 May 2026 06:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tFsG5ZY6Glj7aqxw1RCQRsp3UUqGbY9QCaB9DJHdm
 KA=; b=cFMbN+JNhn1+v/M54vQ9MC2RHQlND3ulw/fM7DxCm7TVx6fHj7s4102y4
 SlyOs215SSWMQw0TKf8u0+41kQIO94402Gvu5NWXRySgSzHQeTTPenymQX8TGKPr
 9PbhtNTsyMqloa7bYdhgDL3ZUBvL/XFc9S3ThBuBFB/Wx/XLS2puy6apKCprxE78
 P4CsashL5cnrBv85fR/Yey8awjfjhzG5AV5PaZm022KTVifTIhQsPei2Rxcw4vTe
 o9uHwwXGLpLjsnISH1HoQuf56noiPLFYv6C5EkhE/hA7rAY21+QfAUfHs72hxUFs
 qDBz5ulGjQ/BJqkr35oDfmd9lEKrw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6p2dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 13 May 2026 06:23:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D69Xni012179
 for <ltp@lists.linux.it>; Wed, 13 May 2026 06:23:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpfvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 13 May 2026 06:23:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64D6M4YB51052816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2026 06:22:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1169A20043;
 Wed, 13 May 2026 06:22:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FE6320040;
 Wed, 13 May 2026 06:22:03 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2026 06:22:03 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Wed, 13 May 2026 06:48:18 +0000
Message-Id: <20260513064818.1596754-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0418db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=PbOIB4diTmVM6Q8_:21 a=_lWdfTxEh9cA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=Bvbn2sn2poSNpGOXLE4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2MCBTYWx0ZWRfX2U03UCFsVkWy
 JXegZExHFZ4CoAF5amJu3UTOY1R2zItJoKNeRV/WlfJqh7K/6sbuT6pBzPevXH+q0vo8x0UeuCZ
 yv5ZeTVHtmiIeuwOR9OMJWNUEIop3FQy4Und4GGQ9KEDmEznv/6r5algPXCmITv+ahQWnsrsPWX
 Gx5sbys6DY/9GkzNCtCEUZB1442/2UF/mXXYKfXCL6n2uEliWUyefimBbOMt9mEep/EBUxeMDV3
 bKxnkZEoP5OFXzshuV8HaNFdlHBCclu3jGeZ0BPKHGyLJ5WYCx7DjFQIjd8KqZ0y2cUW8O/bu/n
 wQSk5kbUtEK/DVad0W6pz9KLRYvA79g1XNpd6145t/YkQBAxzOPKtk4LUxwG9kXX8eB1fEYeYrt
 hX7wPpu1Pl/WujrzSjSQiVTAir0ve2ZMiTYv/T8bkjKDCNyLdM0UK07DVL1zuf59c3my6qtaEOe
 peRpikFPF4k2kykceiw==
X-Proofpoint-GUID: wFn_z30jF0zFQVrUNJqLOhuV1gBezvvj
X-Proofpoint-ORIG-GUID: wFn_z30jF0zFQVrUNJqLOhuV1gBezvvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130060
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Patch:V2:creat07():Added new_behavior flag to detect
 kernel version > 6.11 : Tests that creat() succeeds (write to executed file
 allowed) Removed the old skip logic that did TCONF on kernel >= 6.11 Added
 one static variable exp_errno to store expected result: -1 means creat()
 should succeed ETXTBSY means it should fail with that errno setup() now
 sets exp_errno from kernel version Simplified verify_creat(): if expected
 is success, call creat(), close fd, print TPASS if expected is failure,
 use TST_EXP_FAIL2() for ETXTBSY Removed extra verbose kernel-info messages
 Removed exec of external child binary and replaced it with an in-process
 forked child using TST_CHECKPOINT_WAKE() + pause() Removed .resource_files
 from test
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>

Signed-off-by: lekshmi-cpillai <lepillai@linux.ibm.com>
---
 testcases/kernel/syscalls/creat/creat07.c | 38 ++++++++++-------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index c7b85ee69..f55bca2af 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -19,41 +19,41 @@
 
 #define TEST_APP "creat07_child"
 
+static int exp_errno;
+
 static void verify_creat(void)
 {
 	pid_t pid;
 
 	pid = SAFE_FORK();
-	if (pid == 0) {
-		SAFE_EXECL(TEST_APP, TEST_APP, NULL);
-		exit(1);
+	if (!pid) {
+		TST_CHECKPOINT_WAKE(0);
+		pause();
+		exit(0);
 	}
 
 	TST_CHECKPOINT_WAIT(0);
 
-	TEST(creat(TEST_APP, O_WRONLY));
+	if (exp_errno == -1) {
+		TEST(creat(TEST_APP, O_WRONLY));
 
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "creat() succeeded unexpectedly");
-		return;
+		if (TST_RET < 0) {
+			tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
+		} else {
+			SAFE_CLOSE(TST_RET);
+			tst_res(TPASS, "creat() succeeded");
+		}
+	} else {
+		TST_EXP_FAIL2(creat(TEST_APP, O_WRONLY), exp_errno);
 	}
 
-	if (TST_ERR == ETXTBSY)
-		tst_res(TPASS, "creat() received EXTBSY");
-	else
-		tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");
-
 	SAFE_KILL(pid, SIGKILL);
 	SAFE_WAITPID(pid, NULL, 0);
 }
 
 static void setup(void)
 {
-	if ((tst_kvercmp(6, 11, 0)) >= 0) {
-		tst_brk(TCONF, "Skipping test, write to executed file is "
-			"allowed since 6.11-rc1.\n"
-			"2a010c412853 (\"fs: don't block i_writecount during exec\")");
-	}
+	exp_errno = tst_kvercmp(6, 11, 0) >= 0 ? -1 : ETXTBSY;
 }
 
 static struct tst_test test = {
@@ -61,8 +61,4 @@ static struct tst_test test = {
 	.test_all = verify_creat,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
-	.resource_files = (const char *const []) {
-		TEST_APP,
-		NULL
-	}
 };
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
