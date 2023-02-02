Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C445C61DA4
	for <ltp@archiver.kernel.org>; Thu,  2 Feb 2023 08:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B453CC3E4
	for <ltp@archiver.kernel.org>; Thu,  2 Feb 2023 09:20:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C0893CB28B
 for <ltp@lists.linux.it>; Thu,  2 Feb 2023 09:20:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3D861A0042A
 for <ltp@lists.linux.it>; Thu,  2 Feb 2023 09:20:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 298181FE36;
 Thu,  2 Feb 2023 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675326006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blfbzfO0WXZAAbEZ2v5W1LXrTv9otsINgmby/3KW0N8=;
 b=OxEWLohySnD15QLBw/EFJYfYQ9pDy/pJcHxxFsBUqrzFdNi33x0JzS9eLWUQq4jYiPExOG
 XcYIduM9ZRql0wiBvE3R6MgU9YRRd9QKPSXXl7Bre0rKSWad3m0tP7DEdLEW4O5Urq3aWG
 Gbk3zVMs/LdpOqK30zsgJQ2taAtqwu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675326006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blfbzfO0WXZAAbEZ2v5W1LXrTv9otsINgmby/3KW0N8=;
 b=Pi1phh9LJhlmQyWHgTHfugRHy+H4Q0RxVhbHC3InpslWLH3j2monb7Vyi89ka/KzDmbeuz
 YUnCHQDs/T8csFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC911139D0;
 Thu,  2 Feb 2023 08:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GkUIODVy22PMHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Feb 2023 08:20:05 +0000
Date: Thu, 2 Feb 2023 09:20:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y9tyNEspOUlHMOGU@pevik>
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
 <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Feb 2, 2023 at 8:50 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Edward,

> > > Hi Petr,

> > > > > +++ b/include/lapi/close_range.h
> > > > > @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
> > > > >       return tst_syscall(__NR_close_range, fd, max_fd, flags);
> > > > >  }
> > > > >  # endif
> > > > > +
> > > > > +static inline void close_range_supported_by_kernel(void)
> > > > > +{
> > > > > +     long ret;
> > > > > +
> > > > > +     if ((tst_kvercmp(5, 9, 0)) < 0) {
> > > > > +             /* Check if the syscall is backported on an older kernel */
> > > > BTW what particular use case this fixed? Is it backported to some android
> > > > kernel? Or to some enterprise distro? Because I don't think kernel stable trees
> > > > accept new functionality, just fixes.

> > > Oops, should I use .min_kver instead?  It isn't backported on Android;
> > > I just wasn't sure what the right approach was.

> > Actually, looking into SLES kernel sources, we backported close_range() to SLES
> > 15-SP3 (bsc#1179090), which was 5.3.18 based. Thus you actually did good work :).

> > @Li, @Jan out of curiosity, was this backported to RHEL kernel as well?
> > It'd be useful to note that (one day we will be able to remove it once kernels
> > which backported are EOL).

> Yes, it's present in 8.4 since kernel-4.18.0-290.el8.

Jan, thanks a lot!

@Edward we have Hackweek at SUSE, I'll merge this on Monday,
noting the reason why to keep this instead simple .min_kver.

Kind regards,
Petr

> > Kind regards,
> > Petr

> > > Thanks,
> > > Edward



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
