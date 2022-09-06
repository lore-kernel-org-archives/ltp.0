Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB72C38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 05:58:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 293923C54E8
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 07:58:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D74E83C07BD
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:58:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28BD7200761
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:58:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AFB433B8A;
 Tue,  6 Sep 2022 05:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662443892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D65HiID5sCbp7nQiaIpFfz0W92yLlxJ7yj99BIB1AiQ=;
 b=EJad/QEdTE+uCK1Efax/rN2jKndC9FgTSPZ8cBaS6zDNY6QKSYZlnNCz0qjmtVcaRcx3sP
 iYbjQIVeQIWRi1oxPVP7jch5J8EcCZv+Vbpc7zFd48inUFCzdKtf0O8Scit5cP3Vm6Fhru
 c4Mqsil13w8o706qh54zpXD1kgUpcWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662443892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D65HiID5sCbp7nQiaIpFfz0W92yLlxJ7yj99BIB1AiQ=;
 b=tqHeBalOopEJ+fOjlWFNvo5T62TApmL8yqA8fuvsQs5y6ar5VY/Xnm/wX4wb2Y+cKxosUR
 GZPAAG4WZbY71CCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF3BC13A7A;
 Tue,  6 Sep 2022 05:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jcAHNXPhFmOZFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 05:58:11 +0000
Date: Tue, 6 Sep 2022 07:58:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxbhcvS1RV0OkgJZ@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-2-amir73il@gmail.com>
 <YxYeGclGHpSay6ZN@pevik>
 <CAOQ4uxjNt-1Gqu6D8rGJmAFkS=GX99dQXvVO5n8spaQ_eVgdBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjNt-1Gqu6D8rGJmAFkS=GX99dQXvVO5n8spaQ_eVgdBg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] syscalls/fanotify09: Add test cases for
 FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Sep 5, 2022 at 7:04 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Amir,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > ...
> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> > > index 0eb83e2f8..e40916c08 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> > > @@ -73,12 +73,14 @@ static char event_buf[EVENT_BUF_LEN];
> > >  static int mount_created;

> > >  static int fan_report_dfid_unsupported;
> > > +static int ignore_mark_unsupported;

> > >  static struct tcase {
> > >       const char *tname;
> > >       struct fanotify_mark_type mark;
> > >       unsigned int ondir;
> > >       unsigned int ignore;
> > > +     unsigned int ignore_flags;
> > >       unsigned int report_name;
> > >       const char *close_nowrite;
> > >       int nevents;
> > > @@ -88,7 +90,7 @@ static struct tcase {
> > >               "Events on non-dir child with both parent and mount marks",
> > >               INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > >               0,
> > > -             0,
> > > +             0, 0,
> > >               0,
> > >               DIR_NAME,
> > >               1, 0,

> > nit: as number of struct grow, it'd help readability to omit members with 0:
> >                 .tname = "Events on non-dir child with both parent and mount marks",
> >                 .mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> >                 .close_nowrite = DIR_NAME,
> >                 .nevents = 1,


> You are absolutely right.
> The readability of use cases is quite tough at this point.

> > This is obviously non-blocker of this patch, if you agree it can be done any
> > time later.

> Certainly.
> I think that growing the struct is a good place to stop and
> do this cleanup, we have got plenty of time until v6.0 and I expect to
> get more comments on this series, so I will probably do this cleanup
> already for v2.
Thank you!

FYI we have LTP releases regularly 4x a year [1], the next one will be around
the end of September, with git freeze ~ 2 weeks before, i.e. very soon.
Of course this patchset should get in the release (I don't expect any issues any
major problems reported by Jan or Matthew, checkpatch.pl issues will not block it).

> > Also I fixed make check warnings some time ago (i.e. checkpatch.pl), but they

> Cool. I didn't know.

> > got back. I might find a time to fix them (we appreciate you look after the
> > test, thus don't want to bother you with these tiny details).


> This is the only new check warning I see:

> fanotify10.c:378: ERROR: Bad function definition - void drop_caches()
> should probably be void drop_caches(void)
> make: [../../../../include/mk/rules.mk:56: check-fanotify10] Error 1 (ignored)
> fanotify10.c:378:25: warning: non-ANSI function declaration of
> function 'drop_caches'
My bad - I fixed it before 0cb281815 ("tools: Check headers with checkpatch.pl")
which included the report also for headers. And yes, the rest of (mostly)
formatting reports are in fanotify.h.

Obviously we haven't found all checks which aren't relevant for userspace,
therefore I posted patch ignore some of them in LTP [2].

> I will fix it.
Thank you.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/releases
[2] https://lore.kernel.org/ltp/20220906054612.9790-1-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
