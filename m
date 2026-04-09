Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF5E9DE6A
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:36:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCC503E2E53
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:36:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08953E216E
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:36:04 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 429BB100022D
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:36:03 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Gvgqr2326605
 for <ltp@lists.linux.it>; Thu, 9 Apr 2026 08:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TZC87IlG17k2uuaGv0lxbZsEBGMMSfW1HvNuAfKcl
 Wk=; b=QFEP94CLQ0hRSh1hscUU2YgoR/txdR+Ie8fXg2G+WxojI/WabYuBMEOos
 +5SfjdiIzwym51ZDXVE9a6cAX/nVRiJtvMsL0i0gbpb6WLr3PKOj3ILlhsiANMi6
 rxZUVwLPWKCGvxyf9A698MOUFBXAqi/nkXY58OPkzigkExBBd7Vnw7nWf8bBMnAl
 C/Z86uzixDizZyhG1cLBtwM33hpUdd32/xsAhqREbsk4No/jiS77o/AE2EzHNVfy
 i+IOkpTt0M9pH9WrU2nKl3AQcxaAYRl3U6pZ0c4uNgIgTvSFcj2AKtPJZVaGWZtE
 g67FyUxOBkUC/+APrjinPw6MDB2jg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kk70b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 08:36:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63989jnJ026646
 for <ltp@lists.linux.it>; Thu, 9 Apr 2026 08:36:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg82t01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 08:36:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6398ZvIS31064628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 08:35:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C64F420043;
 Thu,  9 Apr 2026 08:35:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22ECE20040;
 Thu,  9 Apr 2026 08:35:57 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 08:35:56 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Thu,  9 Apr 2026 09:00:18 +0000
Message-Id: <20260409090018.1254510-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3MiBTYWx0ZWRfXzljsl9wdxewi
 +Mkil1p/9gbSQYPss3s+E+tSHFIL0mRatdpHoLsqlnVtyYkAC3Ek3gK/IyrDP/iSSQcpusfxd56
 zOeIiPtV5VjsqC/VVEiVrHTYGWg1iJqOVLMCsdqaBEGus7REcHPnROhqIf9FENxd58V4+VynYUW
 lqSen/2TT2UkeZLFXWZnNxAp4+f00TCMpgP/ds0Z5fZPojHcU+/CWMf6Afmjb3JlIMRxq3Slzr9
 rtlsLmummcH6B5aaHb+DPvdJdypxibCHPWJHa/BOc3taY/3/tddJ94WuMHBiY1ARzYtTFIBvt3g
 s9vJGXYUPttRq7xkxtMi5A1hB2N4GhdYeWYJQhYotaFc1hjI6PVMpDPaJI+/HS3Ba/2+C98dsPe
 VxGzOOUJ0rc23vFGTblKF/Yjer8X0Iktvi/WZ5z4gBtYwuZNumnkestMqB02Z0aOmfaQIbdHchS
 j3oPTYHmoqo8NeFB64Q==
X-Proofpoint-ORIG-GUID: CSLoUwbwddjEk2EQ151WcOWRRh_dZJ3r
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d764f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JQKlb9f-Zrdw7sqUV9EA:9
X-Proofpoint-GUID: CSLoUwbwddjEk2EQ151WcOWRRh_dZJ3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090072
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] growfiles:fix test failure due to missing directory
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

From: lekshmi-cpillai <lepillai@linux.ibm.com>

Signed-off-by: lekshmi-cpillai <lepillai@linux.ibm.com>
---
 testcases/kernel/fs/doio/growfiles.c | 35 +++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 21960f82a..5a76ef4c5 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -119,6 +119,38 @@ int lkfile(int fd, int operation, int lklevel);
 int pre_alloc(int fd, long size);
 #endif /* !linux */
 
+/* Helper function to create directories recursively */
+static int mkdir_recursive(const char *path, mode_t mode)
+{
+	char tmp[PATH_MAX];
+	char *p = NULL;
+	size_t len;
+	struct stat st;
+
+	snprintf(tmp, sizeof(tmp), "%s", path);
+	len = strlen(tmp);
+	if (tmp[len - 1] == '/')
+		tmp[len - 1] = 0;
+
+	for (p = tmp + 1; *p; p++) {
+		if (*p == '/') {
+			*p = 0;
+			if (stat(tmp, &st) == -1) {
+				if (mkdir(tmp, mode) == -1 && errno != EEXIST) {
+					return -1;
+				}
+			}
+			*p = '/';
+		}
+	}
+	if (stat(tmp, &st) == -1) {
+		if (mkdir(tmp, mode) == -1 && errno != EEXIST) {
+			return -1;
+		}
+	}
+	return 0;
+}
+
 extern int datapidgen(int, char *, int, int);
 extern int datapidchk(int, char *, int, int, char **);
 
@@ -482,7 +514,7 @@ int main(int argc, char **argv)
 			unsetenv("TMPDIR");	/* force the use of auto_dir */
 #endif
 			if (stat(auto_dir, &statbuf) == -1) {
-				if (mkdir(auto_dir, 0777) == -1) {
+				if (mkdir_recursive(auto_dir, 0777) == -1) {
 					if (errno != EEXIST) {
 						fprintf(stderr,
 							"%s%s: Unable to make dir %s\n",
@@ -3058,3 +3090,4 @@ int pre_alloc(int fd, long size)
 	return 0;
 }
 #endif
+
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
