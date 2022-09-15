Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF9BECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 08:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF5D3CAC36
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 10:04:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7AF3C941D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 10:04:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4AE9201138
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 10:04:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF36520445;
 Thu, 15 Sep 2022 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663229066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIWx2XxTe+iWMpFkWecZ8HDUb+ZGsHfUgfqsLQOQSAM=;
 b=IjX+fGAZB9jwWTvc+y69GCb2TXai1wyWGolPCXOQsFoiEwrR/TZfjLhet6OOF/GvC1qLsW
 Np6B32ADaBMj+k/9IPqdapP25zbo15xp2o0TxTXpWz0UjI4+Ettwni5uLZ1cVA4zuloUMh
 Zg4M9cA5T6NWts2hal20QQYOvU53jnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663229066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZIWx2XxTe+iWMpFkWecZ8HDUb+ZGsHfUgfqsLQOQSAM=;
 b=T1oLDlRGuyIbx5A6eY04MX0JtqJorEhsUfy0gd+ES1vCoVmZ5nakbfNiylA7jPup+mNtIP
 +btwLVp11sCE6XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0B54133A7;
 Thu, 15 Sep 2022 08:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +GIaKorcImN2cQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 08:04:26 +0000
Date: Thu, 15 Sep 2022 10:04:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YyLciVc4PpITWYgP@pevik>
References: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
 <YtftUlDCvP5uchp9@rei> <YyI+gHa7zCBIyjcg@pevik>
 <CAASaF6xX=gBBjOVEnp6U4HpjfuzBVpbkyD1i0keW+iVjSCJZWg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xX=gBBjOVEnp6U4HpjfuzBVpbkyD1i0keW+iVjSCJZWg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Sep 14, 2022 at 10:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Jan, Cyril,

> > > Hi!
> > > > Test allows up to 240 seconds for PASS result (depending if its VM or not),
> > > > but on slower systems library now kills it after a minute. Restore
> > > > runtime to 5 minutes.

> > > Looking at the test itself it's a bit messed up too.

> > > The test uses rand(); to initialize the buffer size but without
> > > initializing the seed which is not random at all. It also uses number of
> > > available disk blocks as a upper limit, which makes the test runtime
> > > completely unpredictable.

> > > I guess that it would make sense to randomize the buffer sizes but in
> > > certain bounds to make the test more predictable and print the numbers
> > > we are going to use too. Maybe run the test with a few different sizes
> > > and time limits. Maybe the size of the buffers can be function of the
> > > test runtime.

> > > All in all I think that we should really rething what we are doing here
> > > since the current code does not make that much sense to me.

> > Jan, do you plan to do anything with the test before the release?

> I put it at todo list, but haven't dived into it yet. For release, I'd
> go with timelimit
> extension as that can't cause any regressions.

Make sense to me.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> > Kind regards,
> > Petr

> > > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > > ---
> > > >  testcases/kernel/syscalls/fsync/fsync02.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)

> > > > diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
> > > > index e13ba89f1b63..55c7a71c1d65 100644
> > > > --- a/testcases/kernel/syscalls/fsync/fsync02.c
> > > > +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> > > > @@ -114,5 +114,6 @@ static struct tst_test test = {
> > > >     .test_all = run,
> > > >     .setup = setup,
> > > >     .cleanup = cleanup,
> > > > -   .needs_tmpdir = 1
> > > > +   .needs_tmpdir = 1,
> > > > +   .max_runtime = 300,
> > > >  };



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
