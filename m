Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B483F34C78
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 17:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C3E73E2E19
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 19:43:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C37F3C6EE3
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 19:42:56 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C844B2005DC
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 19:42:55 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DFaKLh3309467
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=zxe/MDbv8szFId/GCoY+viqpDFcQkl0OuseK3HSG1
 qs=; b=M7vK50irVX2IxL2nu41CIdAeQCt5IdzhvCsbWPPgT9uY2qpdIIDEmsN75
 ejLswvpbvGmqNdm6oz3qBQD/XXSgCHlpsybmf1L6yeIILVty2L1VwpZEk48AdzFc
 9w6PmVmjH97G7oJIH7I5/dCRrvAFlPMYA7ruKUdXlri5auJ8e9Xd8++3ul1OZkmD
 O98IwTzvMs2yBetTWY0UHuhCLX98qjml2sxaLSh4YrcP1aMLSutP6qA02gbmPpSE
 SydHCXLPysGgQiFN9cK2SkaNZTURyVoQkG3617WAc+v8RCwJoC6EbptMkZZHvEq3
 j6U4gPdjkSL0BNKrmQD7QmDfyj9Ow==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxx0gyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:42:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DEMo3J025837
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:42:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2uje1bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:42:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63DHgprP20382240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 17:42:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCEA758063;
 Mon, 13 Apr 2026 17:42:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C8AB58055;
 Mon, 13 Apr 2026 17:42:51 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 17:42:51 +0000 (GMT)
From: Soma Das <somadas1@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon, 13 Apr 2026 18:07:25 +0000
Message-Id: <20260413180725.411367-1-somadas1@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3MCBTYWx0ZWRfX6HVsTCFU+a49
 WhsGqc5i3thJ11HIFjd1BxxsitEl5MhzEZSuCr9INpWRtMBD0xxrWE+Fqn/7eTqNEEHotYBjQ98
 LnEpTafxFzozpa8f8ZLBVs+K9WgoF1cP5c03M/G2l6YxELm5EtJ8VTe1mL+N+eDMHvYNgt2HEjS
 aRcrXTpNJkElSZ3UE6bMMLqsHx81TuMKukzlS2KHYCBjp6caG/bHyTp8rCSIQ0inpqGEQuvcePy
 ySmV9P3ppWZ4Np5PEeRQc1XaCLCpmU+Bt9tJCd9CytQ+Jh82dLVh/DoNMpZadEcbQAdQxHOGESt
 th3uLMSEr7MIZRUSeQCAVjCHZXlrX7COFfGFkTrHcvKpEBKMb7SZK0W9Xmtu8LcF9NFz4jvCgx9
 eAorEcweBnEQ+LyQh+Xozj2itU5t2rGNp9ZhumUk12d2PQD6MHnUFgDUIOKz2SFygIlaD4knxFX
 q/vK7PIPV2w0jNu7vtQ==
X-Proofpoint-ORIG-GUID: qHinwXaPqrorczlCgb7GOuQIRRcb22Vf
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69dd2b1d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vnwhZ7JpDF0lGcMctGQA:9
X-Proofpoint-GUID: qHinwXaPqrorczlCgb7GOuQIRRcb22Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130170
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mq_unlink01: fix EEXIST failure when run in parallel
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
Cc: somadas1@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When executed with -w N, all workers share the hardcoded
"/test_mqueue" queue name. The second worker to reach
SAFE_MQ_OPEN(O_CREAT|O_EXCL) finds the queue already exists
and aborts with TBROK: EEXIST.

Fix by generating a per-process queue name using getpid(),
matching the approach used in mq_timedreceive01.

Signed-off-by: Soma Das <somadas1@linux.ibm.com>
---
 testcases/kernel/syscalls/mq_unlink/mq_unlink01.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
index baca57948..1cfffb083 100644
--- a/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
+++ b/testcases/kernel/syscalls/mq_unlink/mq_unlink01.c
@@ -14,10 +14,9 @@
 #include "tst_test.h"
 #include "tst_safe_posix_ipc.h"
 
-#define QUEUE_NAME	"/test_mqueue"
-
 static uid_t euid;
 static struct passwd *pw;
+static char queue_name[64];
 
 struct test_case {
 	int as_nobody;
@@ -28,13 +27,11 @@ struct test_case {
 
 static struct test_case tcase[] = {
 	{
-		.qname = QUEUE_NAME,
 		.ret = 0,
 		.err = 0,
 	},
 	{
 		.as_nobody = 1,
-		.qname = QUEUE_NAME,
 		.ret = -1,
 		.err = EACCES,
 	},
@@ -64,6 +61,9 @@ static struct test_case tcase[] = {
 
 void setup(void)
 {
+	snprintf(queue_name, sizeof(queue_name), "/test_mqueue_%d", getpid());
+	tcase[0].qname = queue_name;
+	tcase[1].qname = queue_name;
 	euid = geteuid();
 	pw = SAFE_GETPWNAM("nobody");
 }
@@ -79,10 +79,10 @@ static void do_test(unsigned int i)
 	 * When test ended with SIGTERM etc, mq descriptor is left remains.
 	 * So we delete it first.
 	 */
-	mq_unlink(QUEUE_NAME);
+	mq_unlink(queue_name);
 
 	/* prepare */
-	fd = SAFE_MQ_OPEN(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
+	fd = SAFE_MQ_OPEN(queue_name, O_CREAT | O_EXCL | O_RDWR, S_IRWXU, NULL);
 
 	if (tc->as_nobody && seteuid(pw->pw_uid)) {
 		tst_res(TFAIL | TERRNO, "seteuid failed");
@@ -107,7 +107,7 @@ EXIT:
 	if (fd > 0 && close(fd))
 		tst_res(TWARN | TERRNO, "close(fd) failed");
 
-	mq_unlink(QUEUE_NAME);
+	mq_unlink(queue_name);
 }
 
 static struct tst_test test = {
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
