Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MJTDY-00033G-QR
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 14:12:52 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 943F88640B
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2009 16:12:48 +0200 (CEST)
Date: Wed, 24 Jun 2009 16:12:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090624141248.GA9577@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] [PATCH] Adapt the cgroup/test_6_2 test to the
	various	ways clone is called on different architectures
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
To: "Jiri Palecek >" <"<jirka"@suse.de>
Cc: ltp-list@lists.sourceforge.net

Hi,
that's the clone() check I was speaking about here. IMHO much cleaner solution
is to create some directory in ltp root (someting like libftest) and put all
such headers and code there, so they are not copied and spread all around ltp.

>  Code shamelessly taken from clone01 test
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>
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

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
