Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447EC433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 12:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3986D3C0CCF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 13:44:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A17E3C7047
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 16:34:27 +0100 (CET)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C2EA2011BC
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 16:34:25 +0100 (CET)
Date: Thu, 2 Dec 2021 10:34:23 -0500
From: Rich Felker <dalias@libc.org>
To: Zack Weinberg <zack@owlfolio.org>
Message-ID: <20211202153422.GH7074@brightrain.aerifal.cx>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 06 Dec 2021 13:44:12 +0100
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
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
> On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
> > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > long long (unsigned) int to just long (unsigned) int in order to match
> > the uint64_t and int64_t size in userspace.
> ....
> > +
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
> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
> 
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
> + * In user space match <stdint.h>.
>   */
> +#ifdef __KERNEL__
>  # include <asm-generic/int-ll64.h>
> +#elif __has_include (<bits/types.h>)
> +# include <bits/types.h>
> +typedef __int8_t __s8;
> +typedef __uint8_t __u8;
> +typedef __int16_t __s16;
> +typedef __uint16_t __u16;
> +typedef __int32_t __s32;
> +typedef __uint32_t __u32;
> +typedef __int64_t __s64;
> +typedef __uint64_t __u64;
> +#else
> +# include <stdint.h>
> +typedef int8_t __s8;
> +typedef uint8_t __u8;
> +typedef int16_t __s16;
> +typedef uint16_t __u16;
> +typedef int32_t __s32;
> +typedef uint32_t __u32;
> +typedef int64_t __s64;
> +typedef uint64_t __u64;
> +#endif
> 
> The middle clause could be dropped if we are okay with all uapi
> headers potentially exposing the non-implementation-namespace names
> defined by <stdint.h>. I do not know what the musl libc equivalent
> of <bits/types.h> is.

We (musl) don't have an equivalent header or __-prefixed versions of
these types.

FWIW I don't think stdint.h exposes anything that would be problematic
alongside arbitrary use of kernel headers.

Rich

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
