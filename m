Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CF6C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 05:44:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411B63C8979
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 06:44:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF1C33C0B90
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:44:40 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28F6F10005BB
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 06:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639374278; i=@fujitsu.com;
 bh=evaJqqkGaylDpRYT3blh5oEaPWKw4ObFAinvz33gFPw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=mDpoKgRsLXsZifV+410jIo3lixLCKoe6LYi91fYQ94OAAZL4DFJ8lmfU1pblNV6Mc
 wozrWGfKtq2mgV6RYwu900DxGsFiEY2gA/QIZ4TiV3KNLsHenKJoJrRvnpcO8/rdyj
 BZIBZQhVZ/wLT1M9UqT/nYAG30YWksUbiVoVLV/kbXYJkXP0vsiHgJGSYz05dFRN5E
 udK5/4ZAPqCvXOL25hKPtlNcxGWGBVR78HbievL3GA1ife/0Dcp4OLsDXitDxORp8n
 lJzpKLx1csydipuSiCXmL2/dWnMRUIuPYK4v+qZhyVrwZn3TsFPkBzXAyogniypSYK
 wnDUSpswpEbAA==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id E6/61-30341-5CDD6B16;
 Mon, 13 Dec 2021 05:44:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSffo3W2
 JBvvvK1is+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBn9r2YzFuznqnh5YztjA2MjZxcjF4eQwFlG
 idm9h1ghnJ1MEhMvzWWDcPYwShxadwUow8nBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXE
 4gtLOAhsef/ZhYQm0VAVeJv93GwGl4BT4lL8zvAeiUEFCSmPHwPZHNwcAqoSLx+GQcSFhJQlp
 i+9DUjRLmgxMmZT1ggxktIHHzxAqpVUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+FpH0
 BI9MqRqukosz0jJLcxMwcXUMDA11DQ1NdU10jU1O9xCrdRL3UUt3y1OISXUO9xPJivdTiYr3i
 ytzknBS9vNSSTYzAIE4pZv2/g7G776feIUZJDiYlUd5vjFsThfiS8lMqMxKLM+KLSnNSiw8xy
 nBwKEnwttzaligkWJSanlqRlpkDjCiYtAQHj5IILyMwqoR4iwsSc4sz0yFSpxgVpcR5j94BSg
 iAJDJK8+DaYFF8iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw7zSQKTyZeSVw018BLWYCWVy
 5GWRxSSJCSqqBKemx6x9eJu57bzZei3gctTM98kxSn/YP5jJGM4MFyyzvNRzPdhVmzPiWe9a7
 srfxwPZIFhYtR+Yqk3ILneV2NZ1PSw6rflrOafhl5qOZr67ulo+vYphXu8wxQO5fQLqSj3Xvu
 URfX3MdUb0vR2b5T3wd5lW+Lyv5i3Ok+a8UOya708s8HXccb3puvcWe/+Kf4we2S+6QiVjA4z
 OX5d712KwaK40knfBZ7HyJ5w5bPjzE/0ilqizUr/fas+DLx5vfiP75b/ZMYa1/7rE45b7Cew9
 uNYr3ebKtXhrN3qNRZHRF0W/JzSDWq9opslPnpuyS+ruV+9cvA7HjE8W9S48/Yd12UdDB9L9U
 o61Yg70SS3FGoqEWc1FxIgBzMvU6XQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-585.messagelabs.com!1639374277!154814!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3175 invoked from network); 13 Dec 2021 05:44:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-5.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 05:44:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1D7C21000F6
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:44:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 11070100047
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 05:44:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 05:44:07 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 13:44:19 +0800
Message-ID: <1639374260-22887-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <YbNH1J8E3nzH15Cu@yuki>
References: <YbNH1J8E3nzH15Cu@yuki>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] swapping01: skip test if zram-swap is being
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
