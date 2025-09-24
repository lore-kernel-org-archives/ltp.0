Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CACCAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 07:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 499DA3CDF36
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 09:04:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C23DC3CDC15
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 09:04:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1BD05200929
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 09:03:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12DA821E1F;
 Wed, 24 Sep 2025 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758697439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8alDrBG9WJpuMWfAgq55bPjBZ3Aia4MkyLYn990KLE=;
 b=uVsa4mXjyfVro1l/1QiVx/CvkbTfcypZfjEx3uyrYHW/kOCuOnLv0LnBbDfPDNsJ7AjLH1
 LkWGKZJkSr4r4gbmRbq8+Nlu7efu481MRwEl0Zsw4EEroyWB3be4AgB3qtEjGAlFiece3d
 qtIXM7tlPq9SVHCTq7MjANBEru+judo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758697439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8alDrBG9WJpuMWfAgq55bPjBZ3Aia4MkyLYn990KLE=;
 b=b+qNIFU4QLuYRsLLioDdre0gjVYc0i6aaz2SykDQZcHemYOOeDRl8DrHZx/coemMgPTxyq
 6zeVDvarNWLOoKDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uVsa4mXj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b+qNIFU4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758697439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8alDrBG9WJpuMWfAgq55bPjBZ3Aia4MkyLYn990KLE=;
 b=uVsa4mXjyfVro1l/1QiVx/CvkbTfcypZfjEx3uyrYHW/kOCuOnLv0LnBbDfPDNsJ7AjLH1
 LkWGKZJkSr4r4gbmRbq8+Nlu7efu481MRwEl0Zsw4EEroyWB3be4AgB3qtEjGAlFiece3d
 qtIXM7tlPq9SVHCTq7MjANBEru+judo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758697439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8alDrBG9WJpuMWfAgq55bPjBZ3Aia4MkyLYn990KLE=;
 b=b+qNIFU4QLuYRsLLioDdre0gjVYc0i6aaz2SykDQZcHemYOOeDRl8DrHZx/coemMgPTxyq
 6zeVDvarNWLOoKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA9B213A61;
 Wed, 24 Sep 2025 07:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LOznL96X02g0YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Sep 2025 07:03:58 +0000
Date: Wed, 24 Sep 2025 09:03:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250924070353.GA48664@pevik>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan> <aNNWzGWH56SLSXza@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aNNWzGWH56SLSXza@localhost>
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 12DA821E1F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Thu, Sep 18, 2025 at 05:35:15PM +0200, Cyril Hrubis wrote:
> > Hi!
> > > > > The test should have needs_cmds set to parted (we do that properly in
> > > > > ioctl09.c) then we do not have to handle the 255 exit code here since
> > > > > the test would be skipped if it's missing.

> > > > If we use needs_cmds all the check will be skipped in this case.

> > > @Cyril: only single test require 'parted' as I reported in v1 [1].
> > > Yeah, code gets slightly more complicated just because single test requires
> > > parted. Or you would not care? IMHO it does not make sense to split test into
> > > two (too much duplicity).

> > The problem here is how to handle the metadata. One posible solution is
> > to add a notion of optional dependencies so that we would have
> > 'needs_foo' and 'wants_foo'. Or turn the needs_foo into a structure with
> > an .optional boolean flag.

> What's difference between needs_foo and wants_foo? wants_foo means we do
> not do brk if not exist foo?
> I guess we need wants_parted support for .needs_cmds like following
> change? Could you give me more guidance

> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -147,6 +147,10 @@ static struct tst_test test = {
>                 "loop",
>                 NULL
>         },
> +       .needs_cmds= (const char *const []) {
> +               "wants_parted",

IMHO this is a wrong way.  The command name ("value") should not need to be
parsed. Why?
1) not obvious
2) theoretically there can be a binary "wants_*")

Cyril's approach to change "key" (i.e. .needs_cmd => .wants_cmd) is better.

Alternatives to wants_* could be "needs_foo_subtest" or "uses_foo"

Kind regards,
Petr

> +               NULL
> +       },

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
