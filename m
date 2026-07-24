Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E0BC531C9
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 11:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9393E5583
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 13:31:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E813E2AEF
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 13:31:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B43231A009BC
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 13:31:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2A197B721;
 Fri, 24 Jul 2026 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784892691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4Fl2k1FpSpJK+mklx9BVXOYPucR6gTnEOaL/KmPfMg=;
 b=cJgf6gr0tLXnmNMNCoh4noJOjGGgOdTC36txJzSulrkj6hqj4uiE1eNG+mOI/3gAtEtIYB
 2WUOWK65FpZfZhk98D7C2GpdJGbq/U9O8ItjjevO1X40rvannfm3dMeKqA6/Wsd1Iy7Z3Q
 JGkC4JlUi01YIJkgwVYTr7sH4igOj8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784892691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4Fl2k1FpSpJK+mklx9BVXOYPucR6gTnEOaL/KmPfMg=;
 b=uN6fqIGwjWAJp+iaNacU9vBW87coV7enEVJ63hjlNFiLzOCCe41GgFjVa8r6kHMpVWVBxd
 bDZAOv7lyQIiNhDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EacrBbxe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ejcbKRDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784892690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4Fl2k1FpSpJK+mklx9BVXOYPucR6gTnEOaL/KmPfMg=;
 b=EacrBbxe7B4furWfLw83ZPqg/2BzMrEQlMR5erZxHTqv4t3w8bfFBOmURcktb/71kLO8Jw
 VmyoUinVXOPDHjpJAyX/1uabTdbwXKseMIezDi9auEbHR+fL+97m4vtMIKE0hRQfY7hmAh
 a8TcrSVTCXAX72vkvzBaR+UjCdvmf8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784892690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4Fl2k1FpSpJK+mklx9BVXOYPucR6gTnEOaL/KmPfMg=;
 b=ejcbKRDRoB3DpFLIN15Mr+p+4k60tAs0dYZ4JZnbC5skD8VaMPjRbkctOtm+P2A0CI0+UV
 jWWxqrCjaiGeEmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 953EA779BA;
 Fri, 24 Jul 2026 11:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABiHIxJNY2qKLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jul 2026 11:31:30 +0000
Date: Fri, 24 Jul 2026 13:31:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260724113119.GA876268@pevik>
References: <20260722080456.GA826637@pevik>
 <6a60b4f2.332cc45f.161033.23b2@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a60b4f2.332cc45f.161033.23b2@mx.google.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B2A197B721
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > I'd say it depends how your displays tabs (if tabs are in the sources, we have
> > .editorconfig, but not all not all developers have their editor set to use it).
> > In certain setup it does not look OK + the problem of inconsistency, but I'm ok
> > to ignore it.

> At the moment i use the standard kernel guidelines for TAB (8 spaces)


> > > > * OPEN_ENDED_LINE asks for not ending line with '(' or '['.
> > > > i.e. instead of this:
> > > > 	ruleset_fd = TST_EXP_FD_SILENT(
> > > > 								   tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > > > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> > > > have this:
> > > > 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> > > > 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));

> > > you choose the right example, landlock testing suite has been updated to
> > > match this rule and now it has stuff like:

> > > 	apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
> > > 				path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

> For some reason my email client is not showing the correct spaces in the
> example:

> my_ret_val = apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
>                                      path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

> or:


> my_ret_val = apply_landlock_fs_layer(ruleset_attr,
>                                      sizeof(struct tst_landlock_ruleset_attr_abi1),
>                                      path_beneath_attr,
>                                      MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

> to escape the 80-100 lines rule.

As I wrote, I prefer more arguments in the line than a single one.

Anyway, I tend to send RFC patch to add OPEN_ENDED_LINE, to see what others
think about it. But if you're strongly against it, I would not want to enforce
you.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
