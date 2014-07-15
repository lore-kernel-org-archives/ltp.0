Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6yMd-0004zc-9x
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 08:45:31 +0000
Date: Tue, 15 Jul 2014 10:45:01 +0200
From: chrubis@suse.cz
Message-ID: <20140715084501.GA19089@rei>
References: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
Subject: Re: [LTP] [PATCH] fix fanotify syscall (again)
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a52093c..6625811 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -28,27 +28,43 @@
>  #ifndef	__FANOTIFY_H__
>  #define	__FANOTIFY_H__
>  
> +#include "config.h"
> +
>  #include <stdint.h>
> -#include <endian.h>
> -#include "lapi/abisize.h"
>  #include "linux_syscall_numbers.h"
>  
>  /* fanotify(7) wrappers */
>  
> -#define	myfanotify_init(flags, event_f_flags) \
> -	syscall(__NR_fanotify_init, flags, event_f_flags)
>  
> -long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
> +#if defined(HAVE_SYS_FANOTIFY_H)
> +
> +#include <sys/fanotify.h>
> +
> +static int myfanotify_init(unsigned int flags, unsigned int event_f_flags)
> +{
> +	return fanotify_init(flags, event_f_flags);
> +}
> +static long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
>                       int dfd, const char *pathname)
>  {
> -#if LTP_USE_64_ABI
> -	return ltp_syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
> -#else
> -	return ltp_syscall(__NR_fanotify_mark, fd, flags,
> -			 __LONG_LONG_PAIR((unsigned long) (mask >> 32),
> -					  (unsigned long) mask),
> -			 dfd, (unsigned long) pathname);
> -#endif
> +	return fanotify_mark(fd, flags, mask, dfd, pathname);
> +}

What about we drop the myfanotify*() functions now since we check if
fanotify.h exists now, use fanotify*() in the testcases and define the
syscall wrappers only when fanotify.h is not available (see for example
include/lapi/renameat.h)?

Otherwise it looks fine to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
