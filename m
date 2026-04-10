Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316D5F36BAD
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 06:00:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99B873E2962
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 08:00:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53CE03E12D9
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:59:55 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF5E420077C
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:59:49 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A1oNTo2299314
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 05:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q6oUlfqIU6UebAeE9
 5YBUx55wHLeSPfrW/Vk3flMfOE=; b=n22NNy5lMDdRTo+9nOxozqwaNVv9llxxe
 v1L4451MMi2DDQUZAb99cs8BRgmVNMn1XmRxO2DUlZnVavdbf3mW7NUdAw/k3q0e
 P+dpRHh3iuaEFObXc/bO9XW2XzITBGVJMYy4tbyiv/SHUJFShwPaxTrYbCZzi4vP
 HUS3aOkJRRg18pf5LfDSRaT4lZYiIp/kODp4ZMAJifFh9iaEThXPzcMI9qlJBq2O
 62lJn5i7iIyAHccmGaOG2LAwYn72hmbg9zZbO8bOj/X9aThGrXGES6TWpGfvDOs/
 waubYYK3yBHHPrspcfdQa+Kat4g10r+gWVUwuCiWEMI1eCs75UlGQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g7gpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 05:59:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2Q5n2019008
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 05:59:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9prkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 05:59:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63A5xhGr32047492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 05:59:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F00D12004B;
 Fri, 10 Apr 2026 05:59:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E67420043;
 Fri, 10 Apr 2026 05:59:42 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 05:59:42 +0000 (GMT)
From: lepillai@linux.ibm.com
To: ltp@lists.linux.it
Date: Fri, 10 Apr 2026 06:24:07 +0000
Message-Id: <20260410062407.2839810-1-lepillai@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260409090018.1254510-1-lepillai@linux.ibm.com>
References: <20260409090018.1254510-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d891d3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JQKlb9f-Zrdw7sqUV9EA:9
X-Proofpoint-ORIG-GUID: DvEuW-5opc7hbrnAx5CvK9hKpfuPS2W2
X-Proofpoint-GUID: DvEuW-5opc7hbrnAx5CvK9hKpfuPS2W2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA1MSBTYWx0ZWRfX6WPXBj6OCt42
 5eJJZgap1eyjxEhUeZZ2/BJeMUJzxgKS1UrTYkn+ZZA7ajfiwLsc7LDEdDNjiUvYzS106nn2+Ow
 sTxg3nuXOhsKfrLbOG/rTwjdfuXbjzY/eb8E1iD7Hr6jE1E1edfcNp39sSr6b2BGYIl2j4XunCb
 F+qZK1NLZ5i7DmlQF5JWovv7m2CyUwVygoVpQRUrMSrxt94Nfbxy5WbgVLC+gUWpRkS3gUlpS90
 Sz3iOk/s0Xe/WXlZYu69CkkSbAlIggni+t9Wa5ULPBCBWMlUyOBW1SyIyMwEKqjidjKIFsaGxCq
 REjIoVWdN6U8kTiKlwo5sv0Jbf69DyBy4638ZsLdEkZUqkdevWIFr+9/ESCADRIbztX47sJX76p
 5Kp4rETNEeDkXUC4wz1jCz3MLzjE+d1aWgn6tGpPF6ffIdAN/lZDvYlHEZQEwHqKj16zcpTVn9u
 +McJpfbHw4hbp882yTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100051
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] growfiles:fix test failure due to missing
 directory /test/growfiles/reiser
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

-The test attempts to creates the required directory structure recursively(which was not in current code),Sets appropriate permissions (0755)and  Verifies the directory is accessible
-Added proper error handling

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
