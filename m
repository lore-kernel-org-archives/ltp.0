Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqWa-0005gG-7Q
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:27:32 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqWZ-0002mJ-4d
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:27:32 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07Awmxj000989
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 03:58:48 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6fJF114402
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:06:41 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o07B6eI3021727
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 04:06:41 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B4403A8.2040502@cn.fujitsu.com>
References: <4B4403A8.2040502@cn.fujitsu.com>
Date: Thu, 07 Jan 2010 16:36:26 +0530
Message-Id: <1262862386.12213.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix the bug of the smaller cpu_set_t's length
	in	sched_getaffinity01
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
To: miaox@cn.fujitsu.com
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Wed, 2010-01-06 at 11:29 +0800, Miao Xie wrote: 
> sched_getaffinity01 test failed because the len of cpu_set_t in the glibc is smaller than
> the length of the cpumask in the kernel. So we must use the dynamically sized CPU sets instead
> of the standard cpu_set_t.
> 
> This patch fix this problem.
> Before using this patch, the test result is following:
> sched_getaffinity01    0  TINFO  :  system has 4 processor(s).
> sched_getaffinity01    1  TPASS  :  sched_getaffinity(0, len, (cpu_set_t *)-1): TEST_ERRNO=EINVAL(22): Invalid argument
> sched_getaffinity01    2  TPASS  :  sched_getaffinity(0, 0, &mask): TEST_ERRNO=EINVAL(22): Invalid argument
> sched_getaffinity01    3  TPASS  :  sched_getaffinity(getpid() + 1, len, &mask): TEST_ERRNO=EINVAL(22): Invalid argument
> sched_getaffinity01    4  TFAIL  :  could not get cpu affinity: TEST_ERRNO=EINVAL(22): Invalid argument
> 
> The subcases1-3 of this test also failed though they were successful according to the log.
> Becuase the errnos returned were wrong.
> 
> After using this patch, the test result is following:
> sched_getaffinity01    0  TINFO  :  system has 4 processor(s).
> sched_getaffinity01    0  TINFO  :  cpusetsize is 512
> sched_getaffinity01    0  TINFO  :  mask.__bits[0] = 15 
> sched_getaffinity01    1  TPASS  :  sched_getaffinity() succeed ,this process 2239 is running processor: 0
> sched_getaffinity01    2  TPASS  :  sched_getaffinity() succeed ,this process 2239 is running processor: 1
> sched_getaffinity01    3  TPASS  :  sched_getaffinity() succeed ,this process 2239 is running processor: 2
> sched_getaffinity01    4  TPASS  :  sched_getaffinity() succeed ,this process 2239 is running processor: 3
> sched_getaffinity01    5  TPASS  :  sched_getaffinity(0, len, (cpu_set_t *)-1): TEST_ERRNO=EFAULT(14): Bad address
> sched_getaffinity01    6  TPASS  :  sched_getaffinity(0, 0, mask): TEST_ERRNO=EINVAL(22): Invalid argument
> sched_getaffinity01    7  TPASS  :  sched_getaffinity(getpid() + 1, len, mask): TEST_ERRNO=ESRCH(3): No such process
> 
> Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  .../sched_getaffinity/sched_getaffinity01.c        |   81 +++++++++++++++-----
>  1 files changed, 61 insertions(+), 20 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> index 7c4a254..7dfb0ec 100644
> --- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> +++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
> @@ -119,11 +119,15 @@ do { \
>  	tst_resm((TEST_RETURN == -1 ? TPASS : TFAIL) | TTERRNO, #t); \
>  } while (0)
> 
> +#if !(__GLIBC_PREREQ(2,7))
> +#define CPU_FREE(ptr)	free(ptr)
> +#endif
>  int main(int ac, char **av) {
>          int lc,num,i;                 /* loop counter */
>          char *msg;              /* message returned from parse_opts */
> -	cpu_set_t mask;
> -	unsigned int len = sizeof(cpu_set_t);
> +	cpu_set_t *mask;
> +	int nrcpus = 1024;
> +	unsigned int len;
> 
>          /* parse standard options */
>          if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
> @@ -140,30 +144,67 @@ int main(int ac, char **av) {
>          for (lc = 0; TEST_LOOPING(lc); ++lc) {
>                  Tst_count = 0;
>                  for (testno = 0; testno < TST_TOTAL; ++testno) {
> -                     QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *)-1));
> -                     QUICK_TEST(sched_getaffinity(0, 0, &mask));
> -                     QUICK_TEST(sched_getaffinity(getpid() + 1, len, &mask));
> -
> -		     CPU_ZERO(&mask); //clear
> -                     TEST(sched_getaffinity(0,len,&mask));     //call sched_getaffinity()
> +#if __GLIBC_PREREQ(2,7)
> +realloc:
> +		     mask = CPU_ALLOC(nrcpus);
> +# else
> +		     mask = malloc(sizeof(cpu_set_t));
> +#endif
> +		     if (mask == NULL) {
> +		           tst_resm(TFAIL|TTERRNO, "cann't get enough memory");
> +		           cleanup();
> +		           tst_exit();
> +		     }
> +
> +#if __GLIBC_PREREQ(2,7)
> +		     len = CPU_ALLOC_SIZE(nrcpus);
> +		     CPU_ZERO_S(len, mask); //clear
> +#else
> +		     len = sizeof(cpu_set_t);
> +		     CPU_ZERO(mask); //clear
> +#endif
> +                     TEST(sched_getaffinity(0, len, mask));     //call sched_getaffinity()
>  		     if(TEST_RETURN == -1) {
> -                 	   tst_resm(TFAIL|TTERRNO, "could not get cpu affinity");
> -			cleanup();
> -			tst_exit();
> +			   CPU_FREE(mask);
> +#if __GLIBC_PREREQ(2,7)
> +			   if (errno == EINVAL && nrcpus < (1024 << 8)) {
> +				nrcpus = nrcpus << 2;
> +				goto realloc;
> +			   }
> +#else
> +			   if (errno == EINVAL)
> +				tst_resm(TFAIL, "NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
> +			   else
> +#endif
> +                 		tst_resm(TFAIL|TTERRNO, "could not get cpu affinity");
> +			   cleanup();
> +			   tst_exit();
>                       } else {
>  				tst_resm(TINFO,"cpusetsize is %d", len);
> -				tst_resm(TINFO,"mask.__bits[0] = %lu ",mask.__bits[0]);
> +				tst_resm(TINFO,"mask.__bits[0] = %lu ",mask->__bits[0]);
>  				for(i=0;i<num;i++){    // check the processor
> -	                        	TEST(CPU_ISSET(i,&mask));
> +#if __GLIBC_PREREQ(2,7)
> +	                        	TEST(CPU_ISSET_S(i, len, mask));
> +#else
> +					TEST(CPU_ISSET(i, mask));
> +#endif
>  					if (TEST_RETURN != -1 ){
>                                  	tst_resm(TPASS,"sched_getaffinity() succeed ,this process %d is running processor: %d",getpid(), i);
> -					}
> -			        }
> -	                    }
> -
> -
> -                     }
> -		}
> +				}
> +			    }
> +	             }
> +
> +#if __GLIBC_PREREQ(2,7)
> +		     CPU_ZERO_S(len, mask); //clear
> +#else
> +		     CPU_ZERO(mask);	//clear
> +#endif
> +                     QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *)-1));
> +                     QUICK_TEST(sched_getaffinity(0, 0, mask));
> +                     QUICK_TEST(sched_getaffinity(getpid() + 1, len, mask));
> +		     CPU_FREE(mask);
> +                }
> +	}
>          cleanup();
>  	tst_exit();
>  }


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
