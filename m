Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E772C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 03:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716868072; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Fmt50AeANs7zzatgfblUSeZIZ7Q3hV0S09c/72F6mTM=;
 b=Umb/is2fEux5bk9k035QkrK465F2uVCqvLojnowSjH+tnHIiAlVr+yBiY35Eve35vLrZe
 KgHVIbWyalhLCS1aD8YX9GAdO1Rl4c9Z3lDCuXN8qnLQzRxlyDvhPSzJlC0QuYrE3OJW46c
 PwyxzozbL3mlCbCXJiSW/QQtoW2E/68=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 125243D04F8
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 05:47:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 429AC3D0293
 for <ltp@lists.linux.it>; Tue, 28 May 2024 05:47:28 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FB2F60063A
 for <ltp@lists.linux.it>; Tue, 28 May 2024 05:47:27 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5785199e0d6so408568a12.2
 for <ltp@lists.linux.it>; Mon, 27 May 2024 20:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716868046; x=1717472846; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KaRSzrSvomNSeUZ7yy46XXoHH9zcPUI6RBxZV9fn4JM=;
 b=YZAKy4DhTsETmcGa9ik0HIyShMeqbtKtMSJHEZKBlPthhExfORhwcdQ2NKwrntbHws
 1Fzb3IT1HsUdez6E5ULY6+PF8/sTl16mHfrABx20yqZ1TC7MDZBss9QNtfrlENHGVZOu
 zsF6gldlg5jRDCIgOolxFJMz/7EnxOYZLKwpIfPe87j/g7XUnElq2JviAGcCV4sDgY6f
 JcVLXk6nqeqQdLOkyLkdk7gNv1rqV6msuaQPvTaLImaWnV75goUR/fEHQeXOZBZs9sb3
 Lt3b8YGSNeMu+9nS01SiJIgrJpAwUbyiTp5QwkRlQDgbovgDvUnLeVEcQpyeXVeiDe4a
 RhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716868046; x=1717472846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KaRSzrSvomNSeUZ7yy46XXoHH9zcPUI6RBxZV9fn4JM=;
 b=gfknUTH8NEh0EMDtE4OsO5j5REDyP2oIPREDlSg0g3FTXfCn+tDtmIBVYddU3ehl8r
 TVQZYKIqLhNz+nuLhebYrt9LNsyPUsbFR+NSI882Wxb7nXkRk0nia3wSPXdlVucpUqQs
 qmhOSjr2RnUfexrlnOPk8AMoah0B/mnh1z9RqNa8e//ONRHZxNiwB2xtqzDppKG+/vls
 RUnYjjHAjw3wTM2hDar6/8Q4KBqSXg8SIKUn+1EE7pgqcYdWewMgzS2+5h0wvmUfOIQB
 DrRVv43K74nT+6FzSDMFlLFTEW+Uf7zO+ubTCl/NyjoeXLoal0qQ1TXrzol/tgpoWEBx
 ARwA==
X-Gm-Message-State: AOJu0Yz1hwlCiThLOGEMvvNWv9rlG958JjkgIEPBYJ95tDLTVVzBeI8M
 MadwB+ocpuakplc2pgE7QyRHVH1CNit7ozbEhSevfnDIu9Z8WIQWTsLiVMePCZ4aXTratcEcw/k
 =
X-Google-Smtp-Source: AGHT+IGcZ7iuj3pKPfHMnqeFHTzribYcD8nNONOhHMwRFscUNJmKcR6MmomFv2LMKifNqpn8lXWsdw==
X-Received: by 2002:a50:d59d:0:b0:578:6782:578a with SMTP id
 4fb4d7f45d1cf-57867825ecfmr8820407a12.2.1716868046066; 
 Mon, 27 May 2024 20:47:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579daf4b7ddsm1608132a12.3.2024.05.27.20.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 20:47:25 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 23:47:18 -0400
Message-Id: <20240528034718.31798-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] pwritev201.c: Add check for RWF_APPEND flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../kernel/syscalls/pwritev2/pwritev201.c     | 35 ++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
index 987412ba8..cb329d8fc 100644
--- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
+++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
+ * Copyright (c) 2024 SUSE LLC <wegao@suse.com>
  */
 
 /*\
@@ -15,6 +16,9 @@
  * - If the file offset argument is -1, pwritev2() should succeed in
  *   writing the expected content of data and the current file offset
  *   is used and changed after writing.
+ * - If the file flag argument is RWF_APPEND, pwritev2() should succeed in
+ *   writing the expected content to end of file. The offset argument does
+ *   not changed after writing except offset argument is -1.
  */
 
 #define _GNU_SOURCE
@@ -42,13 +46,16 @@ static struct tcase {
 	off_t write_off;
 	ssize_t size;
 	off_t exp_off;
+	int flag;
 } tcases[] = {
-	{0,     1, 0,          CHUNK, 0},
-	{CHUNK, 2, 0,          CHUNK, CHUNK},
-	{0,     1, CHUNK / 2,  CHUNK, 0},
-	{0,     1, -1,         CHUNK, CHUNK},
-	{0,     2, -1,         CHUNK, CHUNK},
-	{CHUNK, 1, -1,         CHUNK, CHUNK * 2},
+	{0,     1, 0,          CHUNK, 0, 0},
+	{CHUNK, 2, 0,          CHUNK, CHUNK, 0},
+	{0,     1, CHUNK / 2,  CHUNK, 0, 0},
+	{0,     1, -1,         CHUNK, CHUNK, 0},
+	{0,     2, -1,         CHUNK, CHUNK, 0},
+	{CHUNK, 1, -1,         CHUNK, CHUNK * 2, 0},
+	{CHUNK, 1, CHUNK,      CHUNK, CHUNK, RWF_APPEND},
+	{CHUNK, 1, -1,         CHUNK, CHUNK * 2, RWF_APPEND},
 };
 
 static void verify_pwritev2(unsigned int n)
@@ -60,7 +67,7 @@ static void verify_pwritev2(unsigned int n)
 	SAFE_PWRITE(1, fd, initbuf, sizeof(initbuf), 0);
 	SAFE_LSEEK(fd, tc->seek_off, SEEK_SET);
 
-	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, 0));
+	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, tc->flag));
 	if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO, "pwritev2() failed");
 		return;
@@ -72,17 +79,21 @@ static void verify_pwritev2(unsigned int n)
 		return;
 	}
 
-	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != tc->exp_off) {
+	if (SAFE_LSEEK(fd, 0, SEEK_CUR) != tc->exp_off && !(tc->flag == RWF_APPEND && tc->write_off == -1)) {
 		tst_res(TFAIL, "pwritev2() had changed file offset");
 		return;
 	}
 
 	memset(preadbuf, 0, CHUNK);
 
-	if (tc->write_off != -1)
-		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->write_off);
-	else
-		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->seek_off);
+	if (tc->flag == RWF_APPEND)
+		SAFE_PREAD(1, fd, preadbuf, tc->size, sizeof(initbuf));
+	else {
+		if (tc->write_off != -1)
+			SAFE_PREAD(1, fd, preadbuf, tc->size, tc->write_off);
+		else
+			SAFE_PREAD(1, fd, preadbuf, tc->size, tc->seek_off);
+	}
 
 	for (i = 0; i < tc->size; i++) {
 		if (preadbuf[i] != 0x61)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
