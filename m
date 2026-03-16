Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51578D58B07
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:28:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21D73E4B88
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 795C53E48A5
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:36 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93F87600774
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:32 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G93Vtc3176840; Mon, 16 Mar 2026 12:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ngHH0jr92zTpKgKko
 8jvvbmpEu4q2uHb/wnCMsG3yMk=; b=kZFo2A7+kg9ubKrDPp8pZGS5EBDLRXo5V
 /tVpMxyMVtQJigHKH9I23eNffoGWUJQrWleOPVppmiZIE5kRlQZU9VlT0tvTf6uy
 AetvUaRt+cru9lKnd+NoN5VJsig4ckLR/W1kTSs7sIPwpoa+ThklyOGEoZYVlYk8
 e/tfqLb20WN1F7dfvrbmBrBqpgFCMnaLsl2MnphcHTy909nd4CAqufj3wlDrd7I5
 lZ7fjvD5GgBeTtIZ+rj2Hg/ZQS9uWfn/5hQkWGQhuOVctjQS6YmJ5CGhrNAoAWWL
 blsfnZrQHBFgBNMt8a1Wp6v9ox8jm7QJOm8lhwRHjdEy8C1G9YMdQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cqgb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GA73DT013996;
 Mon, 16 Mar 2026 12:27:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxvufe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GCRSGZ44302622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 12:27:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76D8C2004B;
 Mon, 16 Mar 2026 12:27:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AC3820043;
 Mon, 16 Mar 2026 12:27:28 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.83.233]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 12:27:28 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon, 16 Mar 2026 13:27:25 +0100
Message-ID: <20260316122725.122719-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316122725.122719-1-japo@linux.ibm.com>
References: <20260316122725.122719-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b7f733 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7TtIAGwwYx7YTiSAdyoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfX53sX97i/nHg/
 9/kXu1Qoo91b7jhGp7IlYv9QLRu7SOKYdIlWcRRxLQnARiF9T8qOKdHBPjTB//wKjrcHQa5qMcD
 gAK3n7lEpPzP37xGlO3wfGH95dnV2F8NE3AN93+4cu9EBPQUQec+bALhxcPKzBZnPmDLS9GvvnC
 MaMAniC10VB36XhQR+GXDz10aZeivNWw+LrqZclGlf4VRJ3zxOWnHKFwD3QmVR3kf67meXyfShX
 mhngWUgpEBM32+ljXIXmjzERdK69vqILYBaBEZiERiwMWKwniM70lV8CrOX33wZyJy/KHjXwd0y
 5J9of9FwBODVTe4kZZjkLj8j2OUqFMyanjLfXLLTxDS78PvKoaoSbCP6wJDxjovZPElHjQ9ZRnM
 ZaA+eknRbfHsUuEZH/2y6Ivo9soOinzgrJCN010AsftB1ZIMWSw2Uq8AexqexSFIjaB9MBsq4ZQ
 hCcYSfQsDpjzEKn76GQ==
X-Proofpoint-GUID: 9OiTrS-BWtRBEldVZHM0svUy5vJBZdWk
X-Proofpoint-ORIG-GUID: 9OiTrS-BWtRBEldVZHM0svUy5vJBZdWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160093
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] setxattr02: Adapt test for kernel 7.1.0+
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

Behavior:
- Kernel < 7.1.0: setxattr() on socket returns -EPERM (original behavior)
- Kernel >= 7.1.0: setxattr() on socket returns 0 (success, new behavior)

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 .../kernel/syscalls/setxattr/setxattr02.c     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 9f5f998da9ba..c1996fb60d73 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -15,7 +15,8 @@
  * - EPERM - set attribute to a FIFO
  * - EPERM - set attribute to a char special file
  * - EPERM - set attribute to a block special file
- * - EPERM - set attribute to a UNIX domain socket
+ * - EPERM/SUCCEED - set attribute to a UNIX domain socket (dc0876b9846d 
+ *   "xattr: support extended attributes on sockets")
  */
 
 #include "config.h"
@@ -49,6 +50,8 @@
 #define BLK      "setxattr02blk"
 #define SOCK     "setxattr02sock"
 
+static bool socket_xattr_supported;
+
 struct test_case {
 	char *fname;
 	char *key;
@@ -57,7 +60,16 @@ struct test_case {
 	int flags;
 	int exp_err;
 	int needskeyset;
+	void (*fix_errno)(struct test_case *tc);
 };
+
+static void fix_sock(struct test_case *tc)
+{
+	/* dc0876b9846d ("xattr: support extended attributes on sockets") */
+	if (socket_xattr_supported)
+		tc->exp_err = 0;
+}
+
 static struct test_case tc[] = {
 	{			/* case 00, set attr to reg */
 	 .fname = FILENAME,
@@ -115,6 +127,7 @@ static struct test_case tc[] = {
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = EPERM,
+	 .fix_errno = fix_sock,
 	 },
 };
 
@@ -126,6 +139,9 @@ static void verify_setxattr(unsigned int i)
 				XATTR_CREATE);
 	}
 
+	if (tc[i].fix_errno)
+		tc[i].fix_errno(&tc[i]);
+
 	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
 			tc[i].flags));
 
@@ -185,6 +201,8 @@ static void setup(void)
 	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
 	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
 	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
+
+	socket_xattr_supported = (tst_kvercmp(7, 1, 0) >= 0);
 }
 
 static struct tst_test test = {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
