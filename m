Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD47E9DE6A
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 582D43E2A04
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:35:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853913E216E
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:35:25 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BE051400345
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:35:23 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Iaudo2591197
 for <ltp@lists.linux.it>; Thu, 9 Apr 2026 08:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TZC87IlG17k2uuaGv0lxbZsEBGMMSfW1HvNuAfKcl
 Wk=; b=D5B+Iq2jIeplvdG3Sl2AexD6j0W7N4hIOvgKdg+mhqZbmZgITuwzC006u
 Cynw5kQTeHntLwJ5wRcKuNPAnzf2l4mAV6qoaW766U9Ga5PNJScXwsWquUg0IpsA
 nTorq1DpHKbuR8oRGkZGFe5Ep3ui9753wht9IoS0BrIuaTVv5y3Gh6KQT7L9UBdP
 4AnkCt4iLMywMvZcbNqifxe8cvAM/e0TzB9TxujOy+ySkWN9gQlfmPL/nMpGNk/N
 VtQHjzom10o4epG55D6mQsnd136vTUyOGOXfdqRDL4TZ6UWcz4YjPxRNnglekz0Y
 YA5iigj+KsgWoA1Q6Z79cfl578KoA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ec2s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 08:35:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6398BAeW030068
 for <ltp@lists.linux.it>; Thu, 9 Apr 2026 08:35:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7jty6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 08:35:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6398ZG3C34799918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 08:35:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 938C820040;
 Thu,  9 Apr 2026 08:35:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6F6F2004B;
 Thu,  9 Apr 2026 08:35:15 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 08:35:15 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Thu,  9 Apr 2026 08:59:37 +0000
Message-Id: <20260409085937.1253631-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLyTuDZiUwPIuy4FLBguUnHk0INO9N8a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3MiBTYWx0ZWRfX9XOM04w9yj/d
 KpEH2c0gNiRuB1dM2DWSt/s0Hv44nUsvNIDzCVgssJD44FucAtxPpoNKTxd6MdQkaH0gsRyo/Ue
 EWTNNO2FTjLmF4QaWU6XS2Rtw+WLiSDXTmIr6+pkmrdPVfpkU4jIjoQOTcVNwtZyy1fk+CXN7cx
 npOilqcv+0NxxZd8NMNLX2sbQigoQ+gKS9PhxAShS9i/V3V8ZF1IB6bR8M31G+hVVTc3vfeHOMJ
 0GlS8DeE0oB1GhKEuefUFULwtF1A0Wx65wJ/kOj/DgewE/P36XaRGYJfUC3hotvk5yUPiCCPEa3
 75SbZPgUVoUITWkstMqKXyLyZUp8tH+kRpr+bEDkt1+LEKZb2sc+xetRauwiwqXLar8hqeqyvex
 pfadY7st0Lb0jKvWHiRITwle/TlIR62ccR7dQLc+TauZoggXSKcWlaOWGkJc5EDV5MFThbOFgEW
 JmrPC/qCzyVTWqFiBPw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d764c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=JQKlb9f-Zrdw7sqUV9EA:9
X-Proofpoint-GUID: oLyTuDZiUwPIuy4FLBguUnHk0INO9N8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090072
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
