Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X6eJh-0004cn-HT
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:21:09 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6eJg-0000S4-7k
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 11:21:09 +0000
Date: Mon, 14 Jul 2014 07:20:55 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1886124008.9567128.1405336855355.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
References: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
MIME-Version: 1.0
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





----- Original Message -----
> From: "Helge Deller" <deller@gmx.de>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 10 July, 2014 6:13:55 PM
> Subject: [LTP] [PATCH] fix fanotify syscall (again)
> 
> This patch to some degree reverts my last patch which was committed as:
>   commit 5d08e164964e19be693e6e8fddf3afb82e505b4f
>   Author: Helge Deller <deller@gmx.de>
>   Date:   Wed Apr 16 21:00:28 2014 +0200
>   fix fanotify syscall check on compat kernel
> 
> The problem is, that fanotify_mark() uses a 64bit parameter (mask).
> When calling this syscall with it's 64bit parameter on a 32bit arch it is
> very
> architecture and compiler dependend, in which order the lower and higher
> 32bits

Hi,

just trying to understand why it's not working now. Shouldn't __LONG_LONG_PAIR
take care of endian issues?

In email from Apr 18, you said "Yes, works for me (hppa arch, 32bit userspace,
64bit kernel)." - has anything changed since then?

Regards,
Jan

> are put on the stack and thus ends up in the arguments for the Linux kernel.
> 
> So, to avoid any problems we really need to call this syscall the same way as
> it's defined by glibc.
> 
> This patch will utilize the glibc header <sys/fanotify.h> if available and
> only use a manual syscall as fallback.
> 
> Tested on the hppa/parisc 32- and 64bit architecture.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h
> b/testcases/kernel/syscalls/fanotify/fanotify.h
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
> +
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
> +
> +#else /* HAVE_SYS_FANOTIFY_H */
> +
> +static int myfanotify_init(unsigned int flags, unsigned int event_f_flags)
> +{
> +	return syscall(__NR_fanotify_init, flags, event_f_flags);
>  }
>  
> +static long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
> +                     int dfd, const char *pathname)
> +{
> +	return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
> +}
> +
> +#endif
> +
> +
>  #endif /* __FANOTIFY_H__ */
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
