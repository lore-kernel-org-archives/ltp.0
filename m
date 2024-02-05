Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD0C48286
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 02:29:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3B73CE057
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 03:29:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 061383C9968
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 03:29:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 444A260084A
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 03:29:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 942012218D;
 Mon,  5 Feb 2024 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707100142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIuybfT81aB0RTrvkl/dNlakuKJv89p5+N1FMqPi4yg=;
 b=gfWEJKROwfFsChKAnKIxK9E8gte/dkfqY7459Icc2X3bA1aiv5+nWnX+Ztql8X80wPyH5k
 MDAsGy8ZtMiiUSTmnu+w9w3AWD8ff9Rh2N9LS5wyrfKP5s5r8w/BdeLR9yu7Q502fIy1Gv
 nHT+wIU73nyRcSOl1ZYGZJPhUf0Dp5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707100142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIuybfT81aB0RTrvkl/dNlakuKJv89p5+N1FMqPi4yg=;
 b=Eq3yG2QGJ1VDEXRzdbqA1YRHte217V4VUQnXG8RHDGVKuPjrfuRpiQUn95wYZVUlOQeD0p
 EQtoaI9rtm0VOxAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707100142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIuybfT81aB0RTrvkl/dNlakuKJv89p5+N1FMqPi4yg=;
 b=gfWEJKROwfFsChKAnKIxK9E8gte/dkfqY7459Icc2X3bA1aiv5+nWnX+Ztql8X80wPyH5k
 MDAsGy8ZtMiiUSTmnu+w9w3AWD8ff9Rh2N9LS5wyrfKP5s5r8w/BdeLR9yu7Q502fIy1Gv
 nHT+wIU73nyRcSOl1ZYGZJPhUf0Dp5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707100142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIuybfT81aB0RTrvkl/dNlakuKJv89p5+N1FMqPi4yg=;
 b=Eq3yG2QGJ1VDEXRzdbqA1YRHte217V4VUQnXG8RHDGVKuPjrfuRpiQUn95wYZVUlOQeD0p
 EQtoaI9rtm0VOxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CF113A2E;
 Mon,  5 Feb 2024 02:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MAVrFO5HwGUPRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 02:29:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  5 Feb 2024 03:28:57 +0100
Message-ID: <20240205022857.191692-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205022857.191692-1-pvorel@suse.cz>
References: <20240205022857.191692-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gfWEJKRO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Eq3yG2QG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,opensuse.org:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 942012218D
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] swapon03: Swap is not supported on TMPFS on tmpfs
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_test.c:1701: TINFO: === Testing on ext4 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swanIztq7/mntpoint fstyp=ext4 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon03.c:164: TWARN: Failed to create swapfile: swapfile02: EINVAL (22)
swapon03.c:175: TFAIL: Failed to setup swaps

At least on kernel 6.7.

Fixes: 009a407a0 ("swapon/off: enable all_filesystem in swap test")
Reported-by: Dominique Leuenberger <dimstar@opensuse.org>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 3dbcd5bfd..37314cc65 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -247,6 +247,9 @@ static void setup(void)
 	if (access("/proc/swaps", F_OK))
 		tst_brk(TCONF, "swap not supported by kernel");
 
+	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
+		tst_brk(TCONF, "swap not supported on tmpfs");
+
 	is_swap_supported(TEST_FILE);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
