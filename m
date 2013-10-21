Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYF3E-00028R-2v
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 12:57:40 +0000
Date: Mon, 21 Oct 2013 14:57:23 +0200
From: chrubis@suse.cz
Message-ID: <20131021125723.GA2385@rei>
References: <525F76B7.4050705@oracle.com>
	<1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1382087565-2370-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] msgctl{08, 09, 10, 11}: cleanup
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> index f467389..ae61b51 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> @@ -18,6 +18,15 @@
>  
>  top_srcdir              ?= ../../../../..
>  
> +FILTER_OUT_MAKE_TARGETS	:= libmsgctl
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +SRCS			?= $(wildcard $(abs_srcdir)/*.c)
> +OBJS			:= $(notdir $(patsubst %.c,%.o,$(SRCS)))
> +.INTERMEDIATE: $(OBJS)
> +
> +$(MAKE_TARGETS): %: %.o libmsgctl.o
> +libmsgctl.o: libmsgctl.h
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c b/testcases/kernel/syscalls/ipc/msgctl/libmsgctl.c
> new file mode 100644
> index 0000000..fa77b56

This is too hacky what about building .a library instead as it's done in
testcases/kernel/mem/lib ?

I've looked into the lib.mk and it looks like you don't even have to put
the lib in the separate directory if you set LIBSRC in the corresponding
Makefile.

I should really make some time to write more documentation for the most
common build system usages....

> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
> index f733946..8d7e431 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
> @@ -51,6 +51,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "ipcmsg.h"
> +#include "libmsgctl.h"
>  
>  void setup();
>  void cleanup();

Can you add void to all functions that take no parameters? (Otherwise
the compiler thinks that they take unspecified number of integer
parameters...)

> @@ -61,38 +62,22 @@ void cleanup();
>  char *TCID = "msgctl08";	/* Test program identifier.    */
>  int TST_TOTAL = 1;		/* Total number of test cases. */

Can you please also remove useless comments as:

/* Test program identifier.    */

/* Total number of test cases. */

/*
 *  *  *  * These globals must be defined in the test.
  *   *   *   */

/*--------------------------------------------------------------------*/

And similar?


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
