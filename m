Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA0310706E0
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 15:14:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90DDE3C2365
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 16:14:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14383CF204
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:19 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D25C21400242
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:18 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62EDF5D31391237; Sat, 14 Mar 2026 15:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bj7cuAF4ls2B6nBh2
 A14IX3brW/CYmnidF0uak5cmM4=; b=l1a0Te9A8U6BZmBYSDzgp7MLVw8joQZKp
 TyhEAYIBBdKVx5sT1KYLaaPxM/WAIZODAn91Po3ImnLsCb9bojwWt2zZ2l4mEKu2
 2Cksg83JjSM8+HxLRCr/SXJRZn3pt0nUAjKW5c8mMhxnZJ6fOe4ADfDxhHEYfgoD
 chIPcZH6l4Azv+AqIV6PjvoDpFm4xVoVqrVzGuVFd/hU3wlYQMb2MGvAshtKWhkm
 JxDDNT2QfyVL+4jo9+h7NIc69WYU/XziBVUgBXixEjlLN5BLiTXAC6zUDf+4M73p
 rreRfuePtkPQoFF2ROfOv8Lx0GCU5O5+i5LuWMDY/UhoFg92aXb5A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrsfyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62E8e3q7018355;
 Sat, 14 Mar 2026 15:13:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8an8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62EFDDkG52887852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2026 15:13:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9932720043;
 Sat, 14 Mar 2026 15:13:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EC202004B;
 Sat, 14 Mar 2026 15:13:13 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.80.172]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Mar 2026 15:13:13 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Sat, 14 Mar 2026 16:13:04 +0100
Message-ID: <20260314151304.82136-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314151304.82136-1-japo@linux.ibm.com>
References: <20260314151304.82136-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b57b0c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=D8qa3E3ZBTQVZeoaTDYA:9
X-Proofpoint-ORIG-GUID: JQIVBwu65OfnVz_xP21JJM4GVlLgIrr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDExOSBTYWx0ZWRfXz6XtcJTSK0W3
 mVmaUMKEnBRLy+byr/0PxNBmIYte1CIDdzC3On3Z4y+QZYj0cQvlqLXRvomn+XqqqIKWIOhbkuJ
 7DQA3/CQXiqdX1BgNcRcbdqPSS8vYFw8LtSe0pyHL8/bmgsAa2kXCJW1g4kl7oavyTd6Tms/A4U
 4KPM0EMwoAeK3EaP/vEa9QnpLn55MPtzLIfBUxvjcFsPZQBwvnGWGbS+GDzyaDRejohwYIKDKAs
 k1coUwvpylcCYC1T8/cPgrjSFpSBA7Out9RHZIpP838tDuQ3G5z2KQsNRbj/4VEhrY+PcBPQ2YM
 qb2XROF+Y6W9ttYwFDHIWUQOU53MKTp67TIpcNTXtx6cgz4FfIp0K2CvPZXUglYrp7GJfkuwMgo
 K5pJfrFFGN8vYmQGKLc+fMUuhlLz2AVvtmbl7csPAwFcaaa4mwu4OTxRNu+pKkaYTyQaQEFv8mh
 yOiZLEsH6e5woxNQiZA==
X-Proofpoint-GUID: JQIVBwu65OfnVz_xP21JJM4GVlLgIrr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140119
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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

Starting with kernel 7.1.0, sockets support extended attributes in the
user.* namespace. This behavior was enabled by dc0876b9846d ("xattr:
support extended attributes on sockets"), which permits user.* xattrs on
S_IFSOCK inodes (previously rejected with -EPERM).

Adapts the test to expect success (exp_err = 0) instead of EPERM when
testing setxattr(2) on sockets with kernel 7.1.0+.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/setxattr/setxattr02.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 9f5f998da9ba..c905f42dbb9e 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -15,7 +15,7 @@
  * - EPERM - set attribute to a FIFO
  * - EPERM - set attribute to a char special file
  * - EPERM - set attribute to a block special file
- * - EPERM - set attribute to a UNIX domain socket
+ * - EPERM/SUCCEED - set attribute to a UNIX domain socket (commit dc0876b9846d)
  */
 
 #include "config.h"
@@ -132,6 +132,10 @@ static void verify_setxattr(unsigned int i)
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
 		tst_brk(TCONF, "setxattr(2) not supported");
 
+	/* consider kernels with commit dc0876b9846d */
+	if ((tst_kvercmp(7, 1, 0) >= 0) && (strncmp(tc[i].fname, SOCK, strlen(SOCK)) == 0))
+		tc[i].exp_err = 0;
+
 	/* success */
 
 	if (!tc[i].exp_err) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
