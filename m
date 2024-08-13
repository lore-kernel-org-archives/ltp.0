Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0C9C52D7B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 17:33:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2339F3D212B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 19:33:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA53B3C021C
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 19:33:05 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEDF6100077D
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 19:33:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13EDD22723;
 Tue, 13 Aug 2024 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723570381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wmk5Ge0xjW7fOu4aDZse/0MvXuRz/DVig0ED3FP+6Pc=;
 b=TSOpZ6VPviJj2vAI5w4AzHGHZt9lEk4VpR8LOyDMYKcWhMaPoiNiWZbLWvleTXdkGFgMFV
 aByrR8X6iO9RdnNumI7Jm9eX0Yrh47jCN65EeYDuMKFW7AJg7gRugf87P3pX86328RPJrM
 IqDo5RtLmi0gRFG9dR9cCzVenEEJaG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723570381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wmk5Ge0xjW7fOu4aDZse/0MvXuRz/DVig0ED3FP+6Pc=;
 b=P0R+VKTgmULUhrd4OmrIqEW+lXoBbZUTJEerdbnittY7twtP05MtrX+G5YIAWxnLFUwh0/
 yI1ATNlV0acgpSBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LJpAucGo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hSTX1q5X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723570380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wmk5Ge0xjW7fOu4aDZse/0MvXuRz/DVig0ED3FP+6Pc=;
 b=LJpAucGoJblRK9RtPgF7XkGlxMLgtcwQ0Z5xO7AYxzEUUTvp1Ckxyzauv0udb5SfecnDKl
 KVL+iIjQVJmv7yQcbPzrYgLMvF9B1+vC1GiTHIrt31o+g+HwI3acfthaSQ9419+PIXDaXq
 cmapvhoUZGEDtPWgPyRbUpygqzbvCTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723570380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wmk5Ge0xjW7fOu4aDZse/0MvXuRz/DVig0ED3FP+6Pc=;
 b=hSTX1q5XkNGJjRy5xLOVRSArfCT6iCIMcaGB6OwsSYXm2vjLVCRpxG1ckUZSLMhKU3/I/c
 smTQyIQeOhd7wpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B99C6136A2;
 Tue, 13 Aug 2024 17:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o//LKcuYu2Y6XgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 Aug 2024 17:32:59 +0000
Date: Tue, 13 Aug 2024 19:32:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: =?iso-8859-2?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Message-ID: <20240813173254.GB482023@pevik>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
 <20240808095824.GC327665@pevik> <20240809.Ohqueicih1ou@digikod.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240809.Ohqueicih1ou@digikod.net>
X-Rspamd-Queue-Id: 13EDD22723
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux-test-project.readthedocs.io:url,suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.it:url];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: =?iso-8859-2?Q?G=FCnther?= Noack <gnoack@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Aug 08, 2024 at 11:58:24AM +0200, Petr Vorel wrote:
> > is is really helpful when landlock support has
> > > been backported into old kernels.

> > Great, I'm glad you removed it from all landlock tests. It really did not make
> > sense to guard correct version with 3 guards (kernel version, kernel config and
> > ABI). Could you please remove also CONFIG_SECURITY_LANDLOCK=y, because you
> > check EOPNOTSUPP in verify_landlock_is_enabled().

> > Anyway, feel free to merge these first 3 patches (ideally remove also
> > CONFIG_SECURITY_LANDLOCK=y before merge).

> My understanding is that LTP only tests supported features to make sure
> they work as expected, if enabled.  Is it correct?

FYI LTP should skip the test if feature is not enabled (instead of false
positive result). And LTP tries to support various kernels (mainline,
stable/LTS, enterprise kernels), various glibc (and other libc) versions [1].

If possible (like in landlock case) it's best to avoid hardcoding minimal kernel
version (features can be backported). Also, when not needed, it's better to
avoid kernel config check (e.g. for landlock).

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html

> I'm then wondering what is the purpose of needs_kconfigs.  If there is
> no "needed" config, does that means that Landlock tests will always run
> and detect at run time if tests are skipped or not?  If yes, it looks
> good to me.

> Andrea's commit to remove needs_kconfig:
> https://github.com/linux-test-project/ltp/commit/e7ebc637d0d99295490adf57660a3b3a177d65d3

> Is there an online dashboard to see some tested kernels?


> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
