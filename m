Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03991CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 12:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED2B3CEE3F
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 14:13:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBD123CD3BE
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 14:13:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D73811A00E09
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 14:13:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3884721882;
 Fri, 13 Oct 2023 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697199217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEGOIGHeQtKhOkpl3hltAEOwoQWfqUnM5E/IpUQgIr0=;
 b=CiqlXT0B7PyHnRFe366Hvm6iqLVfeC54EaMnrFsRMfSz+95JUpFcU35gp1DI+dfHO1bwbb
 CrSzP1z3W9RPxnM9GuNzJBWVxm+A7I3+9mNoMiVR8ue8skz9QteKQM8v6PygB8zbVmOCdg
 CWCBocLiiynBx4pbb/e6E0/XtInjSHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697199217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEGOIGHeQtKhOkpl3hltAEOwoQWfqUnM5E/IpUQgIr0=;
 b=aXkS8T3m962Gj9zjXGJvvoy91suxVJRgw2c9EkhBect6PblyT/4B5q/tEuso5RMpNHQJBS
 2eBwOyM1kEfAtAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AA991358F;
 Fri, 13 Oct 2023 12:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IeFXBXE0KWUoagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 12:13:37 +0000
Date: Fri, 13 Oct 2023 14:13:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231013121335.GA726277@pevik>
References: <20231012103916.30712-1-rpalethorpe@suse.com>
 <ZSgIrcu2A5eC_OvZ@yuki> <87y1g6ylc9.fsf@suse.de>
 <ZSkOEKRXAGwvUwR0@yuki> <87pm1iyg2r.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pm1iyg2r.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-8.57 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.27)[89.84%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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

Hi Richie, Cyril,

> >> On NixOS:

> >> $ ./setsockopt10
> >> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.dep does not exist or not a file
> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.builtin does not exist or not a file

For my info: this comes from Cyrils suggestion to use .needs_drivers.

> > Can you strace modprobe to see what is different on the system, these
> > files have to be installed somewhere in order for modprobe to actually
> > work...

> They will be in /nix/store/<kernel package hash>/.../modules or similar.
> I can probably make it work on NixOS by creating a nix file, but I think
> there is a bigger issue.

"NixOS is a Linux distribution built on top of the Nix package manager." [1]

I have no idea why Linux distro needs non-standard patch. IMHO we can take patch
which detects NixOS and use it's path, but for the distro itself would be better
if it has at least symlink to the standard path (i.e. it'd be worth to report
it).

As Cyril noted we have .needs_drivers, but that's also require config files in
/lib/modules. But setsockopt10 could also benefit from .modprobe patchset [2],
particularly [3]. i.e. instead of asking for CONFIG_TLS "modprobe tls" could
work. But currently we also expect modules.builtin is in /lib/modules. We could
rethink that (e.g. introduce variable which ignores the check, or allows to pass
path the correct prefix of the directory or remove
tst_check_builtin_driver(name), which is based on parsing modules.builtin).

But for broader discussion please comment on the patchset itself.

And now something completely different: root vs. normal user:
$ find /lib/modules/$(uname -r) |grep tls
...
/lib/modules/6.5.0-1-amd64/kernel/net/tls/tls.ko

But this does not work, when run as user:
$ ./setsockopt10
...
setsockopt10.c:96: TINFO: child: Listen for tcp1 connection
setsockopt10.c:133: TINFO: parent: Connect for tcp0 connection
setsockopt10.c:138: TCONF: parent: setsockopt failed: The TLS module is probably not loaded: ENOENT (2)
tst_test.c:1622: TINFO: Killed the leftover descendant processes

Maybe that has been discussed, but I'd really request the root, because it works
with it:

# ./setsockopt10
...
setsockopt10.c:145: TINFO: parent: Disconnect by setting unspec address
setsockopt10.c:153: TPASS: parent: Can't listen on disconnected TLS socket: EINVAL (22)
setsockopt10.c:110: TINFO: child: connect for tcp2 connection
setsockopt10.c:114: TINFO: child: could not connect to tcp1: ECONNREFUSED (111)

Kind regards,
Petr

[1] https://en.wikipedia.org/wiki/NixOS
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=377451&state=*
[3] https://patchwork.ozlabs.org/project/ltp/patch/20231013074748.702214-3-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
