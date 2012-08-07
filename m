Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Sya5m-0005vB-4M
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 03:04:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sya5k-0005AD-R8
	for ltp-list@lists.sourceforge.net; Tue, 07 Aug 2012 03:04:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q7733lKQ011617
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Aug 2012 11:04:14 +0800
Message-ID: <50208562.3030401@cn.fujitsu.com>
Date: Tue, 07 Aug 2012 11:02:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <501A3EA1.4010902@cn.fujitsu.com> <501F8DA0.6030104@cn.fujitsu.com>
	<50207F19.5080105@cn.fujitsu.com>
In-Reply-To: <50207F19.5080105@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] pthread_cond_brodcast/1-2.c hung when mem left
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

On 08/07/2012 10:36 AM, DAN LI wrote:
> pthread_cond_brodcast/1-2.c try to create as many childrens(thread or process) 
> as possible,however,if current free memory is exhausted before all childrens are
> started,the case will timeout and hung since it's stated with program "t0".
>  
> The patch adjust count of childrens according to judgement of size of current free
> memory.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  .../interfaces/pthread_cond_broadcast/1-2.c        |   39 ++++++++++++++++++--
>  1 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> index f6ad9df..a31dc2b 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
> @@ -48,6 +48,7 @@
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include <semaphore.h>
> +#include <sys/sysinfo.h>
>  
>  #include "../testfrmw/testfrmw.h"
>  #include "../testfrmw/testfrmw.c"
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
> @@ -242,6 +243,34 @@ void *timer(void *arg)
>  	FAILED_KILLALL("Operation timed out. A signal was lost.");
>  	return NULL; /* For compiler */
>  }
> +static int decide_process_children_count(void)
> +{
> +	struct sysinfo sysinforma;
> +	int ret;
> +	int avail_count;
> +	unsigned long memper;
> +	unsigned long min_stack;
> +
> +	min_stack = sysconf(_SC_THREAD_STACK_MIN);
> +
> +	ret = sysinfo(&sysinforma);

This is a linux specific function, so you can define this function
like this

#ifdef __linux__
static void decide_xxx(void)
{
	xxx
	xxx
}
#else
static void decide_xxx(void)
{
	return;
}
#endif

Thanks,
Wanlong Gao


> +	if (ret != 0)
> +		UNRESOLVED(ret, "Failed to get system infomation.");
> +
> +	memper = min_stack * max_thread_children;
> +	if (memper > sysinforma.freeram)
> +		UNTESTED("Free ram not enough for test.");
> +
> +	avail_count = sysinforma.freeram / memper;
> +
> +	if (avail_count < 10)
> +		UNTESTED("Free ram not enough for test.");
> +
> +	max_process_children = (avail_count < max_process_children ?
> +					avail_count : max_process_children);
> +
> +	return 0;
> +}
>  
>  int main(int argc, char *argv[])
>  {
> @@ -268,6 +297,8 @@ int main(int argc, char *argv[])
>  
>  	output_init();
>  
> +	decide_process_children_count();
> +
>  	/* check the system abilities */
>  	pshared = sysconf(_SC_THREAD_PROCESS_SHARED);
>  	cs = sysconf(_SC_CLOCK_SELECTION);
> @@ -476,7 +507,7 @@ int main(int argc, char *argv[])
>  				} else {
>  					ret = errno;
>  				}
> -			} while ((ret == 0) && (child_count < MAX_THREAD_CHILDREN));
> +			} while ((ret == 0) && (child_count < max_thread_children));
>  			#if VERBOSE > 2
>  			output("[parent] Created %i children threads\n", child_count);
>  			#endif
> @@ -504,7 +535,7 @@ int main(int argc, char *argv[])
>  				} else {
>  					ret = errno;
>  				}
> -			} while ((ret == 0) && (child_count < MAX_PROCESS_CHILDREN));
> +			} while ((ret == 0) && (child_count < max_process_children));
>  			#if VERBOSE > 2
>  			output("[parent] Created %i children processes\n", child_count);
>  			#endif
> -- 
> 1.7.7.6
> 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
