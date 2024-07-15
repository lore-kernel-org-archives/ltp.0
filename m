Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A70C3DA59
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 09:52:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 747F83D1A32
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 11:52:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABC13CDECA
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 11:52:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80A8C1001270
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 11:52:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9835521BA6;
 Mon, 15 Jul 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E822137EB;
 Mon, 15 Jul 2024 09:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1nANGk7xlGaUFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Jul 2024 09:52:14 +0000
Date: Mon, 15 Jul 2024 11:52:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240715095213.GA424468@pevik>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
 <20240712132205.GA145191@pevik> <ZpE5q627g9bpxfwj@yuki>
 <20240712190926.GA399927@pevik> <ZpTmyoh2J1zvWHwO@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpTmyoh2J1zvWHwO@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9835521BA6
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] sched_football: Rewrite into new API
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I hoped there is something I just overlooked. Even I'm not a big fan of meson,
> > instead of implementing something own I would consider migrating to it.
> > Looking into Andrea's POV, where he did at least some work [1].

> I'm afraid that meson is not good choice for us. LTP has to be able to
> be compiled everywhere even on ten years old distribution and very
> restricted embedded devices, hence I would like us to stay on the most
> common and stable build system tooling out there. Which is plain old
> make.

Correct + not pushing for it now. FYI iputils compilation worked even on old
CentOS 7 (well, meson and ninja got over epel).

15-SP2 (IMHO the oldest distro LTP upstream cares) has meson 0.54.2 and ninja
1.10, these would be enough for initial support. Therefore once we bump the
support higher (next year), we *could* consider moving away from autotools
(obviously starting to ask on automated-testing@yoctoproject.org if somebody has
problems with the dependencies.

> And the main problem with our build system is not the tooling we choose,
> but the complexity imposed by the out-of-tree build implemented in the
> complex makefiles. As far as I can tell 99% of the problems would be
> solved by ripping out out-of-tree support, which would remove most of
> the code we have in there.

+1 for removal. I wonder if anybody finds a time to do that.

> > But back to the reality, would it be possible to merge this even with broken
> > dependency? I'm not sure myself.

> I will double check the code, before adding my final reviewed-by.

Thank you! It still bothers me that building sched_football does not trigger
building a library, but at least it will work for a full build (building whole
LTP).

> Also this is a step number one. I think that we should enable the
> realtime compilation by default and the sched_football should be added
> to the scheduller runtest file as well, so that it's executed by default
> as well.

+1, I'll have look into it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
