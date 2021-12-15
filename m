Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C06C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59D6C3C8D84
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:20:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74AAE3C7FC9
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:27 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A541A1400276
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639552825; i=@fujitsu.com;
 bh=evaJqqkGaylDpRYT3blh5oEaPWKw4ObFAinvz33gFPw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=s1UJZ9VoQ1ZVRZNcFuSZG3/WA84+zC9uhPCnfvJTSpBz8I+5KM5XdTZg+8w+cV8C5
 BYr9lpfaYBVCSYkmns75w1iXLRbPGuAKMlRQdr1QOMbIfxGeStAtkySxbfJN3Rl0es
 gWdJFEB23yzyp0Grzlp4UcOWr++DyRN3yUkLVZFR+I9yM0UyFwOYmTUp8Rvgz/4DsX
 aaAAPtKprCgCSlCaPaGopt49qpiysZPK5HnxAZ/btoQT+arIo4OnFjhKHg9mTdbaIJ
 dtZ+94+xgrCvN1N5Ktf40EHGlfarNtwLtwspmRShXUjaHQgEjNSst0tHcpUPb4n+rx
 vR2P9QZHWUDRg==
Received: from [100.115.6.23] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id C9/04-10124-93799B16;
 Wed, 15 Dec 2021 07:20:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRWlGSWpSXmKPExsViZ8MxRddy+s5
 EgxcnBC1WfN/B6MDose/3OtYAxijWzLyk/IoE1oz+V7MZC/ZzVby8sZ2xgbGRs4uRi0NIoIlJ
 4sy6w+xdjJxAzh5GiXfduiA2m4CmxLPOBcwgtoiAhERHw1uwGmYBdYnlk34xgdjCAh4SLx6eA
 qthEVCVODPvBZjNCxT/cPsPI4gtIaAgMeXhe6i4oMTJmU9YIOZISBx8AVEvIaAocanjG1R9hc
 SsWW1MExh5ZyFpmYWkZQEj0ypGy6SizPSMktzEzBxdQwMDXUNDU10TXUtjvcQq3US91FLd8tT
 iEl1DvcTyYr3U4mK94src5JwUvbzUkk2MwABLKWaJ3cG4te+n3iFGSQ4mJVHet+U7E4X4kvJT
 KjMSizPii0pzUosPMcpwcChJ8L6cCJQTLEpNT61Iy8wBBjtMWoKDR0mE99hUoDRvcUFibnFmO
 kTqFKOilDjvVpCEAEgiozQPrg0WYZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfPaTAKawp
 OZVwI3/RXQYiaQxbnbQRaXJCKkpBqYnA/vLFUu9d0car5v9nyzgm/vBbOe7+a8UlM//3RZYRc
 je2zWSbZH7xq+hCznqNz1wUCw/e6UdGWfLeYpFxkmzV/uqX/t+I8mX9kyCwbDwMmsT25wvZw+
 r+jv4/dO8neWnBCbVTJrStm3/vcOlR/tZxcv32K66PPeabP674aFL8yxNi55tkOEsY+lrWvl/
 w/rf0b5zOHpZ+aMmRY8YYXEpsppbH5pcmVFRVOTrHj/fNsd9uFlbPi1lw2vp+6ceurDy5mq25
 vKH/CKv37QE+FusUagYs6t+w9vfp3sEj/3HU+c5IakjDUTlrpaJf7adYGxtHj6lVlrw523JAb
 NO9pXZVrE+6Kez3wxr09+y+mX0kosxRmJhlrMRcWJAI/VHO4rAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-591.messagelabs.com!1639552824!69972!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22201 invoked from network); 15 Dec 2021 07:20:25 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-5.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Dec 2021 07:20:25 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BF7KJT3006429
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:24 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 07:20:17 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 15 Dec 2021 15:20:46 +0800
Message-ID: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] swapping01: skip test if zram-swap is being
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 392b79d65..925790186 100644
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
 
@@ -67,6 +67,17 @@ static void test_swapping(void)
 #ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
+	FILE *file;
+	char line[PATH_MAX];
+
+	file = SAFE_FOPEN("/proc/swaps", "r");
+	while (fgets(line, sizeof(line), file)) {
+		if (strstr(line, "/dev/zram")) {
+			SAFE_FCLOSE(file);
+			tst_brk(TCONF, "zram-swap is being used!");
+		}
+	}
+	SAFE_FCLOSE(file);
 
 	init_meminfo();
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
