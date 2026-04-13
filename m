Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B3EBFD37
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 11:30:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A38F3E2E14
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 13:30:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9B93E14D3
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 13:30:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01EEE600730
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 13:30:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FF006A894;
 Mon, 13 Apr 2026 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776079812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAMVY8XA9Pwfl6RcoWRxTTjMT89o6POT/O6Qn0j1vL0=;
 b=a8F11dIKaAK6m0JHr2bMcyiRU3phWkI98j0LQnni+eYiwg7R7bV7WzunFGnEkMQp16W4Xt
 WPGCodBXZrZd0DW2doGjsHIrAOGEjNqY9zbLR0L2DYFvIOs3OVWIAsgqpTG6bxtGkosItl
 pdevv3ncBfxWyHeS4TdxW/Z/H18X3Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776079812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAMVY8XA9Pwfl6RcoWRxTTjMT89o6POT/O6Qn0j1vL0=;
 b=96YYNDlREyzJwJcCo2IfPTEbXe8xtnK1heunl32heKNHXSfPZYdi6esK5NBg1oCxh6QN6H
 bbu2cnjmvFsKQUDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a8F11dIK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=96YYNDlR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776079812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAMVY8XA9Pwfl6RcoWRxTTjMT89o6POT/O6Qn0j1vL0=;
 b=a8F11dIKaAK6m0JHr2bMcyiRU3phWkI98j0LQnni+eYiwg7R7bV7WzunFGnEkMQp16W4Xt
 WPGCodBXZrZd0DW2doGjsHIrAOGEjNqY9zbLR0L2DYFvIOs3OVWIAsgqpTG6bxtGkosItl
 pdevv3ncBfxWyHeS4TdxW/Z/H18X3Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776079812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gAMVY8XA9Pwfl6RcoWRxTTjMT89o6POT/O6Qn0j1vL0=;
 b=96YYNDlREyzJwJcCo2IfPTEbXe8xtnK1heunl32heKNHXSfPZYdi6esK5NBg1oCxh6QN6H
 bbu2cnjmvFsKQUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E2BE4AE72;
 Mon, 13 Apr 2026 11:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UF/HDMTT3GkpSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Apr 2026 11:30:12 +0000
Date: Mon, 13 Apr 2026 13:30:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260413113002.GB219073@pevik>
References: <20260409081546.GB96667@pevik>
 <20260411110405.7330-1-always.starving0@gmail.com>
 <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1O6mgFhsT0XP33=8Ji5dJPS5d27Oz8A74wWckcDX0c4LVHxQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7FF006A894
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] close: add test for double close EBADF
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

Hi all,

...
> > +static void verify_close(unsigned int i)
> >  {
> > -       TST_EXP_FAIL(close(-1), EBADF);
> > +       int fd;
> > +       struct tcase *tc = &tcases[i];
> > +
> > +       switch (tc->type) {
> > +       case INVALID_FD:
> > +               TST_EXP_FAIL(close(-1), EBADF, "%s", tc->desc);
> > +               break;
> > +
> > +       case DOUBLE_CLOSE:
> > +               fd = SAFE_OPEN("close02", O_CREAT, 0600);

> According to the open(2) man page, the flags argument must include one
> of the access modes: O_RDONLY, O_WRONLY, or O_RDWR.

Good catch, Li.

> For example:

>   fd = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);

> With the flag updated to include an access mode (like O_RDWR),
> it will look good to me:

> Reviewed-by: Li Wang <wangli.ahau@gmail.com>

Agree.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

And welcome back. Feel free to update .mailmap to the new address.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
