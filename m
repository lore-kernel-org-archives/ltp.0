Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3612EFD5F77
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 05:05:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93D693C0648
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 07:05:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACA6C3C0648
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:05:01 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D71151000933
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 07:05:00 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637EtMkL2211769
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TZC87IlG17k2uuaGv0lxbZsEBGMMSfW1HvNuAfKcl
 Wk=; b=jiZeTTjtSlshAZSR8VzqIdk8XvNrsM+Ae/vTiYFKqJYAD9PGNDPUVwJzf
 EMfk8ALgL6i1OwZ9aTUQ0/WDeCoXttISficEmqf4B1r/obrOHwXxPHkPy2YBNuM+
 zceK6nwWMLdjnZ74T1WBViJD6IHx3gx1A8QfU6Bf9aaVDsIiD4irMB+W1+Fnq80I
 /pkexi1CkJ/Cb+rK1fMJpemuJ7+08tMSo3rwNJHIpBzlQslGhfvcttVSjtA9EAff
 v5a5rxEeJWvh3bIWbAUiqT/UWHjl11y4HCm4E/2EIOzOsNXie67SE0boa4tierS1
 L38suRssebhuOd8lfTzbJfAFKMHYA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hdtj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:04:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380PV18026707
 for <ltp@lists.linux.it>; Wed, 8 Apr 2026 05:04:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7x1sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 05:04:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63854r5M31195488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Apr 2026 05:04:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6D0E20040;
 Wed,  8 Apr 2026 05:04:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4663B20043;
 Wed,  8 Apr 2026 05:04:52 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Apr 2026 05:04:52 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 05:29:10 +0000
Message-Id: <20260408052910.3811654-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0MSBTYWx0ZWRfXyhnEla4odWOm
 ptfQeyYiapdmkCeE+bw9vs+li1H+aBJH5/M1VvVrtreNnry9eh+e83uS/XNwAEE3dChcfBFcfuE
 ZKkQJd5Su74M3omjL3gOgc64X8fQxBj6DVshqc4xVwuSN/PPfLWBuF8fqIh6/V2zxC6z2KxqEqM
 cS1kEb8awelWLWAVv3IMhUrpgalh8sIE+dEckVBgA2bShUkumcAz/oCU2GM3962K96d+WFQLFlP
 PslCxlXonc+WVpGsLZjgO6cSrJv8/t9ctlLLAa/hvZQOc3zEWSDxsxtNtgbL48NB+FHQQbB3NT2
 /h5ijAdyTW2tRTuqJNGq7+Yjx6fyHI0I5w8V2N6SkyTZbbwzS7MR0r9QAHgE/G6KwXQk0D6jJTo
 b0MoVq1rxrONIQ7Z0tyD77Z9BxGGqo+2AvpSU2L9KhIz5eff8aAeagVlTpmDm1OSKq3fIiU+p2h
 HhKyY41yd3sb5WTDKcg==
X-Proofpoint-GUID: hJZ0K4Cx4hM3on_qeuIAYVVnMe3BGClE
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d5e1fa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=MPeClQraqjtvOJeD:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=JQKlb9f-Zrdw7sqUV9EA:9
X-Proofpoint-ORIG-GUID: hJZ0K4Cx4hM3on_qeuIAYVVnMe3BGClE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080041
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
