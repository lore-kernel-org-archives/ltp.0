Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C121C54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05383E744C
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:59:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0A453E4BAA
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:59:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1FD66001B2
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:59:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A4263E08;
 Wed, 29 Jul 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkureTAA+NcqAli7KU9wfPPyCj3J5Z2jiwNXWjHHDUc=;
 b=EJxWc0FdCAGLnoZBgRKa7Ol1lS0PAhoDJnKra0Gi81gTn/0Zn4rq4VOYLBpI3/gWHrhxnt
 uQFyIr8MwhKxU7OCzmivJ6pSlAadeAVt5pHIuW8lCZf30t3MfkK65RXR2PNQSe7yJ3qGNb
 Ib//68mXlM/uOicvzLgSs/Ig/0SIEJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkureTAA+NcqAli7KU9wfPPyCj3J5Z2jiwNXWjHHDUc=;
 b=TI6a7p9nhDQcygMmJERm8XsVsf0oDA1V0KLQw0whd8QRa5tjdoH0IikJBti2CuJbqs3ju1
 qrWzZL/1z49u4kDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkureTAA+NcqAli7KU9wfPPyCj3J5Z2jiwNXWjHHDUc=;
 b=drRLxkcDlXceTgcHAUXdaaIc6BqcjL+0RblZd6xKksPeflUKg577LtbXUWyLiyDnUpwHD+
 JqweOkixZJAsSloU/JglT8BDKYRII724/ufvERc5ktFB+QKQIJp6do5mWB0YDGm+i1xJKV
 vl7QFm6mhO5Uzb3bCVWp3m0/BSMHBCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zkureTAA+NcqAli7KU9wfPPyCj3J5Z2jiwNXWjHHDUc=;
 b=d1g2qmEzwigtFFZdj0Kv53a/bXFYk6ZnZjk+8bAZz3FHo1hip7iGNmuAGqKGzRyKHLybyL
 ncCbdknCHn0T+xAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 426C4779A1;
 Wed, 29 Jul 2026 09:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vyIxEOfOaWqrKAAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 09:59:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 00383A131F; Wed, 29 Jul 2026 11:58:54 +0200 (CEST)
Date: Wed, 29 Jul 2026 11:58:54 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <xf7wrvwsw7kww4rht6s3ntsogfoz567ag6i5ikvumnytmytngz@wvzzixl7tiu3>
References: <20260729091717.23042-1-pvorel@suse.cz>
 <20260729091717.23042-6-pvorel@suse.cz>
 <wexuhnkssz5j5kswcmsj73l7i6yrhpsvg36t4hg2e3flxvp4l3@5jczb6r55haj>
 <20260729095142.GA24216@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729095142.GA24216@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 29-07-26 11:51:42, Petr Vorel wrote:
> > On Wed 29-07-26 11:17:17, Petr Vorel wrote:
> > > fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> > > FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> > > reporting pidfds for thread IDs, so this combination is expected to
> > > succeed.
> 
> > > The test that these flag combinations are allowed:
> > >                 FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
> > > 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
> > > 			   FAN_REPORT_DFID_NAME),
> 
> > > Because the above flag combinations are already "tested" by the tests
> > > that use them and we don't have any tests that >= 5.10 has support for
> > > FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.
> 
> > > Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> 
> > I agree with the intention. I just think that if the option is called
> > max_kver, then this suggest this is the last version where the test should
> > be run. Not the first version where the test shouldn't be run. So the name
> > is a bit confusing to me.
> 
> Good catch ...
> 
> > 								Honza
> 
> ...
> > >  static struct tst_test test = {
> > >  	.setup = do_setup,
> > > +	.max_kver = "7.2",
> 
> ... it was supposed to be:
> .max_kver = "7.1"
> 
> FYI .max_kver is a new implementation (part of the patchset, I just did not want
> to bother you with LTP internals, that's why you're Cc only on fanotify20.c
> patch) and works exactly as you suggested (run on kernel <= 7.1, skip on >= 7.2).

OK :)

> If there is no other objection with with the patchset, I'll fix this before
> merge.

Thanks! In that case feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
