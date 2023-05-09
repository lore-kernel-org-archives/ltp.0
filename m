Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75776C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 09:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA3EB3CD6E5
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 11:15:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3B03C0238
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:48 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E1729140054C
 for <ltp@lists.linux.it>; Tue,  9 May 2023 11:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683623747; i=@fujitsu.com;
 bh=T952k5SVqQ8IFmFZiEnFsixSgcqs3adIrVFAlXQ6AKE=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
 b=X2OB0aBIHgafv1z3W4OEPWRVEx1GPGd+S6eBZukPekqVxm8ZEduhmb7mTgpxUmwLI
 rQOMkZy2ixMUuTFwwarfH+o7neRv+wAYP1S4gf1PBVuQm2XNWgbv30GZPi1NofF2K+
 e0AP1TBXG9EOkwRVlUo3yaSr+lwTCSa70yUKQR59waBYe5R5rH6R1CRWo/jGl4DpOt
 5kHoBOyTAlWYaf6kki4815CGvetoWxYGjTiZpWynZnYm3SPkKujCZibgMEumhJ+KYo
 oDlMmd/QM1Vu1E5mHLES2GcWxyW5hjqlcKaSsBU5R99+JpCwPP/lKEwAnlxm0TRJsr
 JHr6pDeh+KkTQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRWlGSWpSXmKPExsViZ8ORpOvEH5V
 i8KRPz2Ltnj/MFiu+72B0YPLYtKqTzWPf73WsAUxRrJl5SfkVCawZ37fMZSs4JFKxcNUDlgbG
 q4JdjFwcQgIbGSW2H97JAuFMY5L4tbOXsYuRk4NNQFPiWecCZhBbREBM4vqGV6wgNrOArcTL4
 1uBajg4hAXcJP6ddAYJswioSux6vAesnFfAU2LO95vsILaEgILElIfvweKcAl4Sc9tegNlCQD
 VvuiaxQtSoSVw9t4l5AiPPAkaGVYymxalFZalFupZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW
 6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIFBklKsGLWDcfauv3qHGCU5mJREebv2RaYI8SXlp1Rm
 JBZnxBeV5qQWH2KU4eBQkuB9wBOVIiRYlJqeWpGWmQMMWJi0BAePkgjvCRagNG9xQWJucWY6R
 OoUo6KUOG85L1BCACSRUZoH1waLkkuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHkngkzhyc
 wrgZv+CmgxE9Bi/8vhIItLEhFSUg1MzGtOHw6M3ievwxrReJBP4PwHteL3l+7+OLLs3hHtQqY
 jonPdwxg074gzvLKU601Pb2S8d9kwf6LWv2KFTcEab6oPCa3bFdb2colMQd3CuC0rNC+FzWr8
 /PLUHtU7C7WyYlexpuxji3uiuOLd+ratdu+flq/in6I+cxfTV/sjfcUcx7gvszl9SmWtc3jKG
 /zh4U+hGHP/x9OU+8u2vl+/5OA2p9jY/Dd5ryJZp4jIZFtVu+2KX8p2bGfZL6fpN3dKKna8VV
 OZdGayzoo7/5613V3QsPf12Yl394odey97fnfX/MTr0zkm+IseNC5fdzr47xeftjhb5oI/l59
 UbtwVxHT+vLDAspc7z35XXbY5VVeJpTgj0VCLuag4EQDnphLcDQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-571.messagelabs.com!1683623746!53334!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8899 invoked from network); 9 May 2023 09:15:46 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-12.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 May 2023 09:15:46 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 7297B1B1;
 Tue,  9 May 2023 10:15:46 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 78EB67B;
 Tue,  9 May 2023 10:15:45 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 May 2023 17:14:06 +0800
Message-Id: <1683623648-22778-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1683623648-22778-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/7] lapi/stat.h: Remove deprecated STATX_ALL macro
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
