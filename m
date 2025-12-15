Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA11FD5B84E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:14:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 723F93D022E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:14:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7087F3C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:14:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2203200910
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:14:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAC385BD01;
 Mon, 15 Dec 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FBE33EA63;
 Mon, 15 Dec 2025 16:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SCNWHsozQGm7fwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 16:14:02 +0000
Date: Mon, 15 Dec 2025 17:13:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251215161353.GA282302@pevik>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AAC385BD01
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

Hi,
...
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
> > > @@ -81,5 +81,10 @@ static struct tst_test test = {
> > >  		{&info0, .size = sizeof(*info0)},
> > >  		{&info1, .size = sizeof(*info1)},
> > >  		{}
> > > +	},
> > > +	.needs_kconfigs = (const char *[]) {
> > > +		"CONFIG_USER_NS",
> > > +		"CONFIG_PID_NS",

> > How about to check /proc/self/ns/user and /proc/self/ns/pid as ioctl_ns06.c
> > does?

> >     int exists = access("/proc/self/ns/user", F_OK);

> >     if (exists < 0)
> >         tst_res(TCONF, "namespace not available");

> > Long time ago we tried to avoid forcing config. Is it now considered as better?
> > (maybe more readable?) Or we would keep checking /proc (or /sys) but add a
> > comment for required functions?

> This case is specific to the CONFIG_PID_NS/CONFIG_USER_NS configurations
> and the feature can't be tested if kernel is not configured with them.
> Manual is clear about it: https://www.man7.org/linux/man-pages/man7/pid_namespaces.7.html

And https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html.

Yeah, I understand that. The dependency of CLONE_NEWUSER/CLONE_NEWPID is also
visible in kernel sources (e.g. fs/nsfs.c). But my question was different:
Do we now prefer everything kind of document with .needs_kconfigs, even it's
possible to detect it otherwise? (speed of parsing kconfig, kind of hard request
for kconfig being available even we can figure the support otherwise).

And if we decide for forcing kconfig, we should update ioctl_ns06.c, which does
/proc based detection (i.e. to use the same approach).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
