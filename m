Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114F9F3D5FF
	for <ltp@archiver.kernel.org>; Sun, 29 Mar 2026 11:33:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F330A3E21F6
	for <ltp@archiver.kernel.org>; Sun, 29 Mar 2026 13:33:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35F323C6FD7
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 13:33:03 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 346321A00147
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 13:33:02 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62T8t3t02786047
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 11:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=C4nK0oV1eFlaFS1LIonuhN/PPACEoGSG2paATNIDI
 jk=; b=XTfFupsksp6Q9CdKIJN1eTmkLygzB2/YUsTj2j0x/Z7ICEfVfdIEKq0f9
 npodbhk7tHMY5HDw2vufiJ0vsoqlrGfDwW+EaQVWtraitk0oKw3kJxtjnSUIGulZ
 EB5K1TiVGBtMwriq+LGWx6QX3iYmx7HVYkVTGvedlbZU1AhRfCpzkdRMFlmOSNR2
 vETR/J4xurzF3YwQkoTta06zqZs7w4I6zjAgM6oWJIUeYF6V+lkFZVyaZhi8ZCUa
 kBz41zfwo0mUy5+22tNg0cFBMkwHXgcc9NJ9LOXe2M8gb0nWjAqygGI/gsk7zcWf
 X909rQDPc9tpD3Ty880awmYxU2RTg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc37ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 11:33:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62TAF8i1031034
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 11:33:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjh119-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Sun, 29 Mar 2026 11:32:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62TBWuW744761382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 29 Mar 2026 11:32:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EE8620043;
 Sun, 29 Mar 2026 11:32:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73A8720040;
 Sun, 29 Mar 2026 11:32:55 +0000 (GMT)
Received: from li-49acbccc-2994-11b2-a85c-d51b89e344f1.ibm.com.com (unknown
 [9.124.209.6]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 29 Mar 2026 11:32:55 +0000 (GMT)
From: Pavithra <pavrampu@linux.ibm.com>
To: ltp@lists.linux.it
Date: Sun, 29 Mar 2026 17:02:52 +0530
Message-ID: <20260329113252.204926-1-pavrampu@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69c90dec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=46T53Tob3IBC708BRNsA:9
X-Proofpoint-GUID: KrliZbsNZsrXOp19yEqPP93MwqPLPFB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA4OCBTYWx0ZWRfX0ob6oiiSYpeO
 c53jcMsxK/EO9Q9hZdJZt869BYrilWlsv0Bl7UvoMAAjEZhcXTgy6sah0CvSp/wCfYhp8z6JIgu
 1rDF+gtHn+jJcNSfi5jIFBEmO8Y8ZTDfbe7lmKl1eK4uCB8H8nG8Q3tCK7YBRDk+AqHtciI8lTJ
 UylusfdPdObeFOUeVnHX63+t7gSNqs0vTfRQAIDhpzfii5HEYDB8z8FfiltN1VtaFmEAfGlGzJw
 hWotowCojpZgIBxEQVa14iCddWbiH6d5y1l73IjtaCjVxDFCWE4Y9FMBZ2/CHuHUTCkZK+8rN1W
 QLaVXXKtBa6IeDcjsZyW7IPQPtUw36UkCGhEVhBNv1/63hdD0PR76h2G5exSpbZEohbdN05pwoi
 F7ncBeqs87H6IvY/RoY14cqTvQRSZEw+dHJtMGfKAq1c6HESG8hhCbOlg3R8PXmOFA4AwnboL++
 5mQ0Xd+nXnbrMo9ZVdg==
X-Proofpoint-ORIG-GUID: KrliZbsNZsrXOp19yEqPP93MwqPLPFB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603290088
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix memcontrol02 test failure on powerpc.
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
Cc: pavrampu@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

memcontrol02 test is failing on PowerPC with 50MB allocation. Increase to
100MB for both anonymous and page cache tests, and bump minimum
device size from 300MB to 400MB accordingly.

Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
---
 testcases/kernel/controllers/memcg/memcontrol02.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 0b79403c9..fcce82d68 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -32,9 +32,9 @@ static struct tst_cg_group *cg_child;
 static int fd;
 static int file_to_all_error = 10;
 
-static void alloc_anon_50M_check(void)
+static void alloc_anon_100M_check(void)
 {
-	const ssize_t size = MB(50);
+	const ssize_t size = MB(100);
 	char *buf, *ptr;
 	ssize_t anon, current;
 	const char *const anon_key_fmt =
@@ -58,9 +58,9 @@ static void alloc_anon_50M_check(void)
 		     current, anon);
 }
 
-static void alloc_pagecache_50M_check(void)
+static void alloc_pagecache_100M_check(void)
 {
-	const size_t size = MB(50);
+	const size_t size = MB(100);
 	size_t current, file;
 	const char *const file_key_fmt =
 		TST_CG_VER_IS_V1(tst_cg, "memory") ? "cache %zd" : "file %zd";
@@ -102,9 +102,9 @@ static void test_memcg_current(unsigned int n)
 			current);
 
 		if (!n)
-			alloc_anon_50M_check();
+			alloc_anon_100M_check();
 		else
-			alloc_pagecache_50M_check();
+			alloc_pagecache_100M_check();
 	} else {
 		tst_reap_children();
 		cg_child = tst_cg_group_rm(cg_child);
@@ -136,7 +136,7 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.test = test_memcg_current,
 	.mount_device = 1,
-	.dev_min_size = 300,
+	.dev_min_size = 400,
 	.mntpoint = TMPDIR,
 	.all_filesystems = 1,
 	.forks_child = 1,
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
