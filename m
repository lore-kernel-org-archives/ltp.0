Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A004E7717D
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 12:15:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5B13E7FEC
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 13:15:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069593E7FE5
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 13:15:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E94C1BD940B
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 13:15:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B874A1F45F;
 Mon,  9 Dec 2024 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733746504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuuJAOxMdGFFnHzWkYF8AjbIMWVjMLLLrMkkjdU9EI=;
 b=yoXBvyBuW5ULgS8Sp8GZ6TcZstPwwr0W2o3970KG8yrB1p/P0DIm9f9KWFCZNpxkNMEZq4
 RCvjiXv4AVedYYFWyewZdGVk+vaZXrzFDmyFAtDpr4jSqj09Dp5AJIsV/LGTYwXwFnU4kJ
 dHBWOpyga/TwkJDVO2Z78tzgfJrJIPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733746504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuuJAOxMdGFFnHzWkYF8AjbIMWVjMLLLrMkkjdU9EI=;
 b=RkpJSuxEi+rXeh1jlG2a6yKK1jD2GdX1KKNJMEwwNYCXIN98dXqpdgvK/mAglUSH87ZXRK
 agRCCVod0SjSAIDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oxxguo8R;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ADv4+hAv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733746503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuuJAOxMdGFFnHzWkYF8AjbIMWVjMLLLrMkkjdU9EI=;
 b=oxxguo8RX1BCY/BRtD2JnCcH/KEyqdgfiPcdenZKaWQG4Iq4MHyY1HXEsd2WsUbOVgizQX
 paXI77JuWcCerKO4lQfpJZdEZV9hKjkjWmqbaL9zLqjiUCfWmrLuRam/0cLFdbO3gNtrT+
 Nan//Eg0VC/pGVZMdMj93+xsOcDjoWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733746503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8kuuJAOxMdGFFnHzWkYF8AjbIMWVjMLLLrMkkjdU9EI=;
 b=ADv4+hAvoVc9FEilVhCfewwQFd5rUInOJ9N7Zj0o69qfMq6Z7ZXc3pSXuzfVDlN+jMFcmH
 ozObSgVap1+RGpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99554138D2;
 Mon,  9 Dec 2024 12:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WuooJEffVmcgVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Dec 2024 12:15:03 +0000
Date: Mon, 9 Dec 2024 13:14:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241209121458.GB210779@pevik>
References: <20241207085754.159597-1-liwang@redhat.com>
 <20241209044318.GA180329@pevik>
 <CAEemH2fSJP8Y8-CLbtKFq+PUcmP_3=aF8Wszom-bDfP6=HOCjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fSJP8Y8-CLbtKFq+PUcmP_3=aF8Wszom-bDfP6=HOCjg@mail.gmail.com>
X-Rspamd-Queue-Id: B874A1F45F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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

Hi Li,
...
> > > Notes:
> > >     Hi, @Cyril, @Petr, I have no openSUSE and Ubuntu at my hands, could
> > you
> > >     help check if the debug configures are useful to the other two
> > platforms?
> > >     Or, should we add any more options there? Thanks.

> > openSUSE debug kernel:

> > $ grep ^CONFIG_DEBUG /boot/config-6.13.0-rc1-1.g492f944-debug # openSUSE
> > Tumbleweed
> > CONFIG_DEBUG_RSEQ=y
> > CONFIG_DEBUG_GPIO=y
> > CONFIG_DEBUG_BUGVERBOSE=y
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_DWARF5=y
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> > CONFIG_DEBUG_INFO_BTF=y
> > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > CONFIG_DEBUG_FS=y
> > CONFIG_DEBUG_FS_ALLOW_ALL=y
> > CONFIG_DEBUG_NET=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > CONFIG_DEBUG_RODATA_TEST=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_DEBUG_SHIRQ=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y

> > => openSUSE debug kernel would be detected by:
> > CONFIG_DEBUG_NET=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > CONFIG_DEBUG_RT_MUTEXES=y
> > CONFIG_DEBUG_SPINLOCK=y
> > CONFIG_DEBUG_MUTEXES=y


