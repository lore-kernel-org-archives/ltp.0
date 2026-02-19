Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B4E9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 16:31:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325CC3D078E
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 17:31:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D1803C7A8A
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:30:41 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB7F710009B8
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 17:30:40 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61J9AQ8q1272818; Thu, 19 Feb 2026 16:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tDczbCaVw2Toqldw6SIi7EKQWs5CFJcx/eU9Es+vm
 hU=; b=eYQiahDnVemU41EgqAtOcEvv4FL/w1BCJVhXZbd8rKO8MVYEfbNBuFl66
 LzQeLNY9OOnBQHkbPCgS0c9pMwwd+Lb9abi9GEYxhETdyUMziY//IksLwcxRgfnH
 XVbd5R8DKJX0swmLx6/fqVx3eZU/Yl/kpxpRaC7tY6cCbSJFaHZYQpe0jbDGUIX3
 JEHbh3Jo1F6Kvo3rSnZL6eUavQMfKJTadTKqBQZMrnSOm6yr5KWs6NnYiK832uiO
 AFHGhzdpUVtSnwVZIbDZOGW2SQv4F3OPe9rzQ72RA92MVyooosEY0OsH5H6KlLpF
 scLZ5Q57ARUEfWZbcU4NA20mUhUQg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4knpyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 16:30:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JDVGiQ015721;
 Thu, 19 Feb 2026 16:30:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45cw1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Feb 2026 16:30:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61JGUa2u52887876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Feb 2026 16:30:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 379EA2004B;
 Thu, 19 Feb 2026 16:30:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 100D520043;
 Thu, 19 Feb 2026 16:30:36 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.aag-de.ibm.com (unknown
 [9.52.197.53]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Feb 2026 16:30:36 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Thu, 19 Feb 2026 17:30:30 +0100
Message-ID: <20260219163030.69022-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE0NyBTYWx0ZWRfX/ElZM2HaI4KQ
 mbcHpgZ23fmFErv8vUjIm1irrjwFhEgtYuDfGTryuvzpl9QLIfDxThBLP5g0eiGEeL/Ppx9YUC3
 fam+XssileDYrdw6yFhjjeeegXLgDSdkOQE1oWA0CGQILjiet65VPCfftfJtdsHhBY72O1gHTGp
 gUFpwBn3ZhVJEsVhjBj+qcoLDS1SsfdUALVpbkaGEimm+wbVyHtKxYDwCacDgbGc4I+LKDAz020
 mN+i0EoJBfX2tj+RrnN83v4qae4/gDIgPX9Ze3HIoceQeosuyZk0PwVFf8FRp2VctqMQI0riVrz
 /8GWkcW5/RUN3W+mK6bfUeQvGdfN7CtafLsoddGPKMC8B0u0QjwmPaQFegu52HXYWtUIYuohA9H
 tXT8PoWwa9OWiezx8fRg+NtjdA5k94N2acN/H5slTxEMgvPyA3RNQd8kdFSLD8oFLe1JPeYaDA3
 /LEBdMOKdD8H1d1oFyg==
X-Proofpoint-ORIG-GUID: XvLh9a-_zPRSsaBMgQF70fXt2aFsifTd
X-Proofpoint-GUID: XvLh9a-_zPRSsaBMgQF70fXt2aFsifTd
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69973aae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=3Y0mmnoklB6cX8GlaNoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190147
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] [STAGING] ioctl_pidfd06: accept EREMOTE/ESRCH
 for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PIDFD_GET_INFO semantics changed for pidfds referring to tasks without a PID
in the caller's current pid namespace (commit ab89060fbc92e ("pidfs: return
-EREMOTE when PIDFD_GET_INFO is called on another ns")).

Accept both errnos to keep the test working on kernels with and without the
change (including backports).

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 751281bacb74..6b4bc3191e37 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -14,6 +14,7 @@
 
 static struct tst_clone_args *args;
 static struct pidfd_info *info;
+static const int exp_errnos[] = {EREMOTE, ESRCH};
 
 static void run(void)
 {
@@ -41,7 +42,8 @@ static void run(void)
 	args->exit_signal = SIGCHLD;
 
 	if (!SAFE_CLONE(args)) {
-		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
+		TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO, info), exp_errnos,
+				ARRAY_SIZE(exp_errnos));
 		exit(0);
 	}
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
