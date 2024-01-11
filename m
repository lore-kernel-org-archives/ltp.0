Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DEDC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 15:06:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D192F3CE433
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 16:06:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 865393C768C
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 16:06:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1CE2E6068F7
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 16:05:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B3E221FA2;
 Thu, 11 Jan 2024 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704985558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7aS2PlMmCiryfDitmcL1Cpo6Mq4SnSFnam7+9jfCSKY=;
 b=cwwC4wzzhaS2W8TrOrefafXYQUJWF+LsVrLsHixvjo/Zg7NzxJUc48GiuhwT68YqB23QsB
 XSSpRikRCCGc3Dvw4j9XQByMdTjeiD73rbHtKf70W9bAa+1On1+QPxKuRKo1hj5r24Ynnu
 ic5SNdGJItApES/0JJsEigKUjUrIkDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704985558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7aS2PlMmCiryfDitmcL1Cpo6Mq4SnSFnam7+9jfCSKY=;
 b=8F9unIkUQdFYxSz8VnMLjHmwfUIeSRPJTm0NH5yfeLRQ9lSW/RODtE7C2Z2djOXFM2nzBB
 B9tfyRH82RDgDoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704985558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7aS2PlMmCiryfDitmcL1Cpo6Mq4SnSFnam7+9jfCSKY=;
 b=cwwC4wzzhaS2W8TrOrefafXYQUJWF+LsVrLsHixvjo/Zg7NzxJUc48GiuhwT68YqB23QsB
 XSSpRikRCCGc3Dvw4j9XQByMdTjeiD73rbHtKf70W9bAa+1On1+QPxKuRKo1hj5r24Ynnu
 ic5SNdGJItApES/0JJsEigKUjUrIkDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704985558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7aS2PlMmCiryfDitmcL1Cpo6Mq4SnSFnam7+9jfCSKY=;
 b=8F9unIkUQdFYxSz8VnMLjHmwfUIeSRPJTm0NH5yfeLRQ9lSW/RODtE7C2Z2djOXFM2nzBB
 B9tfyRH82RDgDoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829A8132CF;
 Thu, 11 Jan 2024 15:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UL71HdUDoGUdRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jan 2024 15:05:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 16:05:53 +0100
Message-ID: <20240111150553.1923767-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cwwC4wzz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8F9unIkU
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.94 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[11]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.05)[59.67%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 0B3E221FA2
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] safe_macros: Fix bcachefs failure old kernel
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP with bcachefs-tools and kernel < 6.7 fails (more tests):

    # LTP_SINGLE_FS_TYPE=bcachefs ./chdir01
    ...
    tst_supported_fs_types.c:57: TINFO: mkfs.bcachefs does exist
    tst_test.c:1669: TINFO: === Testing on bcachefs ===
    tst_test.c:1117: TINFO: Formatting /dev/loop0 with bcachefs opts=''
    extra opts=''
    tst_test.c:1131: TINFO: Mounting /dev/loop0 to
    /tmp/LTP_chdwqhGtZ/mntpoint fstyp=bcachefs flags=0
    tst_test.c:1131: TBROK: mount(/dev/loop0, mntpoint, bcachefs, 0, (nil))
    failed: ENODEV (19)

The problem is that on FUSE support we expect there is FUSE bcachefs
implementation. bcachefs supports fusemount, but let's skip testing atm.

Fixes: 94802606e ("lib: Add support bcachefs filesystem to .all_filesystems")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I'm sorry, although man bcachefs(8) mentions fusemount, I haven't
figured out how to mount filesystem. Am I missing something?

Also, maybe for the start I would prefer to to test just kernel
functionality (no fuse).

Kind regards,
Petr

 lib/tst_supported_fs_types.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 369836717..21765c370 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -96,6 +96,11 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)
 
 	SAFE_RMDIR(template);
 
+	if (!strcmp(fs_type, "bcachefs") && tst_kvercmp(6, 7, 0) < 0) {
+		tst_res(TINFO, "bcachefs skipped on kernel < 6.7");
+		return TST_FS_UNSUPPORTED;
+	}
+
 	/* Is FUSE supported by kernel? */
 	if (fuse_supported == -1) {
 		ret = open("/dev/fuse", O_RDWR);
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
