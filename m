Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A54C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 09:02:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD46C3C967E
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 10:01:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC98A3C9554
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:01:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A71E260065E
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:01:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BFC11F3A1;
 Tue, 18 Jan 2022 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642496508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIfZPJLw3QTw831CL+LXQtC7iFRhxWAhAPsfNmzkay8=;
 b=wQL2f7W053GQiiVMASI4j7SGRpP3iuJox/JBS9IMnUYIsFhu1hPS2k5LeB6U8g5aiog0Ij
 zGfMij9UY2VVx/vuj9rc4tZ7GHQFM6qIUlkJWjSX7s3WoRfjnQfl/dQHl7JGiwOMm6elB5
 YcwnCWUf1RLJ7UfDZqbBN1omjzPZ6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642496508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIfZPJLw3QTw831CL+LXQtC7iFRhxWAhAPsfNmzkay8=;
 b=D8QVMuV6TfPygyk1+cu3AvIYo0fm55UzTW6DMC0nwT0gFXdt7KW0HYEWu6qxY1n2qEiXNO
 iICZh9RnoFvGBkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 648B213DC7;
 Tue, 18 Jan 2022 09:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ihn+FvyB5mGAdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 09:01:48 +0000
Date: Tue, 18 Jan 2022 10:01:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YeaB+smLnVt9voPy@pevik>
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
 <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
 <YeUxCq4rsLX98E3d@pevik>
 <CAEemH2eLo7BF5+WuQS8jerbQc6Dzcg4quQK6=HC_7KsrQZXbQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eLo7BF5+WuQS8jerbQc6Dzcg4quQK6=HC_7KsrQZXbQQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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

Hi all,

> On Mon, Jan 17, 2022 at 5:04 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Li, Cyril,

> > > > > +++ b/testcases/kernel/syscalls/utime/utime03.c
> > > > > @@ -93,7 +93,7 @@ static struct tst_test test = {
> > > > >         .mntpoint = MNTPOINT,
> > > > >         .all_filesystems = 1,
> > > > >         .skip_filesystems = (const char *const[]) {
> > > > > -               "v9",
> > > > > +               "9p",

> > > > I'm wondering does it really take effect with whatever "v9" or "9p"?
> > > > Because the fs_type_whitelist[] does not include any of them.
> > +1. Do we want to add 9p to fs_type_whitelist[]? I suppose not, because (despite

> I agree with you, as 9p is not a widely used filesystem for Linux distribution.

> > of the name containing "whitelist" it's the list of filesystems actually being
> > tested - this is a bit confusing to me).

> Yes, it is actually the filesystem list that LTP will be tested on.
> or maybe rename it to better understand.
+1. I'll try to send patch after release.


> > > Unless removing the .all_filesystems as well otherwise, it is impossible
> > > has a chance to test on 9p.
> > Yep. I forgot that .skip_filesystems works also on single fs.
> > So correct entry in .skip_filesystems is kind of documentation in case of
> > .all_filesystems being removed. I guess we should just remove the entry.

> Sorry, what does that 'remove the entry' mean? I didn't catch your point here.
As you pointed out it does not have any effect now to whitelist 9p.
It's kind of documentation. Maybe instead of fixing the line we should remove it
and put a comment above.

	/* NOTE: also does not work on 9p */
	.skip_filesystems = (const char *const[]) {
		"vfat",
		"exfat",
		NULL
	}

Obviously the best would be to recheck if the limitation still exists,
because whole problem is 10 years old: it was added
bc5da68248cc963e17862b7a0c556409c29c763e in 2011 by Cyril:

    The functional tests for utime checks if utime updates the
    modification and access time to current time, however V9FS,
    similar to NFS, by default uses the server's localtime if
    client doesnt specify a new time. The current implentation
    does not run the test if the underlying filesystem is NFS.
    A similar check for V9FS is also required, hence this patch.

Note later was found that NFS was ok on 2.6.18:
d623e2c7fe ("splice01/tee01/utime: add kernel version check for NFS test")
and remove during Martin's rewrite in ec3c3e5462.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
