Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D025DC761AF
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 08:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 120383C0123
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 10:23:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25E833CC9B1
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:23 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3DF98600973
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 10:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680164602; i=@fujitsu.com;
 bh=9DxWK2tbYyu5/brN8GelV3mERG5UOKb+6PysFuVVIj4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=f9VPEi50sgqg7mF5x34pZW1BT4dj4gxbe+PSZ860Umo2MRh+ix5ly2lxFUvbOddkk
 NIgcPXDUhXEdFIbJwICkXBX8jrT0CqqQ1m9K96qP7HA4QH1rXChzyIUZK98ghARFoA
 5GS0nsmlCDIoaNPwqBUXzpxY1d5VrkGTbzkms1wv0we3fo73jkx8k7NygMae+p2isq
 f7uai8XreaRKr9i+Fy6mo4YR00CxzPC7QKLU4SpqbH2F0RM4JqFgmGV9dj0XSY5L3n
 Ye0HOuhlv/8/STF3cSBKf0kBNnGVp7X+XTRflTh3sbprEdGUjMsuY4j0zsKrQeCmQ4
 LIbCNSRthyNsg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8ORqPvTTTX
 F4O9CQ4u1e/4wW6z4voPRgclj06pONo99v9exBjBFsWbmJeVXJLBm9H67y1ZwR7hifs9d5gbG
 /wJdjFwcQgJbGCVOvjrGCOEsZ5KY0vmQBcLZyyhx7Uk7WxcjJwebgKbEs84FzCC2iICEREfDW
 3YQm1nATuLO4iawuLCAs8TU759ZQWwWAVWJU7vfMYLYvAKeEl+7poPZEgIKElMevgeq5+DgFP
 CSaNnLCRIWAipZsP8KK0S5oMTJmU9YIMZLSBx88YIZolVJoq0VokZCoEKicfohJghbTeLquU3
 MExgFZyFpn4WkfQEj0ypGs+LUorLUIl1DU72kosz0jJLcxMwcvcQq3US91FLd8tTiEl1DvcTy
 Yr3U4mK94src5JwUvbzUkk2MwIBOKWaJ38F4re+v3iFGSQ4mJVHeSk7VFCG+pPyUyozE4oz4o
 tKc1OJDjDIcHEoSvJtcgHKCRanpqRVpmTnA6IJJS3DwKInwqjgBpXmLCxJzizPTIVKnGBWlxH
 n7XYESAiCJjNI8uDZYRF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMxrBLKdJzOvBG76K6D
 FTECLj6WqgCwuSURISTUwLfuv5SnLbXx9w1H/628vZ65878b3/essrce6/t+vn+7bF+bqn+HA
 7Sui55Ly9AwDK1dK+JFvpUlbYt+mG+X/n3BTRm/C+dSTdtZOsoHbTqs33q+bvPfE6pozIaYH7
 15eOzku1J5nR7clb3BHeHnbs/S5ax/WVq7cuuKoRtDy9vaIFAOWtbOFQoL0CzzU3zltDt/xQW
 pl/+6VG38Uap67yb9w7pFHdrwu2cqyn/Y7PLNMN51svcjC0X+jBhvbBS+14LiDU64ptETtY49
 n1Tv+MqNRwifm8oJLG45xtZxJ+HdD9LcZl0bPZ/6cFuG//57f9dy09Kk+122N1RyFqpsnTYnQ
 X6BxQWrdVG67497MSizFGYmGWsxFxYkAg2qBNmMDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-585.messagelabs.com!1680164601!862!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13148 invoked from network); 30 Mar 2023 08:23:21 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-11.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 30 Mar 2023 08:23:21 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 68CCF1001A6;
 Thu, 30 Mar 2023 09:23:21 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 5C03A1001A2;
 Thu, 30 Mar 2023 09:23:21 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 30 Mar 2023 09:23:19 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 30 Mar 2023 16:22:49 +0800
Message-ID: <1680164569-12114-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lapi/stat.h: Remove deprecated STATX_ALL macro
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
