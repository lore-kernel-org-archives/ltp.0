From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jan 2020 15:48:58 +0100
Subject: [LTP] [RFC PATCH] pty03: Regression test for slip/slcan data
 race
In-Reply-To: <20200121140707.20583-1-rpalethorpe@suse.com>
References: <20200121140707.20583-1-rpalethorpe@suse.com>
Message-ID: <20200121144857.GB6337@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The kernel patch to fix this is still under review:
> https://lore.kernel.org/netdev/20200121134258.18013-1-rpalethorpe@suse.com/T/#u
> 
>  testcases/kernel/pty/Makefile |   2 +
>  testcases/kernel/pty/pty03.c  | 132 ++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 testcases/kernel/pty/pty03.c
> 
> diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
> index f9fc4f57e..52bb56c8d 100644
> --- a/testcases/kernel/pty/Makefile
> +++ b/testcases/kernel/pty/Makefile
> @@ -26,4 +26,6 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  CPPFLAGS		+= -D_GNU_SOURCE
>  
> +pty03: LDFLAGS += -pthread

This has to be CFLAGS +=

All the manual pages say "compile & link with -pthread".


Other than that the test looks fine. Ideally we should add the linux git
tag once the upstream patch is accepted, then merge the test.

-- 
Cyril Hrubis
chrubis@suse.cz
