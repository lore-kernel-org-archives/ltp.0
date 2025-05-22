Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D2FC54756
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747906240; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=pvQbJBRguyUKM3idzCTR88DXcnNkuC3Du5GFI9JXEiY=;
 b=bNYbb6McQm1z/WwzqM5uZEpPUisuC3F30fPaQ0jtdqq/Lxh/jpyyMqul7L8xvjg7Zls0B
 Bg8ODTZ+Oh6Xqb5dZdYbjFy/NXQfiJLUQI3h/YDgmfxHfB8V1izX3ydT0oPDJKgrcOaA84Q
 DoFIF/uOOWDeEGaYL5rlSJfISJSglw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8950F3CC736
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 11:30:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659E03CBAC9
 for <ltp@lists.linux.it>; Thu, 22 May 2025 11:30:18 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0BD6600721
 for <ltp@lists.linux.it>; Thu, 22 May 2025 11:30:10 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9H3mT013221
 for <ltp@lists.linux.it>; Thu, 22 May 2025 09:30:09 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfwtbqa-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 22 May 2025 09:30:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 22 May 2025 02:29:49 -0700
Received: from pek-lpg-core5.wrs.com (128.224.153.45) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 22 May 2025 02:29:47 -0700
To: <ltp@lists.linux.it>
Date: Thu, 22 May 2025 17:30:03 +0800
Message-ID: <20250522093003.1958528-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5NCBTYWx0ZWRfX2oewmG2h8rhJ
 ykSiY5fRwOKeSZe4UjdpIZ8IAL3ODSbbxpvd6UyM6JNHJmGSZcYswjiXpu0aVofhNc9BW1kAZvm
 sI0PtCSSL0Qy92fuKjEyzgu/hllit+QKbEp3BcWdTr/UhmwGKgT8HbpbETdbeK+sZd6oFJEmA65
 obeDOXsXWoNN5bMXD87nQARX7H3LHKyxMDPKIxO4FFSWWW4lLLDVH+DbUBTL4VeJIB9vAqSoJre
 jHn+5psZQvMzdB9hqCftSopTMvMGHDHjeLczqh5OuamCvzqXvsK2HTdxXx9P/hK3opejHBvzt3u
 rwIShEh1ixd6q0QfVM4jsH5dfnCe44/BsQcxEr6MwkjcI5rBzfWCMCCxBVqDCghzrPLMp8/5SnQ
 qr0D+fRLuhCCDL03p6QvaOWG1TSlqmA7OoVWJeDqfnzzl5jX5EAcd3IPr2i5gyDMVuziPjlS
X-Proofpoint-ORIG-GUID: H7pCgLSKjjMq2Ly3SeAbKsBpA3_8BYsT
X-Proofpoint-GUID: H7pCgLSKjjMq2Ly3SeAbKsBpA3_8BYsT
X-Authority-Analysis: v=2.4 cv=b6Cy4sGx c=1 sm=1 tr=0 ts=682eeea1 cx=c_pps
 a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17
 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=PXjPc0Suysfkux3l2gYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=873 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505220094
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ipc: Skip msgctl05 when
 __USE_TIME64_REDIRECTS is defined
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
From: Jiaying Song via ltp <ltp@lists.linux.it>
Reply-To: jiaying.song.cn@windriver.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Jiaying Song <jiaying.song.cn@windriver.com>

The msgctl05 test checks if the kernel clears the *_high fields in struct msqid64_ds.

However, when __USE_TIME64_REDIRECTS is defined, this structure may not
contain those fields due to header redirection. This patch adds a check
to skip the test in such cases, avoiding false failures and improving test robustness.

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
index cd2643b..27beeb8 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -11,7 +11,11 @@
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 
-#ifdef HAVE_MSQID64_DS_TIME_HIGH
+#if !defined(HAVE_MSQID64_DS_TIME_HIGH)
+TST_TEST_TCONF("test requires struct msqid64_ds to have the time_high fields");
+#elif defined(__USE_TIME64_REDIRECTS)
+TST_TEST_TCONF("test requires __USE_TIME64_REDIRECTS to be undefined");
+#else
 
 static void run(void)
 {
@@ -43,6 +47,5 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_tmpdir = 1,
 };
-#else
-TST_TEST_TCONF("test requires struct msqid64_ds to have the time_high fields");
+
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
