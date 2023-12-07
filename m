Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD79C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 19:41:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E466B3CBBA7
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 20:41:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5B53CE81A
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02D8D1000488
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:38 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EAAD1F750;
 Thu,  7 Dec 2023 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DwboQL/DHJSf9SD8lSKa4XQy4oebdMOBMZGqQH9yO8=;
 b=FZZ/CALHkph1b5c1SRxJdqmZNQc+KWLFOaiztbc82nBynO2SuiXAMHk6JWeMDd7rZuchoT
 9uUJkc/SqC7u5oqkw1mr6gbqGRKtnPEOFG9quL7AIr5C+yboStGkr991Df5mkmTZDm2wnw
 iahatC6iPnAPgdVI9Tfvoi5Q+UjJXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DwboQL/DHJSf9SD8lSKa4XQy4oebdMOBMZGqQH9yO8=;
 b=hVEI9LMeECsG42Xkerv6wMgNRk+ljL53MtapbbWrI7TU7glQSBRSfIVTkJsyfu0mBsNd+c
 smG8rWRz47OK+mAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DwboQL/DHJSf9SD8lSKa4XQy4oebdMOBMZGqQH9yO8=;
 b=FZZ/CALHkph1b5c1SRxJdqmZNQc+KWLFOaiztbc82nBynO2SuiXAMHk6JWeMDd7rZuchoT
 9uUJkc/SqC7u5oqkw1mr6gbqGRKtnPEOFG9quL7AIr5C+yboStGkr991Df5mkmTZDm2wnw
 iahatC6iPnAPgdVI9Tfvoi5Q+UjJXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DwboQL/DHJSf9SD8lSKa4XQy4oebdMOBMZGqQH9yO8=;
 b=hVEI9LMeECsG42Xkerv6wMgNRk+ljL53MtapbbWrI7TU7glQSBRSfIVTkJsyfu0mBsNd+c
 smG8rWRz47OK+mAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C7A913B96;
 Thu,  7 Dec 2023 19:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QDG5NLQfcmVyBQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 19:40:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 20:40:11 +0100
Message-ID: <20231207194011.273027-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207194011.273027-1-pvorel@suse.cz>
References: <20231207194011.273027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RLecpkqykizks3u9s7xp6n6wei)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,suse.com,fujitsu.com,linux.dev,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.49%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on Bcachefs
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
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

STATX_ATTR_COMPRESSED is not supported on Bcachefs, thus skip it
(it's already skipped on tmpfs and XFS).

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 testcases/kernel/syscalls/statx/statx04.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 58296bd24..c2ed52deb 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -96,8 +96,9 @@ static void setup(void)
 	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
 		expected_mask |= attr_list[i].attr;
 
-	/* STATX_ATTR_COMPRESSED not supported on XFS, TMPFS */
-	if (!strcmp(tst_device->fs_type, "xfs") || !strcmp(tst_device->fs_type, "tmpfs"))
+	/* STATX_ATTR_COMPRESSED not supported on Bcachefs, TMPFS, XFS */
+	if (!strcmp(tst_device->fs_type, "bcachefs") || !strcmp(tst_device->fs_type, "tmpfs") ||
+	    !strcmp(tst_device->fs_type, "xfs"))
 		expected_mask &= ~STATX_ATTR_COMPRESSED;
 
 	/* Attribute support was added to Btrfs statx() in kernel v4.13 */
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
