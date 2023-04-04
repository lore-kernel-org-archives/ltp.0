Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65582C6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 07:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 894323CA87F
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 09:31:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0DCF3CAD4B
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:31:04 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67E1C140015B
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 09:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1680593462; i=@fujitsu.com;
 bh=9DxWK2tbYyu5/brN8GelV3mERG5UOKb+6PysFuVVIj4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Qdv3S6gTX38RKeBRTjV3Y4vWdt1NYQz9iM2WfMopgaeQ5Hdfe8/fp5JpKDUZ3TXe2
 mfmiIjARU/He+1okfjqfM8qudx6Wef1fGxFKz+JFNtQhtciMPUN/KvIY/Gcv1NE1UE
 S6njJwdgMT1GF8fCTlqG0pNvyHAOAQBAwGobVe6032z2PHUn8qK5ojWDk6pE7zJN6k
 fP7VgzkXiNdiYErbRh9aMT7cISYxo6GmLRNrwOUM9K/v08EOGGROwmx5NkzyJUJKjK
 1kxupfgE1f8pAbFIQO739/v+sIIdJhFl7++KDvvJzQ/r3xKTQH3q/QBIG5AI9uKE7/
 R0VMKn9Dy1G6g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8OxWdf0kna
 KwZ/b5hZr9/xhtljxfQejA5PHplWdbB77fq9jDWCKYs3MS8qvSGDN6P12l63gjnDF/J67zA2M
 /wW6GLk4hAQ2Mkrsf9rOCuEsYZL4s3oPM4Szh1Fi0ZNHLF2MnBxsApoSzzoXMIPYIgISEh0Nb
 9lBbGYBO4k7i5vA4sICbhIznm9iBbFZBFQk/i1vAKvhFfCU+LViERuILSGgIDHl4Xuwek4BL4
 k9tw+A1QsJpEv0n/vFDFEvKHFy5hMWiPkSEgdfvGCG6FWSaGu9wgphV0g0Tj/EBGGrSVw9t4l
 5AqPgLCTts5C0L2BkWsVoWpxaVJZapGuul1SUmZ5RkpuYmaOXWKWbqJdaqlueWlyia6SXWF6s
 l1pcrFdcmZuck6KXl1qyiREY0CnFyjN3MC7r+6t3iFGSg0lJlPfRRu0UIb6k/JTKjMTijPii0
 pzU4kOMMhwcShK8meeBcoJFqempFWmZOcDogklLcPAoifD+PQeU5i0uSMwtzkyHSJ1iVJQS59
 14ASghAJLIKM2Da4NF9CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrwuZ4Cm8GTmlcBNfwW
 0mAlocWuUBsjikkSElFQDk4+W0svOvX5zvDh+vqnbuYr3l0LpSqNVPu/kjVxLJp848vcXf/DH
 MJG/hRfKbnlbPw620mO3sr2yTPfyjqiX7kmzXe6JikteNXdp/LV572lez9Snnt99VHTj629cY
 vjldoC5a96ha4cbQzy+TY15W73kn7zGxgyugxs/1Sj8fDTJ+Y5w78GsYya+EdMzD7YK3nhRtJ
 j93qYL6dJn92ZEaa38ueZ03YcZjiWGl9NOM9UHRf03FGnbURL7ddVLxtjzT/skDGcfXbDKLva
 2TFOg/BVPUR+nBbpl8TJ7P+QlmJ2eUv8oO/XH4rXejNwCwY/Vvv0pMTg9QbxnX8s9NRkuz/Lj
 Ii6Z8SVn3yb+lMyfrsRSnJFoqMVcVJwIABYRVhljAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-565.messagelabs.com!1680593461!300034!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24855 invoked from network); 4 Apr 2023 07:31:01 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-8.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 4 Apr 2023 07:31:01 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 99A14162;
 Tue,  4 Apr 2023 08:31:01 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 8D36015A;
 Tue,  4 Apr 2023 08:31:01 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 4 Apr 2023 08:30:59 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 4 Apr 2023 15:30:30 +0800
Message-ID: <1680593430-14728-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] lapi/stat.h: Remove deprecated STATX_ALL macro
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
