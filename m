Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AF4FD5F77
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 04:52:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7131E3E1E18
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 06:52:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FCA43C0648
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 06:52:29 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C57002000C0
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 06:52:28 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63843s0F2297475
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 04:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=xv0cVzbpc6god1Aw9wEjKRkuOi6LFsoCn886Q9rvu
 NI=; b=PMUtSFrMCVa6d/bxCD7+gbeU4bT6Md8Ei+5qWZgs3cTGmZDny9JP8QDXr
 fjD0rIs+hC2LGP/Xbi0Z+wlxVAW82xNfMdO9XPd3uF65ea3nPv5z6WDXRwwLPaJf
 U4Fu/1pS2u8Sfj6Mun52UeROFQnmWQitBqR+LGRfPUFqCe+BxPTl845tiyQ/fVLe
 N6YAD1fnf8tpVv7mS1ig8eembEB1/3paxZL5XqXX/00DGQGi/msg1wdm8v05lhWN
 a6h8RYnBk535mDrC+/UMAv/hCXZT0gdhnJpsrRSvUXSbVFircw+0ypnE0lrqHsmj
 riGQFu7CTfjX2SF47Bor3JvD5dGdA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwte7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 04:52:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NivpY030058
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 04:52:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7e1g6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 04:52:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6384p72P54198700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2026 04:51:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4026A20040;
 Wed,  8 Apr 2026 04:51:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D97C2004D;
 Wed,  8 Apr 2026 04:51:06 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2026 04:51:06 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 05:15:24 +0000
Message-Id: <20260408051524.3803026-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5df0a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=MPeClQraqjtvOJeD:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=JQKlb9f-Zrdw7sqUV9EA:9
X-Proofpoint-ORIG-GUID: a7G_wHmRZdk6-UgBfV6uHFMsE0I4kGkq
X-Proofpoint-GUID: a7G_wHmRZdk6-UgBfV6uHFMsE0I4kGkq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0MSBTYWx0ZWRfXx8zj/cZGu06m
 XSwKn5tNY9gxw//o/yN+0s69R/CbWlOi2a7QG4SWG63PemB5fSyNOrpqEYNIa3dn2iYpVfxXse3
 j6e6/dau2PU0ruGI6uBojEoLjvw7wLpigANTY0hMC5Bw6kLnLy8pm7GQ/LdVxCJqxpflaHdac22
 FxK51n+V0/aseSTURHpp7fwusE/3lsUKfhS+m7XQ0+JJWFu5qe5Gi6AhSXl6DkpeltJxxMJcVgj
 8gRyBZrg9q6ZWwVCBDiHAq3KSVMqi6Ha7t7CngHBjX3UbaObsvg/YJRyrMj2XWdlI0bYmqHc5Np
 Rn9AN1P0TqSxSEIQR85F0Z41kA5qnZn1fH3qZGf7Jb3pG5Run+erjaiBofJK6hjqAcBc9R736jN
 naihs49UHu6cP5/yEqhwX1OHRMwXzhg6WXMWe26eFk4xlaB3NNJ12WZAvvoYxBs7dQ5PJRI/Vyc
 MHq5UOOcDaZOv+cX+kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080041
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] The error indicates that the test is failing because
 it cannot create the directory /test/growfiles/reiser.
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
Cc: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>

Signed-off-by: lekshmi-cpillai <lekshmi@ktes.isst.tadn.ibm.com>
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
