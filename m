Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6707DC761A6
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 10:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34BC43CD282
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 12:45:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FCD33CD07E
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:12 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F11F1400544
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 12:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680518711; i=@fujitsu.com;
 bh=9DxWK2tbYyu5/brN8GelV3mERG5UOKb+6PysFuVVIj4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=VqN0jvDURcHgYn2bQwiCJzLXHaGzbvcM+46KU158BFI0P38Xm7EQhJXqNj7H3TVIk
 NY2Tw8sBcrJEPSD9vLFUiDmnUyjXq5hNVhanhvWuHgvnVEg9m2+QZdtP5H2jxZ+Q4+
 3EWYn3g7VAKzcBuCjoffnIjfOKdKw8jLsUc4bPAUXCjf5Rd/qFldAbaHI3VD5VY5se
 vKWEOxpbWPP8UowNCQhBSCeh4cMZnJ0qs/nXVviFbx7wjWtOgCj30F4dHHna0gEUfp
 Bgc0P5ICdzH8nByx6ahwDBgqLHItKRBsZ0mua+rR8G8igSkrGvH793FPn2tvxLNPEu
 QDhLcHUm/lkug==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8ORpGu2Tiv
 F4NBDTou1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBm9H67y1ZwR7hifs9d5gbG
 /wJdjFwcQgIbGSUu3ZnCBOEsZpK4N/cIG4Szh1HiwIadQBlODjYBTYlnnQuYQWwRAQmJjoa37
 CA2s4CdxJ3FTWBxYQE3iU37j4LFWQRUJLZcb2MBsXkFPCSO793MCmJLCChITHn4HqyeU8BT4t
 DE00DzOYCW1Uhcv+sHUS4ocXLmExaI8RISB1+8YIZoVZJoa70CNaZConH6ISYIW03i6rlNzBM
 YBWchaZ+FpH0BI9MqRrPi1KKy1CJdQwO9pKLM9IyS3MTMHL3EKt1EvdRS3fLU4hJdI73E8mK9
 1OJiveLK3OScFL281JJNjMCATilWZN3BeKnvr94hRkkOJiVR3rVrtFKE+JLyUyozEosz4otKc
 1KLDzHKcHAoSfBaguQEi1LTUyvSMnOA0QWTluDgURLhvbQEKM1bXJCYW5yZDpE6xagoJc7ruR
 YoIQCSyCjNg2uDRfQlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8e0C282TmlcBNfwW0mAl
 ocWuUBsjikkSElFQD07KD149v/B6kw/N3CteK1S/kK2s0DUIaSvbNltA+IhLnezEy/vasoo3n
 b/5OfLxO5lvO5/po5ke1f1Y5pK/gm3Qh3/xe+NPWna2Jgftq9I9++7i6Yc4SWYc/jhfXr7gte
 ayhUk40ZU6Am6Pn7JX/p5zk0VhavjV8mRPb4ke3vF7FuPb790w5pX5xv1+kw85DM46rbmkzW2
 43V97p8InN2gtE1C9/Xf8sVfWyx5zyi9xOJzYVnP0lcM8txt68PmNqkEDZ7QzhKXLinncMPp6
 JviwiPflYhGuh/8W0W3yHpfdFO/bNyHp8NGPJ7M0ZE1pOda/b/mx79Srp1R3Kb15/vixhvHBh
 8JfbNW2vnn9eYFenxFKckWioxVxUnAgAJ6615WMDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-565.messagelabs.com!1680518709!195617!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9807 invoked from network); 3 Apr 2023 10:45:10 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-14.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Apr 2023 10:45:10 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C9C161D2;
 Mon,  3 Apr 2023 11:45:09 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id BE9C47B;
 Mon,  3 Apr 2023 11:45:09 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 3 Apr 2023 11:45:07 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 3 Apr 2023 18:44:36 +0800
Message-ID: <1680518676-2863-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] lapi/stat.h: Remove deprecated STATX_ALL macro
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

Since kernel 5.10-rc1 commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
this flag has been mark as deprecated.

Kernel should keep this macro for compatibility, but ltp doesn't think
about it. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h                       | 4 ----
 testcases/kernel/syscalls/statx/statx06.c | 4 ++--
 testcases/kernel/syscalls/statx/statx07.c | 6 +++---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index c2db8a589..7c9a7a00c 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -188,10 +188,6 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_DIOALIGN		0x00002000U
 #endif
 
-#ifndef STATX_ALL
-# define STATX_ALL		0x00000fffU
-#endif
-
 #ifndef STATX__RESERVED
 # define STATX__RESERVED	0x80000000U
 #endif
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index ce82b905b..60e736c5a 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -111,10 +111,10 @@ static void test_statx(unsigned int test_nr)
 	clock_wait_tick();
 	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
 
-	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
+	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_BASIC_STATS | STATX_BTIME, &buff));
 	if (TST_RET != 0) {
 		tst_brk(TFAIL | TTERRNO,
-			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)",
+			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_BTIME, &buff)",
 			TEST_FILE);
 	}
 
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index b13c11f72..c798c7a10 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -62,15 +62,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
 {
 	struct statx buf;
 
-	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
+	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS | STATX_BTIME, &buf));
 
 	if (TST_RET == -1) {
 		tst_brk(TFAIL | TST_ERR,
-			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
+			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf)",
 			file_name, flag_name);
 	}
 
-	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
+	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf) = %o",
 		file_name, flag_name, buf.stx_mode);
 
 	return buf.stx_mode;
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
