Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C288C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 09:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7EF43C8DCF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 10:13:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60E103C8982
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:13:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C5B751A0113F
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:13:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5E4521709;
 Tue, 23 Nov 2021 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637658789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lTMkFzzS/iQ1UTdPJDo4VfG+cYsQ7qvYb44dbmTy1I4=;
 b=RyKQwgj/Saeq7dYXOT1Xv81yD1LVdPtxakF+YhsMAI23Cf17DNmMcj8Fr1TXdvoKA8yt5v
 X8pxEBLKyT8v7BRb1hxeIg0aufeuOsN630emCfhg5wv7RQiilW1c4J47Wo1Z5XyOqX7s9G
 EuMkzLy9xj9EXDEBibM1MVL/tlmok64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637658789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lTMkFzzS/iQ1UTdPJDo4VfG+cYsQ7qvYb44dbmTy1I4=;
 b=q/V53TWlUucuq6/PU2saOecZPm4M0I1G61OFFXTjvOTpqL4qKQszT5OJDIMQP+d0Irwwgb
 hXqTAKawGM+2RpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1E8913DA3;
 Tue, 23 Nov 2021 09:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sznMLaWwnGF/DgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 23 Nov 2021 09:13:09 +0000
Date: Tue, 23 Nov 2021 10:14:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <YZyw56flmdQnBIuh@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +#include <asm/bitsperlong.h>
> > +
> >  /*
> > - * int-ll64 is used everywhere now.
> > + * int-ll64 is used everywhere in kernel now.
> >   */
> > -#include <asm-generic/int-ll64.h>
> > +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> > +# include <asm-generic/int-l64.h>
> > +#else
> > +# include <asm-generic/int-ll64.h>
> > +#endif
> 
> I don't think this is correct on all 64-bit architectures, as far as I
> remember the
> definition can use either 'long' or 'long long' depending on the user space
> toolchain.

As far as I can tell the userspace bits/types.h does exactly the same
check in order to define uint64_t and int64_t, i.e.:

#if __WORDSIZE == 64
typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;
#else
__extension__ typedef signed long long int __int64_t;
__extension__ typedef unsigned long long int __uint64_t;
#endif

The macro __WORDSIZE is defined per architecture, and it looks like the
defintions in glibc sources in bits/wordsize.h match the uapi
asm/bitsperlong.h. But I may have missed something, the code in glibc is
not exactly easy to read.

> Out of the ten supported 64-bit architectures, there are four that already
> use asm-generic/int-l64.h conditionally, and six that don't, and I
> think at least
> some of those are intentional.
>
> I think it would be safer to do this one architecture at a time to make
> sure this doesn't regress on those that require the int-ll64.h version.

I'm still trying to understand what exactly can go wrong here. As long
as __BITS_PER_LONG is correctly defined the __u64 and __s64 will be
correctly sized as well. The only visible change is that one 'long' is
dropped from the type when it's not needed.

> There should also be a check for __SANE_USERSPACE_TYPES__
> to let userspace ask for the ll64 version everywhere.

That one is easy to fix at least.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
