Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123FCC25B74
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 04:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717044061; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=wXnVT/oMGlM7sC4g5nMuNYXgMRSU+5S2Qr/hqfKvBBg=;
 b=PIAsgCaQRiEb4gjiDRb0qXi8gggxZVZsmOQK9hEVzceRn6LPQH29Nc/P6NHTTERdnBxjT
 mZ9Z2PWLMwSIIdXH3muyHA0WKLmLX7jphvPVhxFYAxh2pAHBr8VbpsPuEcUMUsKA2HXRDkD
 lsmHtie3gozmKc2u4RpHipru50qHtZ4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B2163D06F9
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 06:41:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05A773CB6F5
 for <ltp@lists.linux.it>; Thu, 30 May 2024 06:40:37 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AE0F61401354
 for <ltp@lists.linux.it>; Thu, 30 May 2024 06:40:36 +0200 (CEST)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e95a60dfcdso4876481fa.1
 for <ltp@lists.linux.it>; Wed, 29 May 2024 21:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717044035; x=1717648835; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DnVvL+HSaNv0zKFh4dhiE1eKagOjl8Wr6achMpknAuI=;
 b=GL+XEt0Tk53lp/J02nTIVrLHD8Vk8W+J7wMtyXswQ0fnf1DTY3DuRJPQcTyGVcru+d
 pg3xVnrWe96eGtuaW8+SAjeAFu0ptJUC5C7/MSE9dLsHZcUkBZECXwQM4tUmD7yUO2p2
 YF4gvmEeUbaSGz62bg/DX9sUcH4ISTOrxjz500vLg0r04bLROZaFIO2qYYysJbpwFV4k
 RpSxMnQp0p4HwhKOve6/TQ8k+3Fsh7q4bAI66nCjhnooI1hV5BUjKCp57eX2tCMUm6Hk
 c0zA5zHg5M11nZR6aZJIvc7YU+fsQ23Fwb/IMB8zRrW+WYoWbIxOZ1GHLb/u4nUCB5c7
 Su1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717044035; x=1717648835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnVvL+HSaNv0zKFh4dhiE1eKagOjl8Wr6achMpknAuI=;
 b=sZUgJ+MfZJspkyrn65V8wzINfURKtdJmmR3MHuMwk6hGdZihKvUsYaNKD6Voah5DnY
 vzlkp/OPjg1eVrwTjGwLthvOIZF8aMuix5sG4b5uuwNRL3H2TfOtqa1eHnutZfYSfSXF
 p8p5HLLczQXuDm3fX+T+k8rPazAkj7XdEGJZOBPrJob/M21G3oIl+GYQmTHIsNFDB7/J
 9vmU/kGYmXg67F8Odk9QoEl0MZ39b+hOboP290Mou4WfaFpgQPK3QuzONC64bVxpPNs1
 3YXJ5VfVaiLWPX05e4telhaxpKd0wQNE3BFmcoOGwW1r+diMvpUu0ibqCBSmIJ4RZIZf
 OYYA==
X-Gm-Message-State: AOJu0YzkIH2n2NRUR/ySeLcKCq3pDRC3NjDftuxb+37cCwLhRYm8t4cZ
 NY7zK6p/iRUZ7MPMvPCxCftoI64p6pC0TnM9g7umo+2dqG1fzqss24aA6n8642XsJa//s78Vftg
 =
X-Google-Smtp-Source: AGHT+IHvrPBkNQsKmgcaDBlhnokuS/Qc8r5bEzzjrVL3pyyiv3EPQYQ26knf9Sd39syJrTGPUz7nDA==
X-Received: by 2002:a2e:b5d8:0:b0:2d3:4b73:7b40 with SMTP id
 38308e7fff4ca-2ea847ed798mr3305701fa.17.1717044035022; 
 Wed, 29 May 2024 21:40:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785234a7efsm9386034a12.4.2024.05.29.21.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 21:40:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 May 2024 00:40:29 -0400
Message-Id: <20240530044029.15474-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] msync04.c: Use direct IO to verify the data is
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
---
 testcases/kernel/syscalls/msync/msync04.c | 56 +++++++++++++----------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index 1718bd7dc..c0580d1b0 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -11,6 +11,7 @@
  * is no longer dirty after msync() call.
  */
 
+#define _GNU_SOURCE
 #include <errno.h>
 #include "tst_test.h"
 
@@ -43,10 +44,35 @@ static uint64_t get_dirty_bit(void *data)
 	return pageflag_entry & (1ULL << 4);
 }
 
-static void test_msync(void)
+static void verify_mmaped(void)
+{
+	void *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
+
+	tst_res(TINFO, "Not see dirty bit so we check content of file instead");
+	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
+	SAFE_READ(0, test_fd, buffer, getpagesize());
+
+	char *char_buffer = (char *)buffer;
+
+	if (char_buffer[8] == 'B')
+		tst_res(TCONF, "write file ok but msync couldn't be tested"
+				" because the storage was written to too quickly");
+	else
+		tst_res(TFAIL, "write file failed");
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
@@ -55,27 +81,11 @@ static void test_msync(void)
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
