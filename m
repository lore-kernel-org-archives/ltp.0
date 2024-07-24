Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C896AC3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69213D1C2D
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:18:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC7703D0895
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:18:23 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4B0D1000D58
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:18:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEF7D1F7A1;
 Wed, 24 Jul 2024 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721827100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
 b=FuBQFIif1Yc1oeaBaLW8lYkBmLdefhslLAjPwWKBZbbVN5sjFwRfwigAdgW5tiVqWpummx
 DTB9pwhyVNO18d0Y60YgB+rwgvkBLAcpLA0bhGMGMOWwOVzKG3/ZCsKOLKbqo0M1GG7oCw
 0xTOW2S/R5iNPlqQ6qvgOSW2wD+1dXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721827100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
 b=PHN8vmjIum5QrnGQwAC7nE4RlXzg3zgNLTPQcaz+P3mWJGTWTtJ5fKrjHLBSb9vudv11Mh
 7uxDRJLj0Sko68Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FuBQFIif;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PHN8vmjI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721827100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
 b=FuBQFIif1Yc1oeaBaLW8lYkBmLdefhslLAjPwWKBZbbVN5sjFwRfwigAdgW5tiVqWpummx
 DTB9pwhyVNO18d0Y60YgB+rwgvkBLAcpLA0bhGMGMOWwOVzKG3/ZCsKOLKbqo0M1GG7oCw
 0xTOW2S/R5iNPlqQ6qvgOSW2wD+1dXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721827100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h+aj3OTVxMj7+tqkBCsQv23PHYcFQaXkl3Rf51EKvUo=;
 b=PHN8vmjIum5QrnGQwAC7nE4RlXzg3zgNLTPQcaz+P3mWJGTWTtJ5fKrjHLBSb9vudv11Mh
 7uxDRJLj0Sko68Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A741324F;
 Wed, 24 Jul 2024 13:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id noIPARz/oGbdEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 13:18:20 +0000
Date: Wed, 24 Jul 2024 15:18:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20240724131816.GA950793@pevik>
References: <20240719174325.GA775414@pevik>
 <20240722090012.mlvkaenuxar2x3vr@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240722090012.mlvkaenuxar2x3vr@quack3>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BEF7D1F7A1
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[lists.linux.it,vger.kernel.org,kernel.dk,suse.com,gmail.com,suse.cz,suse.de,infradead.org];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
 Peter Zijlstra <peterz@infradead.org>, fstests@vger.kernel.org,
 linux-block@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 Mike Galbraith <umgwanakikbuti@gmail.com>, ltp@lists.linux.it,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,


[ Cc Peter and Mike ]
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

> > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > (Non default parameter creates much smaller file, thus the change is not that
> > obvious).

> But still it's kind of curious what caused the 9x slow down. So I'd be
> curious to know the result of the bisection :). Thanks for report!

It looks to be the slowdown was introduced by commit 63304558ba5d
("sched/eevdf: Curb wakeup-preemption") [1] from v6.6-rc1.

I also compiled current next (next-20240724), it's also slow  and reverting
commit from it returns the original speed on both Btrfs and XFS.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63304558ba5dcaaff9e052ee43cfdcc7f9c29e85

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
