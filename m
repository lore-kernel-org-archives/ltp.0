Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C25DC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 21:11:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31F5C3CFE73
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 23:11:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D12DB3CE531
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:51 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 607091A0044E
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE9565C70B;
 Thu, 25 Apr 2024 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L442fKFljT79afJdZAPXx6aM4gjehT4OvrZHT4kUR1Q=;
 b=R72kxALCgKpZKt/svqwwA4I/VnajR4Ut/f+1N/22wtEoQFexlJCiZ7Kbb0zOeskb0rQRYE
 hEvblrzrnUcKLawVBL8jUZH/30SMCAJ/8azP+ZAEuRmD/DTHPOxfDcQNOJt9Dc3x12JTwg
 aubxShuM2gjB4rWj9MRq3y/UQ0n3Yvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L442fKFljT79afJdZAPXx6aM4gjehT4OvrZHT4kUR1Q=;
 b=6d3l0QbvbL8tbxVpdT0CUk/S/P8K2knOA6KvN/4Mfc/kOZhhMNRm1ajkBPmOM9VaPuRlfw
 77KSGUuKSP1x/oCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L442fKFljT79afJdZAPXx6aM4gjehT4OvrZHT4kUR1Q=;
 b=R72kxALCgKpZKt/svqwwA4I/VnajR4Ut/f+1N/22wtEoQFexlJCiZ7Kbb0zOeskb0rQRYE
 hEvblrzrnUcKLawVBL8jUZH/30SMCAJ/8azP+ZAEuRmD/DTHPOxfDcQNOJt9Dc3x12JTwg
 aubxShuM2gjB4rWj9MRq3y/UQ0n3Yvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L442fKFljT79afJdZAPXx6aM4gjehT4OvrZHT4kUR1Q=;
 b=6d3l0QbvbL8tbxVpdT0CUk/S/P8K2knOA6KvN/4Mfc/kOZhhMNRm1ajkBPmOM9VaPuRlfw
 77KSGUuKSP1x/oCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DFD41393C;
 Thu, 25 Apr 2024 21:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iCWuIdrGKmbQaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 21:10:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 23:10:42 +0200
Message-ID: <20240425211042.299714-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425211042.299714-1-pvorel@suse.cz>
References: <20240425211042.299714-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] libswap: Use {SAFE_,}MAKE_MINIMAL_SWAPFILE()
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

This effectively increases the minimal used number of blocks to 256.

All {SAFE_,}MAKE_SWAPFILE_SIZE() calls which were creating swap used 10
blocks. While this is ok on 4kb page size, it's too low on systems with
64kb page size (e.g. on aarch64 with CONFIG_ARM64_64K_PAGES=y or on
ppc64le with CONFIG_PAGE_SIZE_64KB=y):

    TWARN: Swapfile size is less than the system page size. Using page size
    (65536 bytes) instead of block size (4096 bytes).

Obviously it would fail also on kernels with CONFIG_PAGE_SIZE_256KB.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/libltpswap/libswap.c                     | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c | 2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   | 4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index aed76dfe2..eb066df71 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -192,7 +192,7 @@ int make_swapfile(const char *file, const int lineno,
 bool is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int ret = SAFE_MAKE_SWAPFILE_BLKS(filename, 10);
+	int ret = SAFE_MAKE_SMALL_SWAPFILE(filename);
 	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 5a15826e4..0ab8338c5 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -87,7 +87,7 @@ static void setup(void)
 	nobody_uid = nobody->pw_uid;
 
 	is_swap_supported(TEST_FILE);
-	SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
+	SAFE_MAKE_SMALL_SWAPFILE(SWAP_FILE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index e5e29b8e7..54796bdcc 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -50,8 +50,8 @@ static void setup(void)
 	is_swap_supported(TEST_FILE);
 
 	SAFE_TOUCH(NOTSWAP_FILE, 0777, NULL);
-	MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
-	MAKE_SWAPFILE_BLKS(USED_FILE, 10);
+	MAKE_SMALL_SWAPFILE(SWAP_FILE);
+	MAKE_SMALL_SWAPFILE(USED_FILE);
 
 	if (tst_syscall(__NR_swapon, USED_FILE, 0))
 		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 5295a6a73..ecce28bdc 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -49,7 +49,7 @@ static int setup_swap(void)
 
 			/* Create the swapfile */
 			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-			MAKE_SWAPFILE_BLKS(filename, 10);
+			MAKE_SMALL_SWAPFILE(filename);
 
 			/* turn on the swap file */
 			TST_EXP_PASS_SILENT(swapon(filename, 0));
@@ -62,7 +62,7 @@ static int setup_swap(void)
 		tst_brk(TFAIL, "Failed to setup swap files");
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	MAKE_SWAPFILE_BLKS(TEST_FILE, 10);
+	MAKE_SMALL_SWAPFILE(TEST_FILE);
 
 	return 0;
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
