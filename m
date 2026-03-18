Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53083103E164
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1AC43CAE38
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:13:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E36C3C2EA3
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:14 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7AD5860070D
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:13 +0100 (CET)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I6MZJ74022659; Wed, 18 Mar 2026 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8ZL3g3Rgha/ywYu5x
 673WmJsVLupIXFWI6ExFGMp7W0=; b=Tw7O2ryoQSQrLy315Rib4lIzfUhgnbRAp
 SgwFEPuN0uuHyHQbcbqezv0APqe2Tw6NkI8JtvkJtdZOrB6ca3faw61ZKHLlxfSQ
 gR1b0Us0K04JFMM7XqfyQc2S9noAE92mVYmlvLIYUa8zjJWMAkeaxGJDahGM5MRt
 utr3jS8NQfpHp7LrzRuanc5r+gQGpEXMUfjP8pPZwefh2L3UqGhkYE2IoKy02bo6
 fNYNSCpAZqBdXxbA/6ZbarC9wvJQFoKPL9zJ5logAwl1/WIrmjxLaFJbHidBFjD3
 KrmxziiALLKmB2KBGYm2gl+tp79QQU9hWlePd19V5dHpy9fvuyqTQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs9j34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IALcsb032448;
 Wed, 18 Mar 2026 11:13:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jwgqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IBD8LW54264212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 11:13:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8CA520043;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AADA92004F;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.aag-de.ibm.com (unknown
 [9.52.197.53]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Wed, 18 Mar 2026 12:13:05 +0100
Message-ID: <20260318111306.98139-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318111306.98139-1-japo@linux.ibm.com>
References: <20260318111306.98139-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba88c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=7TtIAGwwYx7YTiSAdyoA:9
X-Proofpoint-ORIG-GUID: m0vcAYbGysUZPb2mmpMyoEl-OQhXfipj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5NSBTYWx0ZWRfX9d7g0GKKnjhH
 5gTMqF16BzidZVjpn0gw5UlvljHKbUxvtdISbEo2PZGuPlRgQmRnJbIhTBTdTjkA+oKpW6w6rTT
 8l+5ur596tUdfN09IrhFRx+Ss/3w8Uw/UlvfP1x05Fm9PxbZJ6HDPcht68PveROOLVxrgsRc2GA
 m8seoZKm7/HadB7zckk66Ft6vIL7FhTchjtGwW/X5TcwEjrvVVeJrgzNjovi2M2ylPybsLz7mPe
 G2Jd8sJVzJhdX/Njfmu8ho2mP2Nk6ige0Fj2l3FQckYn3FxtucevKxer5cltFCU16UW5qQ/EuSh
 cZkNW4gicJMgMDsfdmZ11jBF9XzWgeRNMNlqAluSiA1F8cfbPsNY8khDuSbmhVoeEeQiCF3qxtf
 5xSdDsA4mqeohTfGY9R+KzvHcB9RoL5EBUImNADEFGAqlODIgpwCZMW+UlxNiSWUfJGM6UBv4JR
 rpmSxIXgdqDg5A7vgsw==
X-Proofpoint-GUID: m0vcAYbGysUZPb2mmpMyoEl-OQhXfipj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180095
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] fsetxattr02: Adapt test for kernel 7.1.0+
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
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 18490a865871..49dcd7cefbe8 100644
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
@@ -73,7 +78,9 @@ struct test_case {
 	int exp_err;
 	int issocket;
 	int needskeyset;
+	bool check_xattr;
 };
+
 static struct test_case tc[] = {
 	{			/* case 00, set attr to reg */
 	 .fname = FILENAME,
@@ -139,6 +146,7 @@ static struct test_case tc[] = {
 	 .flags = XATTR_CREATE,
 	 .exp_err = EPERM,
 	 .issocket = 1,
+	 .check_xattr = true,
 	 },
 };
 
@@ -152,6 +160,9 @@ static void verify_fsetxattr(unsigned int i)
 				XATTR_CREATE);
 	}
 
+	if (tc[i].check_xattr && socket_xattr_supported)
+		tc[i].exp_err = 0;
+
 	TEST(fsetxattr(tc[i].fd, tc[i].key, tc[i].value, tc[i].size,
 			tc[i].flags));
 
@@ -233,6 +244,8 @@ static void setup(void)
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
