Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BEDE9B243
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:38:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99603D0F87
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:38:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E5D73CA689
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:38:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C42D81A001D1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:38:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D9373F148;
 Tue, 24 Feb 2026 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771925904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeo5IMOarD/t5dbgNBLcf4yohEZthP9wMgBXBA4M7Z0=;
 b=NxVlF9j4wKzTspMzA/4wYY4d36xBlazn8zsrE6SoapDjTtyjPiCVJI3FKRYTzS7yGYPzxC
 GDEaUDQ+iq6VQutI1XjpNEkXL27CdtQcvgsCJDwMATmCIbCCd3+RdD1dH/RqK+HNe6+iKK
 8j+TSl/OEOGmz/NXZnYN7EE8122nRTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771925904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeo5IMOarD/t5dbgNBLcf4yohEZthP9wMgBXBA4M7Z0=;
 b=HwIwco4rcL7KwDN1HzxA79SRkpQx5/jUG+LkMg6Yib6Z5gPYa8S3h0NBlBDgTF587VDJww
 OGNB3lWOY7qn4nDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NxVlF9j4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HwIwco4r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771925904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeo5IMOarD/t5dbgNBLcf4yohEZthP9wMgBXBA4M7Z0=;
 b=NxVlF9j4wKzTspMzA/4wYY4d36xBlazn8zsrE6SoapDjTtyjPiCVJI3FKRYTzS7yGYPzxC
 GDEaUDQ+iq6VQutI1XjpNEkXL27CdtQcvgsCJDwMATmCIbCCd3+RdD1dH/RqK+HNe6+iKK
 8j+TSl/OEOGmz/NXZnYN7EE8122nRTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771925904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xeo5IMOarD/t5dbgNBLcf4yohEZthP9wMgBXBA4M7Z0=;
 b=HwIwco4rcL7KwDN1HzxA79SRkpQx5/jUG+LkMg6Yib6Z5gPYa8S3h0NBlBDgTF587VDJww
 OGNB3lWOY7qn4nDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFDC3EA68;
 Tue, 24 Feb 2026 09:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id edzlL45xnWmOCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 09:38:22 +0000
Date: Tue, 24 Feb 2026 10:38:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260224093820.GA37927@pevik>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZyGMpdvgFXoYjHb@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 1D9373F148
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > > ---
> > >  testcases/network/nfs/nfs_stress/nfs_lib.sh | 22 +++++++++++++++++----
> > >  1 file changed, 18 insertions(+), 4 deletions(-)

> > > diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > > index 1ac8bd657..e52f96a5a 100644
> > > --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > > +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > > @@ -45,7 +45,7 @@ TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
> > >  TST_MOUNT_DEVICE=1
> > >  TST_FORMAT_DEVICE=1
> > >  TST_NEEDS_ROOT=1
> > > -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
> > > +TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount mount.nfs"

> I guess that in the furture we want separate scripts for the different
> hosts so that each of them can have proper metadata. I suppose that the

FYI I merged v2 (ecc02095e3). I was also thinking whether add
TST_RHOST_NEEDS_CMDS (or TST_NET_NEEDS_CMDS) variable for checking rhost. My
guess is that more tests will need this check for 2 host side. And while I'm not
keen on extending tst_net.sh, it would show us that in the end something needs
to be handled in LTP metadata (LTP C API struct tst_test or some new struct
tst_net) when we rewrite tests into shell loader or even pure C API.

> TST_MOUNT_DEVICE does not apply to the rhost either.

Good point, it'd be worth to investigate why I added TST_MOUNT_DEVICE=1 and
whether it's still valid.

> And with that we would need some kind of "master file" that would
> explain which script should be executed on which host etc. But I guess
> that it would be tricky to desing this properly.

I'm not sure if separated file is worth of adding. There is tst_rhost_run()
function which should be used for checking, which works well on both netns and 2
host based setup (that's why v2).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
