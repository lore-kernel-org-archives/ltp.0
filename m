Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372BC433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:28:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B00960E93
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9B00960E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E23D3C898D
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 09:28:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374133C87FE
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 09:28:20 +0100 (CET)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C290601409
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 09:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637310497; i=@fujitsu.com;
 bh=Rcos8C9cLlQMGW7BHvw750vV1vytM7hmHyWfC2R/4is=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=EBpGJfMnOfMXASI1hGQOz3VzUoSwFz9u2d1gcVTLhTnEj7806smfsrC0FqW3dxgxD
 fSbwEJtrY4cVD3f5lcDDi0rgrwBcLiOf8GG2QjaK9e/3jz5XEsN+eGhNxtUsN31s0T
 oqfZl+IBn1hpg86/XfJ8HulatfQZLUBAXh5DAlu591cwcA8LFALzN8/K4/oE1g1y60
 VNTmt5tlx1R3peqCM+6tFFFAi/rFuszLpWxf7mKTgwCsTijNQJ3yYHb82daMNGxPvg
 G+DXyEWsrYETJGYLC8DzlP3k77CRaultwwXGNQMIV6ANA6LQe1+Zdc0P6leEvBk29w
 na4HNAqY2jupA==
Received: from [100.112.196.154] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 83/A1-01873-12067916;
 Fri, 19 Nov 2021 08:28:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8ORqKuYMD3
 R4Mw2AYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePmll/sBWd5KxbfXsHYwPiMu4uRi0NI4Cyj
 xJfebmYIZyeTxIUTD9kgnD2MEmem7GPqYuTkYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0C
 6iGg0NYwFri/T0OkDCLgKrE9K+HwUp4BTwl7m+czApiSwgoSEx5+B5sDKeAl8S1J12MILYQUM
 3ztr/MEPWCEidnPmGBGC8hcfDFC2aIXkWJSx3fGCHsColZs9qYIGw1iavnNjFPYBSchaR9FpL
 2BYxMqxgtkooy0zNKchMzc3QNDQx0DQ2NdA0tLXQNLcz0Eqt0k/RSS3XLU4tLdA31EsuL9Yor
 c5NzUvTyUks2MQIDOKXg2K4djG9ff9A7xCjJwaQkyqsWNj1RiC8pP6UyI7E4I76oNCe1+BCjD
 AeHkgSvXSxQTrAoNT21Ii0zBxhNMGkJDh4lEd7fIGne4oLE3OLMdIjUKUZdjtctP3cwC7Hk5e
 elSonzmsQDFQmAFGWU5sGNgEX2JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCEFN4MvNK4Da
 9AjqCCegI2cuTQY4oSURISTUwJb9Jy5SPsgxz7dxbmxPzRv7TS/nPmSznPJ2/it6cd1Pe6fo1
 r3d3Pzd8vnIh24Rvvu2tdTKzr++ey/29am+KaWY//y3TjjaFdC+5JaaROx8JJa15aFXy9sGKs
 jLR8KtPloqc+vxbeb3eyT/TAwIDLjjxvZd4/y1A3zBzoaLiIjXt/36vn1j4XUtnzWMIdlDTuK
 N6eUp4gVvAToPkKfk7mT//YSpLFDux32udyfXwi2nvri7/d0CF4wcX17QfrH+SfWzcWJp4Eqv
 4O17oCbzuThU42tHd1yYspeXl537n8ZTAkzs6k33+b1S9frP1wqS04MKkFA72ozuzI45cjV5h
 fjVPlP/rcelylbdMhVFKLMUZiYZazEXFiQDUlfaCZwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-291.messagelabs.com!1637310496!189727!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11326 invoked from network); 19 Nov 2021 08:28:17 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-20.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Nov 2021 08:28:17 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id BF64410023B
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:28:16 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A523210023C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:28:16 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 08:28:13 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 19 Nov 2021 16:28:42 +0800
Message-ID: <1637310522-19620-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/stat*: Add nlink member check
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
mount_id member check will add in the next week.
[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa2fcf4
[2]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=728009a47497b6
 testcases/kernel/syscalls/stat/stat01.c   | 8 +++++++-
 testcases/kernel/syscalls/statx/statx01.c | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index 14f1036d5..0f5c1dcc2 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -71,11 +71,17 @@ static void verify_stat(unsigned int n)
 		fail++;
 	}
 
+	if (stat_buf.st_nlink != 1) {
+		tst_res(TFAIL, "stat_buf.st_nlink = %lu expected 1",
+			stat_buf.st_nlink);
+		fail++;
+	}
+
 	if (!fail)
 		tst_res(TPASS, "stat(%s)", tc->pathname);
 }
 
-void setup(void)
+static void setup(void)
 {
 	unsigned int i;
 
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 1289366b9..63d97b8c7 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -16,6 +16,7 @@
  * 3) mode
  * 4) blocks
  * 5) size
+ * 6) nlink
  *
  * A file is created and metadata values are set with
  * predefined values.
@@ -99,6 +100,11 @@ static void test_normal_file(void)
 		tst_res(TFAIL, "stx_blocks(%"PRIu64") is invalid",
 			(uint64_t)buff.stx_blocks);
 
+	if (buff.stx_nlink == 1)
+		tst_res(TPASS, "stx_nlink(1) is correct");
+	else
+		tst_res(TFAIL, "stx_nlink(%u) is different from expected(1)",
+			buff.stx_nlink);
 }
 
 static void test_device_file(void)
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
