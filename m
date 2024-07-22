Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E488CC3DA59
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 13:14:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AC3A3D1BF4
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 15:14:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614AE3C4D11
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 15:13:59 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8782E600F8C
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 15:13:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE43121B49;
 Mon, 22 Jul 2024 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721654036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
 b=DnrlcPpe3Ryh2Ac3vewtY2k6bQM7+wu1YJX0CahKi3yE5N51G3zL9WEWenroKYneSNCzNd
 w555qxHnXtiJZR9Afm1rRveVOyBW98iPQ+z45anB2ErQcKEV+4tW389x4eZWDYTEO3hNwh
 BzHY/Tc2fETyKXkf98u+qG1+/CGek3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721654036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
 b=k8V40oSOrSysVQaDlq2nGICzlZsL88be1X8mCxHYWPSMTc2GVbatr7G9syghOi9DKL7AJT
 9/FwoaozLW3hZbBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DnrlcPpe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=k8V40oSO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721654036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
 b=DnrlcPpe3Ryh2Ac3vewtY2k6bQM7+wu1YJX0CahKi3yE5N51G3zL9WEWenroKYneSNCzNd
 w555qxHnXtiJZR9Afm1rRveVOyBW98iPQ+z45anB2ErQcKEV+4tW389x4eZWDYTEO3hNwh
 BzHY/Tc2fETyKXkf98u+qG1+/CGek3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721654036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eO+kWLDsrIeY9mjf6qkCfwNZXpmlrMP0lUZZv7XChsI=;
 b=k8V40oSOrSysVQaDlq2nGICzlZsL88be1X8mCxHYWPSMTc2GVbatr7G9syghOi9DKL7AJT
 9/FwoaozLW3hZbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3AB136A9;
 Mon, 22 Jul 2024 13:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DzdLGRRbnmZgMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jul 2024 13:13:56 +0000
Date: Mon, 22 Jul 2024 15:13:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20240722131354.GA858324@pevik>
References: <20240719174325.GA775414@pevik>
 <20240722090012.mlvkaenuxar2x3vr@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240722090012.mlvkaenuxar2x3vr@quack3>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE43121B49
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,kernel.dk,suse.com,gmail.com,suse.cz,suse.de];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Slow down of LTP tests aiodio_sparse.c and
 dio_sparse.c in kernel 6.6
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 fstests@vger.kernel.org, linux-block@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>, ltp@lists.linux.it,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan, all,

> Hi!

> On Fri 19-07-24 19:43:25, Petr Vorel wrote:
> > LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3])
> > slowed down on kernel 6.6 on Btrfs and XFS, when run with default
> > parameters. These tests create 100 MB sparse file and write zeros (using
> > libaio or O_DIRECT) while 16 other processes reads the buffer and check
> > only zero is there.

> So the performance of this test is irrelevant because combining buffered
> reads with direct IO writes was always in "better don't do it" territory.
> Definitely not if you care about perfomance.

Thanks a lot for having a look, Jan!

> > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > (Non default parameter creates much smaller file, thus the change is not that
> > obvious).

> But still it's kind of curious what caused the 9x slow down. So I'd be
> curious to know the result of the bisection :). Thanks for report!

I'm already working on it, report soon.

Kind regards,
Petr

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
