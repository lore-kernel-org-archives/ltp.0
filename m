Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10ECC25B74
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 15:40:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453473CF105
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 17:40:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D007B3CE8A5
 for <ltp@lists.linux.it>; Mon, 13 May 2024 17:40:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A89F6600901
 for <ltp@lists.linux.it>; Mon, 13 May 2024 17:40:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAE8334E58;
 Mon, 13 May 2024 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715614816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b66hgS6JXEMziAyMQJUYN0Ug7Irq12svSZhLNkxVvKU=;
 b=wyP7JfSsK0+UcG2olEXOxD7fsLsC36dH92zz2jikk6BVVkwmekWrx8Qxog1isMitcgnacJ
 AZP2cuf+xSyvOL22NUmWJ8PkYoUt4S4nJ1RBcHdP+aLcBYR7Vb4W/oN0R+9VbCnAPwbGi9
 ajl8sWzBUmm4FHF8G2ZvOE6O+7ywZI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715614816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b66hgS6JXEMziAyMQJUYN0Ug7Irq12svSZhLNkxVvKU=;
 b=UBDRZJUWU1TEIYt4e5pkcaKl9c0eAE4J2FhCCZnMitYYC6SQkHIFmlBnuu1brOSh1QzCvm
 1RN3y9p8EmsxTjAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Mjcm6nHO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dh2kAc3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715614815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b66hgS6JXEMziAyMQJUYN0Ug7Irq12svSZhLNkxVvKU=;
 b=Mjcm6nHOMzTqlR1d1yGud69TKrrMYJoWdKrOSSEkEUKWMrg8J9yKBW0a+xG+OgB+QvtNTr
 9dRtvUDoveTVceLNj/WZ/a+Pp2ByPHlGpYgmAI03R87ce1WwVkP5xgP7tnrg7GEj0HJZ1a
 5j497dEeXYhSjVCR5dyRahbm29IDVEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715614815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b66hgS6JXEMziAyMQJUYN0Ug7Irq12svSZhLNkxVvKU=;
 b=dh2kAc3G/j0brk13VIBFfjj7qcP8VTmWsPcTPIEw8E97KwcidvVRUfP5g4vrcUQzO9KMmA
 zDtJOzvqCqiS0aDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAE9813A52;
 Mon, 13 May 2024 15:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fBmrNF80QmbxVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 May 2024 15:40:15 +0000
Date: Mon, 13 May 2024 17:39:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZkI0L9xkrsJ-mhPN@yuki>
References: <20240328083344.277502-1-minachou@andestech.com>
 <20240510153103.GA448405@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240510153103.GA448405@pevik>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EAE8334E58
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, tim609@andestech.com,
 cynthia@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @Cyril the original code prior this patchset in 203ee275c ("Fix struct
> __kernel_old_timeval redefinition on 64bit sparc") did not include
> <linux/time_types.h> for some reason IMHO fallbacks were always used.
> I wonder why and whether we still don't want to use <linux/time_types.h>.

I suppose that this is broken on some old distro, try to run that
through CI and if that passes we can do so.

> Then Fabrice's fix in 12986b755 ("include/tst_timer.h: avoid redefinition of
> kernel structures") add autotools check just for uncommon toolchain (sh4 from
> Texas Instruments). It's somehow hidden (due missing comment it looks like we
> mostly get the definitions from header, but obviously not when we include
> <sys/socket.h>.

I guess that it depends on architecture/libc/kernel headers and it's a
big mess...

> >  AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
> >  AC_CHECK_TYPES([struct mount_attr],,,[
> > diff --git a/include/tst_timer.h b/include/tst_timer.h
> > index 703f03294eae..6fb9400206b8 100644
> > --- a/include/tst_timer.h
> > +++ b/include/tst_timer.h
> > @@ -135,6 +135,13 @@ struct __kernel_itimerspec {
> >  	struct __kernel_timespec it_value;       /* timer expiration */
> >  };
> >  #endif
> > +
> > +#ifndef HAVE_STRUCT___KERNEL_OLD_ITIMERVAL
> > +struct __kernel_old_itimerval {
> > +	struct __kernel_old_timeval it_interval;	/* timer interval */
> > +	struct __kernel_old_timeval it_value;		/* current value */
> > +};
> > +#endif
> >  #endif


I've been staring at the kernel and libc code for a while and it seems
that there is not itimerval64 syscall and interval timers are limited to
32bit on 32bit architectures. In reality I suppose that it does not
matter since nobody is going to use intervals that actually need 64bit
amount of seconds anyways.

So libc takes 64bit itimer, converts it to 32bit and kernel does
the oposite conversion.

Also we should really add tests for the libc wrapper as well, since that
is actually more likely to get broken by the double conversion on 32bit
arch, but that should be done in an subsequent patches.

> >  enum tst_ts_type {
> > @@ -370,6 +377,11 @@ static inline int sys_timerfd_settime64(int fd, int flags, void *its,
> >  	return tst_syscall(__NR_timerfd_settime64, fd, flags, its, old_its);
> >  }
> 
> > +static inline int sys_setitimer(int which, void *new_value, void *old_value)
> > +{
> > +	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> > +}
> C
> +1 adding function to the common place.
> 
> IMHO we slightly prefer to add C functions to C file (e.g. lib/tst_timer.c,
> there are other functions) + adding signature to tst_timer.h.

I would say that there is no point to do that for a single line fuctions
like this and actually I guess that this would break the line numbers
and filenames for the tst_sycall() so it's better this way.

So for the patch as it is:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
