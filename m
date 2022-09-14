Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2207BC6FA82
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:50:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3E73CAC0A
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:50:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39C23CABD6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:50:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 365E41A00668
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:50:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0534333A12;
 Wed, 14 Sep 2022 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663188610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0adP/WZiy4ppBr4FQ2RtfGUJulxk7pDjPe4NX47sIE=;
 b=s+Howi72uBfMyH7sdEL3LgnXhb1GThDnfUWj2TUyAWknXBItse9TV17UnG9+Bdk72hzE50
 mGgnHYRJHg343wFgQPbkFFBAJsfbctnUBmjkGAX76MwRkxp5oeFl4mUPbEo8lbhKuZfo0t
 760+tF+RF8W8MmyxyEJVWswFrgJGe1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663188610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0adP/WZiy4ppBr4FQ2RtfGUJulxk7pDjPe4NX47sIE=;
 b=XHrhgOy44QZDZrI5ru4Uc0BInPjNry5YZHojkuyhU3QFtxwWPwJvVXQ6zOznW3LtvR0a2L
 u/08tFDvnEW05NDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5E42134B3;
 Wed, 14 Sep 2022 20:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z3wbLoE+ImMfMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:50:09 +0000
Date: Wed, 14 Sep 2022 22:50:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YyI+gHa7zCBIyjcg@pevik>
References: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
 <YtftUlDCvP5uchp9@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtftUlDCvP5uchp9@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsync02: restore runtime to 5m
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

Hi Jan, Cyril,

> Hi!
> > Test allows up to 240 seconds for PASS result (depending if its VM or not),
> > but on slower systems library now kills it after a minute. Restore
> > runtime to 5 minutes.

> Looking at the test itself it's a bit messed up too.

> The test uses rand(); to initialize the buffer size but without
> initializing the seed which is not random at all. It also uses number of
> available disk blocks as a upper limit, which makes the test runtime
> completely unpredictable.

> I guess that it would make sense to randomize the buffer sizes but in
> certain bounds to make the test more predictable and print the numbers
> we are going to use too. Maybe run the test with a few different sizes
> and time limits. Maybe the size of the buffers can be function of the
> test runtime.

> All in all I think that we should really rething what we are doing here
> since the current code does not make that much sense to me.

Jan, do you plan to do anything with the test before the release?

Kind regards,
Petr

> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/fsync/fsync02.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
> > index e13ba89f1b63..55c7a71c1d65 100644
> > --- a/testcases/kernel/syscalls/fsync/fsync02.c
> > +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> > @@ -114,5 +114,6 @@ static struct tst_test test = {
> >  	.test_all = run,
> >  	.setup = setup,
> >  	.cleanup = cleanup,
> > -	.needs_tmpdir = 1
> > +	.needs_tmpdir = 1,
> > +	.max_runtime = 300,
> >  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
