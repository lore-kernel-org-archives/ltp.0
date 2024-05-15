Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEEBC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 07:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6E663CF395
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:21:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109CD3CC481
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:21:24 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C699609A3C
 for <ltp@lists.linux.it>; Wed, 15 May 2024 09:21:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1212A33906;
 Wed, 15 May 2024 07:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715757683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e7n6kHLm4dM4qJYrwDADvF5n5Ns01VkdPGxZ8TO++Y=;
 b=cNTJ9KGw1av6ay/YgdCTkM5NLiRO4yBu7xcYyL5l3eg4hslqQtika9zuEvARihuADgPy2Q
 IUY+5yRdYMFfFfz+qWC46+4wP4vVB3842oU2MrV66BNIDki9BO73nf6x4RZR0WJBiYerHI
 Svtm+CsgjDgBbtiHrQbro9oeLvZ0SeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715757683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e7n6kHLm4dM4qJYrwDADvF5n5Ns01VkdPGxZ8TO++Y=;
 b=47D/iKEDyuDOm1udDJccZCaYE+tOHThga8JNZbTuZ/c+5kMrWwwKibY993zaMWRQBror6j
 UdW7MC2scgno2fBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715757683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e7n6kHLm4dM4qJYrwDADvF5n5Ns01VkdPGxZ8TO++Y=;
 b=cNTJ9KGw1av6ay/YgdCTkM5NLiRO4yBu7xcYyL5l3eg4hslqQtika9zuEvARihuADgPy2Q
 IUY+5yRdYMFfFfz+qWC46+4wP4vVB3842oU2MrV66BNIDki9BO73nf6x4RZR0WJBiYerHI
 Svtm+CsgjDgBbtiHrQbro9oeLvZ0SeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715757683;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5e7n6kHLm4dM4qJYrwDADvF5n5Ns01VkdPGxZ8TO++Y=;
 b=47D/iKEDyuDOm1udDJccZCaYE+tOHThga8JNZbTuZ/c+5kMrWwwKibY993zaMWRQBror6j
 UdW7MC2scgno2fBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8535C1372E;
 Wed, 15 May 2024 07:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /6oUHXJiRGYkfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 07:21:22 +0000
Date: Wed, 15 May 2024 09:21:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240515072120.GB197249@pevik>
References: <20240328083344.277502-1-minachou@andestech.com>
 <20240510153103.GA448405@pevik> <ZkI0L9xkrsJ-mhPN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZkI0L9xkrsJ-mhPN@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setitimer: Pass the kernel-defined
 struct __kernel_old_itimerval to sys_setitimer().
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, tim609@andestech.com,
 cynthia@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

thanks, patchset merged.

> Hi!
> > @Cyril the original code prior this patchset in 203ee275c ("Fix struct
> > __kernel_old_timeval redefinition on 64bit sparc") did not include
> > <linux/time_types.h> for some reason IMHO fallbacks were always used.
> > I wonder why and whether we still don't want to use <linux/time_types.h>.

> I suppose that this is broken on some old distro, try to run that
> through CI and if that passes we can do so.

Right. Maybe this could then replace <sys/socket.h>, but I would have to verify
it running also Buildroot CI.

> > Then Fabrice's fix in 12986b755 ("include/tst_timer.h: avoid redefinition of
> > kernel structures") add autotools check just for uncommon toolchain (sh4 from
> > Texas Instruments). It's somehow hidden (due missing comment it looks like we
> > mostly get the definitions from header, but obviously not when we include
> > <sys/socket.h>.

> I guess that it depends on architecture/libc/kernel headers and it's a
> big mess...

Yes, uncommon toolchain.

> > >  AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
> > >  AC_CHECK_TYPES([struct mount_attr],,,[
> > > diff --git a/include/tst_timer.h b/include/tst_timer.h
> > > index 703f03294eae..6fb9400206b8 100644
> > > --- a/include/tst_timer.h
> > > +++ b/include/tst_timer.h
> > > @@ -135,6 +135,13 @@ struct __kernel_itimerspec {
> > >  	struct __kernel_timespec it_value;       /* timer expiration */
> > >  };
> > >  #endif
> > > +
> > > +#ifndef HAVE_STRUCT___KERNEL_OLD_ITIMERVAL
> > > +struct __kernel_old_itimerval {
> > > +	struct __kernel_old_timeval it_interval;	/* timer interval */
> > > +	struct __kernel_old_timeval it_value;		/* current value */
> > > +};
> > > +#endif
> > >  #endif


> I've been staring at the kernel and libc code for a while and it seems
> that there is not itimerval64 syscall and interval timers are limited to
> 32bit on 32bit architectures. In reality I suppose that it does not
> matter since nobody is going to use intervals that actually need 64bit
> amount of seconds anyways.

> So libc takes 64bit itimer, converts it to 32bit and kernel does
> the oposite conversion.

Thanks for investigation.

> Also we should really add tests for the libc wrapper as well, since that
> is actually more likely to get broken by the double conversion on 32bit
> arch, but that should be done in an subsequent patches.

+1. Adding .test_variants with {g,s}etitimer() for {g,s}etitimer0[12].c should
be trivial. Or did you mean to have test variants also for other functions in
include/tst_timer.h (e.g. timerfd_{g,s}ettime()) ?

BTW we already test {g,s}etitimer() libc wrapper in getitimer01.c, therefore we
already have libc wrapper at least somehow covered (the other two test raw
syscall).

Once we agree what to do I'll either post a patch or add a ticket for it (or
feel free to add a ticket yourself).

> > >  enum tst_ts_type {
> > > @@ -370,6 +377,11 @@ static inline int sys_timerfd_settime64(int fd, int flags, void *its,
> > >  	return tst_syscall(__NR_timerfd_settime64, fd, flags, its, old_its);
> > >  }

> > > +static inline int sys_setitimer(int which, void *new_value, void *old_value)
> > > +{
> > > +	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> > > +}
> > C
> > +1 adding function to the common place.

> > IMHO we slightly prefer to add C functions to C file (e.g. lib/tst_timer.c,
> > there are other functions) + adding signature to tst_timer.h.

> I would say that there is no point to do that for a single line fuctions
> like this and actually I guess that this would break the line numbers
> and filenames for the tst_sycall() so it's better this way.

Ah, I was wrong. There are also many other single line functions in
include/tst_timer.h.

Kind regards,
Petr

> So for the patch as it is:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
