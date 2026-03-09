Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9639DF4181F
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 17:22:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14D6B3DF176
	for <ltp@archiver.kernel.org>; Mon,  9 Mar 2026 18:22:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A515B3DD46B
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:44 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 092AB1A006F0
 for <ltp@lists.linux.it>; Mon,  9 Mar 2026 18:21:42 +0100 (CET)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629ELCre1177331; Mon, 9 Mar 2026 17:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=v+xOB+Fda0nfJB3wS
 s/PJIsmjQlYO8hS1ZmcwvZZrfE=; b=KclBmVC28goRfEfE5ebGaEKXsx5ne+HyR
 32bgsBr73aD/tUue/L9vblOCiWDyhEW5ULDJsAcYFa3BrcS6j2glnKWKows4X0zk
 hwxm5EPavtVRSBqA4PxHbILyoWE8m6xsfw4LMauwnT78xWU4MTUXWykarV+sIUKA
 fL2nrj6/40L1SogHUUmqbOTmsai+jT9RpT4LBVkSF5Z/zUJ2OsXFusJCejhU1l+7
 qNKYLtVB/+QmBgY6ALsWVp1fD6kxodH2sSArrRB5wNfMYKCA5Vdx/nX7LPynhK4+
 lJmYPz04Pzd+yFNDMlB1PktQFH6VmtrDaeqLj0jy6Ry3109e+/f7w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr7f1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629EBi2k021150;
 Mon, 9 Mar 2026 17:21:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsp1g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:21:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629HLcZ029688426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 17:21:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDB8B20043;
 Mon,  9 Mar 2026 17:21:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63BEA20040;
 Mon,  9 Mar 2026 17:21:38 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.87.155.142]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 17:21:38 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon,  9 Mar 2026 18:20:56 +0100
Message-ID: <20260309172057.272946-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309172057.272946-1-japo@linux.ibm.com>
References: <20260309172057.272946-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1MyBTYWx0ZWRfX7EWr7fmpeTmz
 ZsbUZFel84SfQOPZDv7TW703RaPRASNkvXkl0GN8jyWs/flOC2MOjNol6r7zrlkXi9F3SSon4xp
 rWgp8ucGsg5JB4BNtWPQHZcQwQR+8QC6e3C9wf/izO2IRpxicBDxaPw0hrPRa8haH4S5VYlKT+D
 cKILPYaDcjEa4K5H3FHNjzOnQTVvYAHto6OT+k6tJuGCT6FSMUYKUcpDfkxLkANMEyRQI3MIwSy
 bYdZOgQ1ndlJwopU/v+g6XzIbWG2IcXAetGghJZ2LT6RiTeCq8e83Nv8psjiRoP7L0XJdKA30DU
 x8EHVfyegwV442D1+jxADg7Eir6NJJrJqKdYcmJHWYmfmxcMhSXYyvYHeh8dZldtnPahCxdPBUB
 S3z0cacBmHs8p5MAWG5at5muYvnAQfGZwu8Z76D0sF4lkkGCWB1Edspshyu3LICLl3doRDEpeHJ
 1XdqRS6GJFXwVvo67XA==
X-Proofpoint-GUID: vI-UlYgU5vZvn3-T3DReJOmMRidIe5Zn
X-Proofpoint-ORIG-GUID: vI-UlYgU5vZvn3-T3DReJOmMRidIe5Zn
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69af01a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=D8qa3E3ZBTQVZeoaTDYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090153
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] setxattr02: Adapt test for kernel 7.0+ socket
 xattr support
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

Starting with kernel 7.0.0, sockets support extended attributes in the
user.* namespace. This behavior was enabled by dc0876b9846d ("xattr:
support extended attributes on sockets"), which permits user.* xattrs on
S_IFSOCK inodes (previously rejected with -EPERM).

Adapts the test to expect success (exp_err = 0) instead of EPERM when
testing setxattr(2) on sockets with kernel 7.0+.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 testcases/kernel/syscalls/setxattr/setxattr02.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 9f5f998da9ba..ac2ad8678d31 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -132,6 +132,10 @@ static void verify_setxattr(unsigned int i)
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
 		tst_brk(TCONF, "setxattr(2) not supported");
 
+	/* consider newer kernels */
+	if ((tst_kvercmp(7, 0, 0) >= 0) && (strncmp(tc[i].fname, SOCK, strlen(SOCK)) == 0))
+		tc[i].exp_err = 0;
+
 	/* success */
 
 	if (!tc[i].exp_err) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
