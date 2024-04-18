Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E464C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:14:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D03303CFC24
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:14:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8219A3CFC1A
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:24 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE4A560A807
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BD3F2084D;
 Thu, 18 Apr 2024 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNEiNE+MRSRjYRMcl1dBcC7769isS2frzvWf4eK8yUY=;
 b=OemBADF5AnU9+BwyVgDZH3Q0tTHCNqXmWTAESAHcGrNekk7gHl9UgvSMxqd4g0sBhiudm/
 H8BrXi1y4JG6BFAou1y2N++EpuPwkClAJUTJWrxYTLYWreiFrQ0tp3AgujGEPDaUmdOQbl
 gF87ABEAhzbHGxg7RD0brw7fZ6PljFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNEiNE+MRSRjYRMcl1dBcC7769isS2frzvWf4eK8yUY=;
 b=QJX3M2ct1Hf+ph5kQresAXfQ4GUyRiHfGA+cuRXYJugSfPsWtwYwfd39kv81b5osX5AIyR
 dKl/+GqM7THsCGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNEiNE+MRSRjYRMcl1dBcC7769isS2frzvWf4eK8yUY=;
 b=N0KHOAxEGQaWvRy4C0WXybwY2x8uBFeLClQporpapIq8e3vXWm+GL9WaO4IjxZ1svf4mnn
 zs9wGnPXBF2VYyicNS+1kCOlYfRKdw5ROBrO3ynLsqBwVq8VJ1IYWnxtazfBHI56jRA1AA
 ait8lffUAXMPHm5PGqQFrKpCXvEfYu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNEiNE+MRSRjYRMcl1dBcC7769isS2frzvWf4eK8yUY=;
 b=qsA7lPqd6hvjvMpJN6gTglkxzFJZ0hcWtnYaczOjytyKaE8EOplpfraj+dYOedn9CvjaOC
 +9YWw4UM+fh5qiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E9DE13981;
 Thu, 18 Apr 2024 14:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MO8zAoAqIWbOHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 14:13:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 16:13:12 +0200
Message-ID: <20240418141312.99794-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418141312.99794-1-pvorel@suse.cz>
References: <20240418141312.99794-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] libswap: Use {SAFE_,}MAKE_MINIMAL_SWAPFILE()
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/libltpswap/libswap.c                     | 2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c | 2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   | 4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index aed76dfe2..92127d8cd 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -192,7 +192,7 @@ int make_swapfile(const char *file, const int lineno,
 bool is_swap_supported(const char *filename)
 {
 	int i, sw_support = 0;
-	int ret = SAFE_MAKE_SWAPFILE_BLKS(filename, 10);
+	int ret = SAFE_MAKE_MINIMAL_SWAPFILE(filename);
 	int fi_contiguous = file_is_contiguous(filename);
 	long fs_type = tst_fs_type(filename);
 	const char *fstype = tst_fs_type_name(fs_type);
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 5a15826e4..676d06619 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -87,7 +87,7 @@ static void setup(void)
 	nobody_uid = nobody->pw_uid;
 
 	is_swap_supported(TEST_FILE);
-	SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
+	SAFE_MAKE_MINIMAL_SWAPFILE(SWAP_FILE);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index e5e29b8e7..20f3cfd26 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -50,8 +50,8 @@ static void setup(void)
 	is_swap_supported(TEST_FILE);
 
 	SAFE_TOUCH(NOTSWAP_FILE, 0777, NULL);
-	MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
-	MAKE_SWAPFILE_BLKS(USED_FILE, 10);
+	MAKE_MINIMAL_SWAPFILE(SWAP_FILE);
+	MAKE_MINIMAL_SWAPFILE(USED_FILE);
 
 	if (tst_syscall(__NR_swapon, USED_FILE, 0))
 		tst_res(TWARN | TERRNO, "swapon(alreadyused) failed");
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 5295a6a73..342b5e38a 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -49,7 +49,7 @@ static int setup_swap(void)
 
 			/* Create the swapfile */
 			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-			MAKE_SWAPFILE_BLKS(filename, 10);
+			MAKE_MINIMAL_SWAPFILE(filename);
 
 			/* turn on the swap file */
 			TST_EXP_PASS_SILENT(swapon(filename, 0));
@@ -62,7 +62,7 @@ static int setup_swap(void)
 		tst_brk(TFAIL, "Failed to setup swap files");
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	MAKE_SWAPFILE_BLKS(TEST_FILE, 10);
+	MAKE_MINIMAL_SWAPFILE(TEST_FILE);
 
 	return 0;
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
