Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A6AD5B84D
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:53:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ADFC3D0124
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:53:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E82C53C8AC5
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:53:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A437E600136
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:52:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B735133779;
 Mon, 15 Dec 2025 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765817576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RA0TO5FnN1Z3NKawt4MMDyLaRyDuElZp/aO7UYPC6I=;
 b=1vqzQwA+uWGfYXkI2iIYan8pNSvRy0rSKJ/ldlfHHklEstyZ2hH/XQoFXcEdGWYfmaav33
 MdRctbCB66WKnAqbCVk9paCKPblHOTCjIKYtg+wrcBjFjatpI7K4liCZg3r4Z5T+hi3D6/
 GLopz0NLpSywANH22p/0RwrCxBs145g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765817576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RA0TO5FnN1Z3NKawt4MMDyLaRyDuElZp/aO7UYPC6I=;
 b=LW4GdLDe4GJcSTL7RgvQCwOy90vn9r8TzLsv3O272Yhvj/x4Snk7LDZRLiaec9ABL56wKU
 gPfDeuEk+iTv5yBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765817574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RA0TO5FnN1Z3NKawt4MMDyLaRyDuElZp/aO7UYPC6I=;
 b=zycZfyO9BMOvJKjguCukriQAXQnTA5guQlgCTSb/AkKDdQqk6yKcFMVB5IfxKusczgDi2N
 hmHv+QsAmNqfCpO9lJSQ2BxIZ58ENRCOk3YM1yZlf3B2SN9sXCe0AWN/f2PKUsdcM3Xqdb
 E3YXPNxLO+TPSrtvTW8iAM5ri+nF9m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765817574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RA0TO5FnN1Z3NKawt4MMDyLaRyDuElZp/aO7UYPC6I=;
 b=XtLMBcOUp8olSbmT6CA3rd76KofUzJg+7qBM2wAJf4Q8djsCHxIaR9nBQOyyBPO/TQPzzq
 JigiTlzuWIIPbBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCF6F3EA63;
 Mon, 15 Dec 2025 16:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CV7wKeU8QGlNJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 16:52:53 +0000
Date: Mon, 15 Dec 2025 17:52:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251215165247.GC282302@pevik>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,man7.org:url,suse.cz:replyto,linux-test-project.readthedocs.io:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.

> > Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
> > visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
> > Do we now prefer everything kind of document with .needs_kconfigs, even it's
> > possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
> > for kconfig being available even we can figure the support otherwise).

> I believe we shouldn't see this as black/white but use this feature when
> it's really needed. This is the case.

Sure, .needs_kconfigs is used when test request some functionality based on
kconfig.  But many tests use /proc or /sys based detection (e.g. ioctl_ns06.c)
or based on certain errno, see include/lapi/syscalls.h or
testcases/kernel/syscalls/fanotify/fanotify.h) because these were
added before LTP supported kconfig. Later, when kconfig was added it was
considering as a last resort (when there was no way to detect dependency
otherwise).

Have we decide to move everything into kconfig?

I'm not sure myself.  needs_kconfigs is simpler and obvious, but it requires
kernel config.  I suppose the speed of parsing config is not an issue.

It'd be nice to mention the resolution (preferred vs. only if no other way to
detect the support) into
https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html

or into upcommig doc/developers/ground_rules.rst
https://patchwork.ozlabs.org/project/ltp/patch/20251215124404.16395-2-chrubis@suse.cz/

Kind regards,
Petr

> > And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
> > /proc based detection (i.e. to use the same approach).

> I didn't check this, but I'm pretty sure we should go all around and
> verify many other tests with the same issue. We should do it in this
> patch-set or on a searate one.


> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
