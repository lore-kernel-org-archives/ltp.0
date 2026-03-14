Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CD510706E0
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 15:13:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BC883E2764
	for <ltp@archiver.kernel.org>; Sat, 14 Mar 2026 16:13:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B16BF3CE841
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:18 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0974E200260
 for <ltp@lists.linux.it>; Sat, 14 Mar 2026 16:13:17 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E5j2ah476267; Sat, 14 Mar 2026 15:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pJ28EBdmnLnFDZsRC
 nPGQImU54XNYk0M77jvEJJfR68=; b=JkcO4NR0HPcWzxS/VcvPQO1azL0nLRhHb
 vjHbS+GGqaOUTktiuCoTTW+JdBb5gwZ9Gnpqmx6HAkVmR7HD5qGoWtLuc/A0KtV3
 AvwbR3YKInXhF1tKkrvhNOzV+PwnCKXaalOyZqCvC+6RRDlM9GfTYx2+6sozA9YC
 feqppObapmXf7tHt+r4sVVfn1eTcGL1wepKn1BDrsO9MMXcYvy5P/dmcxfUdhVWI
 0W9Ct8XRyhzDmZZaIBrBjlhCHs5ZvffJ5jIB+YtDjAOUUZvNyuFaElfCsK0b3Jgj
 DskDE2Jpu86u9EfcdopIbpwo1LvKRS6nqhZjttuUr8Nb0y5LhVHMg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3chhq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62EEhmau014667;
 Sat, 14 Mar 2026 15:13:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8jmp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Mar 2026 15:13:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62EFDD7r44106176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Mar 2026 15:13:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24B8420043;
 Sat, 14 Mar 2026 15:13:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF6D020040;
 Sat, 14 Mar 2026 15:13:12 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.80.172]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Mar 2026 15:13:12 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Sat, 14 Mar 2026 16:13:03 +0100
Message-ID: <20260314151304.82136-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314151304.82136-1-japo@linux.ibm.com>
References: <20260314151304.82136-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b57b0b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=D8qa3E3ZBTQVZeoaTDYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDExOSBTYWx0ZWRfXxi3f2G9rfXuL
 3PdbWZGfe+i6T95EdOzkaTnmqB1QiTqwc7dSoiAszHUFiln8n0HYCpLb/W9pLlgjJ2RTDR2xib6
 hDnW+DByE71aMT5gnxsKJC63/JtDoBO0f+YI/RS/Qp5JCAOaDui+IG+cq//YfDI7tHBYG+Ez3j3
 Z0AXflIWtGP6PWWuSTHyaslSS1ieTpYX0I1CH/oY56BiCnrpp+rjRxOzHxLi9sDIXiOg3M6LV88
 mmnrGwumN+Py//eH7x6ko8RBosP0qZUzAG29oetqn/cdc2VEqVxlSXvxWgqHB/OyHnegIEZlEQ/
 +EJXgnCbD7Z+TuooETpAYXINmTJ6nLVYgT1LTEmwCXZN5RXh+Gve4bWLXP9M8khdd1xF8JppT7K
 fg808wOl7TXTGOdfi6Ul/f5GMj6uv/enKTuSG4zprxKWz1y4Yd+Vi2QHR8lg2LC5h6bckPColOW
 9Nn4289vnlOnBa0TO6g==
X-Proofpoint-GUID: RYc_9ppRSp3SyQIpC-0AXzq3gp0upE_R
X-Proofpoint-ORIG-GUID: RYc_9ppRSp3SyQIpC-0AXzq3gp0upE_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140119
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] fsetxattr02: Adapt test for kernel 7.1.0+
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
user.* namespace. This behavior was enabled by dc0876b9846d ("xattr: support
extended attributes on sockets"), which permits user.* xattrs on S_IFSOCK
inodes (previously rejected with -EPERM).

Adapts the test to expect success (exp_err = 0) instead of EPERM when
testing fsetxattr(2) on sockets with kernel 7.1.0+.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 18490a865871..335a8868ac73 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -19,7 +19,8 @@
  * - Set attribute to a block special file, fsetxattr(2) should
  *   return -1 and set errno to EPERM.
  * - Set attribute to a UNIX domain socket, fsetxattr(2) should
- *   return -1 and set errno to EPERM.
+ *   return -1 and set errno to EPERM. Will SUCCEED on kernel
+ *   with commit dc0876b9846d.
  */
 
 /*
@@ -158,6 +159,10 @@ static void verify_fsetxattr(unsigned int i)
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
 		tst_brk(TCONF, "fsetxattr(2) not supported");
 
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
