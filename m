Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Waii1-0001eB-79
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 09:34:17 +0000
Date: Thu, 17 Apr 2014 11:33:29 +0200
From: chrubis@suse.cz
Message-ID: <20140417093329.GA6558@rei.suse.cz>
References: <20140416190028.GA2093@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140416190028.GA2093@ls3530.fritz.box>
Subject: Re: [LTP] [PATCH] fix fanotify syscall check on compat kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
>  #ifndef	__FANOTIFY_H__
>  #define	__FANOTIFY_H__
>  
> +#include <sys/types.h>
> +#include <endian.h>
> +#include "config.h"
> +#include "linux_syscall_numbers.h"
> +
>  /* fanotify(7) wrappers */
>  
>  #define	myfanotify_init(flags, event_f_flags) \
>  	syscall(__NR_fanotify_init, flags, event_f_flags)
>  
> -#define	myfanotify_mark(fd, flags, mask, dfd, pathname)	\
> -	syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname)
> +long myfanotify_mark(int fd, unsigned int flags, unsigned long long mask, int dfd, const char *pathname)
> +{
> +#if __WORDSIZE == 64
> +	return ltp_syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
> +#else
> +	return ltp_syscall(__NR_fanotify_mark, fd, flags,
> +			 __LONG_LONG_PAIR((unsigned long) (mask >> 32),
> +					  (unsigned long) mask),
> +			 dfd, (unsigned long) pathname);
> +#endif
> +}

I think that the x32 ABI should be handled here as well (as in the
fallocate.h). Mike can you confirm?

Also I've been unable to make the testcases work with -m32 on x86_64
both with and without the patch and even when using glibc wrappers from
sys/fallocate.h, in all cases the error is EINVAL which suggets that the
parameters are passed wrongly somewhere on the way.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
