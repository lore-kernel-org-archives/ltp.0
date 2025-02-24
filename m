Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEDAC021A6
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:00:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CD4F3C98CF
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:00:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 740C23C077F
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:00:21 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C7B61BDB9B9
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:00:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42679211C6;
 Mon, 24 Feb 2025 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740391219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDArZjS1hhLZes5dRHeaXU1As9DnhIPWEqcKINuJ+m4=;
 b=Twt/fWGUOQ2QcWs32ZjDLnKP0MfyKX1dsoYAEZHRK748bVb94JuIo2QfbVoQGXeiEsnVXG
 7C9SZK+G+lbDoDX9dIo1KDq+Pd6kBNOo4kXaAT8f9JaKV4R6YB/nviv+nZactfrHF5FUDS
 HyELrvfao8m4fVIj+v9IJT2z3TF9K/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740391219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDArZjS1hhLZes5dRHeaXU1As9DnhIPWEqcKINuJ+m4=;
 b=p1BbJEyJ3p8YEl0prBCLoS0L35SrfbxE84xo8JgNCYFYtY9iSEgOXAjq7H1fDUWcnygFx0
 X4wwoukHQh75unAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740391219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDArZjS1hhLZes5dRHeaXU1As9DnhIPWEqcKINuJ+m4=;
 b=Twt/fWGUOQ2QcWs32ZjDLnKP0MfyKX1dsoYAEZHRK748bVb94JuIo2QfbVoQGXeiEsnVXG
 7C9SZK+G+lbDoDX9dIo1KDq+Pd6kBNOo4kXaAT8f9JaKV4R6YB/nviv+nZactfrHF5FUDS
 HyELrvfao8m4fVIj+v9IJT2z3TF9K/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740391219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDArZjS1hhLZes5dRHeaXU1As9DnhIPWEqcKINuJ+m4=;
 b=p1BbJEyJ3p8YEl0prBCLoS0L35SrfbxE84xo8JgNCYFYtY9iSEgOXAjq7H1fDUWcnygFx0
 X4wwoukHQh75unAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1307C13929;
 Mon, 24 Feb 2025 10:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sGmnAjNDvGfQbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Feb 2025 10:00:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Feb 2025 11:00:15 +0100
Message-ID: <20250224100016.2857704-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224100016.2857704-1-pvorel@suse.cz>
References: <20250224100016.2857704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.77 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-0.97)[-0.969]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_supported_fs_types: Ignore empty
 $LTP_SINGLE_FS_TYPE value
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

Previously empty $LTP_SINGLE_FS_TYPE value caused no testing:

    # LTP_SINGLE_FS_TYPE= ./getdents02
    ...
    LTP_SINGLE_VARIANT= LTP_SINGLE_FS_TYPE= ./getdents02
    tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.12.10-amd64'
    tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
    tst_supported_fs_types.c:161: TINFO: WARNING: testing only
    tst_supported_fs_types.c:128: TINFO: Filesystem  is not supported
    tst_test.c:1861: TCONF: There are no supported filesystems

Now value is ignored:

    # LTP_SINGLE_FS_TYPE= ./getdents02
    ...
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
    tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
    tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
    tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
    tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
    tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports bcachefs
    tst_supported_fs_types.c:62: TINFO: mkfs.bcachefs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
    tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
    tst_supported_fs_types.c:62: TINFO: mkfs.exfat does exist
    tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
    tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
    tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
    tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
    tst_test.c:1834: TINFO: === Testing on ext2 ===

Fixes: 1199657e91 ("lib: Add support for debugging .all_filesystems")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_supported_fs_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19f..5e51595d82 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -157,7 +157,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
 	only_fs = getenv("LTP_SINGLE_FS_TYPE");
 
-	if (only_fs) {
+	if (only_fs && only_fs[0] != '\0') {
 		tst_res(TINFO, "WARNING: testing only %s", only_fs);
 		if (tst_fs_is_supported(only_fs))
 			fs_types[0] = only_fs;
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
