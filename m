Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A29C77B75
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:12:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F1FA3CDD81
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:12:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311BD3CDD6F
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:46 +0200 (CEST)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1122F140016C
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:45 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="116663677"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="116663677"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:44 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D69C8D42C2
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:41 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 18626D88A5
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:41 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 896A231BB6A;
 Mon, 15 May 2023 16:11:40 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:18 +0800
Message-Id: <1684134680-6190-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--10.884800-10.000000
X-TMASE-MatchedRID: dZ+4kh95TAfOugYCEJUMNfZNLVgVojn/lDt5PQMgj02/UKSk38cGDKy2
 hC8KApGLIOJMP6BaeBXVMJCZKkTk5dz4cH5hW96YTuctSpiuWyUUi4Ehat05499RlPzeVuQQ3Ff
 7+xvoE8FR0mConkwRwp0hmii5sOzv2S7qqJ9At0bNgrlT5Ajc7tC1Z3HzBbIHmyiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1ozSaD3EnD6X6RE5UdTaJjHrhBeAbRPqGeYPI/E9+5BLneGoE8oK2PQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/6] lapi/stat.h: Remove deprecated STATX_ALL macro
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since kernel 5.10-rc1 commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
this flag has been mark as deprecated.

Kernel should keep this macro for compatibility, but ltp doesn't think
about it. So remove it.

For statx06.c, we test btime, so we should STATX_BASIC_STATS | STATX_BTIME
to replace. For statx07.c, we just use STATX_BASIC_STATS is enough.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h                       | 4 ----
 testcases/kernel/syscalls/statx/statx06.c | 4 ++--
 testcases/kernel/syscalls/statx/statx07.c | 6 +++---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index e247c2159..891db33ad 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -185,10 +185,6 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
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
index f688b1b0f..4dbf83e18 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -63,15 +63,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
 {
 	struct statx buf;
 
-	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
+	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS, &buf));
 
 	if (TST_RET == -1) {
 		tst_brk(TFAIL | TST_ERR,
-			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
+			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS, &buf)",
 			file_name, flag_name);
 	}
 
-	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
+	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS, &buf) = %o",
 		file_name, flag_name, buf.stx_mode);
 
 	return buf.stx_mode;
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
