Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D866CCDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 07:39:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E773CEF88
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 09:39:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7815D3CD1A6
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 09:39:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B94F1400E50
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 09:39:04 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 856391FEAF
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 07:39:03 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 25EA12C274;
 Mon, 16 Oct 2023 07:39:03 +0000 (UTC)
References: <20231012103916.30712-1-rpalethorpe@suse.com>
 <ZSgIrcu2A5eC_OvZ@yuki> <87y1g6ylc9.fsf@suse.de> <ZSkOEKRXAGwvUwR0@yuki>
 <87pm1iyg2r.fsf@suse.de> <20231013121335.GA726277@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Oct 2023 08:23:58 +0100
Organization: Linux Private Site
In-reply-to: <20231013121335.GA726277@pevik>
Message-ID: <87lec3xbhn.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 DMARC_NA(0.20)[suse.de]; R_SPF_SOFTFAIL(0.60)[~all:c];
 HAS_ORG_HEADER(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 VIOLATED_DIRECT_SPF(3.50)[]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.00)[1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 856391FEAF
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, Cyril,
>
>> >> On NixOS:
>
>> >> $ ./setsockopt10
>> >> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
>> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.dep does not exist or not a file
>> >> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.builtin does not exist or not a file
>
> For my info: this comes from Cyrils suggestion to use .needs_drivers.
>
>> > Can you strace modprobe to see what is different on the system, these
>> > files have to be installed somewhere in order for modprobe to actually
>> > work...
>
>> They will be in /nix/store/<kernel package hash>/.../modules or similar.
>> I can probably make it work on NixOS by creating a nix file, but I think
>> there is a bigger issue.
>
> "NixOS is a Linux distribution built on top of the Nix package manager." [1]
>
> I have no idea why Linux distro needs non-standard patch. IMHO we can take patch
> which detects NixOS and use it's path, but for the distro itself would be better
> if it has at least symlink to the standard path (i.e. it'd be worth to report
> it).

Only if you can point to a specification and NixOS accepts that spec. If
it is not in POSIX then it is unlikely to get through. There is not even
a /lib in NixOS. Any absolute paths interfere with reproducibility,
isolation and such. To see how such a discussion is likey to go see this
thread on /bin/bash:
https://discourse.nixos.org/t/add-bin-bash-to-avoid-unnecessary-pain/5673

OTOH all we need is a Nix file which creates the symlinks (or patches
LTP) and specifies the LTPs deps to create a reproducible build of LTP
in Nix. At some point I'll add it to CI.

However this doesn't help other distro's or embedded systems that we
don't personally use.

>
> As Cyril noted we have .needs_drivers, but that's also require config files in
> /lib/modules. But setsockopt10 could also benefit from .modprobe patchset [2],
> particularly [3]. i.e. instead of asking for CONFIG_TLS "modprobe tls" could
> work. But currently we also expect modules.builtin is in /lib/modules. We could
> rethink that (e.g. introduce variable which ignores the check, or allows to pass
> path the correct prefix of the directory or remove
> tst_check_builtin_driver(name), which is based on parsing modules.builtin).
>
> But for broader discussion please comment on the patchset itself.
>
> And now something completely different: root vs. normal user:
> $ find /lib/modules/$(uname -r) |grep tls
> ...
> /lib/modules/6.5.0-1-amd64/kernel/net/tls/tls.ko
>
> But this does not work, when run as user:
> $ ./setsockopt10
> ...
> setsockopt10.c:96: TINFO: child: Listen for tcp1 connection
> setsockopt10.c:133: TINFO: parent: Connect for tcp0 connection
> setsockopt10.c:138: TCONF: parent: setsockopt failed: The TLS module is probably not loaded: ENOENT (2)
> tst_test.c:1622: TINFO: Killed the leftover descendant processes
>
> Maybe that has been discussed, but I'd really request the root, because it works
> with it:

Yes, I did say why I don't want to require root in the previous
message. However I'll take this to the patchset thread you posted.

>
> # ./setsockopt10
> ...
> setsockopt10.c:145: TINFO: parent: Disconnect by setting unspec address
> setsockopt10.c:153: TPASS: parent: Can't listen on disconnected TLS socket: EINVAL (22)
> setsockopt10.c:110: TINFO: child: connect for tcp2 connection
> setsockopt10.c:114: TINFO: child: could not connect to tcp1: ECONNREFUSED (111)
>
> Kind regards,
> Petr
>
> [1] https://en.wikipedia.org/wiki/NixOS
> [2] https://patchwork.ozlabs.org/project/ltp/list/?series=377451&state=*
> [3] https://patchwork.ozlabs.org/project/ltp/patch/20231013074748.702214-3-pvorel@suse.cz/


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
