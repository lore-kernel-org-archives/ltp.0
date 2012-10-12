Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TMYF6-00030N-S8
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 05:57:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TMYF2-0007Sx-GZ
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 05:57:04 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q9C5u2o8002062
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Oct 2012 13:56:03 +0800
Message-ID: <5077B093.6010704@cn.fujitsu.com>
Date: Fri, 12 Oct 2012 13:54:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5077A8F8.6050609@cn.fujitsu.com>
In-Reply-To: <5077A8F8.6050609@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v5] pthread_cond_brodcast/1-2.c hung when mem left
 is not enough
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 10/12/2012 01:22 PM, DAN LI wrote:
> pthread_cond_brodcast/1-2.c try to create as many childrens(thread or
> process) as possible,however,if current free memory is exhausted before
> all childrens are started,the case will timeout and hung since it's
> stated with program "t0".

You should make patch against the newest ltp tree.

Thanks,
Wanlong Gao


> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  .../interfaces/pthread_cond_broadcast/1-2.c        | 40 +++++++++++++++++++---
>  testcases/open_posix_testsuite/include/mem_info.h  | 40 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 4 deletions(-)
>  create mode 100644 testcases/open_posix_testsuite/include/mem_info.h
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> index f6ad9df..6b27f40 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> @@ -49,6 +49,7 @@
>  #include <sys/wait.h>
>  #include <semaphore.h>
> 
> +#include "mem_info.h"
>  #include "../testfrmw/testfrmw.h"
>  #include "../testfrmw/testfrmw.c"
> 
> @@ -82,8 +83,8 @@
>  #endif
> 
>  /* Do not create more than this amount of children: */
> -#define MAX_PROCESS_CHILDREN  (200)
> -#define MAX_THREAD_CHILDREN   (1000)
> +static int max_process_children  = 200;
> +static int max_thread_children = 1000;
> 
>  #define TIMEOUT  (180)
> 
> @@ -243,6 +244,35 @@ void *timer(void *arg)
>  	return NULL; /* For compiler */
>  }
> 
> +static void children_number(void)
> +{
> +	struct sysinfo sysinformation;
> +	int avail_number;
> +	unsigned long freeram;
> +	unsigned long per_process;
> +	unsigned long min_stack;
> +
> +	min_stack = sysconf(_SC_THREAD_STACK_MIN);
> +
> +	freeram = getfreeram();
> +	if (freeram == 0)
> +		return;
> +
> +	per_process = min_stack * max_thread_children;
> +	if (per_process > freeram)
> +		UNTESTED("Not enough memory.");
> +
> +	avail_number = freeram / per_process;
> +
> +	if (avail_number < 10)
> +		UNTESTED("Not enough memory.");
> +
> +	max_process_children = (avail_number < max_process_children ?
> +					avail_number : max_process_children);
> +
> +	return;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int ret;
> @@ -268,6 +298,8 @@ int main(int argc, char *argv[])
> 
>  	output_init();
> 
> +	children_number();
> +
>  	/* check the system abilities */
>  	pshared = sysconf(_SC_THREAD_PROCESS_SHARED);
>  	cs = sysconf(_SC_CLOCK_SELECTION);
> @@ -476,7 +508,7 @@ int main(int argc, char *argv[])
>  				} else {
>  					ret = errno;
>  				}
> -			} while ((ret == 0) && (child_count < MAX_THREAD_CHILDREN));
> +			} while ((ret == 0) && (child_count < max_thread_children));
>  			#if VERBOSE > 2
>  			output("[parent] Created %i children threads\n", child_count);
>  			#endif
> @@ -504,7 +536,7 @@ int main(int argc, char *argv[])
>  				} else {
>  					ret = errno;
>  				}
> -			} while ((ret == 0) && (child_count < MAX_PROCESS_CHILDREN));
> +			} while ((ret == 0) && (child_count < max_process_children));
>  			#if VERBOSE > 2
>  			output("[parent] Created %i children processes\n", child_count);
>  			#endif
> diff --git a/testcases/open_posix_testsuite/include/mem_info.h b/testcases/open_posix_testsuite/include/mem_info.h
> new file mode 100644
> index 0000000..1669216
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/include/mem_info.h
> @@ -0,0 +1,40 @@
> +/*
> + *
> + *   Copyright (c) 2012, DAN LI
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms in version 2 of the GNU General Public License as
> + *   published by the Free Software Foundation.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + *
> + *   Author:  DAN LI <li.dan AT cn fujitsu com>
> + *   Date:    10/12/2012
> + */
> +
> +#ifdef __linux__
> +#include <sys/sysinfo.h>
> +
> +static int getfreeram(void)
> +{
> +	int ret;
> +	struct sysinfo sysinformation;
> +
> +	ret = sysinfo(&sysinformation);
> +	if (ret != 0)
> +		return 0;
> +	return sysinformation.freeram;
> +}
> +#else
> +static int getfreeram(void)
> +{
> +	return 0;
> +}
> +#endif
> 


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
