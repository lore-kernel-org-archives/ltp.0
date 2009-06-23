Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7bd-0000pg-23
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:08:17 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7bW-00045p-HN
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:08:12 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NF3OKU032098
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:03:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NF8AwS249200
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:08:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NF89cq021925
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:08:09 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220220.n5M2K5BC031126@e2.ny.us.ibm.com>
References: <200906220220.n5M2K5BC031126@e2.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:20:14 +0530
Message-Id: <1245768614.4860.85.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Define some syscall numbers in
	the	linux_syscall_numbers.h file,
	not to get build failures or crappy results	on other architectures
	which lack them
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

On Fri, 2009-06-19 at 20:54 +0200, Jiri Palecek > wrote: 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks. This is the last patch from you i am checking in. Did i miss
something ?

Regards--
Subrata

> ---
>  testcases/kernel/include/i386.in                   |   14 ++++++++++++++
>  testcases/kernel/include/ia64.in                   |    1 +
>  testcases/kernel/include/powerpc.in                |    1 +
>  testcases/kernel/include/x86_64.in                 |    1 +
>  .../performance_counters/performance_counter01.c   |   11 +++--------
>  .../performance_counters/performance_counter02.c   |   15 +++------------
>  testcases/kernel/syscalls/mq_open/mq_open01.c      |    5 -----
>  testcases/kernel/syscalls/ppoll/ppoll01.c          |    4 ----
>  testcases/kernel/syscalls/utils/numaif.h           |   20 +-------------------
>  9 files changed, 24 insertions(+), 48 deletions(-)
> 
> diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
> index f0ef7e3..c4e7419 100644
> --- a/testcases/kernel/include/i386.in
> +++ b/testcases/kernel/include/i386.in
> @@ -10,15 +10,27 @@ __NR_setreuid		 70
>  __NR_setregid		 71
>  __NR_setgroups		 81
>  __NR_fchown		 95
> +__NR_sgetmask               68
> +__NR_ssetmask               69
> +__NR_sigprocmask   126
> +__NR_bdflush               134
>  __NR_setfsgid		139
>  __NR_setresuid		164
>  __NR_setresgid		170
>  __NR_chown		182
> +__NR_set_thread_area       243
> +__NR_get_thread_area       244
>  __NR_timer_create	259
>  __NR_timer_settime	(__NR_timer_create+1)
>  __NR_timer_delete	(__NR_timer_create+4)
>  __NR_clock_settime	(__NR_timer_create+5)
>  __NR_clock_gettime	(__NR_timer_create+6)
> +__NR_mbind			274
> +__NR_get_mempolicy		275
> +__NR_set_mempolicy		276
> +__NR_mq_open               277
> +__NR_mq_getsetattr (__NR_mq_open+5)
> +__NR_migrate_pages		294
>  __NR_openat		295
>  __NR_mkdirat		296
>  __NR_mknodat		297
> @@ -32,6 +44,7 @@ __NR_symlinkat		304
>  __NR_readlinkat		305
>  __NR_fchmodat		306
>  __NR_faccessat		307
> +__NR_ppoll    309
>  __NR_splice		313
>  __NR_tee		315
>  __NR_vmsplice		316
> @@ -47,3 +60,4 @@ __NR_epoll_create1	329
>  __NR_dup3		330
>  __NR_pipe2		331
>  __NR_inotify_init1	332
> +__NR_perf_counter_open 333
> diff --git a/testcases/kernel/include/ia64.in b/testcases/kernel/include/ia64.in
> index 2d568a9..9191875 100644
> --- a/testcases/kernel/include/ia64.in
> +++ b/testcases/kernel/include/ia64.in
> @@ -16,6 +16,7 @@ __NR_timer_settime		1249
>  __NR_timer_delete		1252
>  __NR_clock_settime		1253
>  __NR_clock_gettime		1254
> +__NR_migrate_pages 1280
>  __NR_openat			1281
>  __NR_mkdirat			1282
>  __NR_mknodat			1283
> diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
> index 83d6553..ea2328c 100644
> --- a/testcases/kernel/include/powerpc.in
> +++ b/testcases/kernel/include/powerpc.in
> @@ -23,3 +23,4 @@ __NR_faccessat (__NR_openat + 12)
>  __NR_eventfd 307
>  __NR_fallocate 309
>  __NR_utimensat 304
> +__NR_perf_counter_open 319
> diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
> index 88c73eb..6bb7dd9 100644
> --- a/testcases/kernel/include/x86_64.in
> +++ b/testcases/kernel/include/x86_64.in
> @@ -46,3 +46,4 @@ __NR_epoll_create1			291
>  __NR_dup3				292
>  __NR_pipe2				293
>  __NR_inotify_init1			294
> +__NR_perf_counter_open	295
> diff --git a/testcases/kernel/performance_counters/performance_counter01.c b/testcases/kernel/performance_counters/performance_counter01.c
> index 7bd498e..841a98f 100644
> --- a/testcases/kernel/performance_counters/performance_counter01.c
> +++ b/testcases/kernel/performance_counters/performance_counter01.c
> @@ -41,14 +41,7 @@
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
> -
> -#ifdef __x86_64__
> -# define __NR_perf_counter_open	295
> -#endif
> -
> -#ifdef __i386__
> -# define __NR_perf_counter_open 333
> -#endif
> +#include "linux_syscall_numbers.h"
> 
>  /* Extern Global Variables */
>  extern int  Tst_count;               /* counter for tst_xxx routines.         */
> @@ -57,6 +50,8 @@ extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
>  char *TCID     = "performance_counter01"; /* test program identifier.          */
>  int  TST_TOTAL = 1; 
> 
> +#define cleanup tst_exit /* for now... */
> +
>  int perf_counter_open(int		hw_event_type,
>                        unsigned int	hw_event_period,
>                        unsigned int	record_type,
> diff --git a/testcases/kernel/performance_counters/performance_counter02.c b/testcases/kernel/performance_counters/performance_counter02.c
> index 1f17123..9c14b7f 100644
> --- a/testcases/kernel/performance_counters/performance_counter02.c
> +++ b/testcases/kernel/performance_counters/performance_counter02.c
> @@ -69,18 +69,7 @@ it print out the values of each counter.
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
> -
> -#ifdef __x86_64__
> -# define __NR_perf_counter_open	295
> -#endif
> -
> -#ifdef __i386__
> -# define __NR_perf_counter_open 333
> -#endif
> -
> -#ifdef __powerpc__
> -# define __NR_perf_counter_open 319
> -#endif
> +#include "linux_syscall_numbers.h"
> 
>  #define PR_TASK_PERF_COUNTERS_DISABLE           31
>  #define PR_TASK_PERF_COUNTERS_ENABLE            32
> @@ -93,6 +82,8 @@ extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
>  char *TCID     = "performance_counter02"; /* test program identifier.          */
>  int  TST_TOTAL = 1;                  /* total number of tests in this file.   */
> 
> +#define cleanup tst_exit /* for now... */
> +
>  typedef unsigned int u32;
>  typedef unsigned long long u64;
>  typedef long long s64;
> diff --git a/testcases/kernel/syscalls/mq_open/mq_open01.c b/testcases/kernel/syscalls/mq_open/mq_open01.c
> index f9c2f08..c81bda8 100644
> --- a/testcases/kernel/syscalls/mq_open/mq_open01.c
> +++ b/testcases/kernel/syscalls/mq_open/mq_open01.c
> @@ -134,11 +134,6 @@ void setup() {
>   */
>  #define SYSCALL_NAME    "mq_open"
> 
> -#ifndef __NR_mq_getsetattr
> -#  define __NR_mq_getsetattr            282
> -#endif
> -
> -
>  /*
>   * Global variables
>   */
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index 910fbdf..1d96e04 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -137,10 +137,6 @@ void setup() {
>   */
>  #define SYSCALL_NAME    "ppoll"
> 
> -#ifndef __NR_ppoll
> -#  define __NR_ppoll    309
> -#endif
> -
>  #ifndef POLLRDHUP
>  #  define POLLRDHUP     0x2000
>  #endif
> diff --git a/testcases/kernel/syscalls/utils/numaif.h b/testcases/kernel/syscalls/utils/numaif.h
> index f358e2e..dab0d00 100644
> --- a/testcases/kernel/syscalls/utils/numaif.h
> +++ b/testcases/kernel/syscalls/utils/numaif.h
> @@ -27,25 +27,7 @@
>   */
> 
>  #include "./include_j_h.h"
> -
> -#ifndef __NR_mbind
> -#  define __NR_mbind			274
> -#endif
> -#ifndef __NR_get_mempolicy
> -#  define __NR_get_mempolicy		275
> -#endif
> -#ifndef __NR_set_mempolicy
> -#  define __NR_set_mempolicy		276
> -#endif
> -#ifndef __NR_migrate_pages
> -#  define __NR_migrate_pages		294
> -#endif
> -#ifndef __NR_move_pages
> -#  define __NR_move_pages		317
> -#endif
> -
> -
> -
> +#include "linux_syscall_numbers.h"
> 
>  #define NUMA_NUM_NODES 	128
>  typedef struct { 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
