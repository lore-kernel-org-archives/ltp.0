Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5039C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:31:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C301D3C67D6
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:31:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5853E3C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:31:01 +0100 (CET)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9C26601321
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:30:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1669372258; i=@fujitsu.com;
 bh=zrrDyEO8wDv92iyNskgEsJsIT01tiC4ndpp3BG8wPCk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=nvifIfwDKnaEd74sYQAXGONoQjV5FoZ6s7WWFxQKms5d34xQolY/udRIAE3wbo9hy
 kkgEiARaw9pQUoqYWcuQvZi88QEzMR7SL/0HD74a9LQXRlHYR8zuTUE/IVUll/fP9Q
 xLnh5bR3OLHy8ffb8YTfiWUBbAkZ9fXC2lfkHPS2wnoESYLt1Ly4dF3pIjatlO8Xs+
 o7ZYGGdTmNYf9UkaLLAp6yAElBa11VxEJjW8D+ayqsVatVAKda1Bk3Or4S/GWuvthg
 Ob3cMFXaUTG4jFbgnr9a6BkgDLQxMeuxz6w3EytHfQ3FneRDOUGxAQhlUfLBYwom9f
 4YR1FOnGVwJZw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8ORpJs0syH
 ZYMM/XosV33cwOjB67Pu9jjWAMYo1My8pvyKBNeP07F2MBfP4Kq68X8LcwDiBp4uRi0NI4BSj
 xMGPsxghnD1MEh83zWCCchglnp3pZ+li5ORgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFnCR+PduIVg9i4CqxJkLZxlBbF4BD4nm1S1gcQkBBYkpD9+DzeEU8JQ487IVLC4EVDP32l
 ZmiHpBiZMzn7BAzJeQOPjiBTNEr6LEpY5vjBB2hcSsWW1MELaaxNVzm5gnMArOQtI+C0n7Aka
 mVYzmxalFZalFuoZGeklFmekZJbmJmTl6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6xZW5yTkp
 enmpJZsYgQGcUpx8dwdj5/I/eocYJTmYlER5b3yvTxbiS8pPqcxILM6ILyrNSS0+xCjDwaEkw
 XtqakOykGBRanpqRVpmDjCaYNISHDxKIrx504DSvMUFibnFmekQqVOMuhyb9nUdYBZiycvPS5
 US5/02HahIAKQoozQPbgQssi8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuadDLKKJzOvBG7
 TK6AjmICOeKpTB3JESSJCSqqBacapner/Xr+xPvJWPzf/RPHeKwYvHy7yVH3KHV/lzH/uTbL5
 cpXJPClRQvcKDZmKKxYXp7jv3pXLcrnISlb/8W/bV70nNwQ4sKywNNBd3TKFOcK94wXP6g/BM
 9lWPdFSL92iaCPnwHSFf+2LkiCOiHi2Hd55Oy4yhq0zvrTpaI7A/VPHW97O4NhS8SGVkfPokS
 TVhNN3evdn60xYpCd0StzK5xOHj+v8i5devNeOTGKa1V31xPxdwAsnqZppU67c6bPZJXq456a
 vhY/avg/n0vX66lIPnWWolXgraPl7aSbrZ4Y3Vkv80yZ+Li/Vn+Cya0JYE5vTup56G/PJ/1iq
 T3/9xH32ZW3KMQ6JZeGflViKMxINtZiLihMB5bFn5WcDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-745.messagelabs.com!1669372257!120128!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8421 invoked from network); 25 Nov 2022 10:30:58 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-17.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Nov 2022 10:30:58 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A9D351AE
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:30:57 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9E6067B
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:30:57 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 25 Nov 2022 10:30:55 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 25 Nov 2022 19:31:15 +0800
Message-ID: <1669375875-1943-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669375875-1943-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1669375875-1943-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] syscalls/mount03: Add MS_STRICTATIME subcase
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

This case should check MS_NOATIME and MS_RELATIME are
not inside stat f_flags[1] .

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0adde57
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount03.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 31a858c35..60f9963da 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -19,6 +19,7 @@
  * - MS_NOSUID - ignore suid and sgid bits
  * - MS_NOATIME - do not update access times
  * - MS_NODIRATIME - only update access_time for directory instead of all types
+ * - MS_STRICTATIME - always update access times
  */
 
 #include <stdio.h>
@@ -164,6 +165,11 @@ static void test_nodiratime(void)
 	test_file_dir_noatime(1, 0);
 }
 
+static void test_strictatime(void)
+{
+	test_file_dir_noatime(1, 1);
+}
+
 #define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
 #define FLAG_DESC2(x) .flag2 = x, .desc = #x
 static struct tcase {
@@ -179,6 +185,7 @@ static struct tcase {
 	{FLAG_DESC(MS_NOSUID), test_nosuid},
 	{FLAG_DESC(MS_NOATIME), test_noatime},
 	{FLAG_DESC(MS_NODIRATIME), test_nodiratime},
+	{FLAG_DESC(MS_STRICTATIME), test_strictatime}
 };
 
 static void setup(void)
@@ -215,6 +222,15 @@ static void run(unsigned int n)
 		tc->test();
 
 	SAFE_STATFS(MNTPOINT, &stfs);
+	if (tc->flag == MS_STRICTATIME) {
+		if (stfs.f_flags & (MS_NOATIME | MS_RELATIME))
+			tst_res(TFAIL, "statfs() gets the incorrect mount flag");
+		else
+			tst_res(TPASS, "statfs() gets the correct mount flag");
+		cleanup();
+		return;
+	}
+
 	if (stfs.f_flags & tc->flag2)
 		tst_res(TPASS, "statfs() gets the correct mount flag");
 	else
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