> Thanks for much for providing these.


> > => if you want to add more:
> > CONFIG_DEBUG_RSEQ=y
> > CONFIG_DEBUG_GPIO=y
> > CONFIG_DEBUG_RODATA_TEST=y
> > CONFIG_DEBUG_SHIRQ=y


> Those kernel debug options on performance are generally less severe
> compared to options like CONFIG_KASAN or CONFIG_PROVE_LOCKING.

> We would like to recognize some configs that obviously lower the system
> speed.

Makes sense.

> > Also FYI some options from default kernel (to see which cannot be used):

> > $ grep ^CONFIG_DEBUG /boot/config-6.13.0-rc1-1.g492f944-default # openSUSE
> > Tumbleweed
> > CONFIG_DEBUG_BUGVERBOSE=y
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_DWARF5=y
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> > CONFIG_DEBUG_INFO_BTF=y
> > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> > CONFIG_DEBUG_FS=y
> > CONFIG_DEBUG_FS_ALLOW_ALL=y
> > CONFIG_DEBUG_PAGEALLOC=y
> > CONFIG_DEBUG_MEMORY_INIT=y

> > $ grep ^CONFIG_DEBUG /boot/config-6.11.10-amd64 # Debian
> > CONFIG_DEBUG_BUGVERBOSE=y
> > CONFIG_DEBUG_KERNEL=y
> > CONFIG_DEBUG_MISC=y
> > CONFIG_DEBUG_INFO=y
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> > CONFIG_DEBUG_INFO_BTF=y
> > CONFIG_DEBUG_INFO_BTF_MODULES=y
> > CONFIG_DEBUG_FS=y
> > CONFIG_DEBUG_FS_ALLOW_ALL=y
> > CONFIG_DEBUG_WX=y
> > CONFIG_DEBUG_MEMORY_INIT=y
> > CONFIG_DEBUG_LIST=y

> > Do Debian/Ubuntu even have debug kernel? I know only about
> > linux-image-amd64-dbg
> > [1], but that package has just debugging symbols.


> Maybe we shouldn't declare that the purpose is to debug kernel,
> any kernel build with the slower configs should impacted.

+1

> > Which tests should I run on the kernel to see if timeout is ok?


> Any test with set .max_runtime you can try, for this patch our original
> work is for starvation.c but now it is generic.

I'll try to do it this week. Also, don't feel blocked by my testing (can be
merged without it).

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


> > Kind regards,
> > Petr

> > [1] https://packages.debian.org/sid/linux-image-amd64-dbg

> > ...
> > > +/*
> > > + * List of debug-kernel config options that may degrade performance
> > when enabled.
> > > + */
> > > +static const char * const tst_kconf_debug_options[][2] = {
> > > +     {"CONFIG_PROVE_LOCKING=y", NULL},
> > > +     {"CONFIG_LOCKDEP=y", NULL},
> > > +     {"CONFIG_DEBUG_SPINLOCK=y", NULL},
> > > +     {"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
> > > +     {"CONFIG_DEBUG_MUTEXES=y", NULL},
> > > +     {"CONFIG_DEBUG_PAGEALLOC=y", NULL},
> > > +     {"CONFIG_KASAN=y", NULL},
> > > +     {"CONFIG_SLUB_RCU_DEBUG=y", NULL},
> > > +     {"CONFIG_TRACE_IRQFLAGS=y", NULL},
> > > +     {"CONFIG_LATENCYTOP=y", NULL},
> > > +     {"CONFIG_DEBUG_NET=y", NULL},
> > > +     {"CONFIG_EXT4_DEBUG=y", NULL},
> > > +     {"CONFIG_QUOTA_DEBUG=y", NULL},
> > > +     {"CONFIG_FAULT_INJECTION=y", NULL},
> > > +     {"CONFIG_DEBUG_OBJECTS=y", NULL},
> > > +     {NULL, NULL}
> > ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
