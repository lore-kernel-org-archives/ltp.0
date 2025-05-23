Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78293C3DA6D
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747986100; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0zxR0DbeWnjfGeNklBrSO8pjwOPJxeSZ/OzAIeq1+BQ=;
 b=QfFaoLi4vkAHhqwea2Xr9BIZyztyh/ygrlxQANvzWosyUgmlv2jZA4wIyQUeayTa1gLzE
 hTtrrT8Jj76eHrpLOB0juF5oiGiAmugkKRGfxDjIidKD7oS5AziB4KvsWIMtMlR3oAvpR0s
 BPGe7H2K5pudaVsPvMuXjmqnjVWY5rE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A83F23CC8C7
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 09:41:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CE803C0980
 for <ltp@lists.linux.it>; Fri, 23 May 2025 09:41:17 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FF92600788
 for <ltp@lists.linux.it>; Fri, 23 May 2025 09:41:12 +0200 (CEST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N5CGbj002016
 for <ltp@lists.linux.it>; Fri, 23 May 2025 00:41:10 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com
 [147.11.82.252])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfrbjtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <ltp@lists.linux.it>; Fri, 23 May 2025 00:41:10 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 23 May 2025 00:40:51 -0700
Received: from pek-lpg-core5.wrs.com (128.224.153.45) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 23 May 2025 00:40:50 -0700
To: <ltp@lists.linux.it>
Date: Fri, 23 May 2025 15:41:07 +0800
Message-ID: <20250523074107.3655219-1-jiaying.song.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA3MCBTYWx0ZWRfX695O82MdTEa8
 TT6AqucY3ndmEGSATXqqyxuCIeSZ2CXDnggQ/IBrexPxQR5kjVBKxGCeQ/Dr243gOzmwsZWPm4h
 TswwX56AAol7NgsETBvHqf/JdQg8yALnCt2T9TWfJiDrU6hv/Og7mfPvPJtZ6KOWtbF+MLtQaOq
 dQFxu0Lgm4LwAd3vjaqKBFlfJRtvAyE1aR2eWB+Hg/xhAJtlroAxBi/ywMzTxbjRBGmnq4gy38k
 cvkOJYYqHl2+omUhvGjWaoZeFe/t67QJD7zREac7dzmyht9NycM9JDJDaEAIjj6ty6AmVJ1bKyk
 +Q0dICoD9e5QBLUPbn1AasP16uLC0riynLZ/PuyVzoHp4/i5CTbR3Wau8MfXX+3bI/t1DBYf7zH
 X9Fzb8YaynV/I5U84cC4TP9Xj8IpIcv+RvsvFylJwGhzR+deFHdwIuZj/CE49OM97ui359Wx
X-Proofpoint-ORIG-GUID: pNgADsOLH2Df2hmVAvLKGhNtMARf9Zlo
X-Proofpoint-GUID: pNgADsOLH2Df2hmVAvLKGhNtMARf9Zlo
X-Authority-Analysis: v=2.4 cv=TrPmhCXh c=1 sm=1 tr=0 ts=68302696 cx=c_pps
 a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17
 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=E9R6e3pyeX3Z4iXZOfAA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=990
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505230070
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/semctl08: Skip semctl08 when
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

When __USE_TIME64_REDIRECTS is defined, glibc redirects struct semid_ds to a
64-bit time-safe version that omits the sem_otime_high and sem_ctime_high
fields. As a result, the case becomes invalid and leads to incorrect behavior.

This patch adds a check to skip the test when __USE_TIME64_REDIRECTS is
defined, ensuring the test only runs when semid_ds structurally matches
semid64_ds and the *_high fields are accessible.

Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl08.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index 1878bd4..3b799fa 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -10,7 +10,11 @@
 #include "tst_test.h"
 #include "libnewipc.h"
 
-#ifdef HAVE_SEMID64_DS_TIME_HIGH
+#if !defined(HAVE_SEMID64_DS_TIME_HIGH)
+TST_TEST_TCONF("test requires struct semid64_ds to have the time_high fields");
+#elif defined(__USE_TIME64_REDIRECTS)
+TST_TEST_TCONF("test requires __USE_TIME64_REDIRECTS to be undefined");
+#else
 
 static void run(void)
 {
@@ -47,6 +51,4 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_tmpdir = 1,
 };
-#else
-TST_TEST_TCONF("test requires struct semid64_ds to have the time_high fields");
 #endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
