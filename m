Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F79C83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 16:31:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C2483CAD84
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 18:31:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0DCA3C627B
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 18:30:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 014212009F3
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 18:30:55 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569BbKDO020465;
 Wed, 9 Jul 2025 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ko5SvHAR3EO6H1IFR8yebLQh3TYj3aczVmsWtpmUW
 ZQ=; b=AAC6PlxwnHl1Kmf561UDhm1IhRKMtpydds5Vp8N0eSF35ZLeoa9TFvxnu
 b4rhH9sm8y9aGwlIeBYebNbb9UjVVg1dGdrU0Yv4WzE5FTmjsfzTUc+1utprVDmW
 yOp17nC7bejdSIv5iZxgv8Vcc+Zjho2eG41/xK+VEByTWmrRGFZEIAeM9nd1nFcT
 Nu7PEXZV0J2RLsoZgMM+oLs+jQ3ks96SeevyrAZL3P8//QZETs8KWCUC1/ges0VH
 HhKw3ovZctVv+lFwRxMXu3+DJkCSTwIBlo+ZAeV/TU5kON8isF2DIPchFhu8U5Po
 VqFYi8ax/AtUVDS/lGI9qBvTC1uWA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss7gcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 16:30:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569FXAEp002865;
 Wed, 9 Jul 2025 16:30:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmgwtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 16:30:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569GUnD658917224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 16:30:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48AA12004B;
 Wed,  9 Jul 2025 16:30:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA42A20040;
 Wed,  9 Jul 2025 16:30:48 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.139.170]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jul 2025 16:30:48 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Wed,  9 Jul 2025 18:30:22 +0200
Message-ID: <20250709163022.69985-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686e993c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7xT3-tc8c4Aw8JKu47QA:9
X-Proofpoint-GUID: qbUyt-D02nN40vJ9Ju_D17jWx6jm4Iqu
X-Proofpoint-ORIG-GUID: qbUyt-D02nN40vJ9Ju_D17jWx6jm4Iqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE0NyBTYWx0ZWRfX3gORpoyU5wan
 e8OAyoBXa4MAF07KVWpdOVbCy4/vdfTUWIXj+eWFF9qYF3fEameAPAEyjqpTk/uCUUjhckPQ8mL
 pVboZuFapZ9wDkESEXcYanV9FGWWrC0/MMB3ceyaRfmlTVrLng7qIaJLN+LNK+vcspO0WBuHJBw
 udWsWNRG1dk6cbCpQ58Sl5x+b74I1NLmNm0hbM7rhynqsMZZG76SigIokQSz8mbpt/VxTzkB4kB
 t439IQdO8EUrbP5A3HHfb0WidE16OVK/RZOlflZiCdcDATYzEw0B/8AfypKsE35bwsd9Vv7rcEZ
 VcxcCKmYRzUryqmjBZAeZM/YmXri4fKPWYJ3H5XKpmoDdoIbHceav8UpeXsJocd0Ts0/Du/Ju6e
 Y6WU6hK0Jq6OX/hzXJ/ECFZn9F2vxIcsAIrCJW8cR29xz1XN4UPcuBPhe0O93YXUZRIC5EIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=960 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090147
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v1 1/1] splice07.c: Skip invalid splice() tests
 involving memfd secret
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

Linux commit cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix
secretmem LSM bypass") prevents any access to secret memory pages from other
kernel subsystems.

Splice operations involving memfd secret are no longer valid and return EACCES.
These test cases are skipped accordingly.

This avoids false negatives in splice07 test:

    [skip]
    splice07.c:54: TFAIL: splice() on pipe read end -> memfd secret expected EBADF, EINVAL: EACCES (13)
    [skip]
    splice07.c:54: TFAIL: splice() on memfd secret -> pipe write end expected EBADF, EINVAL: EACCES (13)
    [skip]

Reference: cbe4134ea4bc ("fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass")
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/splice/splice07.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index 2228e2f269de..c750a14bf439 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -27,6 +27,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 		case TST_FD_UNIX_SOCK:
 		case TST_FD_INET_SOCK:
 		case TST_FD_MEMFD:
+		case TST_FD_MEMFD_SECRET:
 			return;
 		default:
 		break;
@@ -40,6 +41,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 		case TST_FD_FILE:
 		case TST_FD_PROC_MAPS:
 		case TST_FD_MEMFD:
+		case TST_FD_MEMFD_SECRET:
 			return;
 		/* And this complains about socket not being connected */
 		case TST_FD_INET_SOCK:
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
