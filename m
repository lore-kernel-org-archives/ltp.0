Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99405CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:49:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 288BA3E619F
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:49:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B4AC3C1E1C
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:49:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18DDD60073F
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:49:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47B136746E;
 Wed,  3 Jun 2026 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1nr2VEWBtkOJ6lJUyZifPRljwWx694nRMGTlgn6w/o=;
 b=ghfjucH5ySPbEbPRWm5bN/gUHoYd6MZC5wqortqNEOBM8F1PSDzdI017cB0NZAD3ygNydS
 AnzhfjiaSkipNe9bNWAVQ5lnu+KWgc0uM0I0I0THyG+nNuPTTgc976XBNRHZNoTSw1Q0hJ
 KDqDS6N+VNKURCQqht2nYwTYHCGeCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1nr2VEWBtkOJ6lJUyZifPRljwWx694nRMGTlgn6w/o=;
 b=ON9I3akeVxnQacSXMplcYFSvAH7sYp95HdvNwjc0mVwZ60guxvQHSO9F0BchURS/8L/Flr
 Fa1CghHtUi6gK+Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1nr2VEWBtkOJ6lJUyZifPRljwWx694nRMGTlgn6w/o=;
 b=ghfjucH5ySPbEbPRWm5bN/gUHoYd6MZC5wqortqNEOBM8F1PSDzdI017cB0NZAD3ygNydS
 AnzhfjiaSkipNe9bNWAVQ5lnu+KWgc0uM0I0I0THyG+nNuPTTgc976XBNRHZNoTSw1Q0hJ
 KDqDS6N+VNKURCQqht2nYwTYHCGeCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z1nr2VEWBtkOJ6lJUyZifPRljwWx694nRMGTlgn6w/o=;
 b=ON9I3akeVxnQacSXMplcYFSvAH7sYp95HdvNwjc0mVwZ60guxvQHSO9F0BchURS/8L/Flr
 Fa1CghHtUi6gK+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386EB5A4D3;
 Wed,  3 Jun 2026 09:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZqXaDKf4H2qQawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jun 2026 09:49:27 +0000
Date: Wed, 3 Jun 2026 11:49:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: XiaoLei Wu <wxl18715129466@gmail.com>
Message-ID: <ah_4n5km_qrz4nmk@yuki.lan>
References: <20260602064502.718525-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260602064502.718525-1-wxl18715129466@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: skip ntfs3 in ioctl_fiemap01 and mount03
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Since commit 7dc8e9a515ce ("lib: Treat kernel ntfs3 as a separate FS"),
> tests with all_filesystems=1 run on ntfs3 independently.
> 
> ioctl_fiemap01 and mount03 already skip ntfs, but still run on ntfs3.
> ioctl_fiemap01 fails because the returned FIEMAP extents do not match
> the layout expected by the test. mount03 fails because directory
> timestamps are not updated as expected under strictatime. Add ntfs3 to
> their skip lists, matching the existing ntfs skips.

Maybe it would make more sense to match ntfs3 when ntfs is in the
skiplist in the test library instead, something as:

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index d3020fc48..d20c655ea 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -72,6 +72,9 @@ int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
 {
        unsigned int i;

+       if (!strcmp(fs_type, "ntfs3"))
+               fs_type = "ntfs";
+
        if (!skiplist)
                return 0;


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
