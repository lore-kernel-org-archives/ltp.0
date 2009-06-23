Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7rs-0006DO-W1
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:25:04 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7rr-0002nQ-IP
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:25:04 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NFLpIj024413
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:21:51 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NFGOe4199302
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:24:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF7MEa001018
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:07:22 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220256.n5M2uvax024525@e33.co.us.ibm.com>
References: <200906220256.n5M2uvax024525@e33.co.us.ibm.com>
Date: Tue, 23 Jun 2009 20:20:08 +0530
Message-Id: <1245768608.4860.83.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Adapt the cgroup/test_6_2 test to the
	various	ways clone is called on different architectures
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-06-19 at 16:14 +0200, Jiri Palecek > wrote: 
> Code shamelessly taken from clone01 test
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  .../kernel/controllers/cgroup/clone_platform.h     |   34 ++++++++++++++++++++
>  testcases/kernel/controllers/cgroup/test_6_2.c     |   12 ++++++-
>  2 files changed, 45 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/controllers/cgroup/clone_platform.h
> 
> diff --git a/testcases/kernel/controllers/cgroup/clone_platform.h b/testcases/kernel/controllers/cgroup/clone_platform.h
> new file mode 100644
> index 0000000..1785dd1
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/clone_platform.h
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc., 59
> + * Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + */
> +/* Common platform specific defines for the clone system call tests */
> +
> +//#define CHILD_STACK_SIZE 8192
> +#define CHILD_STACK_SIZE 16384
> +
> +#if defined (__s390__) || (__s390x__)
> +#define clone __clone
> +extern int __clone(int(void*),void*,int,void*);
> +#elif defined(__ia64__)
> +#define clone2 __clone2
> +/* Prototype provided by David Mosberger				*/
> +/* int  __clone2(int (*fn) (void *arg), void *child_stack_base,		*/
> +/* 		size_t child_stack_size, int flags, void *arg,		*/
> +/*		pid_t *parent_tid, void *tls, pid_t *child_tid)		*/
> +extern int  __clone2(int (*fn) (void *arg), void *child_stack_base, 
> +		size_t child_stack_size, int flags, void *arg, 
> +		pid_t *parent_tid, void *tls, pid_t *child_tid); 
> +#endif
> diff --git a/testcases/kernel/controllers/cgroup/test_6_2.c b/testcases/kernel/controllers/cgroup/test_6_2.c
> index e5bddb2..79f5c20 100644
> --- a/testcases/kernel/controllers/cgroup/test_6_2.c
> +++ b/testcases/kernel/controllers/cgroup/test_6_2.c
> @@ -24,6 +24,8 @@
>  #include <unistd.h>
>  #include <sched.h>
> 
> +#include "clone_platform.h"
> +
>  #define DEFAULT_USEC	30000
> 
>  int foo(void __attribute__((unused)) *arg)
> @@ -42,7 +44,15 @@ int main(int argc, char **argv)
> 
>  	while (1) {
>  		usleep(usec);
> -		clone(foo, stack+4096, CLONE_NEWNS, NULL);
> +#if defined(__hppa__)
> +		clone(foo, stack, CLONE_NEWNS, NULL);
> +#elif defined(__ia64__)
> +		clone2(foo, stack,
> +			    4096, CLONE_NEWNS, NULL, NULL, NULL, NULL);
> +#else
> +		clone
> +		     (foo, stack + 4096, CLONE_NEWNS, NULL);
> +#endif
>  	}
> 
>  	return 0;


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
