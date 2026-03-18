Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6575103E166
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:14:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740BF3CAE38
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:14:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F1433C52E9
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:14 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81AEB1A0099A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:13:13 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HLotee1474421; Wed, 18 Mar 2026 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8KGAWU4nimKuwBzYm
 3xMU7LCuzqrlEX8QPgLIBZppos=; b=s+zzzUSv/kcCmyjiD2GfSHn+UQI5rHMtf
 2syc8HxlAG3PQQEySDLkVVuDWvSl/zmDfD1ufLtxZZiTaUEeP1avt53g1Z2nsmhV
 LVxS4u7BPVLIpGbH70rIowBeRabaELslEY65AMq+dqZmRIn2ExaWMpPyVwKgGnd4
 ugVmcSb1RbwzzGFJ0UH/tqGljZ0opd0pl2lTkwNlikAlTcdqBQ3cciWro+gHirc7
 W3w8z1zIVtZzO3KDwGoTUHc8BKFGlrbeFj+DcPEuraScozLgfWAQLzU9l2rhp5s2
 R8wKB0Y1oyH2o6r1Vjn/PFRt92ARksdH9NIoySGuRpBThrKk7W2dw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3j13t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I9RGH6028713;
 Wed, 18 Mar 2026 11:13:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkdnm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 11:13:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IBD9hJ34931162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 11:13:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE6CE2004E;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCFE72005A;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.aag-de.ibm.com (unknown
 [9.52.197.53]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2026 11:13:08 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: chrubis@suse.cz, pvorel@suse.cz
Date: Wed, 18 Mar 2026 12:13:06 +0100
Message-ID: <20260318111306.98139-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318111306.98139-1-japo@linux.ibm.com>
References: <20260318111306.98139-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iGcHerjTBUtHTuMW16gtJYY5hNged08k
X-Proofpoint-ORIG-GUID: iGcHerjTBUtHTuMW16gtJYY5hNged08k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5NSBTYWx0ZWRfX1TDnKCZrzd7s
 c5sHTxAO0oUdL/KxZIr5NZZizvC5bt8sx96IrR0T80FwZAPulFwKSRjnulrtLusQRKSTUaaM+Rv
 I1/Ka4TsBTSHsDQJMJYzUSxDkDYKazPfoDl5B4HTe4wQECjCHmyQKzZ1rb5ApBmnCEn1q5ofkuL
 u0rHTxrjMuuSTZhDoiILOYnlAP8/vouKOF9mcw5ydH6qV1sJf7+UEtWmhEbaPPdE5lqDFrXdCwr
 mMGpZXN1gCil1XqhkxKsmEYKalXOJaAWLmteoaVLcMQNh47Mq9PWXeo1hkWChVUQQ5W0oBrtEpA
 TNsCKWq9deqD3t+SglYqSVXY/wBte8yo2If9DR96NT9AO9A+QTbUMvAbBV0NvGQ1j+UFAFVgLXc
 ycZA7QKQvxgXkkJfK2RfmNHW4OxFM5vnxebuSJwyRawEieL/dn0zm0kZdeFTGs2VBErcwdt/Un2
 GfjBj2zm88Owz6jvykA==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69ba88c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7TtIAGwwYx7YTiSAdyoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180095
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] setxattr02: Adapt test for kernel 7.1.0+
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
 testcases/kernel/syscalls/setxattr/setxattr02.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 9f5f998da9ba..151e8f308bbf 100644
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
@@ -57,7 +60,9 @@ struct test_case {
 	int flags;
 	int exp_err;
 	int needskeyset;
+	bool check_xattr;
 };
+
 static struct test_case tc[] = {
 	{			/* case 00, set attr to reg */
 	 .fname = FILENAME,
@@ -115,6 +120,7 @@ static struct test_case tc[] = {
 	 .size = XATTR_TEST_VALUE_SIZE,
 	 .flags = XATTR_CREATE,
 	 .exp_err = EPERM,
+	 .check_xattr = true,
 	 },
 };
 
@@ -126,6 +132,9 @@ static void verify_setxattr(unsigned int i)
 				XATTR_CREATE);
 	}
 
+	if (tc[i].check_xattr && socket_xattr_supported)
+		tc[i].exp_err = 0;
+
 	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
 			tc[i].flags));
 
@@ -185,6 +194,8 @@ static void setup(void)
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
