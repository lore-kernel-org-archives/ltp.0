Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3ECC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 13:38:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D95B3C8D4A
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 15:38:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FFD23C87B1
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 15:38:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFE011401173
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 15:37:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E18C721E10;
 Fri, 17 Jun 2022 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655473078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcdCSjOL/alQUrUXBdLpdDrKaBtEzRAPeNlgv8XQ4G4=;
 b=WzYRwTzvFzevWwKiFygwlzX/ubdArDdNDG7jjgm6z3LEuXzwEHFj3zIgyxJJmda+iFYBBa
 51B7Vj/Yh2fYrP4iWLnF4JwNmvIk7iHrDyyi9ogZpusgEiaRW7V63ryYcx7zv3WbRYiSPE
 c9apqrw+UycyzlElwRm+TIZZs6JLx4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655473078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcdCSjOL/alQUrUXBdLpdDrKaBtEzRAPeNlgv8XQ4G4=;
 b=tM+HA1wn2R06gqWZEVlcy4OnO8+6rh0y+8vJNtfgzW22VXubS5PSNAPq1rQDyc7iYy1VQK
 nSZO0SN/jwVDdvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B425313458;
 Fri, 17 Jun 2022 13:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4sMxKraDrGLpGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jun 2022 13:37:58 +0000
Date: Fri, 17 Jun 2022 15:37:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YqyDtBC3++fGQGdp@pevik>
References: <20220616162339.19322-1-pvorel@suse.cz>
 <YqxFo1iFzHatNRIl@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqxFo1iFzHatNRIl@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] nfs05_make_tree: Restore 5 min
 timeout
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

> Hi!
> > nfs05_make_tree is a long running test. The previous default timeout 5
> > min was enough after reducing runtime in 05be61cf6.

> > But the new default 30 sec introduced in the concept of max runtime is
> > definitely not enough. Restore the previous timeout 5 min.

> Looking at the code this is actually a helper binary rather than a test
> itself. I think that the problem here is that we mix the shell test
> library and C library and the test is a mess of both with unexpected
> consequencies.
Yes.

> I guess that it would probably implement main() in the nfs05_make_tree.c
> instead as we do for the various tools in testcases/lib/*.c. That would
> at least make sure that we will not break anything with changes intended
> for tests and not for helper binaries as this one.

Helper binaries does not use LTP C API. I'd like to keep it (to have SAFE_*()),
I guess you're not against. Therefore just using TST_NO_DEFAULT_MAIN
and adding main(), right?

Kind regards,
Petr

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/network/nfs/nfs_stress/nfs05_make_tree.c | 1 +
> >  1 file changed, 1 insertion(+)

> > diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> > index fdc13bd5d..5456c1bf0 100644
> > --- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> > +++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
> > @@ -215,4 +215,5 @@ static struct tst_test test = {
> >  	.options = opts,
> >  	.test_all = do_test,
> >  	.setup = setup,
> > +	.max_runtime = 300,
> >  };
> > -- 
> > 2.36.1


> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
