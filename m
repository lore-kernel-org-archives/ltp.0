Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F3D58B07
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:28:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DF203E5657
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 960EC3E48A1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:33 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 102C21A006EF
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:27:32 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G147Tt1188668; Mon, 16 Mar 2026 12:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gkM+onLMHLf8w2c/B
 oXmT2hrRoXP1Jau4DHs6EIj+UQ=; b=n05C4/Hyeidz7rhObsK0WHF3n80nmKs9A
 INxwdjrbWC9Kl4gHxyck2LFPcnyp4uNy4e9tnd7AIeR/UARzQBxtVddYahZ5iv7u
 +OjvidzDcEdB1OyPsDZtd2j0D9CH237+zDqB/4zYDqlMyiX94Kc7jb8ObGYXWNpb
 fdjsurvkhmZnwhg+Q1eNK/Fcb6z6klgUYu+3N1vYN33YacpjVgiO+VE7+htenNgN
 nxBq1+QRvj5JEmsbFxtZqkYtZ+gXFBsl1EVJXzZufaHzO91Gs1FWRgAsQDV8axeh
 VSSszh5H+TIx9TtT1yeeO9fJglY2QJMLViEm5xOzXI0S0iYb24IAA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfa2c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GB8kAg032346;
 Mon, 16 Mar 2026 12:27:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jmm3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 12:27:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GCRSjb44302620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 12:27:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1615E2004B;
 Mon, 16 Mar 2026 12:27:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B99C020043;
 Mon, 16 Mar 2026 12:27:27 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com.com (unknown
 [9.111.83.233]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 12:27:27 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Mon, 16 Mar 2026 13:27:24 +0100
Message-ID: <20260316122725.122719-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316122725.122719-1-japo@linux.ibm.com>
References: <20260316122725.122719-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _wIlbZGjYaedw0b67jUQ76xuvaTv212l
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b7f732 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7TtIAGwwYx7YTiSAdyoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfX4ph/mJkEFq94
 o0lfgIXl8XDw91JTnMmIlTQWJ3l7uf070ZH9fliuwKjWina0FGTyMZmZqTlhAi7GAvFw6ejMutP
 D/K3RRSdB3EKMWJw+ynb/3OOq4k6Wya5omUe8gE6ZNW3+A5E3Bxo52J4FwgZ/7W0AHKVFJc4EeH
 7SE8x+i3H2R9WBFP7LWgsStMXu0/ZEwM/XkeuYtAuB7TfmWrDv9pIw3UpUmtDejRU6olI43fKVw
 bsKWrWDJV+/eSVgn1/wXzrZ25Wk0yiDQKdG2yxhk96+Far6QeiH3StWase3vrd6Q8+HAQIxrmZ3
 U2eYe2OIUB/Yiz3TCYIXYb4yT9poYc6XAqV+1dA9qC+qzsBGpQ2jMU9woNj8NvS922r2Ve82xZR
 IMxkz7UMH3sshWJqiw36qc6miUijTltueIfdt5H0tds8xRsAShF5PhfeI6j4DO6wjb+8gFmRK0l
 1F+nIFF1R2+/BtLUjIQ==
X-Proofpoint-GUID: _wIlbZGjYaedw0b67jUQ76xuvaTv212l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160093
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] fsetxattr02: Adapt test for kernel 7.1.0+
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

Behavior:
- Kernel < 7.1.0: fsetxattr() on socket returns -EPERM (original behavior)
- Kernel >= 7.1.0: fsetxattr() on socket returns 0 (success, new behavior)

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 18490a865871..be6e7f489816 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -19,7 +19,10 @@
  * - Set attribute to a block special file, fsetxattr(2) should
  *   return -1 and set errno to EPERM.
  * - Set attribute to a UNIX domain socket, fsetxattr(2) should
- *   return -1 and set errno to EPERM.
+ *   return -1 and set errno to EPERM on kernels < 7.1.0.
+ *   On kernel 7.1.0+ (dc0876b9846d "xattr: support extended 
+ *   attributes on sockets"), returns 0 (success) as sockets now 
+ *   support user.* xattrs.
  */
 
 /*
@@ -62,6 +65,8 @@
 #define BLK      MNTPOINT"/fsetxattr02blk"
 #define SOCK     "fsetxattr02sock"
 
+static bool socket_xattr_supported;
+
 struct test_case {
 	char *fname;
 	int fd;
@@ -73,7 +78,16 @@ struct test_case {
 	int exp_err;
 	int issocket;
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
@@ -139,6 +153,7 @@ static struct test_case tc[] = {
 	 .flags = XATTR_CREATE,
 	 .exp_err = EPERM,
 	 .issocket = 1,
+	 .fix_errno = fix_sock,
 	 },
 };
 
@@ -152,6 +167,9 @@ static void verify_fsetxattr(unsigned int i)
 				XATTR_CREATE);
 	}
 
+	if (tc[i].fix_errno)
+		tc[i].fix_errno(&tc[i]);
+
 	TEST(fsetxattr(tc[i].fd, tc[i].key, tc[i].value, tc[i].size,
 			tc[i].flags));
 
@@ -233,6 +251,8 @@ static void setup(void)
 		SAFE_BIND(tc[i].fd, (const struct sockaddr *) &sun,
 				sizeof(struct sockaddr_un));
 	}
+
+	socket_xattr_supported = (tst_kvercmp(7, 1, 0) >= 0);
 }
 
 static void cleanup(void)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
