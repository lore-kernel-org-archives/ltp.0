Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCf1-0001q2-8m
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:47 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCex-0000c2-Bd
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:47 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FPvdD014235
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:25:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWgPV239058
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FWgil014360
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:42 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907071050.n67AooL6008612@e5.ny.us.ibm.com>
References: <200907071050.n67AooL6008612@e5.ny.us.ibm.com>
Date: Tue, 07 Jul 2009 21:02:31 +0530
Message-Id: <1246980751.5539.49.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add autoconf tests for taskstats members
	not	present on older kernels
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

On Tue, 2009-07-07 at 11:25 +0200, Jiri Palecek wrote: 
> Hello,
> 
> this patch adds autoconf checks for some build failures reported by Cyril Hrubis. Please note I have not tested this on an old kernel.
> 
> Also, it corrects the names of the preprocessor macros defined by autoconf
> 
> The remaining issue (the cgroupstats.h file) should be solved using the autoconf test that was committed recently.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  include/config.h.default                        |   12 ++++++++++--
>  m4/ltp-taskstats.m4                             |    2 +-
>  testcases/kernel/controllers/cgroup/getdelays.c |    9 +++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/config.h.default b/include/config.h.default
> index b9a6731..aa76a34 100644
> --- a/include/config.h.default
> +++ b/include/config.h.default
> @@ -10,9 +10,17 @@
>  /* signalfd() is in glibc-2.7+ */
>  #define HAVE_SYS_SIGNALFD_H 1
>  #define HAVE_SIGNALFD 1
> -#define HAVE_SIGNALFD_SIGINFO_SSI_SIGNO 1
> +#define HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO 1
> 
>  /* ifaddrs.h is in glibc-2.3+ */
>  #define HAVE_IFADDRS_H 1
> 
> -#define HAVE_TASKSTATS_FREEPAGES_COUNT 1
> +/* 2.6.27 */
> +#define HAVE_STRUCT_TASKSTATS_FREEPAGES_COUNT 1
> +
> +/* 2.6.23 */
> +#define HAVE_STRUCT_TASKSTATS_NVCSW 1
> +
> +/* 2.6.20 */
> +#define HAVE_STRUCT_TASKSTATS_READ_BYTES 1
> +
> diff --git a/m4/ltp-taskstats.m4 b/m4/ltp-taskstats.m4
> index 54da783..63e10a2 100644
> --- a/m4/ltp-taskstats.m4
> +++ b/m4/ltp-taskstats.m4
> @@ -30,7 +30,7 @@ dnl
> 
>  AC_DEFUN([_LTP_CHECK_TASKSTATS_FREEPAGES],
>  [dnl
> -AC_CHECK_MEMBERS([struct taskstats.freepages_count],[],[],[dnl
> +AC_CHECK_MEMBERS([struct taskstats.freepages_count, struct taskstats.nvcsw, struct taskstats.read_bytes],[],[],[dnl
>  #include <linux/types.h>
>  #include <linux/taskstats.h>
>  ])
> diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
> index 9fe2831..0813a96 100644
> --- a/testcases/kernel/controllers/cgroup/getdelays.c
> +++ b/testcases/kernel/controllers/cgroup/getdelays.c
> @@ -27,6 +27,7 @@
>  #include <linux/taskstats.h>
>  #include <linux/cgroupstats.h>
> 
> +#include "config.h"
>  /*
>   * Generic macros for dealing with netlink sockets. Might be duplicated
>   * elsewhere. It is recommended that commercial grade applications use
> @@ -199,7 +200,7 @@ void print_delayacct(struct taskstats *t)
>  	       "SWAP  %15s%15s\n"
>  	       "      %15llu%15llu\n"
>  	       "RECLAIM  %12s%15s\n"
> -#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
> +#ifdef HAVE_STRUCT_TASKSTATS_FREEPAGES_COUNT
>  	       "      %15llu%15llu\n"
>  #endif
>  	       , "count", "real total", "virtual total", "delay total",
> @@ -214,7 +215,7 @@ void print_delayacct(struct taskstats *t)
>  	       (unsigned long long)t->swapin_count,
>  	       (unsigned long long)t->swapin_delay_total,
>  	       "count", "delay total"
> -#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
> +#ifdef HAVE_STRUCT_TASKSTATS_FREEPAGES_COUNT
>  	       , (unsigned long long)t->freepages_count,
>  	       (unsigned long long)t->freepages_delay_total
>  #endif
> @@ -223,10 +224,12 @@ void print_delayacct(struct taskstats *t)
> 
>  void task_context_switch_counts(struct taskstats *t)
>  {
> +#ifdef HAVE_STRUCT_TASKSTATS_NVCSW
>  	printf("\n\nTask   %15s%15s\n"
>  	       "       %15llu%15llu\n",
>  	       "voluntary", "nonvoluntary",
>  	       (unsigned long long)t->nvcsw, (unsigned long long)t->nivcsw);
> +#endif
>  }
> 
>  void print_cgroupstats(struct cgroupstats *c)
> @@ -242,11 +245,13 @@ void print_cgroupstats(struct cgroupstats *c)
> 
>  void print_ioacct(struct taskstats *t)
>  {
> +#ifdef HAVE_STRUCT_TASKSTATS_READ_BYTES
>  	printf("%s: read=%llu, write=%llu, cancelled_write=%llu\n",
>  		t->ac_comm,
>  		(unsigned long long)t->read_bytes,
>  		(unsigned long long)t->write_bytes,
>  		(unsigned long long)t->cancelled_write_bytes);
> +#endif
>  }
> 
>  int main(int argc, char *argv[])
> -- 
> 1.6.3.3
> 
> 
> 
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have 
> the opportunity to enter the BlackBerry Developer Challenge. See full prize 
> details at: http://p.sf.net/sfu/blackberry
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
