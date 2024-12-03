Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7ADE6C614
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 08:00:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D87E3DDB5C
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 09:00:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87BA63D9EA3
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 08:59:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88B6064DB7E
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 08:59:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 268A3210F8;
 Tue,  3 Dec 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1697D13A15;
 Tue,  3 Dec 2024 07:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BnB6BG26TmcgNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Dec 2024 07:59:41 +0000
Date: Tue, 3 Dec 2024 08:58:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z066Fj9VQVlTOMp_@rei.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik> <Z03RB9JDmBVORPlf@yuki.lan>
 <20241203045310.GA414034@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203045310.GA414034@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 268A3210F8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > be skipped without need to manually enable the filesystem and recompile.
> > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > Therefore I would avoid this.
> 
> > I guess that this should be another env variable e.g.
> > LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
> > only for development purposes.
> 
> Well, LTP_SINGLE_FS_TYPE already has "Testing only"

That was maybe how we intended it but we exposed the API and it seems
that there is a usecase for it so people are possibly using it.

> and that was the reason it just forced filesystem regardless "skip"
> setup. Sure, we can turn it into "normal" variable and introduce
> LTP_FORCE_SINGLE_FS_TYPE if it's needed.  But that would be an use
> case if anybody uses LTP really to test particular filesystem. And it
> would affect only .all_filesystem tests (e.g. user's responsibility
> would be to point TMPDIR to that particular system on non-
> .all_filesystem tests).

There is a usecase we haven't figured out, when you want to test a
single filesystem, you do not want to waste time on the rest of the
filesystems and LTP_SINGlE_FS_TYPE nearly works for that usecase.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
