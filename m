Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EDAC27C75
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718320876; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=807kZd3Tqdlbb2hK94gWUSqtwS7g/XqyIzhbzTeIVSw=;
 b=EKvxKh8gpOSXVlFxEzI6dCYgRryXd+5z7/WqXvAsdzzi3aKIXRHO+CSlEYOGCVYE6PyxG
 12H9hbgaP0Y5VkQ0aSSrlLmI7tFmARmopmdFTjtaGkQ/uaSiDYC1RXhNG88P/WT/9O7dF8j
 VvVX8wXNyRplrhh6SsTTPEdt6T4FtrA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A99C3D0C7A
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 01:21:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 749893CF635
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 01:20:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96D4B1000C14
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 01:20:52 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6f177b78dcso212611066b.1
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718320851; x=1718925651; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3DeCCFs1MNYjJx7ZGkzjFx3knlNVu1gQH0Kf65zpwY=;
 b=TRPk8D7lLPRwy6eqZdIA8+zOqm1AIN5vdveVAZVu/i4sVf6urv16Kk3rc3xvE9OOUr
 xRac5mZXIhgcmeOw5/XfGgXhAKBqGskLRGRy7p8Le9yJ4purqIq5y2CX1WhZYCb7Xl30
 xG33O+gV9JnYn7TjXm4eNINUBYiXCcv6VC4ct9h9VOBM9epPVpxT0AVkZWZcSRsduRuj
 /XF7IdU8ZI1SrQwqht7/2d87w81hyN0tBVNQNkzDsOeEm17IDhp/cxN65vRupb+crDlN
 PoQ91LedUXys2cNXROyHN1gHIU+0TAj4WtR17YQiSTYy4I7bnt1D6IkqFs2nr1d6TB6m
 aaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718320851; x=1718925651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3DeCCFs1MNYjJx7ZGkzjFx3knlNVu1gQH0Kf65zpwY=;
 b=rCU+jCo2zt0aPMh9MfLyFmuV2Et5MhfugMZfg74AT23JqfvcjY6QziuayPDUM31dpc
 j0QLJGcXu92zLw7z5OilaAiZOB1o846iA4b67sAYqWPIwBYYuCve8jgAEylXPbeq/hIm
 nrGhygucwc3nYof/zJOFPqUoMzfkf5DQ5srPbVH2qPs76Vgkq6p6Q+MZtA6d3PVHkmQJ
 pb347d11cSU3jMfiBl4KSYwkr2vy6kvhgCnHIWEaaXzsWdTiuOSh89rqrIoGC3fgffMD
 bwEPBQz9bqrE6qmxRxAlxSAJ2SbQ07KcM90b06WDfrr8Ye7ypeKCNeNQakh36MQ60MN2
 ByZg==
X-Gm-Message-State: AOJu0Yzcsq763WZKbueeFcEo2idIc7GNmTnLGCFzcjAs+60DqwWN44/o
 PVs3u84l2ZjFYlQXxYQmbG7/xiA5i+6op/IdlYTbsGBX8gvE/zjsmJLj2c05+a9Nyn1xnaLUV9M
 =
X-Google-Smtp-Source: AGHT+IFDimRBUskrCkpi/Z8B76cRn9R5dSGKwAYXwa4PHytvQp8CR1yW55eMCu4c/bwCvwm9w+pOmg==
X-Received: by 2002:a17:907:d406:b0:a6f:6292:2425 with SMTP id
 a640c23a62f3a-a6f629224e4mr39411566b.38.1718320851265; 
 Thu, 13 Jun 2024 16:20:51 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da3f50sm120696966b.14.2024.06.13.16.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 16:20:50 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 13 Jun 2024 19:20:44 -0400
Message-Id: <20240613232044.7418-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240530044029.15474-1-wegao@suse.com>
References: <20240530044029.15474-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] msync04.c: Use direct IO to verify the data is
 stored on disk
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/msync/msync04.c | 55 +++++++++++++----------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 1718bd7dc..e3478f690 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -11,6 +11,7 @@
  * is no longer dirty after msync() call.
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include "tst_test.h"
 
@@ -43,10 +44,34 @@ static uint64_t get_dirty_bit(void *data)
 	return pageflag_entry & (1ULL << 4);
 }
 
-static void test_msync(void)
+static void verify_mmaped(void)
+{
+	char *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
+
+	tst_res(TINFO, "Haven't seen dirty bit so we check content of file instead");
+	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
+	SAFE_READ(0, test_fd, buffer, getpagesize());
+
+	if (buffer[8] == 'B')
+		tst_res(TCONF, "Write was too fast, couldn't test msync()");
+	else
+		tst_res(TFAIL, "write file failed");
+
+	free(buffer);
+}
+
+static void verify_dirty(void)
 {
-	char buffer[20];
+	TST_EXP_PASS_SILENT(msync(mmaped_area, pagesize, MS_SYNC));
+
+	if (TST_RET == 0 && !get_dirty_bit(mmaped_area))
+		tst_res(TPASS, "msync() verify dirty page ok");
+	else
+		tst_res(TFAIL, "msync() verify dirty page failed");
+}
 
+static void test_msync(void)
+{
 	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
 		0644);
 	SAFE_WRITE(SAFE_WRITE_ANY, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);
@@ -55,27 +80,11 @@ static void test_msync(void)
 	SAFE_CLOSE(test_fd);
 	mmaped_area[8] = 'B';
 
-	if (!get_dirty_bit(mmaped_area)) {
-		tst_res(TINFO, "Not see dirty bit so we check content of file instead");
-		test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY);
-		SAFE_READ(0, test_fd, buffer, 9);
-		if (buffer[8] == 'B')
-			tst_res(TCONF, "write file ok but msync couldn't be tested"
-				" because the storage was written to too quickly");
-		else
-			tst_res(TFAIL, "write file failed");
-	} else {
-		if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
-			tst_res(TFAIL | TERRNO, "msync() failed");
-			goto clean;
-		}
-		if (get_dirty_bit(mmaped_area))
-			tst_res(TFAIL, "msync() failed to write dirty page despite succeeding");
-		else
-			tst_res(TPASS, "msync() working correctly");
-	}
-
-clean:
+	if (!get_dirty_bit(mmaped_area))
+		verify_mmaped();
+	else
+		verify_dirty();
+
 	SAFE_MUNMAP(mmaped_area, pagesize);
 	mmaped_area = NULL;
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
