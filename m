Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SFbeC-0005eb-3F
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:38:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFbeA-0006rd-9g
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:38:00 +0000
Message-ID: <4F7CF730.30909@cn.fujitsu.com>
Date: Thu, 05 Apr 2012 09:36:48 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
In-Reply-To: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
Subject: Re: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 04/05/2012 08:38 AM, Garrett Cooper wrote:

> Clean up inotify(7) wrappers
> 
> As a side-effect this also fixes the return code passed back
> by the wrappers as the value should be an integer, not longs
> [this fixes compile errors on platforms where
> sizeof(int) != sizeof(long)].


Looks OK to me. 

Thanks,
Wanlong Gao

> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> ---
>  testcases/kernel/syscalls/inotify/inotify.h   |   45 +++++++++++++++++++++++++
>  testcases/kernel/syscalls/inotify/inotify01.c |   16 +--------
>  testcases/kernel/syscalls/inotify/inotify02.c |   16 +--------
>  testcases/kernel/syscalls/inotify/inotify03.c |   16 +--------
>  4 files changed, 48 insertions(+), 45 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify.h
> 
> 
> --------------1.7.2.5
> Content-Type: text/x-patch; name="0001-Clean-up-inotify-7-wrappers.patch"
> Content-Transfer-Encoding: 8bit
> Content-Disposition: attachment; filename="0001-Clean-up-inotify-7-wrappers.patch"
> 
> diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
> new file mode 100644
> index 0000000..ab7f812
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify.h
> @@ -0,0 +1,45 @@
> +/*
> + * inotify testcase common definitions.
> + *
> + * Copyright (c) 2012 Linux Test Project.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc., 59
> + * Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * Garrett Cooper, April 2012
> + */
> +
> +#ifndef    _INOTIFY_H
> +#define    _INOTIFY_H
> +
> +/* inotify(7) wrappers */
> +
> +/*
> + * ``junk`` is needed to make the macro function like a void argument
> + * function.
> + */
> +#define    myinotify_init(junk)    syscall(__NR_inotify_init)
> +
> +#define    myinotify_add_watch(fd, pathname, mask)    \
> +    syscall(__NR_inotify_add_watch, fd, pathname, mask)
> +
> +#define    myinotify_rm_watch(fd, wd) \
> +    syscall(__NR_inotify_rm_watch, fd, wd)
> +
> +#endif /* _INOTIFY_H */
> diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
> index 4168c0e..8205f82 100644
> --- a/testcases/kernel/syscalls/inotify/inotify01.c
> +++ b/testcases/kernel/syscalls/inotify/inotify01.c
> @@ -50,6 +50,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> +#include "inotify.h"
> 
>  #if defined(HAVE_SYS_INOTIFY_H)
>  #include <sys/inotify.h>
> @@ -76,21 +77,6 @@ int event_set[EVENT_MAX];
> 
>  char event_buf[EVENT_BUF_LEN];
> 
> -static long myinotify_init()
> -{
> -    return syscall(__NR_inotify_init);
> -}
> -
> -static long myinotify_add_watch(int fd, const char *pathname, int mask)
> -{
> -    return syscall(__NR_inotify_add_watch, fd, pathname, mask);
> -}
> -
> -static long myinotify_rm_watch(int fd, int wd)
> -{
> -    return syscall(__NR_inotify_rm_watch, fd, wd);
> -}
> -
>  int main(int ac, char **av)
>  {
>      int lc;            /* loop counter */
> diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
> index 4ffc00c..59f83ba 100644
> --- a/testcases/kernel/syscalls/inotify/inotify02.c
> +++ b/testcases/kernel/syscalls/inotify/inotify02.c
> @@ -54,6 +54,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> +#include "inotify.h"
> 
>  #if defined(HAVE_SYS_INOTIFY_H)
>  #include <sys/inotify.h>
> @@ -92,21 +93,6 @@ struct event_t event_set[EVENT_MAX];
> 
>  char event_buf[EVENT_BUF_LEN];
> 
> -static long myinotify_init()
> -{
> -    return syscall(__NR_inotify_init);
> -}
> -
> -static long myinotify_add_watch(int fd, const char *pathname, int mask)
> -{
> -    return syscall(__NR_inotify_add_watch, fd, pathname, mask);
> -}
> -
> -static long myinotify_rm_watch(int fd, int wd)
> -{
> -    return syscall(__NR_inotify_rm_watch, fd, wd);
> -}
> -
>  int main(int ac, char **av)
>  {
>      int lc;            /* loop counter */
> diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
> index d3c3e7b..d8caa83 100644
> --- a/testcases/kernel/syscalls/inotify/inotify03.c
> +++ b/testcases/kernel/syscalls/inotify/inotify03.c
> @@ -49,6 +49,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "linux_syscall_numbers.h"
> +#include "inotify.h"
> 
>  #if defined(HAVE_SYS_INOTIFY_H)
>  #include <sys/inotify.h>
> @@ -76,21 +77,6 @@ int event_set[EVENT_MAX];
> 
>  char event_buf[EVENT_BUF_LEN];
> 
> -static long myinotify_init()
> -{
> -    return syscall(__NR_inotify_init);
> -}
> -
> -static long myinotify_add_watch(int fd, const char *pathname, int mask)
> -{
> -    return syscall(__NR_inotify_add_watch, fd, pathname, mask);
> -}
> -
> -static long myinotify_rm_watch(int fd, int wd)
> -{
> -    return syscall(__NR_inotify_rm_watch, fd, wd);
> -}
> -
>  #define DEFAULT_FSTYPE    "ext2"
>  #define DIR_MODE    S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP
> 
> 
> ------------------------------------------------------------------------------
> Better than sec? Nothing is better than sec when it comes to
> monitoring Big Data applications. Try Boundary one-second 
> resolution app monitoring today. Free.
> http://p.sf.net/sfu/Boundary-dev2dev
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
