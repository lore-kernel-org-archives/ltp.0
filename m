Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DE1C41513
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 19:57:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B4563CFD69
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 21:57:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71D3F3CF5A8
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 21:57:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CE616010E5
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 21:57:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14CFA21959;
 Mon, 16 Oct 2023 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697486231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETvVhSBz4xpKKG4Xg0qq+dZWHJzCmejUafKAM/T1288=;
 b=iRNZL5ebIO/C1bEaAOcg/QHGTVEPJEPxVDLP2KTA+QNwEeFnVKt6gEGa07kaPFOGI8qdrT
 mb7WVMFjWzMwUL61mNPd/66jOs4/XhaFQvwznYJhLvFaD+k/QSxJunpUbcUzosHVog9Xeu
 YN6sNCOwNkryn0FxdKNFI40hIj6ZSvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697486231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETvVhSBz4xpKKG4Xg0qq+dZWHJzCmejUafKAM/T1288=;
 b=BWnVtz/wB/CLu2BU/Qt2wC+HE1jh57SDe/r34kQBK2ACZLYWqZxjnwxbWiQsAiu6SmPIeE
 ziWsPLTvB804RtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89CE7133B7;
 Mon, 16 Oct 2023 19:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ce8ZHJaVLWXtBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 19:57:10 +0000
Date: Mon, 16 Oct 2023 21:57:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231016195708.GA880799@pevik>
References: <20231012103916.30712-1-rpalethorpe@suse.com>
 <ZSgIrcu2A5eC_OvZ@yuki> <87y1g6ylc9.fsf@suse.de>
 <ZSkOEKRXAGwvUwR0@yuki> <87pm1iyg2r.fsf@suse.de>
 <20231013121335.GA726277@pevik> <87lec3xbhn.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lec3xbhn.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-9.66 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-2.36)[-0.786]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add setsockopt10 TLS ULP UAF CVE-2023-0461
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie, Cyril,

> >> >> On NixOS:

> >> >> $ ./setsockopt10
> >> >> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> >> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.dep does not exist or not a file
> >> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.builtin does not exist or not a file

> > For my info: this comes from Cyrils suggestion to use .needs_drivers.

> >> > Can you strace modprobe to see what is different on the system, these
> >> > files have to be installed somewhere in order for modprobe to actually
> >> > work...

> >> They will be in /nix/store/<kernel package hash>/.../modules or similar.
> >> I can probably make it work on NixOS by creating a nix file, but I think
> >> there is a bigger issue.

> > "NixOS is a Linux distribution built on top of the Nix package manager." [1]

> > I have no idea why Linux distro needs non-standard patch. IMHO we can take patch
> > which detects NixOS and use it's path, but for the distro itself would be better
> > if it has at least symlink to the standard path (i.e. it'd be worth to report
> > it).

> Only if you can point to a specification and NixOS accepts that spec. If
> it is not in POSIX then it is unlikely to get through. There is not even
> a /lib in NixOS. Any absolute paths interfere with reproducibility,
> isolation and such. To see how such a discussion is likey to go see this
> thread on /bin/bash:
> https://discourse.nixos.org/t/add-bin-bash-to-avoid-unnecessary-pain/5673

Lol, missing /bin/bash, that's serious, at least they have /bin/sh :).

> OTOH all we need is a Nix file which creates the symlinks (or patches
> LTP) and specifies the LTPs deps to create a reproducible build of LTP
> in Nix. At some point I'll add it to CI.

I'm open to any solution - different path for NixOS or environment variable,
which could be used for NixOS (and maybe hopefully for other use case).
Please send a patch, whatever looks best to you.

> However this doesn't help other distro's or embedded systems that we
> don't personally use.


> > As Cyril noted we have .needs_drivers, but that's also require config files in
> > /lib/modules. But setsockopt10 could also benefit from .modprobe patchset [2],
> > particularly [3]. i.e. instead of asking for CONFIG_TLS "modprobe tls" could
> > work. But currently we also expect modules.builtin is in /lib/modules. We could
> > rethink that (e.g. introduce variable which ignores the check, or allows to pass
> > path the correct prefix of the directory or remove
> > tst_check_builtin_driver(name), which is based on parsing modules.builtin).

> > But for broader discussion please comment on the patchset itself.

> > And now something completely different: root vs. normal user:
> > $ find /lib/modules/$(uname -r) |grep tls
> > ...
> > /lib/modules/6.5.0-1-amd64/kernel/net/tls/tls.ko

> > But this does not work, when run as user:
> > $ ./setsockopt10
> > ...
> > setsockopt10.c:96: TINFO: child: Listen for tcp1 connection
> > setsockopt10.c:133: TINFO: parent: Connect for tcp0 connection
> > setsockopt10.c:138: TCONF: parent: setsockopt failed: The TLS module is probably not loaded: ENOENT (2)
> > tst_test.c:1622: TINFO: Killed the leftover descendant processes

> > Maybe that has been discussed, but I'd really request the root, because it works
> > with it:

> Yes, I did say why I don't want to require root in the previous
> message. However I'll take this to the patchset thread you posted.

Ah right, thanks for info. +1 for keeping the discussion there.

Kind regards,
Petr

> > # ./setsockopt10
> > ...
> > setsockopt10.c:145: TINFO: parent: Disconnect by setting unspec address
> > setsockopt10.c:153: TPASS: parent: Can't listen on disconnected TLS socket: EINVAL (22)
> > setsockopt10.c:110: TINFO: child: connect for tcp2 connection
> > setsockopt10.c:114: TINFO: child: could not connect to tcp1: ECONNREFUSED (111)

> > Kind regards,
> > Petr

> > [1] https://en.wikipedia.org/wiki/NixOS
> > [2] https://patchwork.ozlabs.org/project/ltp/list/?series=377451&state=*
> > [3] https://patchwork.ozlabs.org/project/ltp/patch/20231013074748.702214-3-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
