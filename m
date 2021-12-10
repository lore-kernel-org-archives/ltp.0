Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAF7C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5593C8651
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:40:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0208A3C0761
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:40:47 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC8671400740
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 12:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639136445; i=@fujitsu.com;
 bh=97cjEoC9TjYMb7unMJSQ0hzf2GTirX4eDkYvOLmRKC8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=fdydPfD81YTR/zZhs05i1Fa8AH620jSrZIaLv49QXTRR5bbutW9jji7gfiF2yLXvw
 0gmVIFuNsqa4Xu8qWtysmRlQEBqv51yNdmIWTVbiad/e9eCCLuAvuUGPVWv2dVHJr0
 w/E2eeK1GRgyW0d8Sqp1yIJZvBpb+xwq4TyOT8Qpsbu48nzmUDN7yP+1O46MOfvzN+
 sB2CJ9fJRJfQAJcxle5AVkA19lCGGfxLXGek+N0PR6ijnEWbqcqrnqDzCKtpePrmye
 N/PdnlllTKz42p03l0n8NT7DECUuIENBYc65FSgDm+zP9ySqHMLFPXFDKkwcBn8wGs
 Q5KVCuQv1SB9A==
Received: from [100.115.39.64] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-2.aws.ess.symcld.net id 06/76-09428-DBC33B16;
 Fri, 10 Dec 2021 11:40:45 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxRXevzeZ
 Eg1tr5C1WfN/B6MDose/3OtYAxijWzLyk/IoE1ow1n1+yFNzhrPh9YDtbA+Maji5GLg4hgSYm
 ieeXrrFAOHsYJWbM/MfcxcjJwSagKfGscwGYLSIgIdHR8JYdxGYWUJdYPukXUxcjB4ewgIfEn
 1e5IGEWAVWJu80L2UDCvEDhxn4OkLCEgILElIfvwaZwApXM/w/SyQm0SkVix+UGNhCbV0BQ4u
 TMJywQ0yUkDr54wQzRqyhxqeMbI4RdITFrVhvTBEb+WUhaZiFpWcDItIrROqkoMz2jJDcxM0f
 X0MBA19DQVNfYUtfI0EwvsUo3US+1VLc8tbhE10gvsbxYL7W4WK+4Mjc5J0UvL7VkEyMwJFOK
 1W/sYHx/6ZveIUZJDiYlUV6x35sShfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwMlpvThQSLEpNT
 61Iy8wBxgdMWoKDR0mEdyNImre4IDG3ODMdInWKUVFKnNcCJCEAksgozYNrg8XkJUZZKWFeRg
 YGBiGegtSi3MwSVPlXjOIcjErCvJogU3gy80rgpr8CWswEtNi5ZT3I4pJEhJRUA9OK2FtN/x5
 cdRNgfXSvVVHrzscj6vJTxM/9YmtinKCYGxQY/v//VInJ3iph/NoRk07mL6oxZ3rpXrXdgT/d
 9FhTQ+HXasXtrKpRuRcSepe9e8T+yfiG3UVBGYe+L9FZmlInrDbduhfU/vVl8+H6UKXZica1c
 +SfffRcv6RWTO9CmcSr3M5J37oqTuozL/pU3FGns+tJgPv99U2FAVIWkjOnS9w/tSfHoWaxRf
 /+oLaO712xmktb9R77n7v/3rWl6lb2soq/tqlC6+PTKqxO+x/ka5iXWpb8fNvvI/y3HP63etY
 bbff4qvFvQX/rtE3H+Kp3LLfYO+93/Ios6VwOmQ1h065uzpq1kuP2wYv5O5VYijMSDbWYi4oT
 AbGccXREAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-571.messagelabs.com!1639136445!20844!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17131 invoked from network); 10 Dec 2021 11:40:45 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-11.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 10 Dec 2021 11:40:45 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BABePtQ022674
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:40:45 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 10 Dec 2021 11:40:23 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 10 Dec 2021 19:40:46 +0800
Message-ID: <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YbJ3SKsLu7iNoqZc@pevik>
References: <YbJ3SKsLu7iNoqZc@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] swapping01: skip test if zram-swap is being
 used
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

For the swapping test we attempt to allocate 130% of the available RAM and
we make sure that the overflow would fit the swap, but as long as swap is
backed by RAM this obviously false. So skip it if zram-swap is being used.

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 392b79d65..aef47e9a4 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -40,10 +40,10 @@
 
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "tst_safe_stdio.h"
 #include "lapi/abisize.h"
 #include "mem.h"
 
@@ -67,6 +67,14 @@ static void test_swapping(void)
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
+	FILE *file;
+	char line[PATH_MAX];
+
+	file = SAFE_FOPEN("/proc/swaps", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "/dev/zram"))
+			tst_brk(TCONF, "zram-swap is being used!");
+	}
 
 	init_meminfo();
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
