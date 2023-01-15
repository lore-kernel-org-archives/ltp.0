Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD73C3DA78
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 02:53:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A6C3CC96E
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 03:53:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B030E3CB59B
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 03:53:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C76691A00667
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 03:52:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38AB260DAF;
 Mon, 16 Jan 2023 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673837577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u011nUuW30wndmTSy/5aruxlfDNC6i92XaoWnw5nD3U=;
 b=gmL2KMWaszPIEn0h8pUdgrGGwMtHArLQlbwYywIncLAkGlVtrS3EhQCiCbp0EQW5N6YeZ4
 J0gp2TjGEKxaj3pRXXO9R/ubjz76+92iXg5Sntlgbbvt4jSL2d4WcQbc71gKj6U1+Tt/yh
 1uOooyCp1aVbNc67Q2QlB7SC3x6iqUE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49058134F5;
 Mon, 16 Jan 2023 02:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Djk3CQi8xGObCQAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 16 Jan 2023 02:52:56 +0000
To: ltp@lists.linux.it
Date: Sun, 15 Jan 2023 18:47:08 -0500
Message-Id: <20230115234708.12802-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <Y70tBhCYADj25GCv@pevik>
References: <Y70tBhCYADj25GCv@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] readahead02.c: Fix check input fsize
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: coolgw <wegao@suse.com>

We run the test with a loop device it will fail with ENOSPC if we
pass -s bigger than the loop device, we should at least check if
the device is large enough in the test setup.The test should make
use of use tst_parse_filesize() so that we can pass sizes with
units e.g. -s 128M.

Signed-off-by: WEI GAO <wegao@suse.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_device.h                          |  2 ++
 lib/tst_device.c                              |  2 +-
 .../kernel/syscalls/readahead/readahead02.c   | 22 +++++++++++++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 977427f1c..67ceb25a4 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -6,6 +6,8 @@
 #ifndef TST_DEVICE_H__
 #define TST_DEVICE_H__
 
+#define DEV_SIZE_MB 300u
+
 #include <unistd.h>
 #include <stdint.h>
 #include <sys/stat.h>
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 48d7e3ab6..b098fc80b 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -38,6 +38,7 @@
 #include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_device.h"
 
 #ifndef LOOP_CTL_GET_FREE
 # define LOOP_CTL_GET_FREE 0x4C82
@@ -46,7 +47,6 @@
 #define LOOP_CONTROL_FILE "/dev/loop-control"
 
 #define DEV_FILE "test_dev.img"
-#define DEV_SIZE_MB 300u
 #define UUID_STR_SZ 37
 #define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
 
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 7acf4bb18..a9d0530c2 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -33,6 +33,7 @@
 #include "tst_test.h"
 #include "tst_timer.h"
 #include "lapi/syscalls.h"
+#include "tst_device.h"
 
 static char testfile[PATH_MAX] = "testfile";
 #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
@@ -366,11 +367,25 @@ static void setup_readahead_length(void)
 
 static void setup(void)
 {
-	if (opt_fsizestr) {
-		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
-		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+	/*
+	 * Acutaly dev size will reduced after create filesystem,
+	 * so use dev_szie * 0.8 as dev real usage size, test case will
+	 * create two files within dev so we need div 2 get max file size
+	 */
+	size_t dev_size = (test.dev_min_size ? test.dev_min_size : DEV_SIZE_MB) * 1024 * 1024;
+	size_t fsize_max = dev_size * 0.8 / 2;
+
+	/* At least two pagesize for test case */
+	pagesize = getpagesize();
+	size_t fsize_min = pagesize * 2;
+
+	if (tst_parse_filesize(opt_fsizestr, (long long *)&testfile_size, fsize_min, fsize_max)) {
+		tst_set_max_runtime(1 + DEFAULT_FILESIZE / (DEFAULT_FILESIZE/32));
+		tst_brk(TBROK, "invalid initial filesize '%s'", opt_fsizestr);
 	}
 
+	tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
 
@@ -380,7 +395,6 @@ static void setup(void)
 	/* check if readahead is supported */
 	tst_syscall(__NR_readahead, 0, 0, 0);
 
-	pagesize = getpagesize();
 
 	setup_readahead_length();
 	tst_res(TINFO, "readahead length: %d", readahead_length);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
