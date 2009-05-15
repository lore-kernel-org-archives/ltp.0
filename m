Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M4rhO-0006h5-Bu
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:19:18 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4rhE-0007Nf-Tn
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:19:18 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4F7FJp5011063
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:15:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4F7HpRi214356
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:17:51 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4F7Hoh5022168
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 01:17:50 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A0A0116.8030604@web.de>
References: <4A0A0116.8030604@web.de>
Date: Fri, 15 May 2009 12:47:48 +0530
Message-Id: <1242371868.7224.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add an autoconf test for presence
	oftaskstats.freepages_count
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, 2009-05-13 at 01:07 +0200, Jiri Palecek wrote: 
> Also, use it in getdelays.c to prevent compilation failures
> 
> Hello,
> 
> I've found that ltp didn't compile on Debian because of old kernel headers, 
> which contain taskstats struct without some of the needed fields. This autoconf 
> test detects it and disables the code that would otherwise break.
> 
> Regards
>      Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Same here:

ERROR: patch seems to be corrupt (line wrapped?)
#132: FILE: configure.ac:24:
diff --git a/include/config.h.default b/include/config.h.default
total: 1 errors, 0 warnings, 83 lines checked

and

patching file configure.ac
patch: **** malformed patch at line 132: diff --git
a/include/config.h.default b/include/config.h.default

Regards--
Subrata

> ---
>   configure.ac                                    |    1 +
>   include/config.h.default                        |    2 +
>   m4/ltp-taskstats.m4                             |   38 +++++++++++++++++++++++
>   testcases/kernel/controllers/cgroup/getdelays.c |   15 ++++++---
>   4 files changed, 51 insertions(+), 5 deletions(-)
>   create mode 100644 m4/ltp-taskstats.m4
> 
> diff --git a/configure.ac b/configure.ac
> index c534c97..9fc1696 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,5 +20,6 @@ LTP_CHECK_SYSCALL_MODIFY_LDT
>   LTP_CHECK_SYSCALL_SIGNALFD
>   LTP_CHECK_SELINUX
>   LTP_CHECK_CRYPTO
> +LTP_CHECK_TASKSTATS
>    AC_OUTPUT
> diff --git a/include/config.h.default b/include/config.h.default
> index 9125d85..b9a6731 100644
> --- a/include/config.h.default
> +++ b/include/config.h.default
> @@ -14,3 +14,5 @@
>    /* ifaddrs.h is in glibc-2.3+ */
>   #define HAVE_IFADDRS_H 1
> +
> +#define HAVE_TASKSTATS_FREEPAGES_COUNT 1
> diff --git a/m4/ltp-taskstats.m4 b/m4/ltp-taskstats.m4
> new file mode 100644
> index 0000000..54da783
> --- /dev/null
> +++ b/m4/ltp-taskstats.m4
> @@ -0,0 +1,38 @@
> +dnl
> +dnl Copyright (c) Jiri Palecek 2009
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +dnl
> +
> +
> +AC_DEFUN([LTP_CHECK_TASKSTATS],
> +_LTP_CHECK_TASKSTATS_FREEPAGES
> +)dnl
> +
> +dnl _LTP_CHECK_TASKSTATS_FREEPAGES
> +dnl ----------------------------------------
> +dnl
> +dnl Check for taskstat.freepages_* members, introduced to the kernel
> +dnl in commit 016ae219 in July 2008
> +dnl
> +
> +AC_DEFUN([_LTP_CHECK_TASKSTATS_FREEPAGES],
> +[dnl
> +AC_CHECK_MEMBERS([struct taskstats.freepages_count],[],[],[dnl
> +#include <linux/types.h>
> +#include <linux/taskstats.h>
> +])
> +]dnl
> +)dnl
> diff --git a/testcases/kernel/controllers/cgroup/getdelays.c 
> b/testcases/kernel/controllers/cgroup/getdelays.c
> index 13f7b3a..9fe2831 100644
> --- a/testcases/kernel/controllers/cgroup/getdelays.c
> +++ b/testcases/kernel/controllers/cgroup/getdelays.c
> @@ -199,8 +199,10 @@ void print_delayacct(struct taskstats *t)
>   	       "SWAP  %15s%15s\n"
>   	       "      %15llu%15llu\n"
>   	       "RECLAIM  %12s%15s\n"
> -	       "      %15llu%15llu\n",
> -	       "count", "real total", "virtual total", "delay total",
> +#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
> +	       "      %15llu%15llu\n"
> +#endif
> +	       , "count", "real total", "virtual total", "delay total",
>   	       (unsigned long long)t->cpu_count,
>   	       (unsigned long long)t->cpu_run_real_total,
>   	       (unsigned long long)t->cpu_run_virtual_total,
> @@ -211,9 +213,12 @@ void print_delayacct(struct taskstats *t)
>   	       "count", "delay total",
>   	       (unsigned long long)t->swapin_count,
>   	       (unsigned long long)t->swapin_delay_total,
> -	       "count", "delay total",
> -	       (unsigned long long)t->freepages_count,
> -	       (unsigned long long)t->freepages_delay_total);
> +	       "count", "delay total"
> +#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
> +	       , (unsigned long long)t->freepages_count,
> +	       (unsigned long long)t->freepages_delay_total
> +#endif
> +	       );
>   }
>    void task_context_switch_counts(struct taskstats *t)
> -- 
> 1.6.2
> 
> 
> ------------------------------------------------------------------------------
> The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> production scanning environment may not be a perfect world - but thanks to
> Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
> Series Scanner you'll get full speed at 300 dpi even with all image 
> processing features enabled. http://p.sf.net/sfu/kodak-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
