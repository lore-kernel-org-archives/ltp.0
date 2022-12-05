Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23CEC4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 06:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF0F63CC1E6
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 07:57:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60F7F3CC1E6
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:38 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A22F1A0C00D
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 07:57:37 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQZ526lkrzqSr6
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:53:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 14:57:34 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Dec 2022 14:54:31 +0800
Message-ID: <20221205065432.242539-3-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221205065432.242539-1-zhaogongyi@huawei.com>
References: <20221205065432.242539-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] lib: Replace atoi/atof with
 SAFE_STRTOL/SAFE_STRTOF
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
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace atoi/atof with SAFE_STRTOL/SAFE_STRTOF in parse_opts(),
it is hoped to deal with the abnormal input.

Modify the requirement iterations range from '>= 0' to '> 0',
when iterations' value equal to 0, the test will not run.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b62559d75..23d21c825 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -14,6 +14,7 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <math.h>

 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -677,15 +678,13 @@ static void parse_opts(int argc, char *argv[])
 			print_test_tags();
 			exit(0);
 		case 'i':
-			iterations = atoi(optarg);
-			if (iterations < 0)
-				tst_brk(TBROK, "Number of iterations (-i) must be >= 0");
+			iterations = SAFE_STRTOL(optarg, 1, INT_MAX);
 		break;
 		case 'I':
 			if (tst_test->max_runtime > 0)
-				tst_test->max_runtime = atoi(optarg);
+				tst_test->max_runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
 			else
-				duration = atof(optarg);
+				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
 		break;
 		case 'C':
 #ifdef UCLINUX
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
