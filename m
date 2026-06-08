Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC466CD8CAA
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:53:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE5793E6FD8
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 17:53:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF11E3DEBF9
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 17:53:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 45295602399
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 17:53:01 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658EX7dj3910616; Mon, 8 Jun 2026 15:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QaoUiMRbOPzKclU465VSKCYrat8HMoB9nsK0nHDSi
 q0=; b=JJf/3kX3qzJzlw2FpgFuCnuyCXdwLTfxW9e7a2HT5gjRws+NmhebQgtFv
 NfD4Eq1aGpWhb/UOORSE1J9YPEmkXTd8uqHNpXS46p+kVgBPu6zrLt/0JHurzy4F
 HYnb2/Z4WhQPMi1t5t49mVyKvrIGUo8kVy6+PYFLXLhwaf1yysS/kn1B7uILd+hv
 V1SZ8srpaBeI0ApyI4dpy8kDsk9a7xBXne5Ni5KkZtEhr6ldZkqD5bqZLKHsIeFe
 10CKSAlRsu1ogZkqeMkIRvgSdzBWgu4Oxhl/x2BKc9fd9XrynhdFYippCwzUNvyY
 9zveUi08Np9r5CQ0cNbRWxoMTu1vQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sqxrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 15:53:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658Fnji2017944;
 Mon, 8 Jun 2026 15:52:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgwwx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 15:52:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658Fqv8Z56230354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 15:52:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE89020043;
 Mon,  8 Jun 2026 15:52:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D88220040;
 Mon,  8 Jun 2026 15:52:57 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.135.117]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 15:52:57 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 17:52:41 +0200
Message-ID: <20260608155241.270875-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K6wDvWbHikZx2qjTnQcC63rY1Q_vftLS
X-Proofpoint-GUID: K6wDvWbHikZx2qjTnQcC63rY1Q_vftLS
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a26e55c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=irlIAbkM4dk7JLJdV3EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE0OSBTYWx0ZWRfXxshKafoARwqp
 81tnYFWsNYQZDbORpalzoC91Oz0a1UAbpNXlH8hvhRDY4zTbHgftEybBdQOVzgTWs+KY7JJVxrQ
 jUo8n6/XpyBuwoiN9PvNUWC6gE071jcDX6iWMzcN1B5zmwVm3MrFxy4Bcqrojlxp+84dLDZMrxL
 8cv+zzGp+T+YMEaA8Q1xntv6G8s1vI0GpDraDcDOHMw0G8MvYUjPDTKZDtpR0wPiKONCLq47SIg
 p4tC5b2Vpdj3l+3dikh5PPFNVSjTD4sQd48XOpw6saY9WfBX8i1ZVo/300tZoAVKmR3V8KXRsl1
 /pDtjHcd8zYvePFhD/jSbS7Atzne00hKsq8y/C+v7Pjt2QIoy0YQxWsIpPMaQoGraP9hztboGIZ
 JX+UiFCyqnCb2J95xgeCmkq/W7pFDIewpsXprZ8j+54Wu8uiVRdalafU4hJlYjoeuaPcjbn1ZNa
 buEKUSAxceJ5hilEfRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080149
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

exfat, like XFS, requires actual data writes (not just fallocate) to
fully allocate swap files. Without this, swapon(2) fails with EINVAL
due to unallocated extents.

This matches the kernel's requirement that swap files must be fully
allocated before activation.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 libs/swap/tse_swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
index ae3c193132e6..e321cb1dfe63 100644
--- a/libs/swap/tse_swap.c
+++ b/libs/swap/tse_swap.c
@@ -177,8 +177,9 @@ int make_swapfile(const char *file, const int lineno,
 	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
 		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");
 
-	/* Fill the file if needed (specific to old xfs filesystems) */
-	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
+	/* Fill the file if needed (specific to xfs and exfat filesystems) */
+	long fs_type = tst_fs_type(swapfile);
+	if (fs_type == TST_XFS_MAGIC || fs_type == TST_EXFAT_MAGIC) {
 		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
 			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
 	}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
