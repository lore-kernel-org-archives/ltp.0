Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7124BC4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 19:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 942023CF038
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 20:41:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66A2D3CF03C
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0EDF200900
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C51FE1FBAB;
 Thu,  7 Dec 2023 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjYNJYzgt7He/kBaFAEzfCHeJ5IWmtMCX4BFxvREa3k=;
 b=bFEGLqymlxNoqpS656W38cJsZ0l4kKJ+KY6cNlMHspizDU0fO+X1l+3sfqXvb1hj3ueatg
 HpZRuxiIXiW/Hf03tw1p1c58wMbxAezgpXXk5vUX7WuthotPjd2J2zgkhupYyt9dvoWJRR
 o6utAOUUFmqWCenwgN0yWP2X36Cfsy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjYNJYzgt7He/kBaFAEzfCHeJ5IWmtMCX4BFxvREa3k=;
 b=67YvANta77HWAq9rRwU4v+qBzjJv5kjJjPrx5kSNiJYHjHHoZG95pGYSBilKTRD+zRat6d
 nQOSPmMyCQZKqAAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjYNJYzgt7He/kBaFAEzfCHeJ5IWmtMCX4BFxvREa3k=;
 b=S9Jf2AhWPiguItQz4/pbeDtssBlW6c806eDqtfzhYCipx0h+8HG4N/UdnBOQyvGv+0zQHC
 ZFmD8pG3pw02Lavtyk9NuhUqV/q0pwwRftG4W1R+svS3Qgm5UvVdj4ZKOW5n5YgscjcWF+
 93o4lcSiw9XH2Rx33tcn4I1g2WPBX1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjYNJYzgt7He/kBaFAEzfCHeJ5IWmtMCX4BFxvREa3k=;
 b=wVs3OBRrGMmhkWA4wyWgIGlyfNmRAGm7uaHfx7Oiso/gmL8KXg4oDyA5JDwVLnmdUCgeIa
 JqgS0TodH01rnqDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A5E613907;
 Thu,  7 Dec 2023 19:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id CJeYBLQfcmVyBQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 19:40:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 20:40:10 +0100
Message-ID: <20231207194011.273027-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207194011.273027-1-pvorel@suse.cz>
References: <20231207194011.273027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLY(-4.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RLecpkqykizks3u9s7xp6n6wei)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,suse.com,fujitsu.com,linux.dev,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.62)[82.12%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] lib: Add support bcachefs filesystem to
 .all_filesystems
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

bcachefs has been merged into v6.7-rc1 [1]. Let's add it's support to
LTP .all_filesystems = 1 and TST_ALL_FILESYSTEMS=1.

[1] https://lwn.net/Articles/934692/

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v1

 lib/tst_supported_fs_types.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index d4911fa3b..369836717 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2018-2023
  */
 
 #include <stdio.h>
@@ -24,6 +25,7 @@ static const char *const fs_type_whitelist[] = {
 	"ext4",
 	"xfs",
 	"btrfs",
+	"bcachefs",
 	"vfat",
 	"exfat",
 	"ntfs",
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
